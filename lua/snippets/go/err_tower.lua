local ls = require "luasnip"

local sn = ls.snippet_node
local isn = ls.indent_snippet_node

local s = ls.s
local i = ls.insert_node
local t = ls.text_node
local d = ls.dynamic_node
local c = ls.choice_node
local f = ls.function_node
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

local get_node_text = vim.treesitter.get_node_text

local default_values = {
    int = "0",
    int8 = "0",
    int16 = "0",
    int32 = "0",
    int64 = "0",
    uint = "0",
    uint8 = "0",
    uint16 = "0",
    uint32 = "0",
    uint64 = "0",
    ["time.Time"] = "time.Time{}",
    ["time.Duration"] = "time.Duration(0)",
    bool = "false",
    string = [[""]],
    float32 = "0",
    float64 = "0",
    error = "errt",

    -- Types with a "*" mean they are pointers, so return nil
    [function(text)
        return string.find(text, "*", 1, true) ~= nil
    end] = function(_, _)
        return t "nil"
    end,

    [function(text)
        return not string.find(text, "*", 1, true) and string.upper(string.sub(text, 1, 1)) == string.sub(text, 1, 1)
    end] = function(text, info)
        info.index = info.index + 1
        return sn(info.index, {
            c(1, {
                t(text .. "{}"),
                i(2, text),
            }),
        })
    end,
}

local transform = function(text, info)
    local condition_matches = function(condition, ...)
        if type(condition) == "string" then
            return condition == text
        else
            return condition(...)
        end
    end

    for condition, result in pairs(default_values) do
        if condition_matches(condition, text, info) then
            if type(result) == "string" then
                return t(result)
            end
            return result(text, info)
        end
    end
    info.index = info.index + 1
    return sn(info.index, {
        c(1, {
            t(text .. "{}"),
            i(2, text),
        }),
    })
end

local handlers = {
    parameter_list = function(node, info)
        local result = {}

        local count = node:named_child_count()
        for idx = 0, count - 1 do
            local matching_node = node:named_child(idx)
            local type_node = matching_node:field("type")[1]
            table.insert(result, transform(get_node_text(type_node, 0), info))
            if idx ~= count - 1 then
                table.insert(result, t { ", " })
            end
        end

        return result
    end,

    type_identifier = function(node, info)
        local text = get_node_text(node, 0)
        return { transform(text, info) }
    end,
}

local function_node_types = {
    function_declaration = true,
    method_declaration = true,
    func_literal = true,
}

local function go_result_type(info)
    local node = vim.treesitter.get_node()
    while node ~= nil do
        if function_node_types[node:type()] then
            break
        end
        node = node:parent()
    end
    if not node then
        vim.notify("Not inside a function", vim.log.levels.ERROR, { title = "Snippet" })
        return t ""
    end

    local query = assert(vim.treesitter.query.get("go", "return-snippet"), "No Query")

    for _, capture in query:iter_captures(node, 0) do
        if handlers[capture:type()] then
            return handlers[capture:type()](capture, info)
        end
    end
    return {}
end

local go_return_values = function()
    return sn(
        nil,
        go_result_type {
            index = 0,
        }
    )
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

local function get_method_or_function_name(node)
    if node:type() == "method_declaration" then
        return get_node_text(node:named_child(1), 0)
    end
    return get_node_text(node:named_child(0), 0)
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
        local text = get_node_text(capture, 0)
        if text:sub(1, 1) == "*" then
            return "(" .. text .. ")"
        end
        return text
    end
    return "Method Receiver Not Found"
end

local function get_package_node(node)
    local root = node:tree():root()
    local query = assert(vim.treesitter.query.get("go", "package-node"), "No Query")
    for _, capture in query:iter_captures(root, 0) do
        return capture
    end
    return nil
end

local function get_package_text(node)
    local package_node = get_package_node(node)
    if package_node then
        return get_node_text(package_node, 0) .. "."
    end
    vim.notify("Package name not found", vim.log.levels.ERROR, { title = "Snippet" })
    return ""
end

local function get_function_name()
    local node = vim.treesitter.get_node()
    local method_or_function_node = get_method_or_function_declaration_node(node)
    if not method_or_function_node then
        vim.notify("Not inside a function", vim.log.levels.ERROR, { title = "Snippet" })
        return ""
    end
    local fn_name = get_method_or_function_name(method_or_function_node)
    if method_or_function_node:type() == "method_declaration" then
        return ([[(%s.%s.%s)]]):format(get_package_text(node), get_method_receiver_type_text(node), fn_name)
    end
    return ([[(%s.%s)]]):format(get_package_text(node), fn_name)
end

local function get_context_var_name()
    local node = vim.treesitter.get_node()
    while node ~= nil do
        if function_node_types[node:type()] then
            local query = assert(vim.treesitter.query.get("go", "get-function-params"), "No Query")
            for _, capture in query:iter_captures(node, 0) do
                local var_name = capture:named_child(0)
                if var_name:type() == "identifier" then
                    local type_name = capture:named_child(1)
                    local type_text = get_node_text(type_name, 0)
                    if type_text == "context.Context" then
                        return get_node_text(var_name, 0)
                    end
                end
            end
        end
        node = node:parent()
    end
    return "context.Background()"
