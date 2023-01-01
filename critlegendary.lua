getgenv().debounce = true
local rs = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local keybind = Enum.KeyCode.LeftControl
local Config = {
    WindowName = "ss",
    Color = Color3.fromRGB(255,128,64),
    Keybind = Enum.KeyCode.H
}
repeat wait() until game:IsLoaded() wait()
game:GetService("Players").LocalPlayer.Idled:connect(function()
game:GetService("VirtualUser"):ClickButton2(Vector2.new())
end)

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/1201for/V.G-Hub/main/im-retarded-3"))()
getgenv().Window = Library:CreateWindow(Config, game:GetService("CoreGui"))

UIS.InputBegan:Connect(function (input,bool)
    if bool then return end
    if input.KeyCode == Enum.KeyCode.F then
        if getgenv().debounce == true then 
            getgenv().debounce = false
            getgenv().Window:Toggle(false)
        else
            getgenv().debounce = true
            getgenv().Window:Toggle(true)
        end
    end
end)

local Tab1 = getgenv().Window:CreateTab("Crit Legendary")


local Section1 = Tab1:CreateSection("Test")
local Section2 = Tab1:CreateSection("")

-- used vars
local plr = game:GetService("Players").LocalPlayer
local char = plr.Character
local mt = getrawmetatable(game)
setreadonly(mt,false)
local oldnc = mt.__namecall
local holdremote = nil
local time = tick()
local busy = nil
mt.__namecall = newcclosure(function (self,...) 
    if self.ClassName == "RemoteEvent" and self.Name == "CombatTrigger" then
        busy = true
        return oldnc(self,...)
    end

    return oldnc(self,...) 
end)

local getallchest = Section1:CreateButton("Get All chests",function()
    for i, v in next, workspace.Chests:GetChildren() do
        if v.ClassName == "Model" then
            firetouchinterest(plr.Character.Head,v.Giver,0)
        end
    end

end)

local getTp = Section1:CreateTextBox("Tp to Target","",false,function(p1)
    local target = string.lower(p1)
    for i, v in next, workspace:GetChildren() do
        if string.lower(v.Name) == target then
            plr.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
            return
        end
    end
end)

local getcherries = Section1:CreateToggle("Get Cherries",nil,function(state)
    if state then
        getgenv().cherries = rs.RenderStepped:Connect(function()
            for i, v in next, workspace.MaterialGivers["Sky Cherry"]:GetChildren() do

                if v~=nil and v:FindFirstChild("Giver") then
                    firetouchinterest(plr.Character.Head,v.Giver,0)
                end

            end

        end)
    else
        cherries:Disconnect()
    end

end)

local forcetrade = Section1:CreateTextBox("Force Trade","",nil,function (p1)
    for i, v in next, game:GetService("Players"):GetChildren() do
        if string.lower(v.Name) == string.lower(p1) then
   
            local args = {
                [1] = "ATI",
                [2] = game:GetService("Players")[v.Name]
            }
            
            game:GetService("ReplicatedStorage").Server:FireServer(unpack(args))
            
        end
    end

end)

local dungeon = Section1:CreateButton("TP to Dungeon",function()
    plr.Character.HumanoidRootPart.CFrame = workspace.Teleportations.DungeonsPortal.Main.CFrame
    fireproximityprompt(workspace.Teleportations.DungeonsPortal.Main.ProximityPrompt,20000000000000000000)
end)

local inviteparty = Section1:CreateTextBox("Invite Everyone to party","",nil,function(p1)
    if p1 =="All" then
        for i, v in next, game:GetService("Players"):GetChildren() do 
            if v.Name ~= plr.Name then 
                local args = {
                    [1] = "Invite",
                    [2] = v.Character
                }
    
                game:GetService("ReplicatedStorage").Remotes.Party:FireServer(unpack(args))
            end
        end
    else
        local args = {
            [1] = "Invite",
            [2] = game:GetService("Players"):FindFirstChild(p1).Character
        }

        game:GetService("ReplicatedStorage").Remotes.Party:FireServer(unpack(args))
    end

end)


