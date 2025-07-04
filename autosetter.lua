local p = game:GetService("Players").LocalPlayer
local c = p.Character or p.CharacterAdded:Wait()
local r = c:WaitForChild("HumanoidRootPart")
local A = {L = Vector3.new(-23.5, 8, 0), R = Vector3.new(23.5, 8, 0)}
local active, antenna = false, "L"

local gui = Instance.new("ScreenGui", p.PlayerGui)
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0.35, 0, 0.2, 0)
frame.Position = UDim2.new(0.1, 0, 0.7, 0)
frame.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
frame.Active, frame.Draggable = true, true

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

local panicBtn = Instance.new("TextButton", frame)
panicBtn.Size = UDim2.new(0.9, 0, 0.3, 0)
panicBtn.Position = UDim2.new(0.05, 0, 0.75, 0)
panicBtn.Text = "PANIC"
panicBtn.TextScaled = true
panicBtn.BackgroundColor3 = Color3.new(1, 0, 0)

aimBtn.Activated:Connect(function()
    active = not active
    aimBtn.Text = active and "Auto Aim: ON" or "Auto Aim: OFF"
end)

rBtn.Activated:Connect(function() antenna = "R" end)
lBtn.Activated:Connect(function() antenna = "L" end)
panicBtn.Activated:Connect(function() gui:Destroy() end)

game:GetService("RunService").Heartbeat:Connect(function()
    if not active or not r then return end
    
    local pos = r.Position
    local targetPos = A[antenna]
    local flatTarget = Vector3.new(targetPos.X, pos.Y, targetPos.Z)
    
    r.CFrame = CFrame.lookAt(pos, flatTarget)
end)
