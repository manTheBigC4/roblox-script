--if getgenv().Window ~= nil then getgenv().Window:Destroy() getgenv() = {} end

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

local Tab1 = getgenv().Window:CreateTab("The CraftWars")
local Tab2 = getgenv().Window:CreateTab("UI Settings")

local Section1 = Tab1:CreateSection("Test")
local Section2 = Tab1:CreateSection("")
local Section3 = Tab2:CreateSection("Menu")
local Section4 = Tab2:CreateSection("Background")

local plrservice = game:GetService("Players")

local data = {}
data.tptarget = nil
data.npcs = {}


function storenpcs()
    for i, v in next, workspace:GetChildren() do
        if v.ClassName == "Model" and v:FindFirstChild("Humanoid") and not data.npcs[v.Name] and not plrservice:FindFirstChild(v.Name) and not game:GetService("ReplicatedStorage"):FindFirstChild(v.Name) then
            print(v.Name.." Stored in ".."data.npcs")
            data.npcs[v.Name] = v
            print(data.npcs[v.Name])
            local args = {
                [1] = "placeobject",
                [2] = {
                    [1] = v,
                    [2] = game:GetService("ReplicatedStorage")
                }
            }
            
            game:GetService("Players").LocalPlayer.Backpack.BuildTool.RemoteFunction:InvokeServer(unpack(args))        
        end
    end
end

spawn(function()
    while true do
        pcall(function()storenpcs()end)
        wait()
    end
end)


local tp = Section1:CreateTextBox("Tp Target","",false,function (p1)
    local tar = string.lower(p1)
    for i, v in next, plrservice:GetChildren() do
        local wtf = string.lower(v.Name)
        if  wtf == tar then
            data.tptarget = v
        else
            warn("Player Not Valid")
        end
    end
end)

local Toggle1 = Section1:CreateToggle("TP to Target",nil,function (state)
    getgenv().toggle = state
    while toggle do
        local plr = game:GetService("Players")
        plr.LocalPlayer.Character.HumanoidRootPart.CFrame = data.tptarget.Character.HumanoidRootPart.CFrame
        wait()
    end
end)

local Toggle2 = Section1:CreateToggle("Freeze(All, Ping Spiker)",nil, function (state)
    getgenv().check = state
    if getgenv().check == true then
        getgenv().fastafloop = rs.RenderStepped:Connect(function()
            for i, v in next, workspace:GetChildren() do
                if v.ClassName == "Model" and v:FindFirstChildOfClass("Humanoid") then  
            
                    local args = {
                        [1] = "inserteffect",
                        [2] = v
                    }

                    game:GetService("Players").LocalPlayer.Character:FindFirstChild("Freeze Ray").RemoteFunction:InvokeServer(unpack(args))
                end
            end
        end)
    else
        getgenv().fastafloop:Disconnect()
    end
end)


local Toggle3 = Section1:CreateToggle("Bubbles",nil,function (state)
    getgenv().bubblecheck = state
    if getgenv().bubblecheck == true then
        getgenv().realfastloop = rs.RenderStepped:Connect(function ()
            for i, v in next, workspace:GetChildren() do
                if v.ClassName == "Model" and v:FindFirstChild("Humanoid") then

                    local args = {
                        [1] = "missile",
                        [2] = {
                            [1] = 200,
                            [2] = v.Head
                        }
                    }

                    game:GetService("Players").LocalPlayer.Character:FindFirstChild("Ocean Spellbook").RemoteFunction:InvokeServer(unpack(args))

                end
            end
        end) 
    else
        getgenv().realfastloop:Disconnect()
    end
end)

local Toggle4 = Section1:CreateToggle("Kill Others",nil,function (state)
    getgenv().Killcheck = state
    if getgenv().Killcheck == true then
        getgenv().killloop = rs.RenderStepped:Connect(function ()

            for i, v in next, workspace:GetChildren() do

                if v.ClassName == "Model" and v:FindFirstChild("Humanoid") and v.Name ~= "UnrealDirt" and v.Name ~= "LoucasTitan" and v.Name ~= plrservice.LocalPlayer.Name then

                    local args = {
                        [1] = "hit",
                        [2] = {
                            [1] = v.Humanoid,
                            [2] = v.Humanoid.Health
                        }
                    }

                    game:GetService("Players").LocalPlayer.Character:FindFirstChild("Sword").RemoteFunction:InvokeServer(unpack(args))

                end

            end

        end)
    else
        getgenv().killloop:Disconnect()
    end
end)
local target = Section1:CreateTextBox("Target","name(case sensitive for now)",false, function (string)
    if workspace:FindFirstChild(string) then
        getgenv().target = workspace:FindFirstChild(string)
    else
        print("Wrong name Or Player might not exist")
    end
end)

