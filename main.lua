-- [[ CLAYWNW1 HUB v24 - ULTIMATE STABLE | ALL SEAS ]] --
local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local RS = game:GetService("ReplicatedStorage")
local VU = game:GetService("VirtualUser")
local SG = Instance.new("ScreenGui", game:GetService("CoreGui"))
local Main = Instance.new("Frame", SG)
local Small = Instance.new("Frame", SG)

SG.Name = "CLAYWNW1_V24"
SG.ResetOnSpawn = false

-- [[ MEGA QUEST DATABASE (SEA 1-2-3) ]] --
local function GetQuest()
    local lvl = LP.Data.Level.Value
    if lvl < 10 then return "BanditQuest1", "Bandit", 1
    elseif lvl < 15 then return "MonkeyQuest1", "Monkey", 1
    elseif lvl < 30 then return "GorillaQuest1", "Gorilla", 2
    elseif lvl < 40 then return "PirateQuest", "Pirate", 1
    elseif lvl < 60 then return "BruteQuest", "Brute", 2
    elseif lvl < 75 then return "DesertQuest", "Desert Bandit", 1
    elseif lvl < 90 then return "DesertQuest", "Desert Officer", 2
    elseif lvl < 120 then return "SnowQuest", "Snow Bandit", 1
    elseif lvl < 150 then return "SnowQuest", "Snowman", 2
    elseif lvl < 700 then return "SkyExp1Quest", "Shanda", 2
    elseif lvl < 1500 then return "Area1Quest", "Raider", 1
    else return "ChocolateQuest", "Cocoa Warrior", 1 end
end

-- [[ INTERFACE DESIGN ]] --
Main.Size, Main.Position = UDim2.new(0, 520, 0, 450), UDim2.new(0.3, 0, 0.2, 0)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Main.Active, Main.Draggable = true, true
Instance.new("UICorner", Main)

Small.Size, Small.Position = UDim2.new(0, 200, 0, 45), UDim2.new(0.05, 0, 0.05, 0)
Small.BackgroundColor3, Small.Visible = Color3.fromRGB(0, 255, 127), false
Small.Draggable = true
local SmallBtn = Instance.new("TextButton", Small)
SmallBtn.Size, SmallBtn.Text, SmallBtn.BackgroundTransparency = UDim2.new(1,0,1,0), "CLAYWNW1 HUB", 1
SmallBtn.Font = Enum.Font.SourceSansBold

local MinBtn = Instance.new("TextButton", Main)
MinBtn.Size, MinBtn.Position, MinBtn.Text = UDim2.new(0, 35, 0, 35), UDim2.new(0.9, 0, 0.02, 0), "_"
MinBtn.BackgroundColor3, MinBtn.TextColor3 = Color3.fromRGB(30,30,30), Color3.new(1,1,1)
MinBtn.MouseButton1Click:Connect(function() Main.Visible = false Small.Visible = true end)
SmallBtn.MouseButton1Click:Connect(function() Main.Visible = true Small.Visible = false end)

local Scroll = Instance.new("ScrollingFrame", Main)
Scroll.Size, Scroll.Position = UDim2.new(1, -20, 1, -90), UDim2.new(0, 10, 0, 80)
Scroll.BackgroundTransparency, Scroll.CanvasSize = 1, UDim2.new(0, 0, 4, 0)
Instance.new("UIListLayout", Scroll).Padding = UDim.new(0, 10)

local function AddButton(name, color, fn)
    local b = Instance.new("TextButton", Scroll)
    b.Size, b.Text = UDim2.new(0, 480, 0, 45), name
    b.BackgroundColor3, b.TextColor3 = color, Color3.new(1, 1, 1)
    b.Font = Enum.Font.SourceSansSemibold
    b.TextSize = 18
    b.MouseButton1Click:Connect(fn)
    Instance.new("UICorner", b)
end

-- [[ ENGLISH FEATURES ]] --

AddButton("⚔️ MAIN: Auto-Farm Level (Quantum)", Color3.fromRGB(0, 180, 100), function()
    _G.AutoFarm = not _G.AutoFarm
    task.spawn(function()
        while _G.AutoFarm do task.wait(0.1)
            pcall(function()
                if not LP.PlayerGui.Main.Quest.Visible then
                    local q, m, id = GetQuest()
                    RS.Remotes.CommF_:InvokeServer("StartQuest", q, id)
                else
                    local q, m, id = GetQuest()
                    local target = nil
                    -- Scan all potential folders
                    for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
                        if v.Name == m and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                            target = v break
                        end
                    end
                    if target then
                        repeat
                            if not _G.AutoFarm then break end
                            LP.Character.HumanoidRootPart.CFrame = target.HumanoidRootPart.CFrame * CFrame.new(0, 0, 8)
                            VU:Button1Down(Vector2.new(0,0))
                            task.wait()
                        until target.Humanoid.Health <= 0 or not _G.AutoFarm or not LP.PlayerGui.Main.Quest.Visible
                    end
                end
            end)
        end
    end)
end)

AddButton("🍎 WORLD: Fruit Sniper & ESP", Color3.fromRGB(200, 50, 50), function()
    for _, v in pairs(game.Workspace:GetChildren()) do
        if v:IsA("Tool") and v.Name:find("Fruit") then
            LP.Character.HumanoidRootPart.CFrame = v.Handle.CFrame
            if not v:FindFirstChild("Highlight") then Instance.new("Highlight", v) end
        end
    end
end)

AddButton("👁️ PLAYER: Global ESP", Color3.fromRGB(130, 0, 220), function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP and p.Character then 
            if not p.Character:FindFirstChild("Highlight") then Instance.new("Highlight", p.Character) end
        end
    end
end)

AddButton("⚡ STATS: Max WalkSpeed", Color3.fromRGB(120, 120, 0), function() LP.Character.Humanoid.WalkSpeed = 100 end)
AddButton("🚀 STATS: Infinite Jump", Color3.fromRGB(0, 160, 160), function()
    game:GetService("UserInputService").JumpRequest:Connect(function()
        LP.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end)
end)

AddButton("⏩ MISC: Server Hop", Color3.fromRGB(50, 50, 50), function() game:GetService("TeleportService"):Teleport(game.PlaceId) end)

-- TITLE
local T = Instance.new("TextLabel", Main)
T.Size, T.Text = UDim2.new(1, 0, 0, 70), "CLAYWNW1 HUB v24 | ENGLISH"
T.TextColor3, T.BackgroundColor3 = Color3.new(0, 1, 0.5), Color3.fromRGB(20, 20, 20)
T.TextSize = 24
T.Font = Enum.Font.SourceSansBold
