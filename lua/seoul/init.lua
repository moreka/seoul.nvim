--  _____             _
-- |   __|___ ___ _ _| |
-- |__   | -_| . | | | |
-- |_____|___|___|___|_|.nvim
--
-- Low-contrast dark Neovim color scheme using Seoul Colors
-- based on seoul256.vim
--
-- Repo:        https://github.com/moreka/seoul.nvim
-- Author:      Mohammad Reza Karimi
-- License:     MIT
-- Original:    https://github.com/junegunn/seoul256.vim

local M = {}

--stylua: ignore begin
local grays = {
    [1] = "#FFFFFF",    [2] = "#060606",    [3] = "#171717",
    [4] = "#252525",    [5] = "#333233",    [6] = "#3F3F3F",
    [7] = "#4B4B4B",    [8] = "#565656",    [9] = "#616161",
    [10] = "#6B6B6B",   [11] = "#757575",   [19] = "#BFBFBF",
    [20] = "#C8C8C8",   [21] = "#D1D0D1",   [22] = "#D9D9D9",
    [23] = "#E1E1E1",   [24] = "#E9E9E9",   [25] = "#F1F1F1",
}
--stylua: ignore end

-- Color palette based on actual colors used in seoul256.vim
local palette = {
    dark = {
        -- Accent colors
        red = "#d68787", -- 174
        green = "#87af87", -- 108
        yellow = "#d7af5f", -- 179
        yellow_bright = "#d7af87", -- 180
        orange = "#d7875f", -- 173
        gold = "#d7af87", -- 180
        blue = "#87afd7", -- 110
        cyan = "#5f8787", -- 66
        cyan_bright = "#87afaf", -- 109
        purple = "#af87af", -- 139
        magenta = "#d75f87", -- 168

        -- UI colors
        comment = "#808080", -- 244
        selection = "#4e4e4e", -- 239
        visual = "#005f87", -- 24
        search = "#005f87", -- 24
        inc_search = "#005f5f", -- 23
        cursor_line = "#444444", -- 238
        line_nr = "#767676", -- 243
        status_line_bg = "#626262", -- 241
        status_line_fg = "#d7d7af", -- 187
        pmenu_bg = "#444444", -- 238
        pmenu_sel = "#875f5f", -- 95

        -- Diff colors
        diff_add = "#87af87", -- 108
        diff_delete = "#d68787", -- 174
        diff_change = "#5f87af", -- 67

        -- Git colors
        git_add = "#5f8787", -- 66
        git_change = "#d7af5f", -- 179
        git_delete = "#d75f87", -- 168

        -- Special
        error = "#d75f87", -- 168
        warning = "#d7af5f", -- 179
        info = "#87afd7", -- 110
        hint = "#87af87", -- 108

        -- Terminal colors
        black = "#4e4e4e", -- 239
        white = "#d0d0d0", -- 252
    },
    light = {
        -- Accent colors
        red = "#af5f5f", -- 131
        green = "#5f8700", -- 64
        yellow = "#875f00", -- 94
        yellow_bright = "#af8700", -- 136
        orange = "#d75f00", -- 166
        gold = "#af875f", -- 137
        blue = "#005faf", -- 25
        cyan = "#005f87", -- 24
        cyan_bright = "#5f8787", -- 66
        purple = "#875faf", -- 97
        magenta = "#af005f", -- 125

        -- UI colors
        comment = "#8a8a8a", -- 245
        selection = "#d7d7d7", -- 188
        visual = "#5fafd7", -- 74
        search = "#5fafd7", -- 74
        inc_search = "#afd7d7", -- 152
        cursor_line = "#dadada", -- 253
        line_nr = "#949494", -- 246
        status_line_bg = "#444444", -- 238
        status_line_fg = "#d7d7af", -- 187
        pmenu_bg = "#dadada", -- 253
        pmenu_sel = "#875f5f", -- 95

        -- Diff colors
        diff_add = "#5f8700", -- 64
        diff_delete = "#af5f5f", -- 131
        diff_change = "#5f87af", -- 67

        -- Git colors
        git_add = "#5f8787", -- 66
        git_change = "#875f00", -- 94
        git_delete = "#af005f", -- 125

        -- Special
        error = "#af005f", -- 125
        warning = "#875f00", -- 94
        info = "#005faf", -- 25
        hint = "#5f8700", -- 64

        -- Terminal colors
        black = "#4e4e4e", -- 239
        white = "#e8e8e8", -- 253
    },
}