end

local create_tower_build_choice = function(index)
    return c(index, {
        t "Freeze()",
        sn(nil, { i(1), t "Log(", f(get_context_var_name), t ")" }),
        -- stylua: ignore start
        isn(nil, {
            i(1), t "Log(", f(get_context_var_name), t ").",
            t {"", "Notify("}, f(get_context_var_name), t ")",
        }, "$PARENT_INDENT\t\t"),
        -- stylua: ignore end
    }, {
        node_ext_opts = {
            active = {
                virt_text = { { "<-- Choose build choice" } },
            },
        },
    })
end

local function register_snippet()
    ls.add_snippets("go", {
        s(
            "errt",
            fmta(
                [[
if <err> != nil {
    errt := tower.
        Wrap(<err_same>, "<caller> <message>").
        <build>
	return <result>
}
<finish>
]],
                {
                    err = i(1, "err"),
                    err_same = rep(1),
                    caller = f(get_function_name),
                    message = i(2, "message"),
                    build = create_tower_build_choice(3),
                    result = d(4, go_return_values),
                    finish = i(0),
                }
            )
        ),
        s(
            "errtc",
            fmta(
                [[
if <err> != nil {
    errt := tower.
        Wrap(<err_same>, "<caller> <message>").
        Context(<fields>).
        <build>
	return <result>
}
<finish>
]],
                {
                    err = i(1, "err"),
                    err_same = rep(1),
                    caller = f(get_function_name),
                    message = i(2, "message"),
                    fields = i(3),
                    build = create_tower_build_choice(4),
                    result = d(5, go_return_values),
                    finish = i(0),
                }
            )
        ),
        s(
            "errtp",
            fmta(
                [[
if <err> != nil {
    errt := tower.
        Wrap(<err_same>, "<caller> <message>").
        PublicMessage("<public_message>").
        <build>
	return <result>
}
<finish>
]],
                {
                    err = i(1, "err"),
                    err_same = rep(1),
                    caller = f(get_function_name),
                    message = i(2, "message"),
                    public_message = i(3, "public_message"),
                    build = create_tower_build_choice(4),
                    result = d(5, go_return_values),
                    finish = i(0),
                }
            )
        ),
        s(
            "errtpc",
            fmta(
                [[
if <err> != nil {
    errt := tower.
        Wrap(<err_same>, "<caller> <message>").
        PublicMessage("<public_message>").
        Context(<fields>).
        <build>
	return <result>
}
<finish>
]],
                {
                    err = i(1, "err"),
                    err_same = rep(1),
                    caller = f(get_function_name),
                    message = i(2, "message"),
                    public_message = i(3, "public_message"),
                    fields = i(4),
                    build = create_tower_build_choice(5),
                    result = d(6, go_return_values),
                    finish = i(0),
                }
            )
        ),
        s(
            "errb",
            fmta(
                [[
if <condition> {
    errt := tower.
        Bail("<caller> <message>").
        <build>
	return <result>
}
<finish>
]],
                {
                    condition = i(1),
                    caller = f(get_function_name),
                    message = i(2, "message"),
                    build = create_tower_build_choice(3),
                    result = d(4, go_return_values),
                    finish = i(0),
                }
            )
        ),
        s(
            "errbc",
            fmta(
                [[
if <condition> {
    errt := tower.
        Bail("<caller> <message>").
        Context(<fields>).
        <build>
	return <result>
}
<finish>
]],
                {
                    condition = i(1),
                    caller = f(get_function_name),
                    message = i(2, "message"),
                    fields = i(3),
                    build = create_tower_build_choice(4),
                    result = d(5, go_return_values),
                    finish = i(0),
                }
            )
        ),
        s(
            "errbp",
            fmta(
                [[
if <condition> {
    errt := tower.
        Bail("<caller> <message>").
        PublicMessage("<public_message>").
        <build>
	return <result>
}
<finish>
]],
                {
                    condition = i(1),
                    caller = f(get_function_name),
                    message = i(2, "message"),
                    public_message = i(3, "public_message"),
                    build = create_tower_build_choice(4),
                    result = d(5, go_return_values),
                    finish = i(0),
                }
            )
        ),
        s(
            "errbpc",
            fmta(
                [[
if <condition> {
    errt := tower.
        Bail("<caller> <message>").
        PublicMessage("<public_message>").
        Context(<fields>).
        <build>
	return <result>
}
<finish>
]],
                {
                    condition = i(1),
                    caller = f(get_function_name),
                    message = i(2, "message"),
                    public_message = i(3, "public_message"),
                    fields = i(4),
                    build = create_tower_build_choice(5),
                    result = d(6, go_return_values),
                    finish = i(0),
                }
            )
        ),
    })
end

register_snippet()
