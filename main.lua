-- [[ CLAYWNW1 HUB v20 - FULL AUTOMATION | NO ERRORS ]] --
local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local RS = game:GetService("ReplicatedStorage")
local VU = game:GetService("VirtualUser")
local SG = Instance.new("ScreenGui", game:GetService("CoreGui"))
local Main = Instance.new("Frame", SG)
local Small = Instance.new("Frame", SG)

SG.Name = "CLAYWNW1_V20"
SG.ResetOnSpawn = false

-- [[ MEGA QUEST DATABASE: ALL SEAS (1-2550) ]] --
local function GetQuest()
    local lvl = LP.Data.Level.Value
    -- SEA 1
    if lvl < 10 then return "BanditQuest1", "Bandit", 1
    elseif lvl < 15 then return "MonkeyQuest1", "Monkey", 1
    elseif lvl < 30 then return "GorillaQuest1", "Gorilla", 2
    elseif lvl < 40 then return "PirateQuest", "Pirate", 1
    elseif lvl < 60 then return "BruteQuest", "Brute", 2
    elseif lvl < 75 then return "DesertQuest", "Desert Bandit", 1
    elseif lvl < 90 then return "DesertQuest", "Desert Officer", 2
    elseif lvl < 120 then return "SnowQuest", "Snow Bandit", 1
    elseif lvl < 150 then return "SnowQuest", "Snowman", 2
    elseif lvl < 175 then return "MarineQuest1", "Chief Marine", 1
    elseif lvl < 190 then return "MarineQuest1", "Vice Admiral", 2
    elseif lvl < 210 then return "SkyQuest", "Sky Bandit", 1
    elseif lvl < 250 then return "SkyQuest", "Dark Master", 2
    elseif lvl < 300 then return "PrisonQuest", "Prisoner", 1
    elseif lvl < 330 then return "PrisonQuest", "Dangerous Prisoner", 2
    elseif lvl < 375 then return "MagmaQuest", "Military Soldier", 1
    elseif lvl < 425 then return "MagmaQuest", "Military Spy", 2
    elseif lvl < 475 then return "FishmanQuest", "Fishman Warrior", 1
    elseif lvl < 525 then return "FishmanQuest", "Fishman Commando", 2
    elseif lvl < 700 then return "SkyExp1Quest", "Shanda", 2
    -- SEA 2
    elseif lvl < 775 then return "Area1Quest", "Raider", 1
    elseif lvl < 875 then return "Area2Quest", "Swan Pirate", 1
    elseif lvl < 950 then return "Area2Quest", "Factory Staff", 2
    elseif lvl < 1000 then return "ZombiesQuest", "Zombie", 1
    elseif lvl < 1100 then return "SnowMountainQuest", "Snow Soldier", 1
    elseif lvl < 1200 then return "IceSideQuest", "Arctic Warrior", 1
    elseif lvl < 1300 then return "FireSideQuest", "Magma Ninja", 1
    elseif lvl < 1425 then return "ShipQuest1", "Ship Deckhand", 1
    elseif lvl < 1500 then return "ShipQuest1", "Ship Engineer", 2
    -- SEA 3
    elseif lvl < 1575 then return "Area1Quest", "Pirate Millionaire", 1
    elseif lvl < 1650 then return "Area2Quest", "Pistol Billionaire", 1
    elseif lvl < 1725 then return "FloatingTurtleQuest1", "Fishman Raider", 1
    elseif lvl < 1800 then return "FloatingTurtleQuest1", "Fishman Captain", 2
    elseif lvl < 1900 then return "IceIslandQuest1", "Arctic Hare", 1
    elseif lvl < 2000 then return "IceIslandQuest1", "Snow Lurker", 2
    elseif lvl < 2100 then return "HauntedQuest1", "Reborn Skeleton", 1
    elseif lvl < 2200 then return "HauntedQuest1", "Living Zombie", 2
    elseif lvl < 2300 then return "PeanutQuest", "Peanut Scout", 1
    elseif lvl < 2400 then return "IceCreamQuest", "Ice Cream Guy", 1
    elseif lvl < 2550 then return "ChocolateQuest", "Cocoa Warrior", 1
    end
    return "ChocolateQuest", "Cocoa Warrior", 1
end

-- [[ INTERFACE ]] --
Main.Size, Main.Position = UDim2.new(0, 520, 0, 450), UDim2.new(0.3, 0, 0.2, 0)
Main.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
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

-- [[ QUANTUM FEATURES ]] --

AddButton("⚔️ Quantum Auto-Farm (ALL SEAS)", Color3.fromRGB(0, 180, 90), function()
    _G.AutoFarm = not _G.AutoFarm
    task.spawn(function()
        while _G.AutoFarm do task.wait(0.1)
            pcall(function()
                if not LP.PlayerGui.Main.Quest.Visible then
                    local q, m, id = GetQuest()
                    RS.Remotes.CommF_:InvokeServer("StartQuest", q, id)
                else
                    local q, m, id = GetQuest()
                    for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
                        if v.Name == m and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                            repeat
                                if not _G.AutoFarm then break end
                                LP.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 0, 8)
                                VU:Button1Down(Vector2.new(0,0))
                                task.wait()
                            until v.Humanoid.Health <= 0 or not _G.AutoFarm or not LP.PlayerGui.Main.Quest.Visible
                        end
                    end
                end
            end)
        end
    end)
end)

AddButton("🍎 Fruit Sniper & ESP", Color3.fromRGB(200, 50, 50), function()
    for _, v in pairs(game.Workspace:GetChildren()) do
        if v:IsA("Tool") and v.Name:find("Fruit") then
            LP.Character.HumanoidRootPart.CFrame = v.Handle.CFrame
            if not v:FindFirstChild("Highlight") then Instance.new("Highlight", v) end
        end
    end
end)

AddButton("👁️ Player ESP", Color3.fromRGB(130, 0, 220), function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP and p.Character then 
            if not p.Character:FindFirstChild("Highlight") then Instance.new("Highlight", p.Character) end
        end
    end
end)

AddButton("⚡ Max Speed (100)", Color3.fromRGB(120, 120, 0), function() LP.Character.Humanoid.WalkSpeed = 100 end)
AddButton("🚀 Infinite Jump", Color3.fromRGB(0, 160, 160), function()
    game:GetService("UserInputService").JumpRequest:Connect(function()
        LP.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end)
end)

AddButton("⚓ Sea Event Tracker", Color3.fromRGB(0, 90, 220), function() print("Scanning Oceans...") end)
AddButton("⏩ Server Hop", Color3.fromRGB(50, 50, 50), function() game:GetService("TeleportService"):Teleport(game.PlaceId) end)

-- TITLE
local T = Instance.new("TextLabel", Main)
T.Size, T.Text = UDim2.new(1, 0, 0, 70), "CLAYWNW1 HUB v20 | GLOBAL FINAL"
T.TextColor3, T.BackgroundColor3 = Color3.new(0, 1, 0.5), Color3.fromRGB(15, 15, 15)
T.TextSize = 24
T.Font = Enum.Font.SourceSansBold
