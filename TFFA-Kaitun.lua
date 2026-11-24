-- Noxen TFFA Kaitun: permanently keyless. No key field or key-entry UI is required.
-- Legacy protected delivery remains until the engine hosting migration is complete.
local Env = (type(getgenv) == "function" and getgenv()) or _G
Env.SCRIPT_KEY = "KEYLESS"
local PublicToken = "ef41153fc8c8e272a0975a69bea11e5e7e742658014151d19ec6847bcba871f8"
if #PublicToken ~= 64 or not PublicToken:match("^[a-f0-9]+$") then
    error("[Noxen Kaitun] Owner setup is not finished yet.", 0)
end
loadstring(game:HttpGet("https://api.jnkie.com/api/v1/luascripts/public/" .. PublicToken .. "/download"))()
