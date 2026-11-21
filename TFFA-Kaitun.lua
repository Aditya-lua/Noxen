-- Noxen TFFA Kaitun: the server controls the five-day free window.
-- A paid key resumes normal access after the promotion; this bridge adds no UI.
local Env = (type(getgenv) == "function" and getgenv()) or _G
Env.SCRIPT_KEY = nil
local PublicToken = "ef41153fc8c8e272a0975a69bea11e5e7e742658014151d19ec6847bcba871f8"
if #PublicToken ~= 64 or not PublicToken:match("^[a-f0-9]+$") then
    error("[Noxen Kaitun] Owner setup is not finished yet.", 0)
end
local Settings = Env.Config
local Key = type(Settings) == "table" and Settings.Key or nil
Key = type(Key) == "string" and Key:match("^%s*(.-)%s*$") or ""
local Placeholder = Key == "" or Key == "YOUR_PAID_KEY_HERE" or Key == "YOUR_KEY_HERE"
Env.SCRIPT_KEY = (Placeholder or Key:upper() == "KEYLESS") and "KEYLESS" or Key
loadstring(game:HttpGet("https://api.jnkie.com/api/v1/luascripts/public/" .. PublicToken .. "/download"))()
