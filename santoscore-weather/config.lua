-- config.lua
-- Made by SantosMods.dev for the SantosCore Project

Config = {}

-- All standard GTA V weather types plus special entries
Config.WeatherTypes = {
    "EXTRASUNNY",
    "CLEAR",
    "NEUTRAL",
    "SMOG",
    "FOGGY",
    "OVERCAST",
    "CLOUDS",
    "CLEARING",
    "RAIN",
    "THUNDER",
    "SHOWER",
    "XMAS",
    "SNOW",
    "BLIZZARD",
    "SNOWLIGHT",
    "HALLOWEEN",
    -- Special menu entries handled separately:
    "RANDOM_WEATHER",
    "NEXT_WEATHER",
    "FREEZE_WEATHER",
    "BLACKOUT",
    "SET_TIME_MORNING",
    "SET_TIME_NOON",
    "SET_TIME_EVENING",
    "SET_TIME_NIGHT"
}

-- The chat/console command to open the weather menu
Config.Command = 'weather'

-- Restrict menu access to players with a specific ACE permission
Config.AdminOnly = true
Config.AdminPermission = 'santoscore.weather'

-- Time presets (hour, minute)
Config.TimePresets = {
    MORNING = { hour = 8, minute = 0 },
    NOON    = { hour = 12, minute = 0 },
    EVENING = { hour = 18, minute = 0 },
    NIGHT   = { hour = 23, minute = 0 }
}
