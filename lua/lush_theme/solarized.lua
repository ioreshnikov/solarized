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

---@diagnostic disable: undefined-global

local lush = require('lush')
local hsl = require('lush.hsl')

local color = require('color')

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

theme.markdown = lush(function ()
    return {
        markdownH1 { gui = fmt.bold, fg = color.orange, bg = color.none },
        markdownH2 { gui = fmt.bold, fg = color.orange, bg = color.none },
        markdownH3 { gui = fmt.bold, fg = color.orange, bg = color.none },
        markdownH1Delimiter { gui = fmt.bold, fg = color.yellow, bg = color.none },
        markdownH2Delimiter { gui = fmt.bold, fg = color.yellow, bg = color.none },
        markdownH3Delimiter { gui = fmt.bold, fg = color.yellow, bg = color.none },
        markdownHeadingRule { gui = fmt.bold, fg = color.yellow, bg = color.none },

        markdownListMarker { gui = fmt.none, fg = color.magenta, bg = color.none },
        markdownBlockquote { gui = fmt.none, fg = color.blue, bg = color.none },

        markdownBold { gui = fmt.bold, fg = color.none, bg = color.none },
        markdownBoldDelimiter { gui = fmt.bold, fg = color.base00, bg = color.none },
        markdownCode { gui = fmt.none, fg = color.cyan, bg = color.none },
        markdownCodeDelimiter { gui = fmt.none, fg = color.base00, bg = color.none },
        markdownItalic { gui = fmt.ital, fg = color.none, bg = color.none },
        markdownItalicDelimiter { gui = fmt.ital, fg = color.base00, bg = color.none },

        markdownCodeBlock { gui = fmt.none, fg = color.yellow, bg = color.none },

        markdownLinkText { gui = fmt.none, fg = color.violet, bg = color.none },
        markdownUrl { gui = fmt.undi, fg = color.base00, bg = color.none },

        markdownFootnote { gui = fmt.none, fg = color.green, bg = color.none },
        markdownFootnoteDefinition { gui = fmt.none, fg = color.green, bg = color.none },
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
        WhichKey { gui = fmt.bold, fg = color.orange, bg = color.none },
    }
end)

theme.neotree = lush(function ()
    return {
        NeoTreeNormal { gui = fmt.none, fg = color.none, bg = color.back_darken },
        NeoTreeNormalNC { gui = fmt.none, fg = color.none, bg = color.back_darken },
        -- NeoTreeFloatBorder xxx links to FloatBorder
        -- NeoTreeTitleBar xxx cleared
        -- NeoTreeGitAdded xxx links to GitGutterAdd
        -- NeoTreeGitConflict xxx links to GitGutterDelete
        -- NeoTreeGitModified xxx links to GitGutterChange
        -- NeoTreeGitUntracked xxx cleared
        -- NeoTreeBufferNumber xxx links to SpecialChar
        -- NeoTreeDimText xxx cleared
        -- NeoTreeCursorLine xxx links to CursorLine
        -- NeoTreeDirectoryName xxx cleared
        NeoTreeDirectoryIcon { gui = fmt.none, fg = color.base0, bg = color.none },
        NeoTreeFileIcon { gui = fmt.none, fg = color.base0, bg = color.none },
        -- NeoTreeFileName xxx cleared
        -- NeoTreeFileNameOpened xxx cleared
        -- NeoTreeSymbolicLinkTarget xxx links to NeoTreeFileName
        -- NeoTreeFilterTerm xxx links to SpecialChar
        NeoTreeRootName { gui = fmt.none, fg = color.base01, bg = color.none },
        -- NeoTreeIndentMarker xxx links to NeoTreeDimText
    }
end)

