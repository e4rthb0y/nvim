local lspconfig = require('lspconfig')
local util = lspconfig.util

---@class WorkspaceResolver
local M = {}

---@enum Server
M.server = {
    VTSLS = 'vtsls',
    DENOLS = 'denols',
    JSONLS = 'jsonls',
}

---@type string[]
M.NODE_MARKERS = { 'package.json', 'tsconfig.json', 'jsconfig.json' }

---@type string[]
M.DENO_MARKERS = { 'deno.json', 'deno.jsonc', 'import_map.json' }

---@type string[]
M.DEFAULT_MARKERS = { '.git' }

---@class HandlerCtx
---@field deno_root string|nil The deno root, if exists.
---@field node_root string|nil The node root, if exists.
---@field server Server The server called to attach to the workspace.
---@field fname string The path of the file being opened/resolved.

--- Resolves root conflicts between Deno and Node for the Deno language server.
--- If Deno root is deeper (closer to the file), engage `denols`.
---@param ctx HandlerCtx
---@return string|nil root The absolute path to the project root, or nil if it should not attach.
local function denols_handler(ctx)
    if not ctx.deno_root then
        return nil
    end

    if not ctx.node_root then
        return ctx.deno_root
    end

    if string.len(ctx.deno_root) > string.len(ctx.node_root) then
        return ctx.deno_root
    end

    return nil
end

--- Resolves root conflicts between Deno and Node for the Node (vtsls) language server.
--- If Node root is deeper (closer to the file), engage `vtsls`.
---@param ctx HandlerCtx
---@return string|nil root The absolute path to the project root, or nil if it should not attach.
local function vtsls_handler(ctx)
    if not ctx.node_root then
        return nil
    end

    if not ctx.deno_root then
        return ctx.node_root
    end

    if string.len(ctx.node_root) > string.len(ctx.deno_root) then
        return ctx.node_root
    end

    return nil
end

--- Fails loud on ties. Instead of providing a default, we wait for the real
--- necessity to emerge to decide on a course of action.
---@param ctx HandlerCtx
local function tie_breaker(ctx)
    if
        ctx.node_root
        and ctx.deno_root
        and string.len(ctx.node_root) == string.len(ctx.deno_root)
    then
        error(
            'ERR_RUNTIME_COLLISION: Node workspace and Deno configuration detected at the same boundary. '
                .. 'Resolution for this architectural overlap is not yet designed. '
                .. 'Explicitly define the runtime hierarchy to proceed.',
            0
        )
    end
end

--- Notifies error when no handler was found for the server passed as argument.
---@param error string
local function notify_exception(error)
    vim.notify(
        error,
        vim.log.levels.ERROR,
        { title = '[LSP:Workspace] Resolution Error' }
    )
end

local HANDLERS = {
    [M.server.VTSLS] = vtsls_handler,
    [M.server.DENOLS] = denols_handler,
}

--- Resolves language server in conflicting workspaces using TypeScript using
--- `vtsls` or `denols` (or both). The marker closest to the active buffer
--- dictates the active language server.
---@param fname string The path of the file being opened/resolved.
---@param server Server The language server for which the root is being evaluated.
---@return string|nil root_path The absolute path to the project root, or nil if it should not attach.
function M.get_exclusive_ts_root(fname, server)
    local ok, result
    local handler = HANDLERS[server]

    if not handler then
        notify_exception('No handler for server provided: ' .. tostring(server))
        return nil
    end

    local ctx = {
        deno_root = util.root_pattern(unpack(M.DENO_MARKERS))(fname),
        node_root = util.root_pattern(unpack(M.NODE_MARKERS))(fname),
        server = server,
        fname = fname,
    }

    ok, result = pcall(tie_breaker, ctx)
    if not ok then
        notify_exception(tostring(result))
        return nil
    end

    ok, result = pcall(handler, ctx)
    if not ok then
        notify_exception(tostring(result))
        return nil
    end

    return result
end

return M
