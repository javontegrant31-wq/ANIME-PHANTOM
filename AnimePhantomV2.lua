
-- Created by Javonte Grant

local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local UIS = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local Purple = Color3.fromRGB(145, 65, 255)
local Dark = Color3.fromRGB(19, 13, 29)
local Panel = Color3.fromRGB(34, 23, 49)
local White = Color3.fromRGB(255, 255, 255)

local Old = PlayerGui:FindFirstChild("AnimePhantomX")
if Old then Old:Destroy() end

local Gui = Instance.new("ScreenGui")
Gui.Name = "AnimePhantomX"
Gui.ResetOnSpawn = false
Gui.Parent = PlayerGui

local function Create(class, properties, parent)
    local object = Instance.new(class)
    for key, value in pairs(properties) do
        object[key] = value
    end
    object.Parent = parent
    return object
end

local function Round(object, amount)
    Create("UICorner", {
        CornerRadius = UDim.new(0, amount or 8)
    }, object)
end

local function Notify(message)
    local notification = Create("TextLabel", {
        Size = UDim2.new(0, 260, 0, 42),
        Position = UDim2.new(0.5, -130, 0, 20),
        BackgroundColor3 = Panel,
        Text = message,
        TextColor3 = White,
        TextSize = 13,
        Font = Enum.Font.GothamBold,
        ZIndex = 10
    }, Gui)

    Round(notification, 8)

    Create("UIStroke", {
        Color = Purple,
        Thickness = 2
    }, notification)

    task.delay(3, function()
        if notification.Parent then
            notification:Destroy()
        end
    end)
end

-- Loading screen
local Loading = Create("Frame", {
    Size = UDim2.fromScale(1, 1),
    BackgroundColor3 = Dark,
    BorderSizePixel = 0
}, Gui)

Create("TextLabel", {
    Size = UDim2.new(1, 0, 0, 60),
    Position = UDim2.new(0, 0, 0.4, 0),
    BackgroundTransparency = 1,
    Text = "ANIME PHANTOM X",
    TextColor3 = Purple,
    TextSize = 28,
    Font = Enum.Font.GothamBold
}, Loading)

Create("TextLabel", {
    Size = UDim2.new(1, 0, 0, 30),
    Position = UDim2.new(0, 0, 0.5, 0),
    BackgroundTransparency = 1,
    Text = "Loading V2.0...",
    TextColor3 = White,
    TextSize = 14
}, Loading)

task.wait(5)
Loading:Destroy()

-- Main GUI
local Main = Create("Frame", {
    Size = UDim2.new(0, 540, 0, 380),
    Position = UDim2.new(0.5, -270, 0.5, -190),
    BackgroundColor3 = Dark,
    BorderSizePixel = 0
}, Gui)

Round(Main, 12)

Create("UIStroke", {
    Color = Purple,
    Thickness = 2
}, Main)

-- Header
local Header = Create("Frame", {
    Size = UDim2.new(1, 0, 0, 48),
    BackgroundColor3 = Panel,
    BorderSizePixel = 0
}, Main)

Create("TextLabel", {
    Size = UDim2.new(1, -100, 1, 0),
    Position = UDim2.new(0, 14, 0, 0),
    BackgroundTransparency = 1,
    Text = "ANIME PHANTOM X",
    TextColor3 = Purple,
    TextSize = 18,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Left
}, Header)

local Close = Create("TextButton", {
    Size = UDim2.new(0, 35, 0, 30),
    Position = UDim2.new(1, -42, 0, 9),
    BackgroundColor3 = Color3.fromRGB(180, 45, 65),
    Text = "X",
    TextColor3 = White,
    Font = Enum.Font.GothamBold,
    TextSize = 15
}, Header)

Round(Close, 6)

Close.Activated:Connect(function()
    Gui:Destroy()
end)

-- Dragging
local dragging = false
local dragStart
local startPosition

