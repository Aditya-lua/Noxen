if not game:IsLoaded() then
    game.Loaded:Wait()
end

local FLOWAUTH = "https://flowauth.net/v1/loaders/"
local DISCORD = "https://discord.gg/AcWg7RVPzw"
local TRIES = 3

local GAMES = {
    { Name = "Sell a Million Sushi",   Loader = "c1096e7a1231f0536f076eaa0a97dbde", Places = { 125866884667103 } },
    { Name = "Sweep the Moon",         Loader = "4e34a71592c0f5dd3def560a6bf330c3", Universe = 10772543706 },
    { Name = "100 Days at Sea",        Loader = "b94d682bb710097ec12f796c71707c55", Places = { 139802517550914 } },
    { Name = "Rock Cutting Simulator", Loader = "10bb1ea7f34ba4df5a384ece05dd0e93", Places = { 113742027864370 } },
    { Name = "Throw Food For Animals", Loader = "6edcc235732b7a289fec65ed22c954d2", Places = { 120219252362013 } },
    { Name = "Vox Seas",               Loader = "7ef8a193c27ce40b735ad05517f91793", Places = { 104067066727140 } },
    { Name = "King Legacy",            Loader = "36f4ca7d813b52f946788fead1b77231", Universe = 1451439645 },
}

local StarterGui = game:GetService("StarterGui")
local Env = (type(getgenv) == "function" and getgenv()) or _G

-- SetCore throws until the CoreScripts register it, which can still be the case right after joining
local function Notify(Text, Duration)
    print("[Noxen] " .. Text)
    task.spawn(function()
        for _ = 1, 10 do
            local Ok = pcall(StarterGui.SetCore, StarterGui, "SendNotification", {
                Title = "Noxen",
                Text = Text,
                Duration = Duration or 5,
            })
            if Ok then
                return
            end
            task.wait(0.5)
        end
    end)
end

local function Find()
    for _, Entry in ipairs(GAMES) do
        for _, Place in ipairs(Entry.Places or {}) do
            if game.PlaceId == Place then
                return Entry
            end
        end
    end
    for _, Entry in ipairs(GAMES) do
        if Entry.Universe and game.GameId == Entry.Universe then
            return Entry
        end
    end
    return nil
end

local function Fetch(Url)
    local Problem
    for Try = 1, TRIES do
        local Ok, Body = pcall(game.HttpGet, game, Url)
        if Ok and type(Body) == "string" and Body ~= "" then
            return Body
        end
        Problem = Ok and "empty response" or tostring(Body)
        if Try < TRIES then
            task.wait(Try) -- 1 s, then 2 s
        end
    end
    return nil, Problem
end

-- a second run while the first is still fetching (auto-execute plus a manual run) would load the hub twice
if Env.__NoxenLoaderBusy then
    warn("[Noxen] the loader is already running")
    return
end

local Entry = Find()
if not Entry then
    local Names = {}
    for _, Supported in ipairs(GAMES) do
        table.insert(Names, Supported.Name)
    end
    Notify("This game isn't supported yet. Supported games are listed in the console.", 8)
    print("[Noxen] supported: " .. table.concat(Names, ", "))
    print("[Noxen] requests and news: " .. DISCORD)
    return
end

Env.__NoxenLoaderBusy = true
Notify("Loading " .. Entry.Name, 4)
local Body, Problem = Fetch(FLOWAUTH .. Entry.Loader .. ".lua")
if not Body then
    Env.__NoxenLoaderBusy = nil
    Notify("Couldn't reach FlowAuth, try again in a moment", 8)
    warn("[Noxen] " .. Entry.Name .. ": " .. tostring(Problem))
    return
end

local Chunk, CompileError = loadstring(Body)
Env.__NoxenLoaderBusy = nil
if not Chunk then
    Notify("FlowAuth sent a broken loader, try again", 8)
    warn("[Noxen] " .. Entry.Name .. ": " .. tostring(CompileError))
    return
end

-- called directly, the way you would run FlowAuth's loader yourself, so its own checks see a normal call
Chunk()
