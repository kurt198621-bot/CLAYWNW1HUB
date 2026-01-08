-- [CLAYWNW1 HUB v10 - STABLE & COMPACT ]] --
local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local SG = Instance.new("ScreenGui", game:GetService("CoreGui"))
local Main = Instance.new("Frame", SG)
local Small = Instance.new("Frame", SG)

SG.Name = "CLAYWNW1_V10"
SG.ResetOnSpawn = false

-- MAIN UI
Main.Size, Main.Position = UDim2.new(0, 500, 0, 400), UDim2.new(0.3, 0, 0.2, 0)
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Main.Active, Main.Draggable = true, true

-- MINIMIZE BOX
Small.Size, Small.Position = UDim2.new(0, 180, 0, 45), UDim2.new(0.05, 0, 0.05, 0)
Small.BackgroundColor3, Small.Visible = Color3.fromRGB(0, 255, 127), false
Small.Draggable = true

local SmallBtn = Instance.new("TextButton", Small)
SmallBtn.Size, SmallBtn.Text = UDim2.new(1, 0, 1, 0), "CLAYWNW1 HUB"
SmallBtn.BackgroundTransparency = 1

local MinBtn = Instance.new("TextButton", Main)
MinBtn.Size, MinBtn.Position = UDim2.new(0, 30, 0, 30), UDim2.new(0.9, 0, 0.02, 0)
MinBtn.Text, MinBtn.BackgroundColor3 = "_", Color3.fromRGB(40, 40, 40)

MinBtn.MouseButton1Click:Connect(function() Main.Visible = false Small.Visible = true end)
SmallBtn.MouseButton1Click:Connect(function() Main.Visible = true Small.Visible = false end)

local Title = Instance.new("TextLabel", Main)
Title.Size, Title.Text = UDim2.new(1, 0, 0, 50), "CLAYWNW1 HUB - ENGLISH"
Title.TextColor3, Title.BackgroundColor3 = Color3.new(0, 1, 0.5), Color3.new(0.1, 0.1, 0.1)

local Scroll = Instance.new("ScrollingFrame", Main)
Scroll.Size, Scroll.Position = UDim2.new(1, -20, 1, -70), UDim2.new(0, 10, 0, 60)
Scroll.BackgroundTransparency, Scroll.CanvasSize = 1, UDim2.new(0, 0, 2, 0)
Instance.new("UIListLayout", Scroll).Padding = UDim.new(0, 10)

local function Add(name, color, fn)
    local b = Instance.new("TextButton", Scroll)
    b.Size, b.Text = UDim2.new(0, 460, 0, 45), name
    b.BackgroundColor3, b.TextColor3 = color, Color3.new(1, 1, 1)
    b.MouseButton1Click:Connect(fn)
    Instance.new("UICorner", b)
end

-- FEATURES
Add("⚔️ Auto Farm Level", Color3.fromRGB(40, 40, 40), function()
    _G.Farm = not _G.Farm
    while _G.Farm do task.wait()
        pcall(function()
            for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
                if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                    LP.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 0, 5)
                    game:GetService("VirtualUser"):Button1Down(Vector2.new(0,0))
                end
            end
        end)
    end
end)

Add("🍎 Fruit Sniper & ESP", Color3.fromRGB(150, 0, 0), function()
    for _, v in pairs(game.Workspace:GetChildren()) do
        if v:IsA("Tool") and v.Name:find("Fruit") then
            LP.Character.HumanoidRootPart.CFrame = v.Handle.CFrame
            if not v:FindFirstChild("Highlight") then Instance.new("Highlight", v) end
        end
    end
end)

Add("👁️ Player ESP", Color3.fromRGB(100, 0, 150), function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP and p.Character then Instance.new("Highlight", p.Character) end
    end
end)

Add("⚓ Sea Event Tracker", Color3.fromRGB(0, 100, 200), function() print("Tracking...") end)

Add("⚡ Speed (100)", Color3.fromRGB(100, 100, 0), function() LP.Character.Humanoid.WalkSpeed = 100 end)

Add("🚀 Infinite Jump", Color3.fromRGB(0, 120, 120), function()
    game:GetService("UserInputService").JumpRequest:Connect(function()
        LP.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end)
end)

Add("⏩ Server Hop", Color3.fromRGB(60, 60, 60), function() game:GetService("TeleportService"):Teleport(game.PlaceId) end)
