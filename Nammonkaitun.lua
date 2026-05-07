-- kaitun💧👑 Script - Legacy Toilet Tower Defense

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HRP = character:WaitForChild("HumanoidRootPart")
local RS = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")

-- Webhook URL
local WEBHOOK = "https://discord.com/api/webhooks/1454014854980702241/pXvlOL4pN3Yn5jFqFeOlhVMn-p6BlbfjpTjtiuVcV8OJOujl4a-MEPnZwNGr1YVUUaHh"

-- Teleport
HRP.CFrame = CFrame.new(40, 10, -160)
print("kaitun💧👑 - Teleport แล้ว รอ 2 วิ...")
task.wait(2)

-- GUI กลางจอ
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "KaitunGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = LocalPlayer.PlayerGui

local label = Instance.new("TextLabel")
label.Size = UDim2.new(0, 300, 0, 60)
label.Position = UDim2.new(0.5, -150, 0.5, -30)
label.BackgroundTransparency = 1
label.Text = "kaitun💧👑"
label.TextColor3 = Color3.fromRGB(0, 200, 255)
label.TextScaled = true
label.Font = Enum.Font.GothamBold
label.TextStrokeTransparency = 0
label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
label.Parent = screenGui

local DataRemote = RS:WaitForChild("NetworkingContainer"):WaitForChild("DataRemote")

-- ส่ง Webhook Discord
local function sendWebhook(money)
    local data = HttpService:JSONEncode({
        username = "kaitun💧👑 Bot",
        avatar_url = "https://cdn-icons-png.flaticon.com/512/1828/1828884.png",
        embeds = {
            {
                title = "💰 เกมจบแล้ว!",
                description = "**ผู้เล่น:** " .. LocalPlayer.Name .. "\n**เงินที่ได้:** $" .. tostring(money),
                color = 3066993,
                footer = {
                    text = "kaitun💧👑 Auto Farm"
                },
                timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
            }
        }
    })

    local success, err = pcall(function()
        request({
            Url = WEBHOOK,
            Method = "POST",
            Headers = { ["Content-Type"] = "application/json" },
            Body = data
        })
    end)

    if success then
        print("kaitun💧👑 - ส่ง Webhook แล้ว! เงิน: $" .. tostring(money))
    else
        print("kaitun💧👑 - Webhook Error: " .. tostring(err))
    end
end

-- จับเงินก่อนและหลังเกมจบ
local lastMoney = 0
local function getMoney()
    -- หาเงินจาก GUI ในเกม
    for _, obj in ipairs(game:GetDescendants()) do
        if obj:IsA("TextLabel") then
            local txt = obj.Text or ""
            local num = txt:match("%$(%d+)")
            if num then
                return tonumber(num)
            end
        end
    end
    return 0
end

-- ดักจับตอนเกมจบ (Intermission ขึ้น)
local gameEnded = false
task.spawn(function()
    while true do
        for _, obj in ipairs(game:GetDescendants()) do
            if obj:IsA("TextLabel") then
                local txt = (obj.Text or ""):lower()
                if txt:find("intermission") and not gameEnded then
                    gameEnded = true
                    local money = getMoney()
                    local earned = money - lastMoney
                    sendWebhook(earned)
                    lastMoney = money
                    task.wait(5)
                    gameEnded = false
                end
            end
        end
        task.wait(1)
    end
end)

-- กด Start
local function pressStart()
    local args = {
        {
            {
                "\226\129\130G",
                "b52c5595-0bef-4e24-a9ae-4174ecd16b3d"
            }
        }
    }
    DataRemote:FireServer(unpack(args))
    print("kaitun💧👑 - Start!")
end

-- กด Skip
local function pressSkip()
    local args = {
        {
            {
                "\226\129\130("
            }
        }
    }
    DataRemote:FireServer(unpack(args))
    print("kaitun💧👑 - Skip!")
end

-- รัน
task.spawn(function()
    while true do
        pressStart()
        task.wait(2)
    end
end)

task.spawn(function()
    while true do
        pressSkip()
        task.wait(2)
    end
end)

print("kaitun💧👑 Script Loaded!")
