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
        NonText { gui = fmt.none, fg = color.base02, bg = color.none },

        -- Sidebars and floats
        NormalSB { gui = fmt.none, fg = color.none, bg = color.back_darken },
        NormalFloat { gui = fmt.none, fg = color.none, bg = color.back_darken },
        FloatBorder { gui = fmt.none, fg = color.base00, bg = color.back_darken },

        -- Terminal highlight
        DarkenedPanel { gui = fmt.none, fg = color.none, bg = color.back_darken },
        DarkenedStatusLine { gui = fmt.none, fg =color.none, bg = color.back_darken },
        DarkenedStatusLineNC { gui = fmt.none, fg =color.none, bg = color.back_darken }
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

        DiagnosticVirtualTextError { gui = fmt.none, fg = color.red, bg = color.none },
        DiagnosticVirtualTextWarn { gui = fmt.none, fg = color.orange, bg = color.none },
        DiagnosticVirtualTextInfo { gui = fmt.none, fg = color.cyan, bg = color.none },
        DiagnosticVirtualTextHint { gui = fmt.none, fg = color.base1, bg = color.none },

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
        TSAnnotation { gui = fmt.none, fg = color.magenta, bg = color.none } ,
        -- TSAttribute          { } , -- Annotations that can be attached to the code to denote some kind of meta information. e.g. C++/Dart attributes.
        TSBoolean { gui = fmt.none, fg = color.violet, bg = color.none } , -- Boolean literals: `True` and `False` in Python.
        TSCharacter { gui = fmt.ital, fg = color.cyan, bg = color.none } , -- Character literals: `'a'` in C.
        TSComment { gui = fmt.ital, fg = color.base01, bg = color.none } , -- Line comments and block comments.
        TSConditional { gui = fmt.none, fg = color.green, bg = color.none } , -- Keywords related to conditionals: `if`, `when`, `cond`, etc.
        TSConstant { gui = fmt.none, fg = color.violet, bg = color.noe } , -- Constants identifiers. These might not be semantic
        TSConstBuiltin { gui = fmt.none, fg = color.violet, bg = color.none } , -- Built-in constant values: `nil` in Lua.
        TSConstMacro { gui = fmt.none, fg = color.violet, bg =  color.none } , -- Constants defined by macros: `NULL` in C.
        TSConstructor { gui = fmt.none, fg = color.blue, bg = color.none } , -- Constructor calls and definitions: `{}` in Lua, and Java constructors.
        -- TSError              { } , -- Syntax/parser errors. This might highlight large sections of code while the user is typing still incomplete code, use a sensible highlight.
        -- TSException          { } , -- Exception related keywords: `try`, `except`, `finally` in Python.
        TSField { gui = fmt.none, fg = color.base0, bg = color.none } , -- Object and struct fields.
        TSFloat { gui = fmt.none, fg = color.violet, bg = color.none } , -- Floating-point number literals.
        TSFunction { gui = fmt.none, fg = color.blue, bg = color.none } , -- Function calls and definitions.
        TSFuncBuiltin { gui = fmt.ital, fg = color.blue, bg = color.none } , -- Built-in functions: `print` in Lua.
        -- TSFuncMacro          { } , -- Macro defined functions (calls and definitions): each `macro_rules` in Rust.
        TSInclude { gui = fmt.none, fg = color.orange, bg = color.none } , -- File or module inclusion keywords: `#include` in C, `use` or `extern crate` in Rust.
        TSKeyword { gui = fmt.none, fg = color.green, bg = color.none } , -- Keywords that don't fit into other categories.
        TSKeywordFunction { gui = fmt.bold, fg = color.base1, bg = color.none } , -- Keywords used to define a function: `function` in Lua, `def` and `lambda` in Python.
        TSKeywordOperator { gui = fmt.none, fg = color.green, bg = color.none } , -- Unary and binary operators that are English words: `and`, `or` in Python; `sizeof` in C.
        TSKeywordReturn { gui = fmt.none, fg = color.green, bg = color.none } , -- Keywords like `return` and `yield`.
        TSLabel { gui = fmt.none, fg = color.magenta, bg = color.none } , -- GOTO labels: `label:` in C, and `::label::` in Lua.
        TSMethod { gui = fmt.ital, fg = color.blue, bg = color.none } , -- Method calls and definitions.
        -- TSNamespace          { } , -- Identifiers referring to modules and namespaces.
        TSNone {} , -- No highlighting (sets all highlight arguments to `NONE`). this group is used to clear certain ranges, for example, string interpolations. Don't change the values of this highlight group.
        TSNumber { gui = fmt.none, fg = color.violet, bg = color.none } , -- Numeric literals that don't fit into other categories.
        TSOperator {} , -- Binary or unary operators: `+`, and also `->` and `*` in C.
        TSParameter { gui = fmt.ital, fg = color.none, bg = color.none } , -- Parameters of a function.
        -- TSParameterReference { } , -- References to parameters of a function.
        TSProperty { gui = fmt.ital, fg = color.base0, bg = color.none } , -- Same as `TSField`.
        -- TSPunctDelimiter     { } , -- Punctuation delimiters: Periods, commas, semicolons, etc.
        -- TSPunctBracket       { } , -- Brackets, braces, parentheses, etc.
        -- TSPunctSpecial       { } , -- Special punctuation that doesn't fit into the previous categories.
        -- TSRepeat             { } , -- Keywords related to loops: `for`, `while`, etc.
        TSString { gui = fmt.none, fg = color.cyan, bg = color.none } , -- String literals.
        -- TSStringRegex        { } , -- Regular expression literals.
        -- TSStringEscape       { } , -- Escape characters within a string: `\n`, `\t`, etc.
        -- TSStringSpecial      { } , -- Strings with special meaning that don't fit into the previous categories.
        TSSymbol { gui = fmt.none, fg = color.violet, bg = color.none } , -- Identifiers referring to symbols or atoms.
        TSTag { gui = fmt.none, fg = color.base01, bg = color.none } , -- Tags like HTML tag names.
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
        TSType { gui = fmt.none, fg = color.yellow, bg = color.none } , -- Type (and class) definitions and annotations.
        -- TSTypeBuiltin        { } , -- Built-in types: `i32` in Rust.
        -- TSVariable           { } , -- Variable names that don't fit into other categories.
        TSVariableBuiltin { gui = fmt.ital, fg = color.green, bg = color.none,  } , -- Variable names defined by the language: `this` or `self` in Javascript.
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

