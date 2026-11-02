local M = {}

local hover_ns = vim.api.nvim_create_namespace('lsp_hover_signature')

-- Hover signatures have no body, so parsers rarely recognise them as declarations
-- and the name falls back to @variable, often the same colour as the prose below.
local function set_hover_highlights()
    vim.api.nvim_set_hl(
        0,
        'LspHoverFunctionName',
        { link = '@function', default = true }
    )
end

--- Finds the callable name in a signature line: the identifier directly before
--- its parameter list, optionally with generics in between (`map<U>(`).
--- @param line string
--- @return integer? start_col 0-based, inclusive
--- @return integer? end_col 0-based, exclusive
local function find_signature_name(line)
    local best_s, best_e
    for _, pattern in ipairs({
        '()[%a_$][%w_$]*()%(',
        '()[%a_$][%w_$]*()%b<>%(',
    }) do
        local s, e = line:match(pattern)
        if s and (not best_s or s < best_s) then
            best_s, best_e = s, e
        end
    end
    if best_s then
        return best_s - 1, best_e - 1
    end
end

--- Inserts a thematic break between a leading signature code block and the
--- description after it. Neovim expands `---` into a `─` rule of the float's width.
--- @param contents string[]
--- @return string[]
local function separate_hover_signature(contents)
    local lines = vim.split(table.concat(contents, '\n'), '\n')
    local first = 1
    while lines[first] and lines[first]:match('^%s*$') do
        first = first + 1
    end
    if not (lines[first] and lines[first]:match('^%s*```')) then
        return contents
    end

    for close = first + 1, #lines do
        if lines[close]:match('^%s*```') then
            local next_line = close + 1
            while lines[next_line] and lines[next_line]:match('^%s*$') do
                next_line = next_line + 1
            end
            if
                not lines[next_line]
                or lines[next_line]:match('^%s*[-*_]%s*[-*_]%s*[-*_][-*_%s]*$')
            then
                return contents
            end
            table.insert(lines, close + 1, '')
            table.insert(lines, close + 2, '---')
            table.insert(lines, close + 3, '')
            return lines
        end
    end
    return contents
end

--- Highlights the function name on the first line of the hover's first code block.
--- @param bufnr integer
local function highlight_hover_signature(bufnr)
    vim.api.nvim_buf_clear_namespace(bufnr, hover_ns, 0, -1)
    -- Normalized hover text has no leading blank lines, so a signature starts at row 0
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, 2, false)
    if not (lines[1] and lines[1]:match('^```')) then
        return
    end
    local code = lines[2]
    local start_col, end_col = find_signature_name(code or '')
    if start_col and not code:match('^```') then
        vim.api.nvim_buf_set_extmark(bufnr, hover_ns, 1, start_col, {
            end_col = end_col,
            hl_group = 'LspHoverFunctionName',
            priority = vim.hl.priorities.user,
        })
    end
end

function M.setup()
    vim.diagnostic.config({
        signs = {
            text = {
                [vim.diagnostic.severity.ERROR] = ' ',
                [vim.diagnostic.severity.WARN] = ' ',
                [vim.diagnostic.severity.INFO] = ' ',
                [vim.diagnostic.severity.HINT] = ' ',
            },
        },
        virtual_text = {
            prefix = '●',
            spacing = 4,
        },
        update_in_insert = false,
        underline = true,
        severity_sort = true,
        float = {
            focusable = false,
            border = 'rounded',
            source = true,
            header = '',
            prefix = '',
        },
    })

    -- Modern Neovim 0.11+ way to set global borders for LSP windows
    vim.lsp.config('*', {
        window = {
            hover = { border = 'rounded' },
            signature_help = { border = 'rounded' },
        },
    })

    -- `:colorscheme` clears user-defined groups, so re-link after every switch
    set_hover_highlights()
    vim.api.nvim_create_autocmd('ColorScheme', {
        group = vim.api.nvim_create_augroup(
            'lsp_hover_highlights',
            { clear = true }
        ),
        callback = set_hover_highlights,
    })

    -- vim.lsp.buf.hover() exposes no post-render hook; it tags its float with this
    -- focus_id, so wrap the renderer and decorate only hover windows.
    local open_floating_preview = vim.lsp.util.open_floating_preview
    ---@diagnostic disable-next-line: duplicate-set-field
    vim.lsp.util.open_floating_preview = function(contents, syntax, opts)
        local is_hover = opts and opts.focus_id == 'textDocument/hover'
        if is_hover and syntax == 'markdown' then
            contents = separate_hover_signature(contents)
        end
        local bufnr, winnr = open_floating_preview(contents, syntax, opts)
        if bufnr and is_hover then
            highlight_hover_signature(bufnr)
        end
        return bufnr, winnr
    end
end

return M
