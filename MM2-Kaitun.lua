local Env = (type(getgenv) == "function" and getgenv()) or _G
local Settings = Env.Config
local Key = type(Settings) == "table" and Settings.Key or nil
Env.SCRIPT_KEY = nil
if type(Key) ~= "string" then
    error("[Noxen MM2 Kaitun] Put your Premium MM2 key in Config.Key.", 0)
end
Key = Key:match("^%s*(.-)%s*$")
if Key == "" or Key:upper() == "KEYLESS" or Key == "YOUR_PAID_KEY_HERE" then
    error("[Noxen MM2 Kaitun] A purchased MM2 key is required.", 0)
end
local PublicToken = "99391f69632234eb2623e1ededd8dae9788fd08ee0d32425fe8e3a8eea3eb6a5"
if #PublicToken ~= 64 or not PublicToken:match("^[a-f0-9]+$") then
    error("[Noxen MM2 Kaitun] Owner setup is not finished yet.", 0)
end
Env.SCRIPT_KEY = Key
loadstring(game:HttpGet("https://api.jnkie.com/api/v1/luascripts/public/" .. PublicToken .. "/download"))()