theme.pandoc = lush(function ()
    return {
        pandocTitleBlock { gui = fmt.none, fg = color.blue, bg = color.none },
        pandocTitleBlockTitle { gui = fmt.bold, fg = color.blue, bg = color.none },
        pandocTitleComment { gui = fmt.bold, fg = color.blue, bg = color.none },
        pandocComment { gui = fmt.ital, fg = color.base01, bg = color.none },
        pandocVerbatimBlock { gui = fmt.none, fg = color.yellow, bg = color.none },
        pandocVerbatimBlockDeep { pandocVerbatimBlock },
        pandocCodeBlock { pandocVerbatimBlock },
        pandocCodeBlockDelim { pandocVerbatimBlock },
        pandocBlockQuote { gui = fmt.none, fg = color.blue, bg = color.none },
        pandocBlockQuoteLeader1 { gui = fmt.none, fg = color.blue, bg = color.none },
        pandocBlockQuoteLeader2 { gui = fmt.none, fg = color.cyan, bg = color.none },
        pandocBlockQuoteLeader3 { gui = fmt.none, fg = color.yellow, bg = color.none },
        pandocBlockQuoteLeader4 { gui = fmt.none, fg = color.red, bg = color.none },
        pandocBlockQuoteLeader5 { gui = fmt.none, fg = color.base0, bg = color.none },
        pandocBlockQuoteLeader6 { gui = fmt.none, fg = color.base01, bg = color.none },
        pandocListMarker { gui = fmt.none, fg = color.magenta, bg = color.none },
        pandocListReference { gui = fmt.undr, fg = color.magenta, bg = color.none },

        -- Definitions
        -- Tables

        -- Headings
        pandocHeading { gui = fmt.bold, fg = color.orange, bg = color.none },
        pandocHeadingMarker { gui = fmt.bold, fg = color.yellow, bg = color.none },
        pandocEmphasisHeading { gui = fmt.bldi, fg = color.orange, bg = color.none },
        pandocEmphasisNestedHeading { gui = fmt.bldi, fg = color.orange, bg = color.none },
        pandocStrongEmphasisHeading { gui = fmt.bold, fg = color.orange, bg = color.none },
        pandocStrongEmphasisNestedHeading { gui = fmt.bldi, fg = color.orange, bg = color.none },
        pandocStrongEmphasisEmphasisHeading { gui = fmt.bldi, fg = color.orange, bg = color.none },
        pandocStrikeoutHeading { gui = fmt.revr, fg = color.orange, bg = color.none },
        pandocVerbatimInlineHeading { gui = fmt.bold, fg = color.orange, bg = color.none },
        pandocSuperscriptHeading { gui = fmt.bold, fg = color.orange, bg = color.none },
        pandocSubscriptHeading { gui = fmt.bold, fg = color.orange, bg = color.none },

        -- Links
        -- Main styles
        -- Embedded code
    }
end)

theme.indent = lush(function ()
    return {
        IndentBlanklineChar { gui = ftm.none, fg = color.base02, bg = color.none }
    }
end)

theme.telescope = lush(function ()
    return {
        TelescopeNormal { gui = fmt.none, fg = color.none, bg = color.back_darken },
        TelescopeBorder { gui = fmt.none, fg = color.base01, bg = color.back_darken },
    }
end)

theme.whichkey = lush(function ()
    return {
        WhichKey { gui = fmt.none, fg = color.magenta, bg = color.none },
    }
end)

theme.lualine = lush(function ()
    return {
        lualine_a_inactive { gui=fmt.none, fg=color.base00, bg=color.base02 },

        lualine_a_insert { gui=fmt.revbb, fg=color.base1, bg=color.base02 },
        lualine_a_normal { gui=fmt.revbb, fg=color.base1, bg=color.base02 },
        lualine_a_replace { gui=fmt.revb, fg=color.orange, bg=color.base02 },
        lualine_a_visual { gui=fmt.revb, fg=color.magenta, bg=color.base02 },

        lualine_b_diagnostics_error_inactive { gui = fmt.revbb, fg=color.base00, bg=color.base02 },
        lualine_b_diagnostics_error_normal { gui = fmt.revbb, fg=color.base1, bg=color.base02 },
        lualine_b_diagnostics_hint_inactive { gui = fmt.revbb, fg = color.base00, bg=color.base02 },
        lualine_b_diagnostics_hint_normal { gui = fmt.revbb, fg=color.base1, bg=color.base02 },
        lualine_b_diagnostics_info_inactive { gui = fmt.revbb, fg= color.base00, bg=color.base02 },
        lualine_b_diagnostics_info_normal { gui = fmt.revbb, fg=color.base1, bg=color.base02 },
        lualine_b_diagnostics_warn_inactive { gui = fmt.revbb, fg = color.base00, bg =color.base02 },
        lualine_b_diagnostics_warn_normal { gui = fmt.revbb, fg=color.base1, bg=color.base02 },

        lualine_b_diff_added_inactive { gui=fmt.revbb, fg=color.base00, bg=color.base02 },
        lualine_b_diff_added_normal { gui = fmt.revbb, fg=color.base1, bg=color.base02 },
        lualine_b_diff_modified_inactive { gui=fmt.revbb, fg=color.base00, bg=color.base02 },
        lualine_b_diff_modified_normal { gui = fmt.revbb, fg=color.base1, bg=color.base02 },
        lualine_b_diff_removed_inactive { gui = fmt.revbb, fg = color.base00, bg = color.base02 },
        lualine_b_diff_removed_normal { gui = fmt.revbb, fg=color.base1, bg=color.base02 },

        lualine_b_inactive { gui=fmt.revbb, fg=color.base00, bg=color.base02 },
        lualine_b_normal { gui = fmt.revbb, fg=color.base1, bg=color.base02 },

        lualine_c_inactive { gui = fmt.revbb, fg=color.base00, bg=color.base02 },
        lualine_c_normal { gui = fmt.revbb, fg=color.base1, bg=color.base02 },

        lualine_x_DevIconLua_normal { gui = fmt.revbb, fg=color.base1, bg=color.base02 },
    }
end)

theme.opinionated = lush(function ()
    return {
        Special { gui = ftm.none, fg = color.base0, bg = color.none },

        SignColumn { gui = fmt.none, fg = color.base01, bg = color.base02 },
        VertSplit { gui = fmt.none, fg = color.back, bg = color.base02 },
        LineNr { gui = fmt.none, fg = color.base01, bg = color.base02 },

        -- For diagnostics, I find it's easier to spot it when it's something
        -- outside of palette
        DiagnosticError { gui = fmt.none, fg = color.red.saturate(60), bg = color.none },
        DiagnosticWarn { gui = fmt.none, fg = hsl("#ffa500"), bg = color.none },
        DiagnosticInfo { gui = fmt.none, fg = color.cyan.saturate(70), bg = color.none },
        DiagnosticHint { gui = fmt.none, fg = color.base1, bg = color.none },

        DiagnosticVirtualTextError { gui = fmt.none, fg = color.base1, bg = color.base02 },
        DiagnosticVirtualTextWarn { gui = fmt.none, fg = color.base1, bg = color.base02 },
        DiagnosticVirtualTextInfo { gui = fmt.none, fg = color.base1, bg = color.base02 },
        DiagnosticVirtualTextHint { gui = fmt.none, fg = color.base1, bg = color.base02 },

        DiagnosticUnderlineError { gui = fmt.undr, fg = color.none, bg = color.none, sp = DiagnosticError.fg.saturate(100) },
        DiagnosticUnderlineWarn { gui = fmt.undr, fg = color.none, bg = color.none, sp = DiagnosticWarn.fg.saturate(100) },
        DiagnosticUnderlineInfo { gui = fmt.undr, fg = color.none, bg = color.none, sp = DiagnosticInfo.fg.saturate(100) },
        DiagnosticUnderlineHint { gui = fmt.undr, fg = color.none, bg = color.none, sp = DiagnosticHint.fg },

        DiagnosticSignError { gui = fmt.none, fg = DiagnosticError.fg, bg = SignColumn.bg },
        DiagnosticSignWarn { gui = fmt.none, fg = DiagnosticWarn.fg, bg = SignColumn.bg },
        DiagnosticSignInfo { gui = fmt.none, fg = DiagnosticInfo.fg, bg = SignColumn.bg },
        DiagnosticSignHint { gui = fmt.none, fg = DiagnosticHint.fg, bg = SignColumn.bg },

        TabLine { gui = fmt.none, fg = color.base0, bg = color.base02 },
        TabLineFill { gui = fmt.none, fg = color.base0, bg = color.back_darken },
        TabLineSel { gui = fmt.revbb, fg = color.base01, bg = color.base2 },

        -- Minor adjustments
        gitcommitSummary { gui = fmt.bold, fg = color.orange, bg = color.none },
    }
end)

