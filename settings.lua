local data = {
    volume = 0.5,
    resolution = { width = 1920, height = 1080 },
    fullscreen = false,
    language = "en",
    difficulty = "normal",
    debugger = false,
}

local settings = {}

function settings.get(key)
    return data[key]
end

function settings.set(key, value)
    data[key] = value
end

return settings
