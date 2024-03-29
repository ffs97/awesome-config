---------------------------------------------------
-- Licensed under the GNU General Public License v2
--  * (c) 2010, Adrian C. <anrxc@sysphere.org>
--  * (c) 2013, NormalRa  <normalrawr@gmail.com>
---------------------------------------------------

-- {{{ Grab environment
local tonumber = tonumber
local setmetatable = setmetatable
local string = { format = string.format }
local helpers = require("modules.vicious.helpers")
local math = {
    min = math.min,
    floor = math.floor
}
-- }}}


-- Bat: provides state, charge, remaining time, and wear for a requested battery
-- vicious.widgets.bat
local bat_linux = {}


-- {{{ Battery widget type
local function worker(format, warg)
    if not warg then return end

    local battery = helpers.pathtotable("/sys/class/power_supply/"..warg)
    local battery_state = {
        ["Full\n"]        = "↯",
        ["Unknown\n"]     = "⌁",
        ["Charged\n"]     = "↯",
        ["Charging\n"]    = "+",
        ["Discharging\n"] = "-"
    }

    -- Get current power usage in watt
    local curpower = "N/A"
    if battery.power_now then
        curpower = string.format("%.2f", tonumber(battery.power_now) /1000000)
    end

    -- Check if the battery is present
    if battery.present ~= "1\n" then
        return {battery_state["Unknown\n"], 0, "N/A", 0, curpower}
    end


    -- Get state information
    local state = battery_state[battery.status] or battery_state["Unknown\n"]

    -- Get capacity information
    if battery.charge_now then
        remaining, capacity = battery.charge_now, battery.charge_full
        capacity_design = battery.charge_full_design or capacity
    elseif battery.energy_now then
        remaining, capacity = battery.energy_now, battery.energy_full
        capacity_design = battery.energy_full_design or capacity
    else
        return {battery_state["Unknown\n"], 0, "N/A", 0, curpower}
    end

    -- Calculate capacity and wear percentage (but work around broken BAT/ACPI implementations)
    local percent = math.min(math.floor(remaining / capacity * 100), 100)
    local wear = math.floor(100 - capacity / capacity_design * 100)


    -- Get charge information
    if battery.current_now then
        rate = tonumber(battery.current_now)
    elseif battery.power_now then
        rate = tonumber(battery.power_now)
    else
        return {state, percent, "N/A", wear, curpower}
    end

    -- Calculate remaining (charging or discharging) time
    local time = "N/A"

    if rate ~= nil and rate ~= 0 then
        if state == "+" then
            timeleft = (tonumber(capacity) - tonumber(remaining)) / tonumber(rate)
        elseif state == "-" then
            timeleft = tonumber(remaining) / tonumber(rate)
        else
            return {state, percent, time, wear, curpower}
        end

        -- Calculate time
        local hoursleft   = math.floor(timeleft)
        local minutesleft = math.floor((timeleft - hoursleft) * 60 )

        time = string.format("%02d:%02d", hoursleft, minutesleft)
    end

    return {state, percent, time, wear, curpower}
end
-- }}}

return setmetatable(bat_linux, { __call = function(_, ...) return worker(...) end })
