local ls = require "luasnip"
local sn = ls.sn
local s = ls.s
local i = ls.insert_node
local t = ls.text_node
local d = ls.dynamic_node
local f = ls.function_node
local fmta = require("luasnip.extras.fmt").fmta
local c = ls.choice_node

local get_node_text = vim.treesitter.get_node_text

local create_package_query = function()
    return vim.treesitter.query.parse(
        "go",
        [[
        ((package_identifier) @package)
    ]]
    )
end

local function get_method_receiver_type_text(node)
    local query = vim.treesitter.query.parse(
        "go",
        [[
            (method_declaration receiver: (parameter_list
                (parameter_declaration type: (_) @method_receiver)))
        ]]
    )

    for _, capture in query:iter_captures(node, 0) do
        return get_node_text(capture, 0)
    end
    return "Method Receiver Not Found"
end

local function get_package_node(node)
    local root = node:tree():root()
    local query = create_package_query()
    for _, capture in query:iter_captures(root, 0) do
        return capture
    end
    return nil
end

local function get_method_or_function_declaration_node(node)
    local parent = node:parent()
    while parent ~= nil do
        if parent:type() == "function_declaration" or parent:type() == "method_declaration" then
            return parent
        end
        parent = parent:parent()
    end
end

local root_types = {
    method_declaration = true,
    function_declaration = true,
    func_literal = true,
}

local handlers = {
    ["context.Context"] = function(node)
        local var_name_node = node:prev_named_sibling()
        local text = get_node_text(var_name_node, 0)
        return text
    end,
    ["*http.Request"] = function(node)
        local var_name_node = node:prev_named_sibling()
        local text = get_node_text(var_name_node, 0)
        return text .. ".Context()"
    end,
}

local build_context_node = function()
    local query = assert(vim.treesitter.query.get("go", "search-context"), "No Query")
    local node = vim.treesitter.get_node()
    while node ~= nil do
        if root_types[node:type()] then
            for _, capture in query:iter_captures(node, 0) do
                local text = get_node_text(capture, 0)
                local handle = handlers[text]
                if handle then
                    return handle(capture)
                end
            end
        end
        node = node:parent()
    end
    return "context.Background()"
end

local function get_method_or_function_name(node)
    if node:type() == "method_declaration" then
        return get_node_text(node:named_child(1), 0)
    end
    return get_node_text(node:named_child(0), 0)
end

local build_span_type_node = function(ctx)
    local node = vim.treesitter.get_node()
    local method_or_function_node = get_method_or_function_declaration_node(node)
    if method_or_function_node == nil then
        vim.notify "Not inside method or function"
        return { t "" }
    end
    local package_node = get_package_node(node)
    if package_node == nil then
        vim.notify "No package node found"
        return { t "" }
    end
    local package_text = get_node_text(package_node, 0)
    local final_name = ""
    if method_or_function_node:type() == "method_declaration" then
        local method_node = method_or_function_node
        local receiver_type = get_method_receiver_type_text(method_node)
        final_name = ([[%s.%s]]):format(package_text, receiver_type)
    else
        if method_or_function_node:type() == "function_declaration" then
            local function_node = method_or_function_node
            local fn_name = get_method_or_function_name(function_node)
            final_name = ([[%s.%s]]):format(package_text, fn_name)
        end
    end
    ctx.index = ctx.index + 1
    return { i(ctx.index, final_name) }
end

local build_span_name_node = function(ctx)
    local node = vim.treesitter.get_node()
    local method_or_function_node = get_method_or_function_declaration_node(node)
    if method_or_function_node == nil then
        vim.notify "Not inside method or function"
        return { t "" }
    end
    local fn_name = get_method_or_function_name(method_or_function_node)
    ctx.index = ctx.index + 1
    return { i(ctx.index, fn_name) }
end

local get_span_name_node = function()
    return sn(nil, build_span_name_node { index = 0 })
end

local get_span_type_node = function()
    return sn(nil, build_span_type_node { index = 0 })
end

ls.add_snippets("go", {
    s(
        "apm:span",
        fmta(
            [[
span, <ctx_var> := apm.StartSpan(<ctx>, "<span_name>", "<span_type>")
defer span.End()
<finish>
]],
            {
                ctx_var = c(1, {
                    t "ctx",
                    t "_",
                }),
                ctx = f(build_context_node, {}),
                span_name = d(2, get_span_name_node),
                span_type = d(3, get_span_type_node),
                finish = i(0),
            }
        )
    ),
})
