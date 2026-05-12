-- kaitun💧👑 Script - Toilet HQ Auto Farm 4 จุด

local Players = game:GetService("Players")
local VIM = game:GetService("VirtualInputManager")
local LocalPlayer = Players.LocalPlayer
local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HRP = character:WaitForChild("HumanoidRootPart")
local RS = game:GetService("ReplicatedStorage")
local playerGui = LocalPlayer:WaitForChild("PlayerGui")

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

-- 4 จุด
local points = {
    CFrame.new(-19.2, 5.3, -157.5),
    CFrame.new(1.8,   5.3, -157.0),
    CFrame.new(22.7,  5.3, -158.6),
    CFrame.new(43.8,  5.3, -157.6),
}

-- กด Start (Remote)
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

-- กด Skip (Remote)
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

-- คลิกปุ่ม Start บนหน้าจอ
local offsetY = 40

local function findStartButton()
    for _, obj in pairs(playerGui:GetDescendants()) do
        if obj:IsA("TextButton") and obj.Text == "Start" then
            return obj
        end
    end
end

local function clickButton(btn)
    local pos = btn.AbsolutePosition
    local size = btn.AbsoluteSize
    local centerX = pos.X + size.X / 2
    local centerY = pos.Y + size.Y / 2 + offsetY

    VIM:SendMouseButtonEvent(centerX, centerY, 0, true, game, 0)
    task.wait(0.1)
    VIM:SendMouseButtonEvent(centerX, centerY, 0, false, game, 0)
    print("kaitun💧👑 - คลิกปุ่มที่", centerX, centerY)
end

-- วนลูป 4 จุด
local round = 0
while true do
    for i, point in ipairs(points) do
        -- วาปไปจุด
        character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        HRP = character:WaitForChild("HumanoidRootPart")
        HRP.CFrame = point
        print("kaitun💧👑 - วาปไปจุด", i)
        task.wait(1)

        -- กด Start ทั้ง Remote และคลิกจริง
        pressStart()
        local btn = findStartButton()
        if btn then clickButton(btn) end
        task.wait(1)

        -- Skip
        pressSkip()
        task.wait(3)
    end

    round = round + 1
    print("kaitun💧👑 - ครบรอบที่", round)
end
