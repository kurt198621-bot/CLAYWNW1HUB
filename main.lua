-- [[ CLAYWNW1 HUB v9 - ULTIMATE ENGLISH EDITION ]] --

local ScreenGui = Instance.new("ScreenGui")
local Main = Instance.new("Frame")
local SmallFrame = Instance.new("Frame")
local SmallTitle = Instance.new("TextButton")
local Title = Instance.new("TextLabel")
local TabHolder = Instance.new("ScrollingFrame")

ScreenGui.Name = "CLAYWNW1_PRO_V9"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

-- [[ MAIN UI CONFIGURATION ]] --
Main.Name = "Main"
Main.Parent = ScreenGui
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Main.Position = UDim2.new(0.3, 0, 0.2, 0)
Main.Size = UDim2.new(0, 550, 0, 450)
Main.Active = true
Main.Draggable = true

-- [[ MINIMIZE SYSTEM ]] --
SmallFrame.Parent = ScreenGui
SmallFrame.BackgroundColor3 = Color3.fromRGB(0, 255, 127)
SmallFrame.Position = UDim2.new(0.05, 0, 0.05, 0)
SmallFrame.Size = UDim2.new(0, 200, 0, 45)
SmallFrame.Visible = false
SmallFrame.Draggable = true
Instance.new("UICorner", SmallFrame).CornerRadius = UDim.new(0, 10)

SmallTitle.Parent = SmallFrame
SmallTitle.Size = UDim2.new(1, 0, 1, 0)
SmallTitle.Text = "CLAYWNW1 HUB (OPEN)"
SmallTitle.TextColor3 = Color3.new(0, 0, 0)
SmallTitle.TextSize = 16
SmallTitle.Font = Enum.Font.SourceSansBold
SmallTitle.BackgroundTransparency = 1

local MinBtn = Instance.new("TextButton", Main)
MinBtn.Text = "_"
MinBtn.Size = UDim2.new(0, 35, 0, 35)
MinBtn.Position = UDim2.new(0.92, 0, 0.02, 0)
MinBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MinBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(0, 5)

MinBtn.MouseButton1Click:Connect(function()
    Main.Visible = false
    SmallFrame.Visible = true
end)

SmallTitle.MouseButton1Click:Connect(function()
    Main.Visible = true
    SmallFrame.Visible = false
end)

-- [[ SCROLLING CONTENT ]] --
TabHolder.Parent = Main
TabHolder.Size = U
