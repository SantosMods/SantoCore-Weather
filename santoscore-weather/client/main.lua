-- client/main.lua
-- SantosMods.dev | SantosCore Project: Weather Control (Client)

local menuStack = {}

-- Helper to build the "Set Weather" submenu
local function BuildWeatherTypeOptions()
    local items = {}
    local ignore = {
        RANDOM_WEATHER = true,
        NEXT_WEATHER   = true,
        FREEZE_WEATHER = true,
        BLACKOUT       = true,
        SET_TIME_MORNING = true,
        SET_TIME_NOON    = true,
        SET_TIME_EVENING = true,
        SET_TIME_NIGHT   = true
    }

    for _, w in ipairs(Config.WeatherTypes) do
        if not ignore[w] then
            items[#items + 1] = {
                title       = w,
                description = '',
                event       = 'santoscore-weather:clientRequestWeather',
                args        = { weather = w }
            }
        end
    end

    return items
end

-- Helper to build main menu with tons of options
local function BuildMainMenu()
    return {
        {
            title       = 'Select Weather Type',
            description = 'Pick from all GTA V weather presets',
            event       = 'santoscore-weather:clientShowWeatherTypes'
        },
        {
            title       = 'Random Weather',
            description = 'Apply a random weather type',
            event       = 'santoscore-weather:clientRequestRandom'
        },
        {
            title       = 'Next Weather Cycle',
            description = 'Advance to next in-game weather',
            event       = 'santoscore-weather:clientRequestNext'
        },
        {
            title       = 'Toggle Freeze Weather',
            description = 'Freeze/unfreeze current weather',
            event       = 'santoscore-weather:clientRequestFreeze'
        },
        {
            title       = 'Toggle Blackout',
            description = 'Enable/disable city blackout',
            event       = 'santoscore-weather:clientRequestBlackout'
        },
        {
            title       = 'Set Time: Morning (08:00)',
            description = '',
            event       = 'santoscore-weather:clientRequestTime',
            args        = { preset = 'MORNING' }
        },
        {
            title       = 'Set Time: Noon (12:00)',
            description = '',
            event       = 'santoscore-weather:clientRequestTime',
            args        = { preset = 'NOON' }
        },
        {
            title       = 'Set Time: Evening (18:00)',
            description = '',
            event       = 'santoscore-weather:clientRequestTime',
            args        = { preset = 'EVENING' }
        },
        {
            title       = 'Set Time: Night (23:00)',
            description = '',
            event       = 'santoscore-weather:clientRequestTime',
            args        = { preset = 'NIGHT' }
        }
    }
end

-- Show submenu for selecting specific weather types
RegisterNetEvent('santoscore-weather:clientShowWeatherTypes', function()
    local items = BuildWeatherTypeOptions()
    lib.registerContext({
        id      = 'santoscore_weather_types',
        title   = 'Choose Weather',
        options = items
    })
    lib.showContext('santoscore_weather_types')
end)

-- Main /weather command
RegisterCommand(Config.Command, function()
    if Config.AdminOnly and not IsPlayerAceAllowed(Config.AdminPermission) then
        return
    end

    lib.registerContext({
        id      = 'santoscore_weather_main',
        title   = 'SantosCore Weather Control',
        options = BuildMainMenu()
    })
    lib.showContext('santoscore_weather_main')
end, false)

-- Event: Player selects a weather type
RegisterNetEvent('santoscore-weather:clientRequestWeather', function(data)
    TriggerServerEvent('santoscore-weather:serverSetWeather', data.weather)
end)

-- Event: Random weather
RegisterNetEvent('santoscore-weather:clientRequestRandom', function()
    TriggerServerEvent('santoscore-weather:serverSetRandom')
end)

-- Event: Next weather cycle
RegisterNetEvent('santoscore-weather:clientRequestNext', function()
    TriggerServerEvent('santoscore-weather:serverSetNext')
end)

-- Event: Toggle freeze
RegisterNetEvent('santoscore-weather:clientRequestFreeze', function()
    TriggerServerEvent('santoscore-weather:serverToggleFreeze')
end)

-- Event: Toggle blackout
RegisterNetEvent('santoscore-weather:clientRequestBlackout', function()
    TriggerServerEvent('santoscore-weather:serverToggleBlackout')
end)

-- Event: Set preset time
RegisterNetEvent('santoscore-weather:clientRequestTime', function(data)
    TriggerServerEvent('santoscore-weather:serverSetTime', data.preset)
end)

-- Sync weather from server
RegisterNetEvent('santoscore-weather:clientSyncWeather', function(weather)
    SetWeatherTypeNowPersistent(weather)
    SetWeatherTypeOverTime(weather, 15.0)
end)

-- Sync random weather
RegisterNetEvent('santoscore-weather:clientSyncRandom', function(weather)
    SetWeatherTypeNowPersistent(weather)
    SetWeatherTypeOverTime(weather, 15.0)
end)

-- Sync next weather (advance one step)
RegisterNetEvent('santoscore-weather:clientSyncNext', function(weather)
    SetWeatherTypeNowPersistent(weather)
    SetWeatherTypeOverTime(weather, 15.0)
end)

-- Sync freeze toggle
RegisterNetEvent('santoscore-weather:clientSyncFreeze', function(isFrozen, weather)
    if isFrozen then
        SetWeatherTypeNow(weather)
        SetWeatherTypePersist(weather)
    else
        ClearWeatherTypePersist()
    end
end)

-- Sync blackout toggle
RegisterNetEvent('santoscore-weather:clientSyncBlackout', function(isBlackout)
    SetBlackout(isBlackout)
end)

-- Sync time change
RegisterNetEvent('santoscore-weather:clientSyncTime', function(hour, minute)
    NetworkOverrideClockTime(hour, minute, 0)
end)