local blacktoggle = Section1:CreateToggle("Pull Player(id 169)",nil,function (state)
    local plr = game:GetService("Players").LocalPlayer
    
    getgenv().blackhole = state
    if getgenv().blackhole == true then
        getgenv().rsbh = rs.RenderStepped:Connect(function ()
        
            local args = {
                [1] = "bodyposition",
                [2] = {
                    [1] = getgenv().target.Head,
                    [2] = plr.Character.HumanoidRootPart.Position
                }
            }

            game:GetService("Players").LocalPlayer.Character:FindFirstChild("Blackhole Staff").RemoteFunction:InvokeServer(unpack(args))
    

        end)

    else
        getgenv().rsbh:Disconnect()
    end
end)

local Textbox1 = Section1:CreateTextBox("Give Tool","ID(Must be a Number)",true, function(num)
    local ss = tonumber(num)
    local args = {
        [1] = {
            ["command"] = "givetool",
            ["id"] = ss
        }
    }
    
    game:GetService("ReplicatedStorage").MainControl:InvokeServer(unpack(args))    
end)

local mobratetext = Section1:CreateTextBox("Increase Mob Rate","Must be A number(don't put too much)",true,function(num)
    if type(tonumber(num)) ~= "number" then print("Not A NUMBER") return end
    local Bases = workspace.Bases
   
    local rate = tonumber(num)
    local plrbase = nil
    for i, v in next, Bases:GetChildren() do
        for i2,v2 in next, v:GetChildren() do

            if v2.ClassName == "ObjectValue" and tostring(v2.Value) == game.Players.LocalPlayer.Name then
                plrbase = v
            end

        end
    end
    print(plrbase.Name)

    for i = 1,rate do 
        
        if not plrbase.objects:FindFirstChild("wall") then
            local args = {
                [1] = "placeobject",
                [2] = {
                    [1] = game:GetService("ReplicatedStorage").Blocks.wall,
                    [2] = plrbase.objects,
                    [3] = plrbase.objects.center.CFrame * CFrame.new(0,3.5,0),
                    [4] = 0
                }
            }
            
            game:GetService("Players").LocalPlayer.Backpack.BuildTool.RemoteFunction:InvokeServer(unpack(args))
        end

        local args = {
            [1] = "placeobject",
            [2] = {
                [1] = workspace.Landscape.enemySpawn,
                [2] = plrbase.objects.wall
            }
        }
        
        game:GetService("Players").LocalPlayer.Backpack.BuildTool.RemoteFunction:InvokeServer(unpack(args))
        
    end
end)

local removemobrate = Section1:CreateButton("Reset Mob Rate",function ()
    local Bases = workspace.Bases
    local plrbase = nil
    for i, v in next, Bases:GetChildren() do
        for i2,v2 in next, v:GetChildren() do

            if v2.ClassName == "ObjectValue" and tostring(v2.Value) == game.Players.LocalPlayer.Name then
                plrbase = v
            end

        end
    end
    
    while plrbase.objects:FindFirstChild("wall") do
        local args = {
            [1] = "removeobject",
            [2] = {
                [1] = plrbase.objects.wall,
                [2] = plrbase,
                
            }
        }

        game:GetService("Players").LocalPlayer.Backpack.RemoveTool.RemoteFunction:InvokeServer(unpack(args))

        wait()
    end

end)

local show = Section1:CreateButton("Check Spawnable Npcs",function()
    for i, v in next, data.npcs do
        print(i,v)
    end
    for i, v in next, game:GetService("ReplicatedStorage"):GetChildren() do
        if v.ClassName == "Model" and v:FindFirstChild("Humanoid") then
            print(i,v)
        end
    end

end)

local spawnmob = Section1:CreateTextBox("Spawn Mob","Mob Name",false,function(mob)
    local splitted = mob:split(" ")
    local plrbase = nil
    for i, v in next, workspace.Bases:GetChildren() do
        for i2,v2 in next, v:GetChildren() do

            if v2.ClassName == "ObjectValue" and tostring(v2.Value) == game.Players.LocalPlayer.Name then
                plrbase = v
            end

        end
    end
    print(plrbase.Name)
    if not plrbase.objects:FindFirstChild("fridge") then
        local args = {
            [1] = "placeobject",
            [2] = {
                [1] = game:GetService("ReplicatedStorage").Blocks.fridge,
                [2] = plrbase.objects,
                [3] = plrbase.objects.center.CFrame * CFrame.new(0,3.5,0),
                [4] = 0
            }
        }
        
        game:GetService("Players").LocalPlayer.Backpack.BuildTool.RemoteFunction:InvokeServer(unpack(args))
    end

    if #splitted == 2 then
        for i = 1,tonumber(splitted[2]) do 
            local args = {
                [1] = "placeobject",
                [2] = {
                    [1] = game:GetService("ReplicatedStorage"):FindFirstChild(splitted[1]),
                    [2] = plrbase.objects.fridge
                }
            }
            
            game:GetService("Players").LocalPlayer.Backpack.BuildTool.RemoteFunction:InvokeServer(unpack(args))
        end
    elseif #splitted == 3 then
        local limit = tonumber(table.remove(splitted))
        print(splitted[1].." "..splitted[2])
        for i = 1, limit do 
            local args = {
                [1] = "placeobject",
                [2] = {
                    [1] = game:GetService("ReplicatedStorage"):FindFirstChild(splitted[1].." "..splitted[2]),
                    [2] = plrbase.objects.fridge
                }
            }
            
            game:GetService("Players").LocalPlayer.Backpack.BuildTool.RemoteFunction:InvokeServer(unpack(args))
        end
    elseif #splitted == 4 then 
        local limit = tonumber(table.remove(splitted))
        for i = 1,limit do 
            local args = {
                [1] = "placeobject",
                [2] = {
                    [1] = game:GetService("ReplicatedStorage"):FindFirstChild(splitted[1].." "..splitted[2].." "..splitted[3]),
                    [2] = plrbase.objects.fridge
                }
            }
            
            game:GetService("Players").LocalPlayer.Backpack.BuildTool.RemoteFunction:InvokeServer(unpack(args))
        end
    end

end)