-- Configuration
M.config = {
    style = vim.o.background or "dark",
    darking_offset = 0,
    palette = { light = palette.light, dark = palette.dark },
}

local did_setup = false

function M.setup(opts)
    did_setup = true
    opts = opts or {}

    local offset = opts.darking_offset or M.config.darking_offset

    M.config.palette.dark.bg = grays[7 + offset]
    M.config.palette.dark.bg_lighter = grays[7 + offset + 2]
    M.config.palette.dark.bg_darker = grays[7 + offset - 2]
    M.config.palette.dark.fg = grays[22]
    M.config.palette.dark.fg_lighter = grays[22 + 2]
    M.config.palette.dark.fg_darker = grays[22 - 2]

    M.config.palette.light.bg = grays[23 + offset]
    M.config.palette.light.bg_lighter = grays[23 + offset + 3]
    M.config.palette.light.bg_darker = grays[23 + offset - 1]
    M.config.palette.light.fg = grays[9]
    M.config.palette.light.fg_lighter = grays[4]
    M.config.palette.light.fg_darker = grays[11]

    M.config = vim.tbl_deep_extend("force", M.config, opts)
end

local function hi(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
end

function M.load()
    if not did_setup then
        M.setup()
    end

    local colors = M.config.style == "light" and M.config.palette.light or M.config.palette.dark

    -- Editor highlights
    hi("Normal", { fg = colors.fg, bg = colors.bg })
    hi("NormalFloat", { fg = colors.fg, bg = colors.bg_lighter })
    hi("FloatBorder", { fg = colors.comment, bg = colors.bg_lighter })
    hi("ColorColumn", { bg = colors.bg_lighter })
    hi("Conceal", { fg = colors.comment })
    hi("Cursor", { fg = colors.bg, bg = colors.fg })
    hi("CursorLine", { bg = colors.cursor_line })
    hi("CursorColumn", { bg = colors.cursor_line })
    hi("CursorLineNr", { fg = colors.yellow, bg = colors.cursor_line })
    hi("LineNr", { fg = colors.line_nr, bg = colors.bg })
    hi("Directory", { fg = colors.blue })
    hi("DiffAdd", { fg = colors.diff_add })
    hi("DiffChange", { fg = colors.diff_change })
    hi("DiffDelete", { fg = colors.diff_delete })
    hi("DiffText", { fg = colors.yellow, bold = true })
    hi("ErrorMsg", { fg = colors.error })
    hi("VertSplit", { fg = colors.selection, bg = colors.bg })
    hi("Folded", { fg = colors.comment, bg = colors.bg_lighter })
    hi("FoldColumn", { fg = colors.comment, bg = colors.bg })
    hi("IncSearch", { fg = colors.yellow_bright, bg = colors.inc_search })
    hi("Search", { fg = colors.fg, bg = colors.search })
    hi("MatchParen", { fg = colors.yellow_bright, bg = colors.selection, bold = true })
    hi("ModeMsg", { fg = colors.orange })
    hi("MoreMsg", { fg = colors.orange })
    hi("NonText", { fg = colors.comment })
    hi("Pmenu", { fg = colors.fg, bg = colors.pmenu_bg })
    hi("PmenuSel", { fg = colors.fg, bg = colors.pmenu_sel })
    hi("PmenuSbar", { bg = colors.cyan })
    hi("PmenuThumb", { bg = colors.cyan_bright })
    hi("Question", { fg = colors.yellow })
    hi("SignColumn", { fg = colors.green, bg = colors.bg })
    hi("SpecialKey", { fg = colors.comment })
    hi("SpellBad", { sp = colors.error, undercurl = true })
    hi("SpellCap", { sp = colors.blue, undercurl = true })
    hi("SpellLocal", { sp = colors.cyan_bright, undercurl = true })
    hi("SpellRare", { sp = colors.purple, undercurl = true })
    hi("StatusLine", { fg = colors.status_line_fg, bg = colors.status_line_bg })
    hi("StatusLineNC", { fg = colors.pmenu_sel, bg = colors.status_line_fg })
    hi("TabLine", { fg = colors.fg_darker, bg = colors.bg_lighter })
    hi("TabLineFill", { fg = colors.bg_lighter })
    hi("TabLineSel", { fg = colors.status_line_fg, bg = colors.cyan })
    hi("Title", { fg = colors.gold })
    hi("Visual", { bg = colors.visual })
    hi("VisualNOS", { bg = colors.visual })
    hi("WarningMsg", { fg = colors.warning })
    hi("WildMenu", { fg = colors.pmenu_sel, bg = colors.yellow_bright })

    -- Syntax highlighting
    hi("Comment", { fg = colors.comment, italic = true })
    hi("Constant", { fg = colors.orange })
    hi("String", { fg = colors.green })
    hi("Character", { fg = colors.green })
    hi("Number", { fg = colors.purple })
    hi("Boolean", { fg = colors.purple })
    hi("Float", { fg = colors.purple })
    hi("Identifier", { fg = colors.fg })
    hi("Function", { fg = colors.yellow })
    hi("Statement", { fg = colors.blue })
    hi("Conditional", { fg = colors.blue })
    hi("Repeat", { fg = colors.blue })
    hi("Label", { fg = colors.blue })
    hi("Operator", { fg = colors.cyan_bright })
    hi("Keyword", { fg = colors.blue })
    hi("Exception", { fg = colors.blue })
    hi("PreProc", { fg = colors.cyan })
    hi("Include", { fg = colors.cyan })
    hi("Define", { fg = colors.cyan })
    hi("Macro", { fg = colors.cyan })
    hi("PreCondit", { fg = colors.cyan })
    hi("Type", { fg = colors.yellow })
    hi("StorageClass", { fg = colors.yellow })
    hi("Structure", { fg = colors.yellow })
    hi("Typedef", { fg = colors.yellow })
    hi("Special", { fg = colors.red })
    hi("SpecialChar", { fg = colors.red })
    hi("Tag", { fg = colors.blue })
    hi("Delimiter", { fg = colors.fg })
    hi("SpecialComment", { fg = colors.comment, bold = true })
    hi("Debug", { fg = colors.error })
    hi("Underlined", { underline = true })
    hi("Ignore", { fg = colors.comment })
    hi("Error", { fg = colors.error, bg = colors.bg_darker })
    hi("Todo", { fg = colors.yellow, bg = colors.bg_darker, bold = true })

    -- Treesitter
    hi("@variable", { fg = colors.fg })
    hi("@variable.builtin", { fg = colors.purple })
    hi("@variable.parameter", { fg = colors.fg })
    hi("@variable.member", { fg = colors.fg })
    hi("@constant", { fg = colors.orange })
    hi("@constant.builtin", { fg = colors.purple })
    hi("@module", { fg = colors.cyan })
    hi("@label", { fg = colors.blue })
    hi("@string", { fg = colors.green })
    hi("@string.escape", { fg = colors.red })
    hi("@string.special", { fg = colors.red })
    hi("@character", { fg = colors.green })
    hi("@number", { fg = colors.purple })
    hi("@boolean", { fg = colors.purple })
    hi("@float", { fg = colors.purple })
    hi("@function", { fg = colors.yellow })
    hi("@function.builtin", { fg = colors.yellow })
    hi("@function.macro", { fg = colors.cyan })
    hi("@function.method", { fg = colors.yellow })
    hi("@constructor", { fg = colors.yellow })
    hi("@keyword", { fg = colors.blue })
    hi("@keyword.function", { fg = colors.blue })
    hi("@keyword.operator", { fg = colors.blue })
    hi("@keyword.return", { fg = colors.blue })
    hi("@conditional", { fg = colors.blue })
    hi("@repeat", { fg = colors.blue })
    hi("@exception", { fg = colors.blue })
    hi("@operator", { fg = colors.cyan_bright })
    hi("@preproc", { fg = colors.cyan })
    hi("@include", { fg = colors.cyan })
    hi("@type", { fg = colors.yellow })
    hi("@type.builtin", { fg = colors.yellow })
    hi("@attribute", { fg = colors.cyan })
    hi("@property", { fg = colors.fg })
    hi("@tag", { fg = colors.blue })
    hi("@tag.attribute", { fg = colors.yellow })
    hi("@tag.delimiter", { fg = colors.fg })
    hi("@comment", { link = "Comment" })
    hi("@punctuation.delimiter", { fg = colors.fg })
    hi("@punctuation.bracket", { fg = colors.fg })
    hi("@punctuation.special", { fg = colors.red })

    -- LSP
    hi("DiagnosticError", { fg = colors.error })
    hi("DiagnosticWarn", { fg = colors.warning })
    hi("DiagnosticInfo", { fg = colors.info })
    hi("DiagnosticHint", { fg = colors.hint })
    hi("DiagnosticUnderlineError", { sp = colors.error, undercurl = true })
    hi("DiagnosticUnderlineWarn", { sp = colors.warning, undercurl = true })
    hi("DiagnosticUnderlineInfo", { sp = colors.info, undercurl = true })
    hi("DiagnosticUnderlineHint", { sp = colors.hint, undercurl = true })

    -- Git signs
    hi("GitSignsAdd", { fg = colors.git_add })
    hi("GitSignsChange", { fg = colors.git_change })
    hi("GitSignsDelete", { fg = colors.git_delete })

    -- Telescope
    hi("TelescopeNormal", { fg = colors.fg, bg = colors.bg })
    hi("TelescopeBorder", { fg = colors.comment, bg = colors.bg })
    hi("TelescopePromptBorder", { fg = colors.blue, bg = colors.bg })
    hi("TelescopeSelection", { fg = colors.fg, bg = colors.selection })
    hi("TelescopeMatching", { fg = colors.yellow, bold = true })

    -- NvimTree
    hi("NvimTreeNormal", { fg = colors.fg, bg = colors.bg })
    hi("NvimTreeFolderName", { fg = colors.blue })
    hi("NvimTreeFolderIcon", { fg = colors.blue })
    hi("NvimTreeOpenedFolderName", { fg = colors.blue, bold = true })
    hi("NvimTreeRootFolder", { fg = colors.purple, bold = true })
    hi("NvimTreeSpecialFile", { fg = colors.yellow })
    hi("NvimTreeGitDirty", { fg = colors.git_change })
    hi("NvimTreeGitNew", { fg = colors.git_add })
    hi("NvimTreeGitDeleted", { fg = colors.git_delete })

    -- Terminal colors
    vim.g.terminal_color_0 = colors.black
    vim.g.terminal_color_1 = colors.red
    vim.g.terminal_color_2 = colors.green
    vim.g.terminal_color_3 = colors.yellow
    vim.g.terminal_color_4 = colors.blue
    vim.g.terminal_color_5 = colors.purple
    vim.g.terminal_color_6 = colors.cyan
    vim.g.terminal_color_7 = colors.white
    vim.g.terminal_color_8 = colors.comment
    vim.g.terminal_color_9 = colors.red
    vim.g.terminal_color_10 = colors.green
    vim.g.terminal_color_11 = colors.yellow
    vim.g.terminal_color_12 = colors.blue
    vim.g.terminal_color_13 = colors.purple
    vim.g.terminal_color_14 = colors.cyan
    vim.g.terminal_color_15 = colors.fg
end

return M
