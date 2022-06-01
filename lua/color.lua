---@diagnostic disable: undefined-global

local hsl = require('lush.hsl')

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
    color.secondary_back = hsl("#f4edda")
    color.secondary_cursorline = color.base02
else
    color.secondary_back = hsl("#00212b")  -- taken from VSCode Solarized Theme
    color.secondary_cursorline = color.base02
end

-- Vertical split -- midpoint between base0 and base02
if vim.o.background == "light" then
    -- base0 overlayed on top of base02 with 35% opacity
    color.vert_split = hsl("#bec1b8")
else
    -- base0 overlayed on top of base2 with 25% opacity
    color.vert_split = hsl("#204953")
end

return color
