--
-- Built with,
--
--        ,gggg,
--       d8" "8I                         ,dPYb,
--       88  ,dP                         IP'`Yb
--    8888888P"                          I8  8I
--       88                              I8  8'
--       88        gg      gg    ,g,     I8 dPgg,
--  ,aa,_88        I8      8I   ,8'8,    I8dP" "8I
-- dP" "88P        I8,    ,8I  ,8'  Yb   I8P    I8
-- Yb,_,d88b,,_   ,d8b,  ,d8b,,8'_   8) ,d8     I8,
--  "Y8P"  "Y888888P'"Y88P"`Y8P' "YY8P8P88P     `Y8
--

-- This is a starter colorscheme for use with Lush,
-- for usage guides, see :h lush or :LushRunTutorial

--
-- Note: Because this is lua file, vim will append your file to the runtime,
--       which means you can require(...) it in other lua code (this is useful),
--       but you should also take care not to conflict with other libraries.
--
--       (This is a lua quirk, as it has somewhat poor support for namespacing.)
--
--       Basically, name your file,
--
--       "super_theme/lua/lush_theme/super_theme_dark.lua",
--
--       not,
--
--       "super_theme/lua/dark.lua".
--
--       With that caveat out of the way...
--

-- Enable lush.ify on this file, run:
--
--  `:Lushify`
--
--  or
--
--  `:lua require('lush').ify()`
--

---@diagnostic disable: undefined-global

local lush = require('lush')
local hsl = require('lush.hsl')

-- We start by defining the colorscheme. We use the original definition by
-- Ethan Schoonover's vim-colors-solarized which can be found here:
--     https://github.com/altercation/vim-colors-solarized

local color = {
    base03  = hsl("#002b36"),
    base02  = hsl("#073642"),
    base01  = hsl("#586e75"),
    base00  = hsl("#657b83"),
    base0   = hsl("#839496"),
    base1   = hsl("#93a1a1"),
    base2   = hsl("#eee8d5"),
    base3   = hsl("#fdf6e3"),
    yellow  = hsl("#b58900"),
    orange  = hsl("#cb4b16"),
    red     = hsl("#dc322f"),
    magenta = hsl("#d33682"),
    violet  = hsl("#6c71c4"),
    blue    = hsl("#268bd2"),
    cyan    = hsl("#2aa198"),
    green   = hsl("#859900"),
}

if vim.o.background == "light" then
    local temp03 = color.base03
    local temp02 = color.base02
    local temp01 = color.base01
    local temp00 = color.base00
    color.base03 = color.base3
    color.base02 = color.base2
    color.base01 = color.base1
    color.base00 = color.base0
    color.base0 = temp00
    color.base1 = temp01
    color.base2 = temp02
    color.base3 = temp03
end

color.none = nil
color.back = color.base03

-- Darkened color for the sideboard are not in the original palette
if vim.o.background == "light" then
    color.back_darken = color.base02
else
    color.back_darken = hsl("#001c27")
end

-- Next there are different formatting options that are defined based on a
-- theme options as well.

vim.g.solarized_bold = true
vim.g.solarized_italic = true
vim.g.solarized_underline = true
vim.g.solarized_diffmode = "normal"

local fmt = {
    none = nil,
    bold = vim.g.solarized_bold and "bold" or "",
    bldi = vim.g.solarized_bold
           and (vim.g.solarized_italic and "bold, italic" or "bold")
           or  (vim.g.solarized_italic and "italic" or ""),
    ital = vim.g.solarized_italic and "italic" or "",
    undr = vim.g.solarized_underline and "underline" or "",
    undb = vim.g.solarized_underline
           and (vim.g.solarized_bold and "underline, bold" or "underline")
           or  (vim.g.solarized_bold and "bold" or ""),
    undi = vim.g.solarized_underline
           and (vim.g.solarized_italic and "underline, italic" or "underline")
           or  (vim.g.solarized_italic and "italic" or ""),
    uopt = vim.g.solarized_contrast == "low" and "underline" or "",
    curl = "undercurl",
    stnd = "standout",
    revr = "inverse",
    revb = vim.g.solarized_bold and "reverse, bold" or "inverse",
    revbb = vim.g.solarized_bold and "reverse" or "reverse, bold",
    revbbu = vim.g.solarized_bold
             and (vim.g.solarized_underline and "inverse, underline" or "inverse")
             or  (vim.g.solarized_underline and "inverse, underline, bold" or "inverse, bold")
}

-- We have three possible options for contrast: low, default and high. For low
-- and high we have to swap some colors.

if vim.g.solarized_contrast == "high" then
    color.base03 = color.base00
    color.base00 = color.base0
    color.base0  = color.base1
    color.base1  = color.base2
    color.base2  = color.base3
end

if vim.g.solarized_contrast == "low" then
    color.back = color.base02
end

local theme = {}

theme.basic = lush(function ()
    return {
        Normal { gui = fmt.none, fg = color.base0, bg = color.back },
        Comment { gui = fmt.ital, fg = color.base01, bg = color.none },
        Constant { gui = fmt.none, fg = color.cyan, bg = color.none },
        Identifier { gui = fmt.none, fg = color.blue, bg = color.none },
        Statement { gui = fmt.none, fg = color.green, bg = color.none },
        PreProc { gui = fmt.none, fg = color.orange, bg = color.none },
        Type { gui = fmt.none, fg = color.yellow, bg = color.none },
        Special { gui = fmt.none, fg = color.red, bg = color.none },
        Underlined { gui = fmt.none, fg = color.violet, bg = color.none },
        Ignore { gui = fmt.none, fg = color.none, bg = color.none },
        Error { gui = fmt.bold, fg = color.red, bg = color.none },
        Todo { gui = fmt.bold, fg = color.magenta, bg = color.none }
    }
end)

theme.extended = lush(function ()
    return {
        StatusLine { gui = fmt.revbb, fg = color.base1, bg = color.base02 },
        StatusLineNC { gui = fmt.revbb, fg = color.base00, bg = color.base02 },
        Visual { gui = fmt.revbb, fg = color.base01, bg = color.base03 },
        Directory { gui = fmt.none, fg = color.blue, bg = color.none },
        ErrorMsg { gui = fmt.revr, fg = color.red, bg = color.none },
        IncSearch { gui = fmt.stnd, fg = color.orange, bg = color.none },
        Search { gui = fmt.revr, fg = color.yellow, bg = color.none },
        MoreMsg { gui = fmt.none, fg = color.blue, bg = color.none },
        ModeMsg { gui = fmt.none, fg = color.blue, bg = color.none },
        LineNr { gui = fmt.none, fg = color.base01, bg = color.base02 },
        Question { gui = fmt.bold, fg = color.cyan, bg = color.none },
        VertSplit { gui = fmt.none, fg = color.base00, bg = color.base00 },
        Title { gui = fmt.bold, fg = color.orange, bg = color.none },
        VisualNOS { gui = fmt.stnd .. ', ' .. fmt.revbb, fg = color.none, bg = color.base02 },
        WarningMsg { gui = fmt.bold, fg = color.red, bg = color.none },
        WildMenu { gui = fmt.revbb, fg = color.base2, bg = color.base02 },
        Folded { gui = fmt.undb, fg = color.base0, bg = color.base02 },
        FoldColumn { gui = fmt.none, fg= color.base0, bg = color.base02 },
        SignColumn { gui = fmt.none, fg = color.base0 },
        Conceal { gui = fmt.none, fg = color.blue, bg = color.none },
        SpellBad { gui = fmt.curl, fg = color.none, bg = color.none, sp = color.red },
        SpellCap { gui = fmt.curl, fg = color.none, bg = color.none, sp = color.violet },
        SpellRare { gui = fmt.curl, fg = color.none, bg = color.none, sp = color.cyan },
        SpellLocal { gui = fmt.curl, fg = color.none, bg = color.none, sp = color.yellow },
        Pmenu { gui = fmt.revbb, fg = color.base0, bg = color.base02 },
        PmenuSel { gui = fmt.revbb, fg = color.base01, bg = color.base2 },
        PmenuSbar { gui = fmt.revbb, fg = color.base2, bg = color.base0 },
        PmenuThumb { gui = fmt.revbb, fg = color.base0, bg = color.base02 },
        TabLine { gui = fmt.undr, fg = color.base0, bg = color.base02, sp = color.base0 },
        TabLineFill { gui = fmt.undr, fg = color.base0, bg = color.base02, sp = color.base0 },
        TabLineSel { gui = fmt.revbbu, fg = color.base01, bg = color.base2, sp = color.base0 },
        CursorColumn { gui = fmt.none, fg = color.none, bg = color.base02 },
        CursorLine { gui = fmt.uopt, fg = color.none, bg = color.base02, sp = color.base1 },
        ColorColumn { gui = fmt.none, fg = color.none, bg = color.base02 },
        Cursor { gui = fmt.none, fg = color.base03, bg = color.base0 },
        lCursor { Cursor },
        MatchParen { gui = fmt.bold, fg = color.red, bg = color.base01 }
    }
end)

theme.extra = lush(function ()
    return {
        CursorLineNr { gui = fmt.bold, fg = color.base01, bg = color.base02 },
        NonText { gui = fmt.none, fg = color.base02, bg = color.none }, -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.

        NormalSB { gui = fmt.none, fg = color.none, bg = color.back_darken },
        NormalFloat { gui = fmt.none, fg = color.none, bg = color.back_darken },
        FloatBorder { gui = fmt.none, fg = color.base00, bg = color.back_darken },
    }
end)

if vim.g.solarized_diffmode == "high" then
    theme.diff = lush(function ()
        return {
            DiffAdd { gui = fmt.revr, fg = color.green, bg = color.none },
            DiffChange { gui = fmt.revr, fg = color.yellow, bg = color.none },
            DiffDelete { gui = fmt.revr, fg = color.red, bg = color.none },
            DiffText { gui = fmt.revr, fg = color.blue, bg = color.none }
        }
    end)
elseif vim.g.solarized_diffmode == "low" then
    theme.diff = lush(function ()
        return {
            DiffAdd { gui = fmt.undr, fg = color.green, bg = color.none, sp = color.yellow },
            DiffChange { gui = fmt.undr, fg = color.yellow, bg = color.none, sp = color.yellow },
            DiffDelete { gui = fmt.bold, fg = color.red, bg = color.none },
            DiffText { gui = fmt.undr, fg = color.blue, bg = color.none, sp = color.blue }
        }
    end)
else
    theme.diff = lush(function ()
        return {
            DiffAdd { gui = fmt.bold, fg = color.green, bg = color.base02, sp = color.green },
            Diffchange { gui = fmt.bold, fg = color.yellow, bg = color.base02, sp = color.yellow },
            DiffDelete { gui = fmt.bold, fg = color.red, bg = color.base02 },
            DiffText { gui = fmt.bold, fg = color.blue, bg = color.base02, sp = color.blue }
        }
    end)
end


theme.lsp = lush(function ()
    return {
        -- LspReferenceText            { } , -- used for highlighting "text" references
        -- LspReferenceRead            { } , -- used for highlighting "read" references
        -- LspReferenceWrite           { } , -- used for highlighting "write" references
        -- LspCodeLens                 { } , -- Used to color the virtual text of the codelens. See |nvim_buf_set_extmark()|.
        -- LspCodeLensSeparator        { } , -- Used to color the seperator between two or more code lens.
        -- LspSignatureActiveParameter { } , -- Used to highlight the active parameter in the signature help. See |vim.lsp.handlers.signature_help()|.
    }
end)

theme.diagnostic = lush(function ()
    return {
        DiagnosticError { gui = fmt.none, fg = color.red, bg = color.none },
        DiagnosticWarn { gui = fmt.none, fg = color.orange, bg = color.none },
        DiagnosticInfo { gui = fmt.none, fg = color.cyan, bg = color.none },
        DiagnosticHint { gui = fmt.none, fg = color.base1, bg = color.none },

        DiagnosticVirtualTextError { gui = fmt.none, fg = color.red, bg = color.base02 },
        DiagnosticVirtualTextWarn { gui = fmt.none, fg = color.orange, bg = color.base02 },
        DiagnosticVirtualTextInfo { gui = fmt.none, fg = color.cyan, bg = color.base02 },
        DiagnosticVirtualTextHint { gui = fmt.none, fg = color.base1, bg = color.base02 },

        DiagnosticUnderlineError { gui = fmt.undr, fg = color.none, bg = color.none, sp = DiagnosticError.fg },
        DiagnosticUnderlineWarn { gui = fmt.undr, fg = color.none, bg = color.none, sp = DiagnosticWarn.fg },
        DiagnosticUnderlineInfo { gui = fmt.undr, fg = color.none, bg = color.none, sp = DiagnosticInfo.fg },
        DiagnosticUnderlineHint { gui = fmt.undr, fg = color.none, bg = color.none, sp = DiagnosticHint.fg },

        -- DiagnosticFloatingError    { } , -- Used to color "Error" diagnostic messages in diagnostics float. See |vim.diagnostic.open_float()|
        -- DiagnosticFloatingWarn     { } , -- Used to color "Warn" diagnostic messages in diagnostics float.
        -- DiagnosticFloatingInfo     { } , -- Used to color "Info" diagnostic messages in diagnostics float.
        -- DiagnosticFloatingHint     { } , -- Used to color "Hint" diagnostic messages in diagnostics float.
    }
end)

theme.treesitter = lush(function ()
    return {
    -- TSAttribute          { } , -- Annotations that can be attached to the code to denote some kind of meta information. e.g. C++/Dart attributes.
    -- TSBoolean            { } , -- Boolean literals: `True` and `False` in Python.
    -- TSCharacter          { } , -- Character literals: `'a'` in C.
    -- TSComment            { } , -- Line comments and block comments.
    -- TSConditional        { } , -- Keywords related to conditionals: `if`, `when`, `cond`, etc.
    -- TSConstant           { } , -- Constants identifiers. These might not be semantically constant. E.g. uppercase variables in Python.
    -- TSConstBuiltin       { } , -- Built-in constant values: `nil` in Lua.
    -- TSConstMacro         { } , -- Constants defined by macros: `NULL` in C.
    -- TSConstructor        { } , -- Constructor calls and definitions: `{}` in Lua, and Java constructors.
    -- TSError              { } , -- Syntax/parser errors. This might highlight large sections of code while the user is typing still incomplete code, use a sensible highlight.
    -- TSException          { } , -- Exception related keywords: `try`, `except`, `finally` in Python.
    -- TSField              { } , -- Object and struct fields.
    -- TSFloat              { } , -- Floating-point number literals.
    -- TSFunction           { } , -- Function calls and definitions.
    -- TSFuncBuiltin        { } , -- Built-in functions: `print` in Lua.
    -- TSFuncMacro          { } , -- Macro defined functions (calls and definitions): each `macro_rules` in Rust.
    -- TSInclude            { } , -- File or module inclusion keywords: `#include` in C, `use` or `extern crate` in Rust.
    -- TSKeyword            { } , -- Keywords that don't fit into other categories.
    -- TSKeywordFunction    { } , -- Keywords used to define a function: `function` in Lua, `def` and `lambda` in Python.
    -- TSKeywordOperator    { } , -- Unary and binary operators that are English words: `and`, `or` in Python; `sizeof` in C.
    -- TSKeywordReturn      { } , -- Keywords like `return` and `yield`.
    -- TSLabel              { } , -- GOTO labels: `label:` in C, and `::label::` in Lua.
    -- TSMethod             { } , -- Method calls and definitions.
    -- TSNamespace          { } , -- Identifiers referring to modules and namespaces.
    -- TSNone               { } , -- No highlighting (sets all highlight arguments to `NONE`). this group is used to clear certain ranges, for example, string interpolations. Don't change the values of this highlight group.
    -- TSNumber             { } , -- Numeric literals that don't fit into other categories.
    -- TSOperator           { } , -- Binary or unary operators: `+`, and also `->` and `*` in C.
    -- TSParameter          { } , -- Parameters of a function.
    -- TSParameterReference { } , -- References to parameters of a function.
    -- TSProperty           { } , -- Same as `TSField`.
    -- TSPunctDelimiter     { } , -- Punctuation delimiters: Periods, commas, semicolons, etc.
    -- TSPunctBracket       { } , -- Brackets, braces, parentheses, etc.
    -- TSPunctSpecial       { } , -- Special punctuation that doesn't fit into the previous categories.
    -- TSRepeat             { } , -- Keywords related to loops: `for`, `while`, etc.
    -- TSString             { } , -- String literals.
    -- TSStringRegex        { } , -- Regular expression literals.
    -- TSStringEscape       { } , -- Escape characters within a string: `\n`, `\t`, etc.
    -- TSStringSpecial      { } , -- Strings with special meaning that don't fit into the previous categories.
    -- TSSymbol             { } , -- Identifiers referring to symbols or atoms.
    -- TSTag                { } , -- Tags like HTML tag names.
    -- TSTagAttribute       { } , -- HTML tag attributes.
    -- TSTagDelimiter       { } , -- Tag delimiters like `<` `>` `/`.
    -- TSText               { } , -- Non-structured text. Like text in a markup language.
    -- TSStrong             { } , -- Text to be represented in bold.
    -- TSEmphasis           { } , -- Text to be represented with emphasis.
    -- TSUnderline          { } , -- Text to be represented with an underline.
    -- TSStrike             { } , -- Strikethrough text.
    -- TSTitle              { } , -- Text that is part of a title.
    -- TSLiteral            { } , -- Literal or verbatim text.
    -- TSURI                { } , -- URIs like hyperlinks or email addresses.
    -- TSMath               { } , -- Math environments like LaTeX's `$ ... $`
    -- TSTextReference      { } , -- Footnotes, text references, citations, etc.
    -- TSEnvironment        { } , -- Text environments of markup languages.
    -- TSEnvironmentName    { } , -- Text/string indicating the type of text environment. Like the name of a `\begin` block in LaTeX.
    -- TSNote               { } , -- Text representation of an informational note.
    -- TSWarning            { } , -- Text representation of a warning note.
    -- TSDanger             { } , -- Text representation of a danger note.
    -- TSType               { } , -- Type (and class) definitions and annotations.
    -- TSTypeBuiltin        { } , -- Built-in types: `i32` in Rust.
    -- TSVariable           { } , -- Variable names that don't fit into other categories.
    -- TSVariableBuiltin    { } , -- Variable names defined by the language: `this` or `self` in Javascript.
    }