Header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPosition = Main.Position
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and (
        input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch
    ) then
        local delta = input.Position - dragStart
        Main.Position = UDim2.new(
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

-- Sidebar
local Sidebar = Create("ScrollingFrame", {
    Size = UDim2.new(0, 135, 1, -60),
    Position = UDim2.new(0, 8, 0, 53),
    BackgroundColor3 = Panel,
    BorderSizePixel = 0,
    ScrollBarThickness = 3,
    CanvasSize = UDim2.new(0, 0, 0, 0),
    AutomaticCanvasSize = Enum.AutomaticSize.Y
}, Main)

Round(Sidebar, 8)

local TabLayout = Create("UIListLayout", {
    Padding = UDim.new(0, 5),
    SortOrder = Enum.SortOrder.LayoutOrder
}, Sidebar)

Create("UIPadding", {
    PaddingTop = UDim.new(0, 7),
    PaddingLeft = UDim.new(0, 6),
    PaddingRight = UDim.new(0, 6)
}, Sidebar)

-- Page container
local Content = Create("Frame", {
    Size = UDim2.new(1, -160, 1, -65),
    Position = UDim2.new(0, 152, 0, 55),
    BackgroundColor3 = Panel,
    BorderSizePixel = 0
}, Main)

Round(Content, 8)

local Pages = {}

local function NewPage(name)
    local page = Create("ScrollingFrame", {
        Name = name,
        Size = UDim2.new(1, -12, 1, -12),
        Position = UDim2.new(0, 6, 0, 6),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 3,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        Visible = false
    }, Content)

    Create("UIListLayout", {
        Padding = UDim.new(0, 8),
        SortOrder = Enum.SortOrder.LayoutOrder
    }, page)

    Pages[name] = page
    return page
end

local function ShowPage(name)
    for pageName, page in pairs(Pages) do
        page.Visible = pageName == name
    end
end

local function AddTab(name)
    local button = Create("TextButton", {
        Size = UDim2.new(1, 0, 0, 35),
        BackgroundColor3 = Dark,
        Text = name,
        TextColor3 = White,
        TextSize = 12,
        Font = Enum.Font.GothamBold
    }, Sidebar)

    Round(button, 6)

    button.Activated:Connect(function()
        ShowPage(name)
    end)
end

local function AddButton(page, name, callback)
    local button = Create("TextButton", {
        Size = UDim2.new(1, -5, 0, 38),
        BackgroundColor3 = Dark,
        Text = name,
        TextColor3 = White,
        TextSize = 13,
        Font = Enum.Font.Gotham
    }, page)

    Round(button, 7)

    Create("UIStroke", {
        Color = Purple,
        Thickness = 1
    }, button)

    button.Activated:Connect(callback)
    return button
end

local function AddToggle(page, name, callback)
    local enabled = false
    local button

    button = AddButton(page, name .. " : OFF", function()
        enabled = not enabled
        button.Text = name .. (enabled and " : ON" or " : OFF")
        button.BackgroundColor3 = enabled and Purple or Dark
        callback(enabled)
    end)

    return button
end

-- Pages
local tabNames = {
    "ESP",
    "SPEED",
    "AUTO FARM",
    "LOCK ON",
    "PROTECTION",
    "FLY + SPEED",
    "FREE EMOTES",
    "SERVER",
    "TROLLING",
    "ABOUT"
}

for _, name in ipairs(tabNames) do
    NewPage(name)
    AddTab(name)
end

-- ESP page
AddButton(Pages.ESP, "Player Highlights", function()
    Notify("Highlights are available in your own experience")
end)

AddButton(Pages.ESP, "Refresh Highlights", function()
    Notify("Highlight refresh requested")
end)

AddButton(Pages.ESP, "Role ESP", function()
    Notify("Hidden-role tracking is not included")
end)

-- Speed page
local speed = 16

local function SetSpeed(value)
    speed = value

    local character = Player.Character
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")

    if humanoid then
        humanoid.WalkSpeed = speed
    end

    Notify("Speed set to " .. speed)
end

AddButton(Pages.SPEED, "Speed 24", function()
    SetSpeed(24)
end)

AddButton(Pages.SPEED, "Speed 32", function()
    SetSpeed(32)
end)

AddButton(Pages.SPEED, "Reset Speed", function()
    SetSpeed(16)
end)

-- Auto Farm page
AddButton(Pages["AUTO FARM"], "Auto Farm", function()
    Notify("Auto farming is not included")
end)

-- Lock on page
AddButton(Pages["LOCK ON"], "Training Dummy Lock", function()
    Notify("Dummy lock is available in your own experience")
end)

-- Protection page
AddButton(Pages.PROTECTION, "Anti-Fling Safeguard", function()
    Notify("Protection settings are experience-dependent")
end)

AddButton(Pages.PROTECTION, "Anti-Lag", function()
    Notify("Visual effects settings are experience-dependent")
end)

-- Fly page
AddButton(Pages["FLY + SPEED"], "Fly Controls", function()
    Notify("Flight controls require an authorized game setup")
end)

-- Emotes page
AddButton(Pages["FREE EMOTES"], "Open Emote Menu", function()
    Notify("Use the game's emote menu")
end)

-- Server page
AddButton(Pages.SERVER, "Rejoin Server", function()
    Notify("Rejoining server...")

    local success = pcall(function()
        TeleportService:Teleport(game.PlaceId, Player)
    end)

    if not success then
        Notify("Rejoin unavailable")
    end
end)

AddButton(Pages.SERVER, "Server Hop", function()
    Notify("Server hopping requires an authorized server browser")
end)

-- Trolling page
AddButton(Pages.TROLLING, "Fake Kick Notification", function()
    Notify("You have been kicked! (Fake notification)")
end)

AddButton(Pages.TROLLING, "Fake Warning", function()
    Notify("PHANTOM WARNING: Just a prank!")
end)

-- About page
Create("TextLabel", {
    Size = UDim2.new(1, -5, 0, 50),
    BackgroundTransparency = 1,
    Text = "ANIME PHANTOM X",
    TextColor3 = Purple,
    TextSize = 24,
    Font = Enum.Font.GothamBold
}, Pages.ABOUT)

Create("TextLabel", {
    Size = UDim2.new(1, -5, 0, 35),
    BackgroundTransparency = 1,
    Text = "Created by: Javonte Grant",
    TextColor3 = White,
    TextSize = 15,
    Font = Enum.Font.Gotham
}, Pages.ABOUT)

Create("TextLabel", {
    Size = UDim2.new(1, -5, 0, 35),
    BackgroundTransparency = 1,
    Text = "Version 2.0 | Purple Phantom Edition",
    TextColor3 = Purple,
    TextSize = 12,
    Font = Enum.Font.Gotham
}, Pages.ABOUT)

ShowPage("ESP")
Notify("ANIME PHANTOM X V2.0 LOADED")