theme.devicons = lush(function ()
    return {
        DevIconAi      { fg=color.green },
        DevIconAwk     { fg=color.base0 },
        DevIconBabelrc { fg=color.green },
        DevIconBash    { fg=color.green },
        DevIconBashProfile { fg=color.green },
        DevIconBashrc  { fg=color.green },
        DevIconBat     { fg=color.green },
        DevIconBinaryGLTF { fg=color.yellow },
        DevIconBmp     { fg=color.violet },
        DevIconBrewfile { fg=color.orange },
        DevIconC       { fg=color.violet },
        DevIconCMake   { fg=color.base1 },
        DevIconCMakeLists { fg=color.base1 },
        DevIconCPlusPlus { fg=color.magenta },
        DevIconClojure { fg=color.green },
        DevIconClojureC { fg=color.green },
        DevIconClojureJS { fg=color.cyan },
        DevIconCobol   { fg=color.violet },
        DevIconCoffee  { fg=color.yellow },
        DevIconConf    { fg=color.base0 },
        DevIconConfigRu { fg=color.red },
        DevIconConfiguration { fg=color.base1 },
        DevIconCp      { fg=color.cyan },
        DevIconCpp     { fg=color.cyan },
        DevIconCrystal { fg=color.base2 },
        DevIconCs      { fg=color.green },
        DevIconCsh     { fg=color.base0 },
        DevIconCson    { fg=color.green },
        DevIconCss     { fg=color.violet },
        DevIconCsv     { fg=color.green },
        DevIconCxx     { fg=color.cyan },
        DevIconD       { fg=color.green },
        DevIconDart    { fg=color.blue },
        DevIconDb      { fg=color.base1 },
        DevIconDefault { fg=color.base00 },
        DevIconDesktopEntry { fg=color.violet },
        DevIconDiff    { fg=color.base0 },
        DevIconDoc     { fg=color.blue },
        DevIconDockerfile { fg=color.base1 },
        DevIconDropbox { fg=color.blue },
        DevIconDsStore { fg=color.base01 },
        DevIconDump    { fg=color.base1 },
        DevIconEdn     { fg=color.cyan },
        DevIconEex     { fg=color.violet },
        DevIconEjs     { fg=color.green },
        DevIconElm     { fg=color.cyan },
        DevIconEpp     { fg=color.yellow },
        DevIconErb     { fg=color.red },
        DevIconErl     { fg=color.magenta },
        DevIconEx      { fg=color.violet },
        DevIconExs     { fg=color.violet },
        DevIconFavicon { fg=color.green },
        DevIconFish    { fg=color.base0 },
        DevIconFs      { fg=color.cyan },
        DevIconFsharp  { fg=color.cyan },
        DevIconFsi     { fg=color.cyan },
        DevIconFsscript { fg=color.cyan },
        DevIconFsx     { fg=color.cyan },
        DevIconGDScript { fg=color.base0 },
        DevIconGemfile { fg=color.red },
        DevIconGemspec { fg=color.red },
        DevIconGif     { fg=color.violet },
        DevIconGitAttributes { fg=color.base01 },
        DevIconGitCommit { fg=color.base01 },
        DevIconGitConfig { fg=color.base01 },
        DevIconGitIgnore { fg=color.base01 },
        DevIconGitLogo { fg=color.orange },
        DevIconGitModules { fg=color.base01 },
        DevIconGitlabCI { fg=color.orange },
        DevIconGo      { fg=color.cyan },
        DevIconGodotProject { fg=color.base0 },
        DevIconGruntfile { fg=color.orange },
        DevIconGulpfile { fg=color.magenta },
        DevIconGvimrc  { fg=color.green },
        DevIconH       { fg=color.violet },
        DevIconHaml    { fg=color.base1 },
        DevIconHbs     { fg=color.orange },
        DevIconHeex    { fg=color.violet },
        DevIconHh      { fg=color.violet },
        DevIconHpp     { fg=color.violet },
        DevIconHrl     { fg=color.magenta },
        DevIconHs      { fg=color.violet },
        DevIconHtm     { fg=color.orange },
        DevIconHtml    { fg=color.orange },
        DevIconHxx     { fg=color.violet },
        DevIconIco     { fg=color.green },
        DevIconImportConfiguration { fg=color.base2 },
        DevIconIni     { fg=color.base00 },
        DevIconJava    { fg=color.red },
        DevIconJl      { fg=color.magenta },
        DevIconJpeg    { fg=color.violet },
        DevIconJpg     { fg=color.violet },
        DevIconJs      { fg=color.violet },
        DevIconJson    { fg=color.base1 },
        DevIconJsx     { fg=color.cyan },
        DevIconKotlin  { fg=color.orange },
        DevIconKsh     { fg=color.base0 },
        DevIconLeex    { fg=color.violet },
        DevIconLess    { fg=color.violet },
        DevIconLhs     { fg=color.violet },
        DevIconLicense { fg=color.base01 },
        DevIconLua     { fg=color.blue },
        DevIconMakefile { fg=color.base1 },
        DevIconMarkdown { fg=color.orange },
        DevIconMaterial { fg=color.magenta },
        DevIconMd      { fg=color.base01 },
        DevIconMdx     { fg=color.cyan },
        DevIconMint    { fg=color.cyan },
        DevIconMixLock { fg=color.violet },
        DevIconMjs     { fg=color.yellow },
        DevIconMl      { fg=color.orange },
        DevIconMli     { fg=color.orange },
        DevIconMustache { fg=color.orange },
        DevIconNPMIgnore { fg=color.red },
        DevIconNim     { fg=color.yellow },
        DevIconNix     { fg=color.cyan },
        DevIconNodeModules { fg=color.red },
        DevIconOPUS    { fg=color.orange },
        DevIconOpenTypeFont { fg=color.base1 },
        DevIconPackedResource { fg=color.base0 },
        DevIconPdf     { fg=color.red },
        DevIconPhp     { fg=color.violet },
        DevIconPl      { fg=color.cyan },
        DevIconPm      { fg=color.cyan },
        DevIconPng     { fg=color.magenta },
        DevIconPp      { fg=color.yellow },
        DevIconPpt     { fg=color.orange },
        DevIconProcfile { fg=color.violet },
        DevIconProlog  { fg=color.yellow },
        DevIconPromptPs1 { fg=color.orange },
        DevIconPsb     { fg=color.cyan },
        DevIconPsd     { fg=color.cyan },
        DevIconPy      { fg=color.orange },
        DevIconPyc     { fg=color.orange },
        DevIconPyd     { fg=color.orange },
        DevIconPyo     { fg=color.orange },
        DevIconR       { fg=color.green },
        DevIconRake    { fg=color.red },
        DevIconRakefile { fg=color.red },
        DevIconRb      { fg=color.red },
        DevIconRlib    { fg=color.yellow },
        DevIconRmd     { fg=color.cyan },
        DevIconRproj   { fg=color.green },
        DevIconRs      { fg=color.yellow },
        DevIconRss     { fg=color.orange },
        DevIconSass    { fg=color.magenta },
        DevIconScala   { fg=color.red },
        DevIconScss    { fg=color.magenta },
        DevIconSettingsJson { fg=color.violet },
        DevIconSh      { fg=color.base0 },
        DevIconSig     { fg=color.yellow },
        DevIconSlim    { fg=color.orange },
        DevIconSln     { fg=color.violet },
        DevIconSml     { fg=color.yellow },
        DevIconSql     { fg=color.base1 },
        DevIconStyl    { fg=color.green },
        DevIconSuo     { fg=color.violet },
        DevIconSvelte  { fg=color.orange },
        DevIconSvg     { fg=color.yellow },
        DevIconSwift   { fg=color.yellow },
        DevIconTerminal { fg=color.green },
        DevIconTex     { fg=color.yellow },
        DevIconTextResource { fg=color.green },
        DevIconTextScene { fg=color.violet },
        DevIconToml    { fg=color.base01 },
        DevIconTor     { fg=color.cyan },
        DevIconTs      { fg=color.cyan },
        DevIconTsx     { fg=color.cyan },
        DevIconTwig    { fg=color.green },
        DevIconTxt     { fg=color.base00 },
        DevIconVagrantfile { fg=color.blue },
        DevIconVim     { fg=color.green },
        DevIconVimrc   { fg=color.green },
        DevIconVue     { fg=color.green },
        DevIconWebmanifest { fg=color.yellow },
        DevIconWebp    { fg=color.violet },
        DevIconWebpack { fg=color.cyan },
        DevIconXcPlayground { fg=color.orange },
        DevIconXls     { fg=color.green },
        DevIconXml     { fg=color.orange },
        DevIconXul     { fg=color.orange },
        DevIconYaml    { fg=color.base01 },
        DevIconYml     { fg=color.base01 },
        DevIconZig     { fg=color.yellow },
        DevIconZsh     { fg=color.green },
        DevIconZshenv  { fg=color.green },
        DevIconZshprofile { fg=color.green },
        DevIconZshrc   { fg=color.green },
    }
end)