end)

theme.git = lush(function ()
    return {
        gitcommitComment { gui = fmt.ital, fg = color.base01, bg = color.none },
        gitcommitUntracked { gitcommitComment },
        gitcommitDiscarded { gitcommitComment },
        gitcommitSelected { gitcommitComment },
        gitcommitUnmerged { gui = fmt.bold, fg = color.green, bg = color.none },
        gitcommitOnBranch { gui = fmt.bold, fg = color.base01, bg = color.none },
        gitcommitBranch { gui = fmt.bold, fg = color.magenta, bg = color.none },
        gitcommitNoBranch { gitcommitBranch },
        gitcommitDicardedType { gui = fmt.bold, fg = color.red, bg = color.none },
        gitcommitSelectedType { gui = fmt.bold, fg = color.green, bg = color.none },
        gitcommitHeader { gui = fmt.none, fg = color.base01, bg = color.none },
        gitcommitUntrackedFile { gui = fmt.bold, fg = color.cyan, bg = color.none },
        gitcommitDiscardedFile { gui = fmt.bold, fg = color.red, bg = color.none },
        gitcommitSelectedFile { gui = fmt.bold, fg = color.green, bg = color.none },
        gitcommitUnmergedFile { gui = fmt.bold, fg = color.yellow, bg = color.none },
        gitcommitFile { gui = fmt.bold, fg = color.base0, bg = color.none },
        gitcommitDiscardedArrow { gitcommitDiscardedFile },
        gitcommitSelectedArrow { gitcommitSelectedFile },
        gitcommitUnmergedArrow { gitcommitUnmergedFile }
    }
end)

