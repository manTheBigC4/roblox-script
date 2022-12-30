repeat wait() until game:GetService("Players").LocalPlayer ~= nil and game:GetService("Players").LocalPlayer.Character ~= nil
local placeid = game.PlaceId
local hs = game:GetService("HttpService")
local timequo = tick()
local Ids = {}

local x = pcall(function ()
    Ids = hs:JSONDecode(readfile("CRA.json"))
end)
print(x)
spawn(function()
    while true do
        if x == false then return end
        if timequo - Ids[1] > 300 then
            local del = pcall(function ()
                print(timequo - Ids[1])
                delfile("CRA.json")
            end)
            if del then
                print("CRA.json has been Deleted")
            end
        end 
        wait()
    end
end)

if x == false then
    print("failed")
    table.insert(Ids,timequo)
    writefile("CRA.json",hs:JSONEncode(Ids))
end

print(unpack(Ids))


local site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. placeid .. '/servers/Public?sortOrder=Asc&limit=100'))
local stop = false
for i, v in next, site.data do 
    if stop then break end
    for _,server in next, Ids do
        if tonumber(v.playing) < tonumber(v.maxPlayers) and tostring(v.id) ~= tostring(server) then
            table.insert(Ids,v.id)
            writefile("CRA.json",hs:JSONEncode(Ids))
            wait(5)
            print("Teleporting to",tostring(v.id))
            game:GetService("TeleportService"):TeleportToPlaceInstance(placeid, v.id, game.Players.LocalPlayer)
            stop = true
            break
        end

    end
    

end
