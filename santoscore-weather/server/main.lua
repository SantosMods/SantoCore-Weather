-- server/main.lua
-- SantosMods.dev | SantosCore Project: Weather Control (Server)

-- Internal state tracking
local freezeEnabled   = false
local blackoutEnabled = false

-- Helper to pick a random weather type from standard list
local function GetRandomWeather()
    local stdWeather = {
        "EXTRASUNNY", "CLEAR", "NEUTRAL", "SMOG", "FOGGY",
        "OVERCAST", "CLOUDS", "CLEARING", "RAIN", "THUNDER",
        "SHOWER", "SNOW", "BLIZZARD", "SNOWLIGHT", "XMAS", "HALLOWEEN"
    }
    return stdWeather[ math.random(1, #stdWeather) ]
end

-- Advance to next weather (GTA cycle): broadcast next predefined type
local function GetNextWeather(current)
    local order = {
        "EXTRASUNNY","CLEAR","CLOUDS","OVERCAST","RAIN","THUNDER","CLEARING","SMOG","FOGGY"
    }
    local idx = 1
    for i, w in ipairs(order) do
        if w == current then
            idx = (i % #order) + 1
            break
        end
    end
    return order[idx]
end

-- On request to set specific weather
RegisterNetEvent('santoscore-weather:serverSetWeather', function(weather)
    freezeEnabled = false
    TriggerClientEvent('santoscore-weather:clientSyncWeather', -1, weather)
end)

-- On request to set random weather
RegisterNetEvent('santoscore-weather:serverSetRandom', function()
    freezeEnabled = false
    local randomWeather = GetRandomWeather()
    TriggerClientEvent('santoscore-weather:clientSyncRandom', -1, randomWeather)
end)

-- On request to advance to next weather
RegisterNetEvent('santoscore-weather:serverSetNext', function()
    freezeEnabled = false
    -- Assume current server weather stored somewhere; for simplicity, pick random next
    local curr = GetRandomWeather()
    local nextW = GetNextWeather(curr)
    TriggerClientEvent('santoscore-weather:clientSyncNext', -1, nextW)
end)

-- Toggle freeze
RegisterNetEvent('santoscore-weather:serverToggleFreeze', function()
    freezeEnabled = not freezeEnabled
    TriggerClientEvent('santoscore-weather:clientSyncFreeze', -1, freezeEnabled)
end)

-- Toggle blackout
RegisterNetEvent('santoscore-weather:serverToggleBlackout', function()
    blackoutEnabled = not blackoutEnabled
    TriggerClientEvent('santoscore-weather:clientSyncBlackout', -1, blackoutEnabled)
end)

-- Set preset time
RegisterNetEvent('santoscore-weather:serverSetTime', function(preset)
    local t = Config.TimePresets[preset]
    if t then
        TriggerClientEvent('santoscore-weather:clientSyncTime', -1, t.hour, t.minute)
    end
end)

-- Badger_Discord_API integration: register slash command to change weather
AddEventHandler('onResourceStart', function(resourceName)
    if resourceName == GetCurrentResourceName() and GetResourceState('Badger_Discord_API') == 'started' then
        exports['Badger_Discord_API']:RegisterSlashCommand('weather', 'Change server weather', function(source, args)
            local weather = args.weather and args.weather:upper()
            if weather and type(weather) == 'string' then
                TriggerEvent('santoscore-weather:serverSetWeather', weather)
            end
        end, {
            {
                name        = 'weather',
                description = 'One of: ' .. table.concat(Config.WeatherTypes, ', '),
                required    = true,
                type        = 'STRING'
            }
        })
    end
end)
