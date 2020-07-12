--
--  ███       ███                      █████████          ███ ███
--  ░██      ░░██                     ░░░░░░███          ░░██ ░██
--  ░██       ░██  █████ ███   █████       ███            ░██ ░██      █████ ███   ████
--  ░██████   ░██  ░███ ░██   ███░░██     ███    ███   ██████ ░██████  ░███ ░██  ░███░
--  ░███░░██  ░██  ░███ ░██  ░██████     ███    ░░░   ███░░██ ░███░░██ ░███ ░██   ░███
--  ░███░░██  ░██  ░███ ░██  ░███░░     ███          ░███░░██ ░███░░██ ░███ ░██   ░░░██
--  ░░█████   ████ ░███████  ░░██████  ████████      ░░█████  ░░█████  ░███████   ████
--   ░░░░░   ░░░░  ░░░░░░░    ░░░░░░  ░░░░░░░░        ░░░░░    ░░░░░   ░░░░░░░   ░░░░
--
-- =====================================================================================
--   Name:       init.lua
--   Author:     Gurpreet Singh
--   Url:        https://github.com/ffs97/bluez-dbus-lua/init.lua
--   License:    The MIT License (MIT)
--
--   This module implements a wrapper for the BlueZ DBus API based on lgi. The classes
--   implemented are Manager, Adapter, and Device, each with helper functions to connect
--   to signals and easily read/write properties.
-- =====================================================================================

local helpers = require("bluezdbus.helpers")

local Manager = require("bluezdbus.manager")
local Adapter = require("bluezdbus.adapter")
local Device = require("bluezdbus.device")
local Proxy = require("bluezdbus.proxy")

local get_system_bus = helpers.get_system_bus
local run_main_loop = helpers.run_main_loop

return {
    Manager = Manager,
    Adapter = Adapter,
    Device = Device,
    Proxy = Proxy,
    helpers = helpers,
    get_system_bus = get_system_bus,
    run_main_loop = run_main_loop
}
