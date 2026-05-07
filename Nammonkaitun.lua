-- kaitun💧👑 Script - Toilet HQ Auto Farm

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HRP = character:WaitForChild("HumanoidRootPart")
local RS = game:GetService("ReplicatedStorage")

-- Teleport
HRP.CFrame = CFrame.new(40, 10, -160)
print("kaitun💧👑 - Teleport แล้ว รอ 5 วิ...")
task.wait(5)

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

-- กด Start ไปเรื่อยๆ (UUID ใหม่)
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

-- กด Skip ไปเรื่อยๆ
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

-- รัน Start และ Skip พร้อมกัน
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