local godmode = Section1:CreateButton("GodMode",function()
    if game.PlaceId == 10523045204 then 
        print("On raid")
        local args = {
            [1] = "Nightmare"
        }

        game:GetService("ReplicatedStorage").Remotes.CountVote:FireServer(unpack(args))
    end

    local old 
    old = hookmetamethod(game,"__namecall",function(self,...)
        local args = {...}
        if self.Name == "DamageNew" and self.ClassName == "RemoteEvent" and not checkcaller() and args[3] == "Enemy" then
            return nil
        end


        return old(self,...)
    end)
end)

local infregenstat = Section1:CreateToggle("Inf regen(Mana scroll or mini tree)",nil,function(state)
    getgenv().lol = state
    if state then
        getgenv().g = game.Players.LocalPlayer.Character.PassiveItems.ChildAdded:Connect(function(v)
            task.wait()
            v:Destroy()
        end)
        spawn(function()
            while lol do 
                local args = {
                    [1] = "SetupItem",
                    [2] = "Mana Scroll"
                }
            
                game:GetService("ReplicatedStorage").Server:FireServer(unpack(args))
                wait()
            end
        end)
      
    else
        g:Disconnect()
    end
end)

local autocollectorbs = Section1:CreateToggle("Auto Collect Orbs",nil,function(state)
    if state then
        getgenv().orbs = rs.RenderStepped:Connect(function ()
            if workspace:FindFirstChild("CombatFolder") then
                local combat = workspace.CombatFolder
                local orbsfolder = combat:FindFirstChild(plr.Name) 

                for i, v in next, orbsfolder:GetChildren() do
                    plr.Character.HumanoidRootPart.CFrame = v.Base.CFrame
                    for i = 1,3 do
                        local args = {
                            [1] = "UseItem",
                            [2] = i
                        }
                
                        game:GetService("ReplicatedStorage").Server:FireServer(unpack(args))
                    end
                end
            end
        end)
    else
        orbs:Disconnect()
    end

end)

local autorefill = Section2:CreateToggle("Auto refill mana pot",nil,function(state)
    getgenv().refill = state
    getgenv().de = state
    while refill do
        if not workspace:FindFirstChild("CombatFolder") and de == true then
            local prevloc = plr.Character.HumanoidRootPart.CFrame
            plr.Character.HumanoidRootPart.CFrame = CFrame.new(49.0098686, 34.9999886, -75.8938141, 0.970981956, 5.64069147e-08, -0.239152849, -5.39365637e-08, 1, 1.68740968e-08, 0.239152849, -3.48536111e-09, 0.970981956)
            local items = {}
            for i = 1,3 do 
                items[game:GetService("Players")["Chelly_Hell"].PlayerData.Equipped["Active"..tostring(i)]] = game:GetService("Players")["Chelly_Hell"].PlayerData.Equipped["Active"..tostring(i)].Value 
            end

            local args = {
                [1] = "ClearActive"
            }

            game:GetService("ReplicatedStorage").Server:FireServer(unpack(args))

            task.wait(2)
            for i, v in next, items do
                local args = {
                    [1] = "SetupItem",
                    [2] = tostring(v)
                }
    
                game:GetService("ReplicatedStorage").Server:FireServer(unpack(args))
            end
           

            task.wait(3)
            plr.Character.HumanoidRootPart.CFrame = prevloc
            de = false
            spawn(function()
                repeat wait() until workspace:FindFirstChild("CombatFolder")
                de = true 
            end) 
        end
        wait()
    end
end)

local milgold = Section2:CreateButton("Get 5 mil gold quest lmfao",function ()
    if plr.PlayerData.Quests:FindFirstChild("Foxes and Slimes") then return end
    local prevloc = plr.Character.HumanoidRootPart.CFrame
    plr.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").QuestNPCs["Foxes and Slimes"].Main.CFrame
    wait(1.2)
    fireproximityprompt(game:GetService("Workspace").QuestNPCs["Foxes and Slimes"].Main.ProximityPrompt,5)


    local args = {
        [1] = "MainAction",
        [2] = workspace.QuestNPCs:FindFirstChild("Foxes and Slimes")
    }

    workspace.QuestNPCs.Main.onClick:FireServer(unpack(args))

    plr.Character.HumanoidRootPart.CFrame = prevloc
end)
