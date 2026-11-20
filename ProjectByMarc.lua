-- PROJECT BY MARC
-- PURPLE HUB

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "ProjectByMarc"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local main = Instance.new("Frame")
main.Size = UDim2.fromOffset(280, 350)
main.Position = UDim2.new(0.5, -140, 0.5, -175)
main.BackgroundColor3 = Color3.fromRGB(25, 15, 40)
main.Parent = gui

Instance.new("UICorner", main).CornerRadius = UDim.new(0, 14)

local outline = Instance.new("UIStroke")
outline.Color = Color3.fromRGB(170, 70, 255)
outline.Thickness = 2
outline.Parent = main

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 50)
title.BackgroundTransparency = 1
title.Text = "PROJECT BY MARC"
title.TextColor3 = Color3.fromRGB(200, 140, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 19
title.Parent = main

local container = Instance.new("Frame")
container.Position = UDim2.fromOffset(12, 60)
container.Size = UDim2.new(1, -24, 1, -72)
container.BackgroundTransparency = 1
container.Parent = main

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 9)
layout.Parent = container

local function makeButton(name, callback)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, 0, 0, 38)
    b.BackgroundColor3 = Color3.fromRGB(90, 40, 145)
    b.TextColor3 = Color3.new(1, 1, 1)
    b.Text = name
    b.Font = Enum.Font.GothamBold
    b.TextSize = 14
    b.Parent = container

    Instance.new("UICorner", b).CornerRadius =
        UDim.new(0, 8)

    b.MouseButton1Click:Connect(callback)
end

local function humanoid()
    local char = player.Character
    return char and char:FindFirstChildOfClass("Humanoid")
end

makeButton("SPEED 32", function()
    local h = humanoid()
    if h then h.WalkSpeed = 32 end
end)

makeButton("NORMAL SPEED", function()
    local h = humanoid()
    if h then h.WalkSpeed = 16 end
end)

makeButton("JUMP POWER 75", function()
    local h = humanoid()
    if h then
        h.UseJumpPower = true
        h.JumpPower = 75
    end
end)

makeButton("NORMAL JUMP", function()
    local h = humanoid()
    if h then h.JumpPower = 50 end
end)

makeButton("RESET CHARACTER", function()
    local h = humanoid()
    if h then h.Health = 0 end
end)

makeButton("CLOSE GUI", function()
    gui:Destroy()
end)

-- DRAG GUI
local dragging = false
local dragStart
local startPosition

title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch
    or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPosition = main.Position
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and (
        input.UserInputType == Enum.UserInputType.Touch
        or input.UserInputType == Enum.UserInputType.MouseMovement
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
    if input.UserInputType == Enum.UserInputType.Touch
    or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)
