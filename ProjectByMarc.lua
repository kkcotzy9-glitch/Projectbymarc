
-- PROJECT BY MARC
-- VOID EDITION V3
-- LocalScript / StarterPlayerScripts

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer
local purple = Color3.fromRGB(160, 75, 255)
local dark = Color3.fromRGB(13, 9, 23)
local white = Color3.fromRGB(245, 240, 255)

local speed = 16
local jump = 50
local infiniteJump = false
local alive = true

local gui = Instance.new("ScreenGui")
gui.Name = "ProjectByMarc"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local main = Instance.new("Frame")
main.Size = UDim2.fromOffset(300, 300)
main.Position = UDim2.new(.5, -150, .5, -150)
main.BackgroundColor3 = dark
main.Parent = gui

Instance.new("UICorner", main).CornerRadius =
    UDim.new(0, 16)

local stroke = Instance.new("UIStroke")
stroke.Color = purple
stroke.Thickness = 2
stroke.Parent = main

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -55, 0, 48)
title.Position = UDim2.fromOffset(12, 0)
title.BackgroundTransparency = 1
title.Text = "PROJECT BY MARC"
title.TextColor3 = white
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = main

local close = Instance.new("TextButton")
close.Size = UDim2.fromOffset(35, 35)
close.Position = UDim2.new(1, -43, 0, 7)
close.Text = "X"
close.TextColor3 = white
close.TextSize = 17
close.Font = Enum.Font.GothamBold
close.BackgroundColor3 = purple
close.Parent = main
Instance.new("UICorner", close)

close.Activated:Connect(function()
    alive = false
    gui:Destroy()
end)

local content = Instance.new("Frame")
content.Position = UDim2.fromOffset(15, 58)
content.Size = UDim2.new(1, -30, 1, -70)
content.BackgroundTransparency = 1
content.Parent = main

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 17)
layout.Parent = content

local function getHumanoid()
    local char = player.Character
    return char and char:FindFirstChildOfClass("Humanoid")
end

local function makeSlider(label, min, max, initial, callback)
    local section = Instance.new("Frame")
    section.Size = UDim2.new(1, 0, 0, 75)
    section.BackgroundTransparency = 1
    section.Parent = content

    local name = Instance.new("TextLabel")
    name.Size = UDim2.new(1, 0, 0, 25)
    name.BackgroundTransparency = 1
    name.Text = label
    name.TextColor3 = white
    name.Font = Enum.Font.GothamBold
    name.TextSize = 14
    name.TextXAlignment = Enum.TextXAlignment.Left
    name.Parent = section

    local value = Instance.new("TextLabel")
    value.Size = UDim2.fromOffset(65, 25)
    value.Position = UDim2.new(1, -65, 0, 0)
    value.BackgroundTransparency = 1
    value.TextColor3 = purple
    value.Font = Enum.Font.GothamBold
    value.Text = tostring(initial)
    value.Parent = section

    local bar = Instance.new("Frame")
    bar.Position = UDim2.fromOffset(0, 39)
    bar.Size = UDim2.new(1, 0, 0, 9)
    bar.BackgroundColor3 = Color3.fromRGB(48, 37, 61)
    bar.Parent = section
    Instance.new("UICorner", bar).CornerRadius = UDim.new(1, 0)

    local fill = Instance.new("Frame")
    fill.Size = UDim2.fromScale(
        (initial-min)/(max-min), 1
    )
    fill.BackgroundColor3 = purple
    fill.Parent = bar
    Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)

    local knob = Instance.new("TextButton")
    knob.Size = UDim2.fromOffset(19, 19)
    knob.AnchorPoint = Vector2.new(.5, .5)
    knob.Position = UDim2.new(
        (initial-min)/(max-min), 0, .5, 0
    )
    knob.Text = ""
    knob.BackgroundColor3 = white
    knob.Parent = bar
    Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)

    local function update(input)
        local percent = math.clamp(
            (input.Position.X - bar.AbsolutePosition.X)
            / bar.AbsoluteSize.X, 0, 1
        )

        local number = math.floor(
            min + (max-min)*percent + .5
        )

        fill.Size = UDim2.fromScale(percent, 1)
        knob.Position = UDim2.new(percent, 0, .5, 0)
        value.Text = tostring(number)
        callback(number)
    end

    local active = false

    knob.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
            active = true
            update(input)
        end
    end)

    bar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
            active = true
            update(input)
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if active and (
            input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch
        ) then
            update(input)
        end
    end)

    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
            active = false
        end
    end)
end

makeSlider("⚡ SPEED", 16, 200, speed, function(v)
    speed = v
    local h = getHumanoid()
    if h then h.WalkSpeed = speed end
end)

makeSlider("🦘 JUMP POWER", 50, 1000, jump, function(v)
    jump = v
    local h = getHumanoid()
    if h then
        h.UseJumpPower = true
        h.JumpPower = jump
    end
end)

local toggle = Instance.new("TextButton")
toggle.Size = UDim2.fromOffset(48, 27)
toggle.Position = UDim2.fromOffset(0, 0)
toggle.BackgroundColor3 = Color3.fromRGB(55, 45, 65)
toggle.Text = ""
toggle.Parent = content
Instance.new("UICorner", toggle).CornerRadius = UDim.new(1, 0)

local dot = Instance.new("Frame")
dot.Size = UDim2.fromOffset(21, 21)
dot.Position = UDim2.fromOffset(3, 3)
dot.BackgroundColor3 = white
dot.Parent = toggle
Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)

local toggleLabel = Instance.new("TextLabel")
toggleLabel.Position = UDim2.fromOffset(60, 0)
toggleLabel.Size = UDim2.new(1, -60, 1, 0)
toggleLabel.BackgroundTransparency = 1
toggleLabel.Text = "INFINITE JUMP"
toggleLabel.TextColor3 = white
toggleLabel.Font = Enum.Font.GothamBold
toggleLabel.TextSize = 13
toggleLabel.TextXAlignment = Enum.TextXAlignment.Left
toggleLabel.Parent = content

toggle.Activated:Connect(function()
    infiniteJump = not infiniteJump
    toggle.BackgroundColor3 = infiniteJump
        and purple or Color3.fromRGB(55, 45, 65)
    dot.Position = infiniteJump
        and UDim2.fromOffset(24, 3)
        or UDim2.fromOffset(3, 3)
end)

UIS.JumpRequest:Connect(function()
    if not alive or not infiniteJump then return end
    local h = getHumanoid()
    if h and h.Health > 0 then
        h:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

local function applySettings()
    local h = getHumanoid()
    if h then
        h.WalkSpeed = speed
        h.UseJumpPower = true
        h.JumpPower = jump
    end
end

player.CharacterAdded:Connect(function()
    task.wait(.5)
    if alive then applySettings() end
end)

-- DRAG WINDOW
local dragging = false
local startPos, dragStart

title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch
    or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = main.Position
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and (
        input.UserInputType == Enum.UserInputType.Touch
        or input.UserInputType == Enum.UserInputType.MouseMovement
    ) then
        local delta = input.Position - dragStart
        main.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch
    or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)
