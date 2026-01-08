-- [[ CLAYWNW1 REBORN v1 - OFFICIAL RELEASE ]] --
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local Window = Fluent:CreateWindow({
    Title = "CLAYWNW1 REBORN",
    SubTitle = "by Gemini AI",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

local Tabs = {
    Main = Window:AddTab({ Title = "Auto Farm", Icon = "rbxassetid://4483345998" }),
    World = Window:AddTab({ Title = "World & ESP", Icon = "rbxassetid://4483345998" }),
    Stats = Window:AddTab({ Title = "Stats & Speed", Icon = "rbxassetid://4483345998" })
}

-- [[ AUTO FARM ENGINE ]] --
local Toggle = Tabs.Main:AddToggle("AutoFarm", {Title = "Enable Auto Farm", Default = false })

Toggle:OnChanged(function()
    _G.AutoFarm = Toggle.Value
    task.spawn(function()
        while _G.AutoFarm do task.wait(0.1)
            pcall(function()
                local LP = game.Players.LocalPlayer
                if not LP.PlayerGui.Main.Quest.Visible then
                    -- Get nearest Quest based on Level
                    local lvl = LP.Data.Level.Value
                    local qName = "BanditQuest1" -- Default
                    if lvl >= 700 and lvl < 1500 then qName = "Area1Quest" end
                    if lvl >= 1500 then qName = "ChocolateQuest" end
                    
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", qName, 1)
                else
                    -- Search for target
                    for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
                        if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                            repeat
                                if not _G.AutoFarm then break end
                                LP.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 0, 8)
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

-- [[ WORLD FUNCTIONS ]] --
Tabs.World:AddButton({
    Title = "Fruit Sniper (Teleport)",
    Callback = function()
        for _, v in pairs(game.Workspace:GetChildren()) do
            if v:IsA("Tool") and v.Name:find("Fruit") then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Handle.CFrame
            end
        end
    end
})

Tabs.World:AddToggle("PlayerESP", {Title = "Player ESP", Default = false }):OnChanged(function(v)
    _G.ESP = v
    for _, p in pairs(game.Players:GetPlayers()) do
        if p ~= game.Players.LocalPlayer and p.Character then
            local highlight = p.Character:FindFirstChild("Highlight") or Instance.new("Highlight", p.Character)
            highlight.Enabled = _G.ESP
        end
    end
end)

-- [[ PLAYER STATS ]] --
Tabs.Stats:AddSlider("WalkSpeed", {
    Title = "Custom WalkSpeed",
    Default = 20,
    Min = 20,
    Max = 200,
    Rounding = 1,
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
    end
})

Tabs.Stats:AddButton({
    Title = "Enable Infinite Jump",
    Callback = function()
        game:GetService("UserInputService").JumpRequest:Connect(function()
            game.Players.LocalPlayer.Character.Humanoid:ChangeState("Jumping")
        end)
    end
})

Window:SelectTab(1)
Fluent:Notify({
    Title = "CLAYWNW1 REBORN",
    Content = "Script loaded successfully!",
    Duration = 5
})