theme.devicons = lush(function ()
    return {
        DevIconAi      { fg=hsl("#cbcb41") },
        DevIconAwk     { fg=hsl("#4d5a5e") },
        DevIconBabelrc { fg=hsl("#cbcb41") },
        DevIconBash    { fg=hsl("#89e051") },
        DevIconBashProfile { fg=hsl("#89e051") },
        DevIconBashrc  { fg=hsl("#89e051") },
        DevIconBat     { fg=hsl("#C1F12E") },
        DevIconBinaryGLTF { fg=hsl("#FFB13B") },
        DevIconBmp     { fg=hsl("#a074c4") },
        DevIconBrewfile { fg=color.orange },
        DevIconC       { fg=color.violet },
        DevIconCMake   { fg=color.base1 },
        DevIconCMakeLists { fg=color.base1 },
        DevIconCPlusPlus { fg=hsl("#f34b7d") },
        DevIconClojure { fg=hsl("#8dc149") },
        DevIconClojureC { fg=hsl("#8dc149") },
        DevIconClojureJS { fg=hsl("#519aba") },
        DevIconCobol   { fg=hsl("#005ca5") },
        DevIconCoffee  { fg=hsl("#cbcb41") },
        DevIconConf    { fg=hsl("#6d8086") },
        DevIconConfigRu { fg=hsl("#701516") },
        DevIconConfiguration { fg=hsl("#ECECEC") },
        DevIconCp      { fg=hsl("#519aba") },
        DevIconCpp     { fg=hsl("#519aba") },
        DevIconCrystal { fg=hsl("#000000") },
        DevIconCs      { fg=hsl("#596706") },
        DevIconCsh     { fg=hsl("#4d5a5e") },
        DevIconCson    { fg=hsl("#cbcb41") },
        DevIconCss     { fg=hsl("#563d7c") },
        DevIconCsv     { fg=hsl("#89e051") },
        DevIconCxx     { fg=hsl("#519aba") },
        DevIconD       { fg=hsl("#427819") },
        DevIconDart    { fg=hsl("#03589C") },
        DevIconDb      { fg=hsl("#dad8d8") },
        DevIconDefault { fg=color.base00 },
        DevIconDesktopEntry { fg=hsl("#563d7c") },
        DevIconDiff    { fg=hsl("#41535b") },
        DevIconDoc     { fg=hsl("#185abd") },
        DevIconDockerfile { fg=hsl("#384d54") },
        DevIconDropbox { fg=hsl("#0061FE") },
        DevIconDsStore { fg=hsl("#41535b") },
        DevIconDump    { fg=hsl("#dad8d8") },
        DevIconEdn     { fg=hsl("#519aba") },
        DevIconEex     { fg=hsl("#a074c4") },
        DevIconEjs     { fg=hsl("#cbcb41") },
        DevIconElm     { fg=hsl("#519aba") },
        DevIconEpp     { fg=hsl("#FFA61A") },
        DevIconErb     { fg=hsl("#701516") },
        DevIconErl     { fg=hsl("#B83998") },
        DevIconEx      { fg=hsl("#a074c4") },
        DevIconExs     { fg=hsl("#a074c4") },
        DevIconFavicon { fg=hsl("#cbcb41") },
        DevIconFish    { fg=hsl("#4d5a5e") },
        DevIconFs      { fg=hsl("#519aba") },
        DevIconFsharp  { fg=hsl("#519aba") },
        DevIconFsi     { fg=hsl("#519aba") },
        DevIconFsscript { fg=hsl("#519aba") },
        DevIconFsx     { fg=hsl("#519aba") },
        DevIconGDScript { fg=hsl("#6d8086") },
        DevIconGemfile { fg=hsl("#701516") },
        DevIconGemspec { fg=hsl("#701516") },
        DevIconGif     { fg=hsl("#a074c4") },
        DevIconGitAttributes { fg=hsl("#41535b") },
        DevIconGitCommit { fg=hsl("#41535b") },
        DevIconGitConfig { fg=hsl("#41535b") },
        DevIconGitIgnore { fg=hsl("#41535b") },
        DevIconGitLogo { fg=hsl("#F14C28") },
        DevIconGitModules { fg=hsl("#41535b") },
        DevIconGitlabCI { fg=hsl("#e24329") },
        DevIconGo      { fg=hsl("#519aba") },
        DevIconGodotProject { fg=hsl("#6d8086") },
        DevIconGruntfile { fg=hsl("#e37933") },
        DevIconGulpfile { fg=hsl("#cc3e44") },
        DevIconGvimrc  { fg=hsl("#019833") },
        DevIconH       { fg=hsl("#a074c4") },
        DevIconHaml    { fg=hsl("#eaeae1") },
        DevIconHbs     { fg=hsl("#f0772b") },
        DevIconHeex    { fg=hsl("#a074c4") },
        DevIconHh      { fg=hsl("#a074c4") },
        DevIconHpp     { fg=hsl("#a074c4") },
        DevIconHrl     { fg=hsl("#B83998") },
        DevIconHs      { fg=hsl("#a074c4") },
        DevIconHtm     { fg=hsl("#e34c26") },
        DevIconHtml    { fg=hsl("#e34c26") },
        DevIconHxx     { fg=hsl("#a074c4") },
        DevIconIco     { fg=hsl("#cbcb41") },
        DevIconImportConfiguration { fg=hsl("#ECECEC") },
        DevIconIni     { fg=hsl("#6d8086") },
        DevIconJava    { fg=hsl("#cc3e44") },
        DevIconJl      { fg=hsl("#a270ba") },
        DevIconJpeg    { fg=hsl("#a074c4") },
        DevIconJpg     { fg=hsl("#a074c4") },
        DevIconJs      { fg=color.violet },
        DevIconJson    { fg=color.base1 },
        DevIconJsx     { fg=color.cyan },
        DevIconKotlin  { fg=hsl("#F88A02") },
        DevIconKsh     { fg=hsl("#4d5a5e") },
        DevIconLeex    { fg=hsl("#a074c4") },
        DevIconLess    { fg=hsl("#563d7c") },
        DevIconLhs     { fg=hsl("#a074c4") },
        DevIconLicense { fg=color.base1 },
        DevIconLua     { fg=color.blue },
        DevIconMakefile { fg=hsl("#6d8086") },
        DevIconMarkdown { fg=color.orange },
        DevIconMaterial { fg=hsl("#B83998") },
        DevIconMd      { fg=color.base00 },
        DevIconMdx     { fg=hsl("#519aba") },
        DevIconMint    { fg=hsl("#87c095") },
        DevIconMixLock { fg=hsl("#a074c4") },
        DevIconMjs     { fg=hsl("#f1e05a") },
        DevIconMl      { fg=hsl("#e37933") },
        DevIconMli     { fg=hsl("#e37933") },
        DevIconMustache { fg=hsl("#e37933") },
        DevIconNPMIgnore { fg=hsl("#E8274B") },
        DevIconNim     { fg=hsl("#f3d400") },
        DevIconNix     { fg=hsl("#7ebae4") },
        DevIconNodeModules { fg=hsl("#E8274B") },
        DevIconOPUS    { fg=hsl("#F88A02") },
        DevIconOpenTypeFont { fg=hsl("#ECECEC") },
        DevIconPackedResource { fg=hsl("#6d8086") },
        DevIconPdf     { fg=hsl("#b30b00") },
        DevIconPhp     { fg=hsl("#a074c4") },
        DevIconPl      { fg=hsl("#519aba") },
        DevIconPm      { fg=hsl("#519aba") },
        DevIconPng     { fg=color.magenta },
        DevIconPp      { fg=hsl("#FFA61A") },
        DevIconPpt     { fg=hsl("#cb4a32") },
        DevIconProcfile { fg=hsl("#a074c4") },
        DevIconProlog  { fg=hsl("#e4b854") },
        DevIconPromptPs1 { fg=hsl("#4d5a5e") },
        DevIconPsb     { fg=hsl("#519aba") },
        DevIconPsd     { fg=hsl("#519aba") },
        DevIconPy      { fg=color.orange },
        DevIconPyc     { fg=color.orange.mix(color.back_darken, 25) },
        DevIconPyd     { fg=color.orange.mix(color.back_darken, 25) },
        DevIconPyo     { fg=color.orange.mix(color.back_darken, 25) },
        DevIconR       { fg=hsl("#358a5b") },
        DevIconRake    { fg=hsl("#701516") },
        DevIconRakefile { fg=hsl("#701516") },
        DevIconRb      { fg=hsl("#701516") },
        DevIconRlib    { fg=hsl("#dea584") },
        DevIconRmd     { fg=hsl("#519aba") },
        DevIconRproj   { fg=hsl("#358a5b") },
        DevIconRs      { fg=hsl("#dea584") },
        DevIconRss     { fg=hsl("#FB9D3B") },
        DevIconSass    { fg=hsl("#f55385") },
        DevIconScala   { fg=hsl("#cc3e44") },
        DevIconScss    { fg=hsl("#f55385") },
        DevIconSettingsJson { fg=hsl("#854CC7") },
        DevIconSh      { fg=hsl("#4d5a5e") },
        DevIconSig     { fg=hsl("#e37933") },
        DevIconSlim    { fg=hsl("#e34c26") },
        DevIconSln     { fg=hsl("#854CC7") },
        DevIconSml     { fg=hsl("#e37933") },
        DevIconSql     { fg=hsl("#dad8d8") },
        DevIconStyl    { fg=hsl("#8dc149") },
        DevIconSuo     { fg=hsl("#854CC7") },
        DevIconSvelte  { fg=hsl("#ff3e00") },
        DevIconSvg     { fg=hsl("#FFB13B") },
        DevIconSwift   { fg=hsl("#e37933") },
        DevIconTerminal { fg=hsl("#31B53E") },
        DevIconTex     { fg=hsl("#3D6117") },
        DevIconTextResource { fg=hsl("#cbcb41") },
        DevIconTextScene { fg=hsl("#a074c4") },
        DevIconToml    { fg=hsl("#6d8086") },
        DevIconTor     { fg=hsl("#519aba") },
        DevIconTs      { fg=hsl("#519aba") },
        DevIconTsx     { fg=hsl("#519aba") },
        DevIconTwig    { fg=hsl("#8dc149") },
        DevIconTxt     { fg=color.base00 },
        DevIconVagrantfile { fg=hsl("#1563FF") },
        DevIconVim     { fg=color.green },
        DevIconVimrc   { fg=color.green },
        DevIconVue     { fg=hsl("#8dc149") },
        DevIconWebmanifest { fg=hsl("#f1e05a") },
        DevIconWebp    { fg=hsl("#a074c4") },
        DevIconWebpack { fg=hsl("#519aba") },
        DevIconXcPlayground { fg=hsl("#e37933") },
        DevIconXls     { fg=hsl("#207245") },
        DevIconXml     { fg=hsl("#e37933") },
        DevIconXul     { fg=hsl("#e37933") },
        DevIconYaml    { fg=color.base1 },
        DevIconYml     { fg=color.base1 },
        DevIconZig     { fg=hsl("#f69a1b") },
        DevIconZsh     { fg=hsl("#89e051") },
        DevIconZshenv  { fg=hsl("#89e051") },
        DevIconZshprofile { fg=hsl("#89e051") },
        DevIconZshrc   { fg=hsl("#89e051") },
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
    theme.pandoc,
    theme.git,
    theme.lsp,
    theme.diagnostic,
    theme.indent,
    theme.telescope,
    theme.devicons,
    theme.whichkey,
    theme.lualine,
    theme.opinionated,
})

