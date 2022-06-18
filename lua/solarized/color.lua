---@diagnostic disable: undefined-global

local hsl = require('lush.hsl')

local color = {}

color.lab = function (L, a, b)
    local function clamp(t, min, max)
        if t <= min then
            return min
        elseif t >= max then
            return max
        else
            return t
        end
    end

    L = clamp(L,    0, 100)
    a = clamp(a, -128, 127)
    b = clamp(b, -128, 127)

    local xn = 0.950489
    local yn = 1.000000
    local zn = 1.088840

    local delta = 6.0 / 29.0

    local function f(t)
        if t > delta then
            return t^3
        else
            return 3 * delta^2 * (t - 4.0 / 29.0)
        end
    end

    local x = xn * f((L + 16.0) / 116.0 + a / 500.0)
    local y = yn * f((L + 16.0) / 116.0)
    local z = zn * f((L + 16.0) / 116.0 - b / 200.0)

    local function gamma(t)
        if t < 0.0031308 then
            return 12.92 * t
        else
            return 1.055 * t ^ (1.0/2.4) - 0.055
        end
    end

    local Rp =  3.2406 * x - 1.5372 * y - 0.4986 * z
    local Gp = -0.9689 * x + 1.8758 * y + 0.0415 * z
    local Bp =  0.0557 * x - 0.2040 * y + 1.0570 * z

    local R = gamma(Rp)
    local G = gamma(Gp)
    local B = gamma(Bp)

    local hex = string.format(
        '#%02x%02x%02x',
        clamp(math.floor(255 * R), 0, 255),
        clamp(math.floor(255 * G), 0, 255),
        clamp(math.floor(255 * B), 0, 255)
    )
    return hsl(hex)
end

color.base03  = color.lab(15, -12, -12)
color.base02  = color.lab(20, -12, -12)
color.base01  = color.lab(45, -07, -07)
color.base00  = color.lab(50, -07, -07)
color.base0   = color.lab(60, -06, -03)
color.base1   = color.lab(65, -05, -02)
color.base2   = color.lab(92, -00,  10)
color.base3   = color.lab(97,  00,  10)
color.yellow  = color.lab(60,  10,  65)
color.orange  = color.lab(50,  50,  55)
color.red     = color.lab(50,  65,  45)
color.magenta = color.lab(50,  65, -05)
color.violet  = color.lab(50,  15, -45)
color.blue    = color.lab(55, -10, -45)
color.cyan    = color.lab(60, -35, -05)
color.green   = color.lab(60, -20,  65)

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
    color.base04 = color.lab(90,  00,  10)
    color.base05 = color.lab(85,  00,  10)
else
    color.base04 = color.lab(10, -12, -12)
    color.base05 = color.lab(05, -12, -12)
end

return color
