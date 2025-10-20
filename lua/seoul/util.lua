local M = {}

--- Blend two colors (in hsl space)
--- copied from [folke/Snacks.nvim](https://github.com/folke/snacks.nvim/blob/595963140e464e9bd8244b758a590a7c0b5d0798/lua/snacks/util/init.lua#L175-L183)
---@param col1 string the base color
---@param col2 string the blending color
---@param alpha number the amount of blending (between 0 and 1)
---@return string color the blended color (in hex)
M.blend = function(col1, col2, alpha)
    local col1_rgb = { tonumber(col1:sub(2, 3), 16), tonumber(col1:sub(4, 5), 16), tonumber(col1:sub(6, 7), 16) }
    local col2_rgb = { tonumber(col2:sub(2, 3), 16), tonumber(col2:sub(4, 5), 16), tonumber(col2:sub(6, 7), 16) }
    local blend = function(i)
        local ret = (alpha * col2_rgb[i] + ((1 - alpha) * col1_rgb[i]))
        return math.min(math.max(0, ret), 255) / 255
    end
    return M.rgb_to_hex(blend(1), blend(2), blend(3))
end

--- Blend two colors, while keeping the lumninace of the first color
---@param col1 string the base color
---@param col2 string the blending color
---@param alpha number the amount of blending (between 0 and 1)
---@return string color the blended color (in hex)
M.blend_keep_lum = function(col1, col2, alpha)
    local new_col2 = M.match_luminance(col1, col2)
    return M.blend(col1, new_col2, alpha)
end

-- Convert hex color to RGB (0–1)
M.hex_to_rgb = function(hex)
    hex = hex:gsub("#", "")
    return tonumber(hex:sub(1, 2), 16) / 255, tonumber(hex:sub(3, 4), 16) / 255, tonumber(hex:sub(5, 6), 16) / 255
end

-- Convert RGB (0–1) to hex
M.rgb_to_hex = function(r, g, b)
    r = math.max(0, math.min(1, r))
    g = math.max(0, math.min(1, g))
    b = math.max(0, math.min(1, b))
    return string.format(
        "#%02x%02x%02x",
        math.floor(r * 255 + 0.5),
        math.floor(g * 255 + 0.5),
        math.floor(b * 255 + 0.5)
    )
end

M.rgb_to_hsl = function(r, g, b)
    local max = math.max(r, g, b)
    local min = math.min(r, g, b)
    local h, s, l
    l = (max + min) / 2

    if max == min then
        h, s = 0, 0
    else
        local d = max - min
        s = l > 0.5 and d / (2 - max - min) or d / (max + min)
        if max == r then
            h = (g - b) / d + (g < b and 6 or 0)
        elseif max == g then
            h = (b - r) / d + 2
        else
            h = (r - g) / d + 4
        end
        h = h / 6
    end
    return h, s, l
end

-- Convert HSL to RGB
M.hsl_to_rgb = function(h, s, l)
    local function hue2rgb(p, q, t)
        if t < 0 then
            t = t + 1
        end
        if t > 1 then
            t = t - 1
        end
        if t < 1 / 6 then
            return p + (q - p) * 6 * t
        end
        if t < 1 / 2 then
            return q
        end
        if t < 2 / 3 then
            return p + (q - p) * (2 / 3 - t) * 6
        end
        return p
    end

    if s == 0 then
        return l, l, l
    end

    local q = l < 0.5 and l * (1 + s) or l + s - l * s
    local p = 2 * l - q
    return hue2rgb(p, q, h + 1 / 3), hue2rgb(p, q, h), hue2rgb(p, q, h - 1 / 3)
end

-- Adjust luminance of color2 to match color1
M.match_luminance = function(hex1, hex2)
    local r1, g1, b1 = M.hex_to_rgb(hex1)
    local r2, g2, b2 = M.hex_to_rgb(hex2)

    local h1, s1, l1 = M.rgb_to_hsl(r1, g1, b1)
    local h2, s2, l2 = M.rgb_to_hsl(r2, g2, b2)

    local r, g, b = M.hsl_to_rgb(h2, s2, l1)
    return M.rgb_to_hex(r, g, b)
end

return M
