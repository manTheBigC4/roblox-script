repeat wait() until game:GetService("Players").LocalPlayer ~= nil and game:GetService("Players").LocalPlayer.Character ~= nil
task.wait(5)
local placeid = game.PlaceId
local plr = game:GetService("Players").LocalPlayer
local timequo = tick()


if placeid == 8619263259 then
    writefile("Autoraid.json",game:GetService("HttpService"):JSONEncode(game.JobId))
    
    spawn(function ()
        if plr.PlayerData.Stats.Level.Value >= 300 then
            
            local args = {
                [1] = "UseItem",
                [2] = 1
            }

            game:GetService("ReplicatedStorage").Server:FireServer(unpack(args))

        end
    end)
    plr.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Teleportations.DungeonsPortal.Main.CFrame
    wait(2)
    fireproximityprompt(game:GetService("Workspace").Teleportations.DungeonsPortal.Main.ProximityPrompt,5)
    print("Tping to dungeon...")
    while true do 
        if tick() - timequo > 20 then
            plr.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Teleportations.DungeonsPortal.Main.CFrame
            wait(2)
            fireproximityprompt(game:GetService("Workspace").Teleportations.DungeonsPortal.Main.ProximityPrompt,5)
            print("Repeating.. just in case")
            break
        end
        wait()
    end



elseif placeid == 10523045204 then
    print("Starting...")
    task.wait(3)
    
    local args = {
        [1] = "Nightmare"
    }

    game:GetService("ReplicatedStorage").Remotes.CountVote:FireServer(unpack(args))

    local old 
    old = hookmetamethod(game,"__namecall",function(self,...)
        local args = {...} 
        if self.ClassName == "RemoteEvent" and self.Name == "DamageNew" and not checkcaller() and args[3] == "Enemy" then
            return nil
        end

        return old(self,...)
    end)
    
    
    while true do 
        if not game:GetService("Workspace").Enemies["Dungeon Boss"]:FindFirstChild("Enemy") then
            task.wait(25)
            game:GetService("TeleportService"):TeleportToPlaceInstance(8619263259, game.HttpService:JSONDecode(readfile("Autoraid.json")), game.Players.LocalPlayer)
            break
        end
        if tick() - timequo > 150 then
            game:GetService("TeleportService"):TeleportToPlaceInstance(8619263259, game.HttpService:JSONDecode(readfile("Autoraid.json")), game.Players.LocalPlayer)
            break
        end
        wait()
    end

end
