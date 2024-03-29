-- =====================================================================================
--   Name:       minicontrols.lua
--   Author:     Gurpreet Singh
--   Url:        https://github.com/ffs97/awesome-config/themes/apocalypse/widgets ...
--               ... controlpanel/minicontrols.lua
--   License:    The MIT License (MIT)
--
--   Custom theme based mini widget for basic controls
-- =====================================================================================

local wibox = require("wibox")
local beautiful = require("beautiful").controlpanel.minicontrols

-- -------------------------------------------------------------------------------------
-- Custom Helper Libraries

local helpers = require("helpers")

-- -------------------------------------------------------------------------------------
-- Creating the Widget

local minicontrols =
    helpers.boxed(
    {
        {
            require("widgets.controlpanel.wifi"),
            left = beautiful.spacing,
            right = beautiful.spacing,
            widget = wibox.container.margin
        },
        layout = wibox.layout.fixed.horizontal
    },
    beautiful.width,
    beautiful.height,
    false,
    beautiful.bg,
    beautiful.border_radius
)

-- -------------------------------------------------------------------------------------
return minicontrols
