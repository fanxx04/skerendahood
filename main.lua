script_key = 'VYduAVBjFTcppIFDfCaRfOcQIcVsTqhu'
getgenv().AutofarmSettings = {
    ["Fps"] = 10,
    ["InstaTP"] = true,
    ["Underground"] = true,

    ["Webhook"] = {
        ["URL"] = "",
        ["Interval"] = 10
    },

    ["Serverhop"] = {
        ["Cycle"]   = 15,        -- 1 = After dying once.
        ["Time"]    = 0,        -- 1 = After 1 Minute.
        ["Kick"]    = true,    -- true = After getting kicked.
        ["Blacklisted_IDs"] = { 1234567890, 1234567890 } -- If UserID was found ingame, Detects new joining players too.
    },
    " warlocks atm farm - @snuffing "
}
loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/2f5a5d4b9fc7ed0f115580a53bfab777.lua"))()
