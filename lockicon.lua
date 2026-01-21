-- lockicon.lua
-- Windower addon: shows a lock ICON ONLY when target lock-on is active.
--
_addon.name     = 'lockicon'
_addon.author   = 'ChatGPT'
_addon.version  = '1.6.0'
_addon.commands = {'lockicon','li'}

local config = require('config')
local images = require('images')

local defaults = {
    anchor = 'target',  -- 'fixed' or 'target'
    x = 40,
    y = 200,
    target_dx = 0,
    target_dy = -140,
    icon_size = 90,
}

local settings = config.load(defaults)

local icon = images.new()
icon:path(windower.addon_path .. 'lock.png')
icon:size(settings.icon_size, settings.icon_size)
icon:alpha(255)
icon:visible(false)

local last_locked = nil
local last_x, last_y = nil, nil

local function has_target()
    local t = windower.ffxi.get_mob_by_target('t')
    return t and t.id and t.id ~= 0
end

local function get_screen_wh()
    local info = windower.ffxi.get_info()
    if info and info.ui and info.ui.width and info.ui.height then
        return info.ui.width, info.ui.height
    end
    local ws = windower.get_windower_settings and windower.get_windower_settings()
    if ws and ws.ui_x_res and ws.ui_y_res then
        return ws.ui_x_res, ws.ui_y_res
    end
end

local function get_anchor_pos()
    if settings.anchor == 'fixed' then
        return settings.x, settings.y
    end
    local w, h = get_screen_wh()
    if not w or not h then return settings.x, settings.y end
    return math.floor(w/2 + settings.target_dx), math.floor(h/2 + settings.target_dy)
end

windower.register_event('prerender', function()
    local p = windower.ffxi.get_player()
    if not p or not has_target() then
        if last_locked ~= nil then
            last_locked = nil
            icon:visible(false)
        end
        return
    end

    local locked = (p.target_locked == true)
    local x, y = get_anchor_pos()
    if x ~= last_x or y ~= last_y then
        last_x, last_y = x, y
        icon:pos(x, y)
    end

    if locked ~= last_locked then
        last_locked = locked
        icon:visible(locked)
    end
end)

windower.register_event('unload', function()
    icon:visible(false)
end)