theme.html = lush(function ()
    return {
        htmlTag { gui = fmt.none, fg = color.base01, bg = colors.none },
        htmlEndTag { gui = fmt.none, fg = color.base01, bg = color.none },
        htmlTagN { gui = fmt.bold, fg = color.base1, bg = color.none },
        htmlTagName { gui = fmt.bold, fg = color.blue, bg = color.none },
        htmlSpecialTagName { gui = fmt.ital, fg = color.blue, bg = color.none },
        htmlArg { gui = fmt.none, fg = color.base00, bg = color.none },
        javaScript { gui = fmt.none, fg = color.yellow, bg = color.none }
    }
end)

theme.tex = lush(function ()
    return {
        texStatement { gui = fmt.none, fg = color.cyan, bg = color.back },
        texMathZoneX { gui = fmt.none, fg = color.yellow, bg = color.back },
        texMathMatcher { gui = fmt.none, fg = color.yellow, bg = color.back },
        texRefLabel { gui = fmt.none, fg = color.yellow, bg = color.back }
    }
end)

theme.indent = lush(function ()
    return {
        IndentBlanklineChar { gui = ftm.none, fg = color.base02, bg = color.none }
    }
end)

theme.opinionated = lush(function ()
    return {
        Special { gui = ftm.none, fg = color.base0, bg = color.none },

        SignColumn { gui = fmt.none, fg = color.base01, bg = color.base02.mix(color.base03, 50) },
        VertSplit { gui = fmt.none, fg = color.back, bg = color.base02 },
        LineNr { gui = fmt.none, fg = color.base01, bg = color.base02.mix(color.base03, 50) },

        DiagnosticSignError { gui = fmt.none, fg = color.red, bg = SignColumn.bg },
        DiagnosticSignWarn { gui = fmt.none, fg = color.orange, bg = SignColumn.bg },
        DiagnosticSignInfo { gui = fmt.none, fg = color.cyan, bg = SignColumn.bg },
        DiagnosticSignHint { gui = fmt.none, fg = color.base1, bg = SignColumn.bg },

        TabLine { gui = fmt.none, fg = color.base0, bg = color.base02 },
        TabLineFill { gui = fmt.none, fg = color.base0, bg = color.back_darken },
        TabLineSel { gui = fmt.revbb, fg = color.base01, bg = color.base2 },
    }
end)

return lush.merge({
    theme.basic,
    theme.extended,
    theme.extra,
    theme.diff,
    theme.treesitter,
    theme.html,
    theme.tex,
    theme.git,
    theme.lsp,
    theme.diagnostic,
    theme.indent,
    theme.opinionated,
})

-- vi:nowrap
