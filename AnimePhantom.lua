-- ANIME PHANTOM GUI
-- Roblox Studio LocalScript
-- Mobile + PC

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

local gui = Instance.new("ScreenGui")
gui.Name = "AnimePhantom"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local main = Instance.new("Frame")
main.Size = UDim2.fromOffset(480, 330)
main.Position = UDim2.new(0.5, -240, 0.5, -165)
main.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
main.BorderSizePixel = 0
main.Active = true
main.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 14)
corner.Parent = main

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(155, 65, 255)
stroke.Thickness = 2
stroke.Parent = main

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -60, 0, 48)
title.Position = UDim2.fromOffset(15, 0)
title.BackgroundTransparency = 1
title.Text = "✦ ANIME PHANTOM"
title.TextColor3 = Color3.fromRGB(190, 120, 255)
title.TextSize = 23
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = main

local close = Instance.new("TextButton")
close.Size = UDim2.fromOffset(35, 35)
close.Position = UDim2.new(1, -43, 0, 7)
close.Text = "X"
close.TextColor3 = Color3.new(1,1,1)
close.BackgroundColor3 = Color3.fromRGB(90, 25, 120)
close.Parent = main

Instance.new("UICorner", close).CornerRadius = UDim.new(0, 8)

close.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- Drag support for mouse and touch
local dragging = false
local dragStart, startPosition

main.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPosition = main.Position
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and (
        input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch
    ) then
        local delta = input.Position - dragStart
        main.Position = UDim2.new(
            startPosition.X.Scale,
            startPosition.X.Offset + delta.X,
            startPosition.Y.Scale,
            startPosition.Y.Offset + delta.Y
        )
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

local content = Instance.new("Frame")
content.Position = UDim2.fromOffset(15, 60)
content.Size = UDim2.new(1, -30, 1, -75)
content.BackgroundTransparency = 1
content.Parent = main

local layout = Instance.new("UIGridLayout")
layout.CellSize = UDim2.new(0.48, 0, 0, 55)
layout.CellPadding = UDim2.fromOffset(8, 8)
layout.Parent = content

local function getHumanoid()
    character = player.Character or player.CharacterAdded:Wait()
    return character:WaitForChild("Humanoid")
end

local function makeButton(name, callback)
    local button = Instance.new("TextButton")
    button.Text = name
    button.TextColor3 = Color3.new(1,1,1)
    button.TextSize = 15
    button.Font = Enum.Font.GothamBold
    button.BackgroundColor3 = Color3.fromRGB(35, 20, 48)
    button.Parent = content

    Instance.new("UICorner", button).CornerRadius = UDim.new(0, 10)

    local border = Instance.new("UIStroke")
    border.Color = Color3.fromRGB(130, 65, 190)
    border.Parent = button

    button.MouseButton1Click:Connect(function()
        callback(button)
    end)

    return button
end

local speedEnabled = false
local jumpEnabled = false

makeButton("SPEED: OFF", function(button)
    speedEnabled = not speedEnabled
    getHumanoid().WalkSpeed = speedEnabled and 32 or 16
    button.Text = speedEnabled and "SPEED: ON" or "SPEED: OFF"
end)

makeButton("JUMP: OFF", function(button)
    jumpEnabled = not jumpEnabled
    local hum = getHumanoid()
    hum.UseJumpPower = true
    hum.JumpPower = jumpEnabled and 75 or 50
    button.Text = jumpEnabled and "JUMP: ON" or "JUMP: OFF"
end)

makeButton("RESET CHARACTER", function()
    getHumanoid().Health = 0
end)

makeButton("NORMAL SPEED", function()
    speedEnabled = false
    getHumanoid().WalkSpeed = 16
end)

makeButton("NORMAL JUMP", function()
    jumpEnabled = false
    local hum = getHumanoid()
    hum.UseJumpPower = true
    hum.JumpPower = 50
end)

makeButton("HIDE GUI", function()
    main.Visible = false
end)

-- Reopen GUI using RightShift on PC
UIS.InputBegan:Connect(function(input, processed)
    if not processed and input.KeyCode == Enum.KeyCode.RightShift then
        main.Visible = not main.Visible
    end
end)

-- Character respawn handling
player.CharacterAdded:Connect(function(newCharacter)
    character = newCharacter
    task.wait(0.5)
    speedEnabled = false
    jumpEnabled = false
end)
