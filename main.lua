if game.Players:FindFirstChild("IsjeboyNL") then
    script_key = 'VYduAVBjFTcppIFDfCaRfOcQIcVsTqhu'
    getgenv().ControlSettings = {
        ["Host"] = "IsjeboyNL", -- Or UserID
        ["Fps"] = 5, 
        ["Prefix"] = "/", 
        ["AdMessage"] = "dahood money!!!",
        " discord.gg/iku "
    }
    loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/ca81565eda5d99b30347fb11516b2f62.lua"))()
else 
    script_key = 'VYduAVBjFTcppIFDfCaRfOcQIcVsTqhu'
    getgenv().AutofarmSettings = {
        ["Fps"] = 10,
        ["InstaTP"] = true,
        ["Underground"] = true,

        ["Webhook"] = {
            ["URL"] = "https://discord.com/api/webhooks/1355521391218266222/8Luq8oDNFJ0Xf_lbk8QIZNMAIzgXbNR9l2AKM6nM5LndGuTQ9ELrtasB9C8t2gKEdGnC",
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
end
