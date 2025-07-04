
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
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0.35, 0, 0.22, 0)
frame.Position = UDim2.new(0.1, 0, 0.7, 0)
frame.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
frame.Active = true
frame.Draggable = true

local aimBtn = Instance.new("TextButton", frame)
aimBtn.Size = UDim2.new(0.9, 0, 0.3, 0)
aimBtn.Position = UDim2.new(0.05, 0, 0.05, 0)
aimBtn.Text = "Auto Aim: OFF"
aimBtn.TextScaled = true

local rBtn = Instance.new("TextButton", frame)
rBtn.Size = UDim2.new(0.4, 0, 0.3, 0)
rBtn.Position = UDim2.new(0.05, 0, 0.4, 0)
rBtn.Text = "R Antenna"
rBtn.TextScaled = true

local lBtn = Instance.new("TextButton", frame)
lBtn.Size = UDim2.new(0.4, 0, 0.3, 0)
lBtn.Position = UDim2.new(0.55, 0, 0.4, 0)
lBtn.Text = "L Antenna"
lBtn.TextScaled = true

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
