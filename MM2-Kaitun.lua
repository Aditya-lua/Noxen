-- Noxen MM2 Kaitun: the server controls the five-day free window.
-- A paid key resumes normal access after the promotion; this bridge adds no UI.
local Env = (type(getgenv) == "function" and getgenv()) or _G
Env.SCRIPT_KEY = nil
local PublicToken = "99391f69632234eb2623e1ededd8dae9788fd08ee0d32425fe8e3a8eea3eb6a5"
if #PublicToken ~= 64 or not PublicToken:match("^[a-f0-9]+$") then
    error("[Noxen Kaitun] Owner setup is not finished yet.", 0)
end
local Settings = Env.Config
local Key = type(Settings) == "table" and Settings.Key or nil
Key = type(Key) == "string" and Key:match("^%s*(.-)%s*$") or ""
local Placeholder = Key == "" or Key == "YOUR_PAID_KEY_HERE" or Key == "YOUR_KEY_HERE"
Env.SCRIPT_KEY = (Placeholder or Key:upper() == "KEYLESS") and "KEYLESS" or Key
loadstring(game:HttpGet("https://api.jnkie.com/api/v1/luascripts/public/" .. PublicToken .. "/download"))()
