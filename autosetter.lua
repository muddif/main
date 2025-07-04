local p=game:GetService("Players").LocalPlayer
local c=p.Character or p.CharacterAdded:Wait()
local r=c:WaitForChild("HumanoidRootPart")
local UIS=game:GetService("UserInputService")
local TS=game:GetService("TweenService")
local A={L=Vector3.new(-23.5,8,0),R=Vector3.new(23.5,8,0)}
local a,t,flick,autoset=false,"L",false,false
local targetPlayer=nil

local s=Instance.new("ScreenGui",p.PlayerGui)
local f=Instance.new("Frame",s)
f.Size,f.Position=UDim2.new(0.4,0,0.25,0),UDim2.new(0.3,0,0.6,0)
f.BackgroundColor3=Color3.new(0.2,0.2,0.2)
f.Active,f.Draggable=true,true

local b1=Instance.new("TextButton",f)
b1.Size,b1.Position=UDim2.new(0.9,0,0.15,0),UDim2.new(0.05,0,0.05,0)
b1.Text,b1.TextScaled="Auto Aim: OFF",true

local b2=Instance.new("TextButton",f)
b2.Size,b2.Position=UDim2.new(0.4,0,0.15,0),UDim2.new(0.05,0,0.25,0)
b2.Text,b2.TextScaled="R Antenna",true

local b3=Instance.new("TextButton",f)
b3.Size,b3.Position=UDim2.new(0.4,0,0.15,0),UDim2.new(0.55,0,0.25,0)
b3.Text,b3.TextScaled="L Antenna",true

local b4=Instance.new("TextButton",f)
b4.Size,b4.Position=UDim2.new(0.9,0,0.15,0),UDim2.new(0.05,0,0.45,0)
b4.Text,b4.TextScaled="PANIC",true
b4.BackgroundColor3=Color3.new(1,0,0)

local b5=Instance.new("TextButton",f)
b5.Size,b5.Position=UDim2.new(0.4,0,0.15,0),UDim2.new(0.05,0,0.65,0)
b5.Text,b5.TextScaled="Flick",true

local b6=Instance.new("TextButton",f)
b6.Size,b6.Position=UDim2.new(0.4,0,0.15,0),UDim2.new(0.55,0,0.65,0)
b6.Text,b6.TextScaled="Autoset",true

local txt=Instance.new("TextBox",f)
txt.Size,txt.Position=UDim2.new(0.9,0,0.15,0),UDim2.new(0.05,0,0.85,0)
txt.PlaceholderText,txt.TextScaled="Player name",true

b1.Activated:Connect(function()a=not a b1.Text=a and"Auto Aim: ON"or"Auto Aim: OFF"end)
b2.Activated:Connect(function()t="R"end)
b3.Activated:Connect(function()t="L"end)
b4.Activated:Connect(function()s:Destroy()end)
b5.Activated:Connect(function()t=t=="L"and"R"or"L"end)
b6.Activated:Connect(function()autoset=not autoset end)

local conn=game:GetService("RunService").Heartbeat:Connect(function()
    if not r or not a then return end
    local pos=r.Position
    local ground=workspace:FindPartOnRay(Ray.new(pos,Vector3.new(0,-5,0)))
    if not ground then return end
    
    local targetPos
    if txt.Text~=""then
        local plr=game:FindFirstChild(txt.Text)
        if plr and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")then
            targetPos=plr.Character.HumanoidRootPart.Position
        end
    else
        targetPos=A[t]
    end
    
    if targetPos then
        local flatTarget=Vector3.new(targetPos.X,pos.Y,targetPos.Z)
        r.CFrame=CFrame.lookAt(pos,flatTarget)
    end
    
    if autoset and pos.Y<10 then
        keypress(0x46)
        task.wait(0.1)
        keyrelease(0x46)
    end
end)
