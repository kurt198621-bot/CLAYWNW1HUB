-- [[ CLAYWNW1 HUB v13 - QUANTUM ONYX BASE AUTO-FARM ]] --
local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local RS = game:GetService("ReplicatedStorage")
local SG = Instance.new("ScreenGui", game:GetService("CoreGui"))
local Main = Instance.new("Frame", SG)
local Small = Instance.new("Frame", SG)

SG.Name = "CLAYWNW1_V13"
SG.ResetOnSpawn = false

-- [[ QUANTUM ONYX AUTO-QUEST ENGINE ]] --
local function GetQuestData()
    local lvl = LP.Data.Level.Value
    -- Quantum Onyx Level Logic
    if lvl < 10 then return "BanditQuest1", "Bandit", 1
    elseif lvl < 15 then return "MonkeyQuest1", "Monkey", 1
    elseif lvl < 30 then return "GorillaQuest1", "Gorilla", 2
    elseif lvl < 40 then return "PirateQuest", "Pirate", 1
    elseif lvl < 60 then return "BruteQuest", "Brute", 2
    elseif lvl < 75 then return "DesertQuest", "Desert Bandit", 1
    elseif lvl < 90 then return "DesertQuest", "Desert Officer", 2
    elseif lvl < 120 then return "SnowQuest", "Snow Bandit", 1
    elseif lvl < 150 then return "SnowQuest", "Snowman", 2
    end
    return "BanditQuest1", "Bandit", 1
end

-- MAIN UI CONFIG
Main.Size, Main.Position = UDim2.new(0, 500, 0, 420), UDim2.new(0.3, 0, 0.2, 0)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Main.Active, Main.Draggable = true, true

-- MINIMIZE SYSTEM (CLAYWNW1 HUB TEXT)
Small.Size, Small.Position = UDim2.new(0, 200, 0, 45), UDim2.new(0.05, 0, 0.05, 0)
Small.BackgroundColor3, Small.Visible = Color3.fromRGB(0, 255, 127), false
Small.Draggable = true
local SmallBtn = Instance.new("TextButton", Small)
SmallBtn.Size, SmallBtn.Text, SmallBtn.BackgroundTransparency = UDim2.new(1,0,1,0), "CLAYWNW1 HUB", 1
SmallBtn.Font = Enum.Font.SourceSansBold

local MinBtn = Instance.new("TextButton", Main)
MinBtn.Size, MinBtn.Position, MinBtn.Text = UDim2.new(0, 30, 0, 30), UDim2.new(0.9, 0, 0.02, 0), "_"
MinBtn.MouseButton1Click:Connect(function() Main.Visible = false Small.Visible = true end)
SmallBtn.MouseButton1Click:Connect(function() Main.Visible = true Small.Visible = false end)

local Scroll = Instance.new("ScrollingFrame", Main)
Scroll.Size, Scroll.Position = UDim2.new(1, -20, 1, -80), UDim2.new(0, 10, 0, 70)
Scroll.BackgroundTransparency, Scroll.CanvasSize = 1, UDim2.new(0, 0, 2.5, 0)
Instance.new("UIListLayout", Scroll).Padding = UDim.new(0, 10)

local function Add(name, color, fn)
    local b = Instance.new("TextButton", Scroll)
    b.Size, b.Text = UDim2.new(0, 460, 0, 45), name
    b.BackgroundColor3, b.TextColor3 = color, Color3.new(1, 1, 1)
    b.Font = Enum.Font.SourceSansSemibold
    b.TextSize = 18
    b.MouseButton1Click:Connect(fn)
    Instance.new("UICorner", b)
end

-- [[ FEATURES ]] --

Add("⚔️ Quantum Auto-Farm Level", Color3.fromRGB(0, 120, 0), function()
    _G.AutoQuest = not _G.AutoQuest
    task.spawn(function()
        while _G.AutoQuest do task.wait(0.1)
            pcall(function()
                if not LP.PlayerGui.Main.Quest.Visible then
                    -- Bypassing NPC Dialog (Quantum Method)
                    local qName, mName, qID = GetQuestData()
                    RS.Remotes.CommF_:InvokeServer("StartQuest", qName, qID)
                else
                    -- Auto-Attack & Kill
                    for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
                        if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                            repeat
                                -- Teleport above the enemy
                                LP.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 0, 5)
                                -- Quantum Fast Attack
                                game:GetService("VirtualUser"):Button1Down(Vector2.new(0,0))
                                task.wait()
                            until v.Humanoid.Health <= 0 or not _G.AutoQuest or not LP.PlayerGui.Main.Quest.Visible
                        end
                    end
                end
            end)
        end
    end)
end)

Add("🍎 Fruit Sniper & ESP", Color3.fromRGB(150, 0, 0), function()
    for _, v in pairs(game.Workspace:GetChildren()) do
        if v:IsA("Tool") and v.Name:find("Fruit") then
            LP.Character.HumanoidRootPart.CFrame = v.Handle.CFrame
            if not v:FindFirstChild("Highlight") then Instance.new("Highlight", v) end
        end
    end
end)

Add("👁️ Player ESP", Color3.fromRGB(80, 0, 180), function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP and p.Character then Instance.new("Highlight", p.Character) end
    end
end)

Add("⚓ Sea Event Tracker", Color3.fromRGB(0, 80, 180), function() print("Tracking...") end)

Add("⚡ WalkSpeed (100)", Color3.fromRGB(100, 100, 0), function() LP.Character.Humanoid.WalkSpeed = 100 end)

Add("🚀 Infinite Jump", Color3.fromRGB(0, 150, 150), function()
    game:GetService("UserInputService").JumpRequest:Connect(function()
        LP.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end)
end)

Add("⏩ Server Hop", Color3.fromRGB(60, 60, 60), function() game:GetService("TeleportService"):Teleport(game.PlaceId) end)

-- TITLE
local T = Instance.new("TextLabel", Main)
T.Size, T.Text = UDim2.new(1, 0, 0, 60), "CLAYWNW1 HUB V13 (Quantum Base)"
T.TextColor3, T.BackgroundColor3 = Color3.new(0, 1, 0.5), Color3.new(0.05, 0.05, 0.05)
T.TextSize = 22
T.Font = Enum.Font.SourceSansBold