-- vi:nowrap


-- DiagnosticError xxx ctermfg=1 guifg=#DC312E
-- DiagnosticFloatingError xxx links to DiagnosticError
-- DiagnosticFloatingHint xxx links to DiagnosticHint
-- DiagnosticFloatingInfo xxx links to DiagnosticInfo
-- DiagnosticFloatingWarn xxx links to DiagnosticWarn
-- DiagnosticHint xxx ctermfg=7 guifg=#92A0A0
-- DiagnosticInfo xxx ctermfg=4 guifg=#2AA298
-- DiagnosticOther xxx cleared
-- DiagnosticSignError xxx guifg=#DC312E guibg=#03333F
-- DiagnosticSignHint xxx guifg=#92A0A0 guibg=#03333F
-- DiagnosticSignInfo xxx guifg=#2AA298 guibg=#03333F
-- DiagnosticSignOther xxx cleared
-- DiagnosticSignWarn xxx guifg=#CA4C16 guibg=#03333F
-- DiagnosticUnderlineError xxx cterm=underline gui=underline guisp=#DC312E
-- DiagnosticUnderlineHint xxx cterm=underline gui=underline guisp=#92A0A0
-- DiagnosticUnderlineInfo xxx cterm=underline gui=underline guisp=#2AA298
-- DiagnosticUnderlineWarn xxx cterm=underline gui=underline guisp=#CA4C16
-- DiagnosticVirtualTextError xxx guifg=#DC312E guibg=#073541
-- DiagnosticVirtualTextHint xxx guifg=#92A0A0 guibg=#073541
-- DiagnosticVirtualTextInfo xxx guifg=#2AA298 guibg=#073541
-- DiagnosticVirtualTextWarn xxx guifg=#CA4C16 guibg=#073541
-- DiagnosticWarn xxx ctermfg=3 guifg=#CA4C16
--
-- ErrorMsg       xxx ctermfg=15 ctermbg=1 gui=reverse guifg=#DC312E
-- Exception      xxx links to Statement
-- Float          xxx links to Number
--
-- FloatBorder    xxx guifg=#647A82 guibg=#001D29
-- FloatShadow    xxx guibg=Black blend=80
-- FloatShadowThrough xxx guibg=Black blend=100
--
-- FoldColumn     xxx ctermfg=14 ctermbg=242 guifg=#839495 guibg=#073541
-- Folded         xxx ctermfg=14 ctermbg=242 gui=bold,underline guifg=#839495 guibg=#073541
-- Function       xxx links to Identifier
-- Identifier     xxx cterm=bold ctermfg=14 guifg=#278BD3
-- Ignore         xxx ctermfg=0
-- IncSearch      xxx cterm=reverse gui=standout guifg=#CA4C16
-- Include        xxx links to PreProc
-- IndentBlanklineChar xxx guifg=#073541
-- IndentBlanklineContextChar xxx cterm=nocombine ctermfg=11 gui=nocombine guifg=#859900
-- IndentBlanklineContextStart xxx cterm=underline gui=underline guisp=#859900
-- IndentBlanklineSpaceChar xxx cterm=nocombine ctermfg=12 gui=nocombine guifg=#073541
-- IndentBlanklineSpaceCharBlankline xxx cterm=nocombine ctermfg=12 gui=nocombine guifg=#073541
-- Keyword        xxx links to Statement
-- Label          xxx links to Statement
-- LineNr         xxx ctermfg=11 guifg=#586E74 guibg=#03333F
-- LineNrAbove    xxx links to LineNr
-- LineNrBelow    xxx links to LineNr
-- LspTroubleNormal xxx cleared
-- Macro          xxx links to PreProc
-- MatchParen     xxx ctermbg=6 gui=bold guifg=#DC312E guibg=#586E74
-- Method         xxx cleared
-- ModeMsg        xxx cterm=bold guifg=#278BD3
-- MoreMsg        xxx ctermfg=121 guifg=#278BD3
-- MsgArea        xxx cleared
-- MsgSeparator   xxx links to StatusLine
-- NeoTreeBufferNumber xxx links to SpecialChar
-- NeoTreeCursorLine xxx links to CursorLine
-- NeoTreeDimText xxx guifg=#505050
-- NeoTreeDirectoryIcon xxx guifg=#73cef4
-- NeoTreeDirectoryName xxx guifg=#NONE guibg=#NONE
-- NeoTreeFileIcon xxx links to NormalSB
-- NeoTreeFileName xxx guifg=#NONE guibg=#NONE
-- NeoTreeFileNameOpened xxx gui=bold
-- NeoTreeFilterTerm xxx links to SpecialChar
-- NeoTreeFloatBorder xxx links to FloatBorder
-- NeoTreeGitAdded xxx guifg=#5faf5f
-- NeoTreeGitConflict xxx guifg=#ff5900
-- NeoTreeGitModified xxx guifg=#d7af5f
-- NeoTreeGitUntracked xxx gui=italic guifg=#d7af5f
-- NeoTreeNormal  xxx links to NormalSB
-- NeoTreeNormalNC xxx links to NormalSB
-- NeoTreeRootName xxx gui=bold,italic
-- NeoTreeSymbolicLinkTarget xxx links to NeoTreeFileName
-- NeoTreeTitleBar xxx guibg=#647a82
-- NeogitDiffAddHighlight xxx gui=bold guifg=#859900 guibg=#073541
-- NeogitDiffContextHighlight xxx guibg=#133d47
-- NeogitDiffDeleteHighlight xxx gui=bold guifg=#DC312E guibg=#073541
-- NeogitHunkHeader xxx guibg=#133d47
-- NeogitHunkHeaderHighlight xxx guibg=#264c56
-- NonText        xxx ctermfg=12 guifg=#073541
-- Normal         xxx guifg=#839495 guibg=#002D38
-- NormalFloat    xxx guibg=#001D29
-- NormalNC       xxx cleared
-- NormalSB       xxx guibg=#001D29
-- Number         xxx links to Constant
-- NvimAnd        xxx links to NvimBinaryOperator
-- NvimArrow      xxx links to Delimiter
-- NvimAssignment xxx links to Operator
-- NvimAssignmentWithAddition xxx links to NvimAugmentedAssignment
-- NvimAssignmentWithConcatenation xxx links to NvimAugmentedAssignment
-- NvimAssignmentWithSubtraction xxx links to NvimAugmentedAssignment
-- NvimAugmentedAssignment xxx links to NvimAssignment
-- NvimBinaryMinus xxx links to NvimBinaryOperator
-- NvimBinaryOperator xxx links to NvimOperator
-- NvimBinaryPlus xxx links to NvimBinaryOperator
-- NvimCallingParenthesis xxx links to NvimParenthesis
-- NvimColon      xxx links to Delimiter
-- NvimComma      xxx links to Delimiter
-- NvimComparison xxx links to NvimBinaryOperator
-- NvimComparisonModifier xxx links to NvimComparison
-- NvimConcat     xxx links to NvimBinaryOperator
-- NvimConcatOrSubscript xxx links to NvimConcat
-- NvimContainer  xxx links to NvimParenthesis
-- NvimCurly      xxx links to NvimSubscript
-- NvimDict       xxx links to NvimContainer
-- NvimDivision   xxx links to NvimBinaryOperator
-- NvimDoubleQuote xxx links to NvimStringQuote
-- NvimDoubleQuotedBody xxx links to NvimStringBody
-- NvimDoubleQuotedEscape xxx links to NvimStringSpecial
-- NvimDoubleQuotedUnknownEscape xxx links to NvimInvalidValue
-- NvimEnvironmentName xxx links to NvimIdentifier
-- NvimEnvironmentSigil xxx links to NvimOptionSigil
-- NvimFigureBrace xxx links to NvimInternalError
-- NvimFloat      xxx links to NvimNumber
-- NvimIdentifier xxx links to Identifier
-- NvimIdentifierKey xxx links to NvimIdentifier
-- NvimIdentifierName xxx links to NvimIdentifier
-- NvimIdentifierScope xxx links to NvimIdentifier
-- NvimIdentifierScopeDelimiter xxx links to NvimIdentifier
-- NvimInternalError xxx ctermfg=9 ctermbg=9 guifg=Red guibg=Red
-- NvimInvalid    xxx links to Error
-- NvimInvalidAnd xxx links to NvimInvalidBinaryOperator
-- NvimInvalidArrow xxx links to NvimInvalidDelimiter
-- NvimInvalidAssignment xxx links to NvimInvalid
-- NvimInvalidAssignmentWithAddition xxx links to NvimInvalidAugmentedAssignment
-- NvimInvalidAssignmentWithConcatenation xxx links to NvimInvalidAugmentedAssignment
-- NvimInvalidAssignmentWithSubtraction xxx links to NvimInvalidAugmentedAssignment
-- NvimInvalidAugmentedAssignment xxx links to NvimInvalidAssignment
-- NvimInvalidBinaryMinus xxx links to NvimInvalidBinaryOperator
-- NvimInvalidBinaryOperator xxx links to NvimInvalidOperator
-- NvimInvalidBinaryPlus xxx links to NvimInvalidBinaryOperator
-- NvimInvalidCallingParenthesis xxx links to NvimInvalidParenthesis
-- NvimInvalidColon xxx links to NvimInvalidDelimiter
-- NvimInvalidComma xxx links to NvimInvalidDelimiter
-- NvimInvalidComparison xxx links to NvimInvalidBinaryOperator
-- NvimInvalidComparisonModifier xxx links to NvimInvalidComparison
-- NvimInvalidConcat xxx links to NvimInvalidBinaryOperator
-- NvimInvalidConcatOrSubscript xxx links to NvimInvalidConcat
-- NvimInvalidContainer xxx links to NvimInvalidParenthesis
-- NvimInvalidCurly xxx links to NvimInvalidSubscript
-- NvimInvalidDelimiter xxx links to NvimInvalid
-- NvimInvalidDict xxx links to NvimInvalidContainer
-- NvimInvalidDivision xxx links to NvimInvalidBinaryOperator
-- NvimInvalidDoubleQuote xxx links to NvimInvalidStringQuote
-- NvimInvalidDoubleQuotedBody xxx links to NvimInvalidStringBody
-- NvimInvalidDoubleQuotedEscape xxx links to NvimInvalidStringSpecial
-- NvimInvalidDoubleQuotedUnknownEscape xxx links to NvimInvalidValue
-- NvimInvalidEnvironmentName xxx links to NvimInvalidIdentifier
-- NvimInvalidEnvironmentSigil xxx links to NvimInvalidOptionSigil
-- NvimInvalidFigureBrace xxx links to NvimInvalidDelimiter
-- NvimInvalidFloat xxx links to NvimInvalidNumber
-- NvimInvalidIdentifier xxx links to NvimInvalidValue
-- NvimInvalidIdentifierKey xxx links to NvimInvalidIdentifier
-- NvimInvalidIdentifierName xxx links to NvimInvalidIdentifier
-- NvimInvalidIdentifierScope xxx links to NvimInvalidIdentifier
-- NvimInvalidIdentifierScopeDelimiter xxx links to NvimInvalidIdentifier
-- NvimInvalidLambda xxx links to NvimInvalidParenthesis
-- NvimInvalidList xxx links to NvimInvalidContainer
-- NvimInvalidMod xxx links to NvimInvalidBinaryOperator
-- NvimInvalidMultiplication xxx links to NvimInvalidBinaryOperator
-- NvimInvalidNestingParenthesis xxx links to NvimInvalidParenthesis
-- NvimInvalidNot xxx links to NvimInvalidUnaryOperator
-- NvimInvalidNumber xxx links to NvimInvalidValue
-- NvimInvalidNumberPrefix xxx links to NvimInvalidNumber
-- NvimInvalidOperator xxx links to NvimInvalid
-- NvimInvalidOptionName xxx links to NvimInvalidIdentifier
-- NvimInvalidOptionScope xxx links to NvimInvalidIdentifierScope
-- NvimInvalidOptionScopeDelimiter xxx links to NvimInvalidIdentifierScopeDelimiter
-- NvimInvalidOptionSigil xxx links to NvimInvalidIdentifier
-- NvimInvalidOr  xxx links to NvimInvalidBinaryOperator
-- NvimInvalidParenthesis xxx links to NvimInvalidDelimiter
-- NvimInvalidPlainAssignment xxx links to NvimInvalidAssignment
-- NvimInvalidRegister xxx links to NvimInvalidValue
-- NvimInvalidSingleQuote xxx links to NvimInvalidStringQuote
-- NvimInvalidSingleQuotedBody xxx links to NvimInvalidStringBody
-- NvimInvalidSingleQuotedQuote xxx links to NvimInvalidStringSpecial
-- NvimInvalidSingleQuotedUnknownEscape xxx links to NvimInternalError
-- NvimInvalidSpacing xxx links to ErrorMsg
-- NvimInvalidString xxx links to NvimInvalidValue
-- NvimInvalidStringBody xxx links to NvimStringBody
-- NvimInvalidStringQuote xxx links to NvimInvalidString
-- NvimInvalidStringSpecial xxx links to NvimStringSpecial
-- NvimInvalidSubscript xxx links to NvimInvalidParenthesis
-- NvimInvalidSubscriptBracket xxx links to NvimInvalidSubscript
-- NvimInvalidSubscriptColon xxx links to NvimInvalidSubscript
-- NvimInvalidTernary xxx links to NvimInvalidOperator
-- NvimInvalidTernaryColon xxx links to NvimInvalidTernary
-- NvimInvalidUnaryMinus xxx links to NvimInvalidUnaryOperator
-- NvimInvalidUnaryOperator xxx links to NvimInvalidOperator
-- NvimInvalidUnaryPlus xxx links to NvimInvalidUnaryOperator
-- NvimInvalidValue xxx links to NvimInvalid
-- NvimLambda     xxx links to NvimParenthesis
-- NvimList       xxx links to NvimContainer
-- NvimMod        xxx links to NvimBinaryOperator
-- NvimMultiplication xxx links to NvimBinaryOperator
-- NvimNestingParenthesis xxx links to NvimParenthesis
-- NvimNot        xxx links to NvimUnaryOperator
-- NvimNumber     xxx links to Number
-- NvimNumberPrefix xxx links to Type
-- NvimOperator   xxx links to Operator
-- NvimOptionName xxx links to NvimIdentifier
-- NvimOptionScope xxx links to NvimIdentifierScope
-- NvimOptionScopeDelimiter xxx links to NvimIdentifierScopeDelimiter
-- NvimOptionSigil xxx links to Type
-- NvimOr         xxx links to NvimBinaryOperator
-- NvimParenthesis xxx links to Delimiter
-- NvimPlainAssignment xxx links to NvimAssignment
-- NvimRegister   xxx links to SpecialChar
-- NvimSingleQuote xxx links to NvimStringQuote
-- NvimSingleQuotedBody xxx links to NvimStringBody
-- NvimSingleQuotedQuote xxx links to NvimStringSpecial
-- NvimSingleQuotedUnknownEscape xxx links to NvimInternalError
-- NvimSpacing    xxx links to Normal
-- NvimString     xxx links to String
-- NvimStringBody xxx links to NvimString
-- NvimStringQuote xxx links to NvimString
-- NvimStringSpecial xxx links to SpecialChar
-- NvimSubscript  xxx links to NvimParenthesis
-- NvimSubscriptBracket xxx links to NvimSubscript
-- NvimSubscriptColon xxx links to NvimSubscript
-- NvimTernary    xxx links to NvimOperator
-- NvimTernaryColon xxx links to NvimTernary
-- NvimUnaryMinus xxx links to NvimUnaryOperator
-- NvimUnaryOperator xxx links to NvimOperator
-- NvimUnaryPlus  xxx links to NvimUnaryOperator
-- Operator       xxx links to Statement
-- Pmenu          xxx ctermfg=0 ctermbg=13 gui=reverse guifg=#839495 guibg=#073541
-- PmenuSbar      xxx ctermbg=248 gui=reverse guifg=#EDE7D4 guibg=#839495
-- PmenuSel       xxx ctermfg=242 ctermbg=0 gui=reverse guifg=#586E74 guibg=#EDE7D4
-- PmenuThumb     xxx ctermbg=15 gui=reverse guifg=#839495 guibg=#073541
-- PreCondit      xxx links to PreProc
-- PreProc        xxx ctermfg=81 guifg=#CA4C16
-- Question       xxx ctermfg=121 gui=bold guifg=#2AA298
-- QuickFixLine   xxx links to Search
-- RedrawDebugClear xxx ctermbg=11 guibg=Yellow
-- RedrawDebugComposed xxx ctermbg=10 guibg=Green
-- RedrawDebugNormal xxx cterm=reverse gui=reverse
-- RedrawDebugRecompose xxx ctermbg=9 guibg=Red
-- Repeat         xxx links to Statement
-- Search         xxx ctermfg=0 ctermbg=11 gui=reverse guifg=#B38600
-- SignColumn     xxx ctermfg=14 ctermbg=242 guifg=#586E74 guibg=#03333F
-- Special        xxx ctermfg=224 guifg=#839495
-- SpecialChar    xxx links to Special
-- SpecialComment xxx links to Special
-- SpellBad       xxx ctermbg=9 gui=undercurl guisp=#DC312E
-- SpellCap       xxx ctermbg=12 gui=undercurl guisp=#6D72C5
-- SpellLocal     xxx ctermbg=14 gui=undercurl guisp=#B38600
-- SpellRare      xxx ctermbg=13 gui=undercurl guisp=#2AA298
-- Statement      xxx ctermfg=11 guifg=#859900
-- StatusLine     xxx cterm=bold,reverse gui=reverse guifg=#92A0A0 guibg=#073541
-- StatusLineNC   xxx cterm=reverse gui=reverse guifg=#647A82 guibg=#073541
-- StorageClass   xxx links to Type
-- String         xxx links to Constant
-- Struct         xxx cleared
-- Structure      xxx links to Type
-- Substitute     xxx links to Search
-- TabLine        xxx cterm=underline ctermfg=15 ctermbg=242 guifg=#839495 guibg=#073541
-- TabLineFill    xxx cterm=reverse guifg=#839495 guibg=#001D29
-- TabLineSel     xxx cterm=bold gui=reverse guifg=#586E74 guibg=#EDE7D4
-- Tag            xxx links to Special
-- TelescopeBorder xxx guifg=#586E74 guibg=#001D29
-- TelescopeMatching xxx links to Special
-- TelescopeMultiIcon xxx links to Identifier
-- TelescopeMultiSelection xxx links to Type
-- TelescopeNormal xxx guibg=#001D29
-- TelescopePreviewBlock xxx links to Constant
-- TelescopePreviewBorder xxx links to TelescopeBorder
-- TelescopePreviewCharDev xxx links to Constant
-- TelescopePreviewDate xxx links to Directory
-- TelescopePreviewDirectory xxx links to Directory
-- TelescopePreviewExecute xxx links to String
-- TelescopePreviewGroup xxx links to Constant
-- TelescopePreviewHyphen xxx links to NonText
-- TelescopePreviewLine xxx links to Visual
-- TelescopePreviewLink xxx links to Special
-- TelescopePreviewMatch xxx links to Search
-- TelescopePreviewMessage xxx links to TelescopePreviewNormal
-- TelescopePreviewMessageFillchar xxx links to TelescopePreviewMessage
-- TelescopePreviewNormal xxx links to TelescopeNormal
-- TelescopePreviewPipe xxx links to Constant
-- TelescopePreviewRead xxx links to Constant
-- TelescopePreviewSize xxx links to String
-- TelescopePreviewSocket xxx links to Statement
-- TelescopePreviewSticky xxx links to Keyword
-- TelescopePreviewTitle xxx links to TelescopeTitle
-- TelescopePreviewUser xxx links to Constant
-- TelescopePreviewWrite xxx links to Statement
-- TelescopePromptBorder xxx links to TelescopeBorder
-- TelescopePromptCounter xxx links to NonText
-- TelescopePromptNormal xxx links to TelescopeNormal
-- TelescopePromptPrefix xxx links to Comment
-- TelescopePromptTitle xxx links to TelescopeTitle
-- TelescopeResultsBorder xxx links to TelescopeBorder
-- TelescopeResultsClass xxx links to Function
-- TelescopeResultsComment xxx links to Comment
-- TelescopeResultsConstant xxx links to Constant
-- TelescopeResultsDiffAdd xxx links to DiffAdd
-- TelescopeResultsDiffChange xxx links to DiffChange
-- TelescopeResultsDiffDelete xxx links to DiffDelete
-- TelescopeResultsDiffUntracked xxx links to NonText
-- TelescopeResultsField xxx links to Function
-- TelescopeResultsFunction xxx links to Function
-- TelescopeResultsIdentifier xxx links to Identifier
-- TelescopeResultsLineNr xxx links to LineNr
-- TelescopeResultsMethod xxx links to Method
-- TelescopeResultsNormal xxx links to TelescopeNormal
-- TelescopeResultsNumber xxx links to Number
-- TelescopeResultsOperator xxx links to Operator
-- TelescopeResultsSpecialComment xxx links to SpecialComment
-- TelescopeResultsStruct xxx links to Struct
-- TelescopeResultsTitle xxx links to TelescopeTitle
-- TelescopeResultsVariable xxx links to SpecialChar
-- TelescopeSelection xxx links to Visual
-- TelescopeSelectionCaret xxx links to TelescopeSelection
-- TelescopeTitle xxx links to Ignore
-- TermCursor     xxx cterm=reverse gui=reverse
-- TermCursorNC   xxx cleared
-- Title          xxx ctermfg=225 gui=bold guifg=#CA4C16
-- Todo           xxx ctermfg=0 ctermbg=11 gui=bold guifg=#D33682
-- TodoBgFIX      xxx gui=bold guifg=#839495 guibg=#dc312e
-- TodoBgHACK     xxx gui=bold guifg=#839495 guibg=#ca4c16
-- TodoBgNOTE     xxx gui=bold guifg=#002d38 guibg=#92a0a0
-- TodoBgPERF     xxx gui=bold guifg=#839495 guibg=#278bd3
-- TodoBgTODO     xxx gui=bold guifg=#839495 guibg=#2aa298
-- TodoBgWARN     xxx gui=bold guifg=#839495 guibg=#ca4c16
-- TodoFgFIX      xxx guifg=#dc312e
-- TodoFgHACK     xxx guifg=#ca4c16
-- TodoFgNOTE     xxx guifg=#92a0a0
-- TodoFgPERF     xxx guifg=#278bd3
-- TodoFgTODO     xxx guifg=#2aa298
-- TodoFgWARN     xxx guifg=#ca4c16
-- TodoSignFIX    xxx guifg=#dc312e guibg=#03333f
-- TodoSignHACK   xxx guifg=#ca4c16 guibg=#03333f
-- TodoSignNOTE   xxx guifg=#92a0a0 guibg=#03333f
-- TodoSignPERF   xxx guifg=#278bd3 guibg=#03333f
-- TodoSignTODO   xxx guifg=#2aa298 guibg=#03333f
-- TodoSignWARN   xxx guifg=#ca4c16 guibg=#03333f
-- TroubleCode    xxx links to Comment
-- TroubleCount   xxx links to TabLineSel
-- TroubleError   xxx links to DiagnosticError
-- TroubleFile    xxx links to Directory
-- TroubleFoldIcon xxx links to CursorLineNr
-- TroubleHint    xxx links to DiagnosticHint
-- TroubleIndent  xxx links to LineNr
-- TroubleInformation xxx links to DiagnosticInfo
-- TroubleLocation xxx links to LineNr
-- TroubleNormal  xxx links to LspTroubleNormal
-- TroubleOther   xxx links to DiagnosticOther
-- TroublePreview xxx links to Search
-- TroubleSignError xxx links to DiagnosticSignError
-- TroubleSignHint xxx links to DiagnosticSignHint
-- TroubleSignInformation xxx links to DiagnosticSignInfo
-- TroubleSignOther xxx links to TroubleSignInformation
-- TroubleSignWarning xxx links to DiagnosticSignWarn
-- TroubleSource  xxx links to Comment
-- TroubleText    xxx links to Normal
-- TroubleTextError xxx links to TroubleText
-- TroubleTextHint xxx links to TroubleText
-- TroubleTextInformation xxx links to TroubleText
-- TroubleTextWarning xxx links to TroubleText
-- TroubleWarning xxx links to DiagnosticWarn
-- Type           xxx ctermfg=121 guifg=#B38600
-- Typedef        xxx links to Type
-- Underlined     xxx cterm=underline ctermfg=81 guifg=#6D72C5
-- VertSplit      xxx cterm=reverse guifg=#002D38 guibg=#073541
-- Visual         xxx ctermbg=242 gui=reverse guifg=#586E74 guibg=#002D38
-- VisualNC       xxx cleared
-- VisualNOS      xxx gui=standout,reverse guibg=#073541
-- WarningMsg     xxx ctermfg=224 gui=bold guifg=#DC312E
-- WhichKey       xxx links to Function
-- WhichKeyDesc   xxx links to Identifier
-- WhichKeyFloat  xxx links to NormalFloat
-- WhichKeyGroup  xxx links to Keyword
-- WhichKeySeparator xxx links to WhichKeySeperator
-- WhichKeySeperator xxx cleared
-- WhichKeyValue  xxx links to Comment
-- Whitespace     xxx links to NonText
-- WildMenu       xxx ctermfg=0 ctermbg=11 gui=reverse guifg=#EDE7D4 guibg=#073541
-- commentTSConstant xxx links to TSConstant
-- gitcommitBranch xxx gui=bold guifg=#D33682
-- gitcommitComment xxx gui=italic guifg=#586E74
-- gitcommitDicardedType xxx gui=bold guifg=#DC312E
-- gitcommitDiscarded xxx links to gitcommitComment
-- gitcommitDiscardedArrow xxx links to gitcommitDiscardedFile
-- gitcommitDiscardedFile xxx gui=bold guifg=#DC312E
-- gitcommitFile  xxx gui=bold guifg=#839495
-- gitcommitHeader xxx guifg=#586E74
-- gitcommitNoBranch xxx links to gitcommitBranch
-- gitcommitOnBranch xxx gui=bold guifg=#586E74
-- gitcommitSelected xxx links to gitcommitComment
-- gitcommitSelectedArrow xxx links to gitcommitSelectedFile
-- gitcommitSelectedFile xxx gui=bold guifg=#859900
-- gitcommitSelectedType xxx gui=bold guifg=#859900
-- gitcommitUnmerged xxx gui=bold guifg=#859900
-- gitcommitUnmergedArrow xxx links to gitcommitUnmergedFile
-- gitcommitUnmergedFile xxx gui=bold guifg=#B38600
-- gitcommitUntracked xxx links to gitcommitComment
-- gitcommitUntrackedFile xxx gui=bold guifg=#2AA298
-- htmlArg        xxx guifg=#647A82
-- htmlEndTag     xxx guifg=#586E74
-- htmlSpecialTagName xxx gui=italic guifg=#278BD3
-- htmlTag        xxx guifg=#586E74
-- htmlTagN       xxx gui=bold guifg=#92A0A0
-- htmlTagName    xxx gui=bold guifg=#278BD3
-- javaScript     xxx guifg=#B38600
-- lCursor        xxx guifg=bg guibg=fg
-- luaBlock       xxx cleared
-- luaBraceError  xxx links to Error
-- luaComment     xxx links to Comment
-- luaCond        xxx links to Conditional
-- luaConstant    xxx links to Constant
-- luaElse        xxx links to Conditional
-- luaElseifThen  xxx cleared
-- luaError       xxx links to Error
-- luaFor         xxx links to Repeat
-- luaFunc        xxx links to Identifier
-- luaFunction    xxx links to Function
-- luaFunctionBlock xxx cleared
-- luaIfThen      xxx cleared
-- luaIn          xxx links to Operator
-- luaInnerComment xxx cleared
-- luaLabel       xxx links to Label
-- luaLoopBlock   xxx cleared
-- luaNumber      xxx links to Number
-- luaOperator    xxx links to Operator
-- luaParen       xxx cleared
-- luaParenError  xxx links to Error
-- luaRepeat      xxx links to Repeat
-- luaSpecial     xxx links to SpecialChar
-- luaStatement   xxx links to Statement
-- luaString      xxx links to String
-- luaString2     xxx links to String
-- luaTSBoolean   xxx links to TSBoolean
-- luaTSComment   xxx links to TSComment
-- luaTSConditional xxx links to TSConditional
-- luaTSConstBuiltin xxx links to TSConstBuiltin
-- luaTSConstructor xxx links to TSConstructor
-- luaTSField     xxx links to TSField
-- luaTSFuncBuiltin xxx links to TSFuncBuiltin
-- luaTSFunction  xxx links to TSFunction
-- luaTSKeyword   xxx links to TSKeyword
-- luaTSKeywordFunction xxx links to TSKeywordFunction
-- luaTSKeywordOperator xxx links to TSKeywordOperator
-- luaTSKeywordReturn xxx links to TSKeywordReturn
-- luaTSOperator  xxx links to TSOperator
-- luaTSPunctBracket xxx links to TSPunctBracket
-- luaTSPunctDelimiter xxx links to TSPunctDelimiter
-- luaTSString    xxx links to TSString
-- luaTSVariable  xxx links to TSVariable
-- luaTable       xxx links to Structure
-- luaTableBlock  xxx cleared
-- luaThenEnd     xxx cleared
-- luaTodo        xxx links to Todo
-- texMathMatcher xxx guifg=#B38600 guibg=#002D38
-- texMathZoneX   xxx guifg=#B38600 guibg=#002D38
-- texRefLabel    xxx guifg=#B38600 guibg=#002D38
-- texStatement   xxx guifg=#2AA298 guibg=#002D38
-- vimTSComment   xxx links to TSComment
-- vimTSConditional xxx links to TSConditional
-- vimTSFunction  xxx links to TSFunction
-- vimTSKeyword   xxx links to TSKeyword
-- vimTSNumber    xxx links to TSNumber
-- vimTSOperator  xxx links to TSOperator
-- vimTSPunctBracket xxx links to TSPunctBracket
-- vimTSString    xxx links to TSString
-- vimTSVariable  xxx links to TSVariable
-- vimTSVariableBuiltin xxx links to TSVariableBuiltin