local rem = Section1:CreateButton("Remove all Spawned Mobs",function ()
    local Bases = workspace.Bases
    local plrbase = nil
    
    for i, v in next, Bases:GetChildren() do
        for i2,v2 in next, v:GetChildren() do

            if v2.ClassName == "ObjectValue" and tostring(v2.Value) == game.Players.LocalPlayer.Name then
                plrbase = v
            end

        end
    end
    
    while plrbase.objects:FindFirstChild("fridge") do
        local args = {
            [1] = "removeobject",
            [2] = {
                [1] = plrbase.objects.fridge,
                [2] = plrbase,
                
            }
        }

        game:GetService("Players").LocalPlayer.Backpack.RemoveTool.RemoteFunction:InvokeServer(unpack(args))

        wait()
    end
end)

local f = Section2:CreateButton("Check Plr Base",function ()
    local plrbase = nil
    local Bases = workspace.Bases
    for i, v in next, Bases:GetChildren() do
        for i2,v2 in next, v:GetChildren() do

            if v2.ClassName == "ObjectValue" and tostring(v2.Value) == game.Players.LocalPlayer.Name then
                plrbase = v
            end

        end
    end
    print(plrbase.Name)
end)

local f = Section2:CreateButton("Op Scythe",function()
    for i, v in next, game:GetService("Players"):GetChildren() do
        for i = 1,10 do
            local args = {
                [1] = "placeobject",
                [2] = {
                    [1] = game:GetService("ReplicatedStorage").Items:FindFirstChild("OmegaDeathScythe").Tool,
                    [2] = v.Character
                }
            }
            
            game:GetService("Players").LocalPlayer.Backpack.BuildTool.RemoteFunction:InvokeServer(unpack(args))
            continue
        end
    end

end)

local cras = Section2:CreateButton("Server Crash", function()
    local rs = game:GetService("RunService")

    rs.RenderStepped:Connect(function()
        local args = {
            [1] = "placeobject",
            [2] = {
                [1] = workspace.Bases,
                [2] = workspace
            }
        }
        
        game:GetService("Players").LocalPlayer.Backpack.BuildTool.RemoteFunction:InvokeServer(unpack(args))
    end)
end)

local spawnrateore = Section2:CreateTextBox("Ore spawnrate","",false,function (name)
    local Bases = workspace.Bases
    local repstor = game:GetService("ReplicatedStorage")
    local blocks = repstor.Blocks
    local plrbase = nil
    for i, v in next, Bases:GetChildren() do
        for i2,v2 in next, v:GetChildren() do

            if v2.ClassName == "ObjectValue" and tostring(v2.Value) == game.Players.LocalPlayer.Name then
                plrbase = v
            end

        end
    end


    if not plrbase.objects:FindFirstChild("lamp") then
        local args = {
            [1] = "placeobject",
            [2] = {
                [1] = blocks:FindFirstChild("lamp"),
                [2] = plrbase.objects
            }
        }
        
        game:GetService("Players").LocalPlayer.Backpack.BuildTool.RemoteFunction:InvokeServer(unpack(args))
    end    

    local splitted = name:split(" ")
    local var = tonumber(splitted[2])

    for i = 1,var do 
        local args = {
            [1] = "placeobject",
            [2] = {
                [1] = workspace:FindFirstChild(splitted[1]).oreSpawn,
                [2] = plrbase.objects.lamp
            }
        }
        
        game:GetService("Players").LocalPlayer.Backpack.BuildTool.RemoteFunction:InvokeServer(unpack(args))
    end

end)

local destroyspawnrateore = Section2:CreateButton("Remove ore Spawnrate",function ()
    local plrbase = nil
    local Bases = workspace.Bases
    
    for i, v in next, Bases:GetChildren() do
        for i2,v2 in next, v:GetChildren() do

            if v2.ClassName == "ObjectValue" and tostring(v2.Value) == game.Players.LocalPlayer.Name then
                plrbase = v
            end

        end
    end

    while plrbase.objects:FindFirstChild("lamp") do
        plrbase.objects:FindFirstChild("lamp"):Destroy()
    end
end)
