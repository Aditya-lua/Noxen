local Env = (type(getgenv) == "function" and getgenv()) or _G
local Settings = Env.Config
local Key = type(Settings) == "table" and Settings.Key or nil
Env.SCRIPT_KEY = nil
if type(Key) ~= "string" then
    error("[Noxen Kaitun] Set Config.Key to your paid key before loading.", 0)
end
Key = Key:match("^%s*(.-)%s*$")
if Key == "" or Key:upper() == "KEYLESS" or Key == "YOUR_PAID_KEY_HERE" then
    error("[Noxen Kaitun] Set Config.Key to your paid key before loading.", 0)
end
Env.SCRIPT_KEY = Key
loadstring(game:HttpGet("https://api.jnkie.com/api/v1/luascripts/public/ef41153fc8c8e272a0975a69bea11e5e7e742658014151d19ec6847bcba871f8/download"))()
