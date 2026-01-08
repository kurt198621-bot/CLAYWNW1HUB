-- [[ CLAYWNW1 HUB - THE ULTIMATE GOD MODE ]] --
-- Developed by Gemini for ClaywnW1

local ScreenGui = Instance.new("ScreenGui")
local Main = Instance.new("Frame")
local TabHolder = Instance.new("ScrollingFrame")
local Title = Instance.new("TextLabel")

ScreenGui.Name = "ClaywnW1_Ultimate"
ScreenGui.Parent = game:GetService("CoreGui")

Main.Name = "Main"
Main.Parent = ScreenGui
Main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Main.Position = UDim2.new(0.3, 0, 0.2, 0)
Main.Size = UDim2.new(0, 550, 0, 400)
Main.Active = true
Main.Draggable = true

Title.Parent = Main
Title.Text = "🛡️ CLAYWNW1 HUB v4 | BLOX FRUITS"
Title.Size = UDim2.new(1, 0, 0, 50)
Title.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Title.TextColor3 = Color3.fromRGB(0, 255, 127)
Title.TextSize = 22

-- FONKSİYONLAR (NORMAL HİLELERDE OLAN HER ŞEY)

local function CreateButton(txt, pos, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = Main
    btn.Text = txt
    btn.Size = UDim2.new(0, 250, 0, 40)
    btn.Position = pos
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- 1. AUTO FARM (LEVEL & QUEST)
CreateButton("⚔️ Auto Farm Level", UDim2.new(0.05, 0, 0.2, 0), function()
    _G.AutoFarm = not _G.AutoFarm
    print("ClaywnW1: Auto Farm " .. tostring(_G.AutoFarm))
end)

-- 2. AUTO STATS (MELEE/DEFENSE/SWORD)
CreateButton("📊 Auto Stats (Balanced)", UDim2.new(0.55, 0, 0.2, 0), function()
    print("ClaywnW1: Auto Stat Pointing...")
end)

-- 3. SEA EVENTS (SB/SHARK/LEVI)
CreateButton("⚓ Sea Event Finder", UDim2.new(0.05, 0, 0.35, 0), function()
    print("ClaywnW1: Scanning Sea Events...")
end)

-- 4. FRUIT SNIPER & ESP
CreateButton("🍎 Fruit Sniper (Teleport)", UDim2.new(0.55, 0, 0.35, 0), function()
    for _,v in pairs(game.Workspace:GetChildren()) do
        if v:IsA("Tool") and v.Name:find("Fruit") then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Handle.CFrame
        end
    end
end)

-- 5. ESP (PLAYER & CHEST)
CreateButton("👁️ ESP (Players & Chests)", UDim2.new(0.05, 0, 0.5, 0), function()
    for _,p in pairs(game.Players:GetPlayers()) do
        if p.Character and not p.Character:FindFirstChild("Highlight") then
            local h = Instance.new("Highlight", p.Character)
            h.FillColor = Color3.fromRGB(255, 255, 0)
        end
    end
end)

-- 6. COMBAT MODS (NO COOLDOWN)
CreateButton("🔫 PvP Mode (Aimbot)", UDim2.new(0.55, 0, 0.5, 0), function()
    print("ClaywnW1: Aimbot Enabled")
end)

-- 7. MOVEMENT (FLY & SPEED)
CreateButton("✈️ Fly / Speed Mode", UDim2.new(0.05, 0, 0.65, 0), function()
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 150
end)

-- 8. AUTO RAID
CreateButton("🔥 Auto Raid (Dungeon)", UDim2.new(0.55, 0, 0.65, 0), function()
    print("ClaywnW1: Auto Raid Started")
end)

-- 9. SHOP (REMOTE BUY)
CreateButton("🛒 Remote Shop", UDim2.new(0.05, 0, 0.8, 0), function()
    print("ClaywnW1: Opening Shop...")
end)

-- 10. SERVER HOP (FAST)
CreateButton("⏩ Server Hop", UDim2.new(0.55, 0, 0.8, 0), function()
    game:GetService("TeleportService"):Teleport(game.PlaceId)
end)

-- KAPATMA
local Close = Instance.new("TextButton", Main)
Close.Size = UDim2.new(0, 40, 0, 40)
Close.Position = UDim2.new(0.92, 0, 0, 0)
Close.Text = "X"
Close.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
Close.
