-- [[ CLAYWNW1 HUB - ULTIMATE ENGLISH EDITION ]] --
-- Features: Auto Farm, Auto Stats, Teleports, ESP, Raid, Shop + FLOATING TOGGLE ICON

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "CLAYWNW1 HUB 👑",
    SubTitle = "Blox Fruits | Premium",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true, 
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.RightControl -- Key to Hide Menu
})

-- [[ TABS ]] --
local Tabs = {
    Main = Window:AddTab({ Title = "Auto Farm", Icon = "rbxassetid://10723404469" }),
    Stats = Window:AddTab({ Title = "Auto Stats", Icon = "rbxassetid://10723404469" }),
    Teleport = Window:AddTab({ Title = "Teleports", Icon = "rbxassetid://10723346990" }),
    Raid = Window:AddTab({ Title = "Dungeon / Raid", Icon = "rbxassetid://10723346990" }),
    ESP = Window:AddTab({ Title = "ESP & Visuals", Icon = "rbxassetid://10723404469" }),
    Shop = Window:AddTab({ Title = "Shop & Misc", Icon = "rbxassetid://10723404469" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

local Options = Fluent.Options
local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local RS = game:GetService("ReplicatedStorage")
local Remotes = RS:WaitForChild("Remotes")
local CommF = Remotes:WaitForChild("CommF_")

-- [[ GLOBAL VARIABLES ]] --
_G.AutoFarm = false
_G.FastAttack = true
_G.AutoStats = false
_G.SelectedStat = "Melee"

-- [[ FUNCTIONS ]] --
function CheckQuest()
    local MyLevel = LP.Data.Level.Value
    if MyLevel < 10 then return "BanditQuest1", "Bandit", CFrame.new(1060, 16, 1547)
    elseif MyLevel < 15 then return "MonkeyQuest1", "Monkey", CFrame.new(-1600, 36, 150)
    elseif MyLevel < 30 then return "GorillaQuest1", "Gorilla", CFrame.new(-1240, 6, -485)
    elseif MyLevel < 700 then return "PirateQuest", "Pirate", CFrame.new(-1140, 4, 3827)
    elseif MyLevel >= 700 and MyLevel < 1500 then return "Area1Quest", "Raider", CFrame.new(-400, 70, 2000)
    else return "ChocolateQuest", "Cocoa Warrior", CFrame.new(100, 50, -200)
    end
end

function TP(CFramePos)
    LP.Character.HumanoidRootPart.CFrame = CFramePos
end

-- [[ TAB: MAIN (AUTO FARM) ]] --
Tabs.Main:AddToggle("AutoFarmLevel", {Title = "Auto Farm Level", Default = false }):OnChanged(function(Value)
    _G.AutoFarm = Value
    task.spawn(function()
        while _G.AutoFarm do task.wait()
            pcall(function()
                local QuestName, MonName, MonPos = CheckQuest()
                if not LP.PlayerGui.Main.Quest.Visible then
                    TP(MonPos)
                    CommF:InvokeServer("StartQuest", QuestName, 1)
                    task.wait(0.5)
                else
                    for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
                        if v.Name == MonName and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                            repeat
                                if not _G.AutoFarm then break end
                                v.HumanoidRootPart.CanCollide = false
                                v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                TP(v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
                                game:GetService("VirtualUser"):Button1Down(Vector2.new(0,0))
                                task.wait()
                            until v.Humanoid.Health <= 0 or not _G.AutoFarm
                        end
                    end
                end
            end)
        end
    end)
end)

Tabs.Main:AddToggle("FastAttack", {Title = "Super Fast Attack", Default = true }):OnChanged(function(Value)
    _G.FastAttack = Value
end)

Tabs.Main:AddButton({
    Title = "Auto Farm Chests (BETA)",
    Callback = function()
        for _, v in pairs(game.Workspace:GetChildren()) do
            if v.Name:find("Chest") then
                TP(v.CFrame)
                task.wait(0.5)
            end
        end
    end
})

-- [[ TAB: AUTO STATS ]] --
local StatList = {"Melee", "Defense", "Sword", "Gun", "Demon Fruit"}
Tabs.Stats:AddDropdown("SelectStat", {
    Title = "Select Stat to Upgrade",
    Values = StatList,
    Multi = false,
    Default = 1,
}):OnChanged(function(Value)
    _G.SelectedStat = Value
end)

Tabs.Stats:AddToggle("AutoStatToggle", {Title = "Enable Auto Stats", Default = false }):OnChanged(function(Value)
    _G.AutoStats = Value
    task.spawn(function()
        while _G.AutoStats do task.wait(0.5)
            CommF:InvokeServer("AddPoint", _G.SelectedStat, 1)
        end
    end)
end)

-- [[ TAB: TELEPORTS ]] --
local SeaSection = Tabs.Teleport:AddSection("Sea Teleports")
SeaSection:AddButton({ Title = "Teleport to Sea 1", Callback = function() CommF:InvokeServer("TravelMain") end })
SeaSection:AddButton({ Title = "Teleport to Sea 2", Callback = function() CommF:InvokeServer("TravelDressrosa") end })
SeaSection:AddButton({ Title = "Teleport to Sea 3", Callback = function() CommF:InvokeServer("TravelZou") end })

local IslandSection = Tabs.Teleport:AddSection("Island Teleports")
IslandSection:AddButton({ Title = "Teleport to Miracle Island", Callback = function() TP(CFrame.new(-2800, 20, 3000)) end })

-- [[ TAB: RAID / DUNGEON ]] --
Tabs.Raid:AddDropdown("RaidChip", {
    Title = "Select Raid Chip",
    Values = {"Flame", "Ice", "Quake", "Light", "Dark", "Spider", "Rumble", "Magma", "Buddha", "Dough"},
    Multi = false,
    Default = 1,
}):OnChanged(function(Value)
    _G.RaidChip = Value
end)

Tabs.Raid:AddButton({
    Title = "Buy Chip & Start Raid",
    Callback = function()
        CommF:InvokeServer("RaidsNpc", "Select", _G.RaidChip)
        task.wait(1)
        CommF:InvokeServer("RaidsNpc", "Start")
    end
})

-- [[ TAB: ESP & VISUALS ]] --
Tabs.ESP:AddToggle("PlayerESP", {Title = "Player ESP", Default = false }):OnChanged(function(Value)
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= LP and v.Character then
            if Value then
                local h = Instance.new("Highlight", v.Character)
                h.FillColor = Color3.fromRGB(255, 0, 0)
                h.OutlineColor = Color3.fromRGB(255, 255, 255)
            else
                if v.Character:FindFirstChild("Highlight") then v.Character.Highlight:Destroy() end
            end
        end
    end
end)

Tabs.ESP:AddToggle("FruitESP", {Title = "Fruit ESP", Default = false }):OnChanged(function(Value)
    if Value then
        for _, v in pairs(game.Workspace:GetChildren()) do
            if v:IsA("Tool") and v.Name:find("Fruit") then
                local bg = Instance.new("BillboardGui", v.Handle)
                bg.Size = UDim2.new(0, 100, 0, 50)
                bg.AlwaysOnTop = true
                local txt = Instance.new("TextLabel", bg)
                txt.Size = UDim2.new(1,0,1,0)
                txt.Text = v.Name
                txt.TextColor3 = Color3.new(0,1,0)
                txt.BackgroundTransparency = 1
            end
        end
    end
end)

-- [[ TAB: SHOP & MISC ]] --
Tabs.Shop:AddButton({Title = "Buy Random Fruit", Callback = function() CommF:InvokeServer("Cousin", "Buy") end })
Tabs.Shop:AddButton({Title = "Store Fruit to Inventory", Callback = function() 
    for _, v in pairs(LP.Backpack:GetChildren()) do
        if v.ToolTip == "Blox Fruit" then
             CommF:InvokeServer("StoreFruit", v:GetAttribute("OriginalName"), v)
        end
    end
end })

Tabs.Shop:AddSlider("WalkSpeed", {
    Title = "Walk Speed",
    Default = 16,
    Min = 16,
    Max = 300,
    Rounding = 1,
    Callback = function(Value)
        LP.Character.Humanoid.WalkSpeed = Value
    end
})

-- [[ SETTINGS ]] --
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})
InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)

Window:SelectTab(1)

-- [[ 🚀 FLOATING TOGGLE BUTTON SYSTEM ]] --
-- This system creates a round Blox Fruit icon when the menu is closed.

task.spawn(function()
    -- Create ScreenGui
    local ToggleGui = Instance.new("ScreenGui")
    ToggleGui.Name = "ClaywnwToggle"
    ToggleGui.Parent = game.CoreGui

    -- Create ImageButton (Round Logo)
    local ToggleBtn = Instance.new("ImageButton")
    ToggleBtn.Name = "ToggleBtn"
    ToggleBtn.Parent = ToggleGui
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    ToggleBtn.BackgroundTransparency = 0.5
    ToggleBtn.Position = UDim2.new(0.1, 0, 0.1, 0) -- Initial Position
    ToggleBtn.Size = UDim2.new(0, 60, 0, 60)
    -- Using a Blox Fruits Icon
    ToggleBtn.Image = "rbxassetid://9705916024" 
    ToggleBtn.Visible = false
    
    -- Round Corner
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(1, 0)
    UICorner.Parent = ToggleBtn
    
    -- Stroke (Border)
    local UIStroke = Instance.new("UIStroke")
    UIStroke.Parent = ToggleBtn
    UIStroke.Color = Color3.fromRGB(255, 255, 255)
    UIStroke.Thickness = 2

    -- Make it Draggable
    local function MakeDraggable(gui)
        local UserInputService = game:GetService("UserInputService")
        local dragging
        local dragInput
        local dragStart
        local startPos
        
        local function update(input)
            local delta = input.Position - dragStart
            gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
        
        gui.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                dragStart = input.Position
                startPos = gui.Position
                
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        dragging = false
                    end
                end)
            end
        end)
        
        gui.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                dragInput = input
            end
        end)
        
        UserInputService.InputChanged:Connect(function(input)
            if input == dragInput and dragging then
                update(input)
            end
        end)
    end
    MakeDraggable(ToggleBtn)

    -- Logic: Toggle Menu
    ToggleBtn.MouseButton1Click:Connect(function()
        -- Simulate Right Ctrl press to toggle Fluent
        game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.RightControl, false, game)
        game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode.RightControl, false, game)
    end)

    -- Logic: Auto Show/Hide Button
    -- When Fluent UI is Hidden -> Show Button
    -- When Fluent UI is Visible -> Hide Button
    while true do
        task.wait(0.5)
        local MainFrame = game.CoreGui:FindFirstChild("Fluent") and game.CoreGui.Fluent:FindFirstChild("Frame")
        if MainFrame then
            if MainFrame.Visible then
                ToggleBtn.Visible = false
            else
                ToggleBtn.Visible = true
            end
        end
    end
end)

Fluent:Notify({
    Title = "CLAYWNW1 HUB",
    Content = "Loaded! Press Right Ctrl or use the Icon.",
    Duration = 5
})
