-- Noxen MM2 Kaitun: permanently keyless. No key field or key-entry UI is required.
-- Legacy protected delivery remains until the engine hosting migration is complete.
local Env = (type(getgenv) == "function" and getgenv()) or _G
Env.SCRIPT_KEY = "KEYLESS"
local PublicToken = "99391f69632234eb2623e1ededd8dae9788fd08ee0d32425fe8e3a8eea3eb6a5"
if #PublicToken ~= 64 or not PublicToken:match("^[a-f0-9]+$") then
    error("[Noxen Kaitun] Owner setup is not finished yet.", 0)
end
loadstring(game:HttpGet("https://api.jnkie.com/api/v1/luascripts/public/" .. PublicToken .. "/download"))()
