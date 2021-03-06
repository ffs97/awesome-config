-- -------------------------------------------------------------------------------------
-- Including Standard Awesome Libraries

local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local naughty = require("naughty")
local beautiful = require("beautiful").startscreen.webcam

-- -------------------------------------------------------------------------------------
-- Including Custom Helper Libraries

local helpers = require("helpers")

-- -------------------------------------------------------------------------------------
-- Creating the Webcam Widget

local webcam_icon = wibox.widget {
	image = beautiful.icon,
	resize = true,
	forced_width = beautiful.icon_size,
	forced_height = beautiful.icon_size,
	widget = wibox.widget.imagebox
}

local centered = helpers.centered

local webcam = wibox.widget {
	centered(
		centered(webcam_icon, "horizontal"),
		"vertical"
	),
	bg = beautiful.bg,
	shape = helpers.rrect(beautiful.border_radius or 0),
	forced_width = beautiful.width,
	forced_height = beautiful.height,
	widget = wibox.container.background
}

helpers.add_clickable_effect(
	webcam,
	function()
		webcam.bg = beautiful.bg_hover
	end,
	function()
		webcam.bg = beautiful.bg
	end
)

-- -------------------------------------------------------------------------------------
-- Adding Button Controls to the Widget

webcam:buttons(gears.table.join(
	-- Left click - Open webcam
	awful.button({}, 1, function()
		awful.spawn.with_shell("cheese")
	end)
))

-- -------------------------------------------------------------------------------------
return webcam