theme.lualine = lush(function ()
    return {
        LualineANormal { gui = fmt.none, fg = color.base02, bg = color.base1 },
        LualineBNormal { gui = fmt.none, fg = color.base02, bg = color.base1 },
        LualineCNormal { gui = fmt.none, fg = color.base02, bg = color.base1 },
        LualineAInsert { gui = fmt.none, fg = color.base02, bg = color.base1 },
        LualineAVisual { gui = fmt.none, fg = color.base02, bg = color.base1 },
        LualineAInactive { gui = fmt.none, fg = color.base02, bg = color.base00 },
        LualineAReplace { gui = fmt.none, fg = color.base02, bg = color.base00 },
        LualineBInactive { gui = fmt.none, fg = color.base02, bg = color.base00 },
        LualineCInactive { gui = fmt.none, fg = color.base02, bg = color.base00 },
    }
end)

theme.opinionated = lush(function ()
    return {
        Special { gui = ftm.none, fg = color.base0, bg = color.none },

        SignColumn { gui = fmt.none, fg = color.base01, bg = color.base02 },
        LineNr { gui = fmt.none, fg = color.base01, bg = color.base02 },
        CursorLineNr { LineNr },

        VertSplit { gui = fmt.none, fg = color.vert_split, bg = color.base02 },
        TabLine { gui = fmt.undr, fg = color.base0, bg = color.base02, sp = color.vert_split },
        TabLineFill { gui = fmt.undr, fg = color.base0, bg = color.base02, sp = color.vert_split },
        TabLineSel { gui = fmt.revbbu, fg = color.base01, bg = color.base2, sp = color.vert_split },

        -- For diagnostics, I find it's easier to spot it when it's something
        -- outside the palette
        DiagnosticError { gui = fmt.none, fg = color.red.saturate(60), bg = color.none },
        DiagnosticWarn { gui = fmt.none, fg = hsl("#ffa500"), bg = color.none },
        DiagnosticInfo { gui = fmt.none, fg = color.cyan.saturate(50), bg = color.none },
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

        -- Minor adjustments
        gitcommitSummary { gui = fmt.bold, fg = color.orange, bg = color.none },
        gitcommitType { gui = fmt.none, fg = color.base1, bg = color.none },
        gitcommitUnmergedFile { gui = fmt.bold, fg = color.base1, bg = color.none },
    }
end)

return lush.merge({
    theme.basic,
    theme.extended,
    theme.extra,
    theme.diff,
    theme.diagnostic,
    theme.treesitter,
    theme.git,
    theme.html,
    theme.tex,
    theme.markdown,
    theme.indent,
    theme.telescope,
    theme.whichkey,
    theme.neotree,
    theme.devicons,
    theme.lualine,
    theme.opinionated,
})

-- vi:nowrap
