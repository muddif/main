local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

local ANTENNA = {
    L = Vector3.new(-23.5, 8, 0),
    R = Vector3.new(23.5, 8, 0)
}

local active, antenna, grounded = false, "L", true

local gui = Instance.new("ScreenGui", player.PlayerGui)
local mainFrame = Instance.new("Frame", gui)
mainFrame.Size = UDim2.new(0.35, 0, 0.22, 0)
mainFrame.Position = UDim2.new(0.1, 0, 0.7, 0)
mainFrame.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
mainFrame.Active = true
mainFrame.Draggable = true

local titleBar = Instance.new("Frame", mainFrame)
titleBar.Size = UDim2.new(1, 0, 0.15, 0)
titleBar.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)

local titleText = Instance.new("TextLabel", titleBar)
titleText.Size = UDim2.new(0.8, 0, 1, 0)
titleText.Text = "Antenna Control"
titleText.TextScaled = true
titleText.TextColor3 = Color3.new(1, 1, 1)
titleText.BackgroundTransparency = 1

local minimizeBtn = Instance.new("TextButton", titleBar)
minimizeBtn.Size = UDim2.new(0.1, 0, 1, 0)
minimizeBtn.Position = UDim2.new(0.8, 0, 0, 0)
minimizeBtn.Text = "_"
minimizeBtn.TextScaled = true

local closeBtn = Instance.new("TextButton", titleBar)
closeBtn.Size = UDim2.new(0.1, 0, 1, 0)
closeBtn.Position = UDim2.new(0.9, 0, 0, 0)
closeBtn.Text = "X"
closeBtn.TextScaled = true
closeBtn.BackgroundColor3 = Color3.new(1, 0.2, 0.2)

local contentFrame = Instance.new("Frame", mainFrame)
contentFrame.Size = UDim2.new(1, 0, 0.85, 0)
contentFrame.Position = UDim2.new(0, 0, 0.15, 0)
contentFrame.BackgroundTransparency = 1

local aimBtn = Instance.new("TextButton", contentFrame)
aimBtn.Size = UDim2.new(0.9, 0, 0.3, 0)
aimBtn.Position = UDim2.new(0.05, 0, 0.05, 0)
aimBtn.Text = "Auto Aim: OFF"
aimBtn.TextScaled = true

local rBtn = Instance.new("TextButton", contentFrame)
rBtn.Size = UDim2.new(0.4, 0, 0.3, 0)
rBtn.Position = UDim2.new(0.05, 0, 0.4, 0)
rBtn.Text = "R Antenna"
rBtn.TextScaled = true

local lBtn = Instance.new("TextButton", contentFrame)
lBtn.Size = UDim2.new(0.4, 0, 0.3, 0)
lBtn.Position = UDim2.new(0.55, 0, 0.4, 0)
lBtn.Text = "L Antenna"
lBtn.TextScaled = true

local minimized = false

minimizeBtn.Activated:Connect(function()
    minimized = not minimized
    contentFrame.Visible = not minimized
    mainFrame.Size = minimized and UDim2.new(0.35, 0, 0.15, 0) or UDim2.new(0.35, 0, 0.22, 0)
end)

closeBtn.Activated:Connect(function()
    gui:Destroy()
end)

aimBtn.Activated:Connect(function()
    active = not active
    aimBtn.Text = active and "Auto Aim: ON" or "Auto Aim: OFF"
end)

rBtn.Activated:Connect(function() antenna = "R" end)
lBtn.Activated:Connect(function() antenna = "L" end)

local function CheckGround()
    local ray = Ray.new(rootPart.Position, Vector3.new(0, -3, 0))
    grounded = workspace:FindPartOnRayWithIgnoreList(ray, {character}) ~= nil
end

RunService.Heartbeat:Connect(function()
    CheckGround()
    if not active or not grounded or not rootPart then return end
    local pos = rootPart.Position
    local target = ANTENNA[antenna]
    rootPart.CFrame = CFrame.lookAt(pos, Vector3.new(target.X, pos.Y, target.Z))
end)
