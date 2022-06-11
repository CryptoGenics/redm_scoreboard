local playerList = {}
local playerInfo = {}

Citizen.CreateThread(function()
    open = false
    while true do
        Wait(0)
        if IsControlPressed(0, Config.key) and IsInputDisabled(0) then
            if not open then
                local players = {}

                if Config.Ping then
                    for _, i in ipairs(playerList) do
                        local id = tonumber(i)
                        table.insert(players, 
                        '<tr><td>' .. id .. '</td><td>' .. playerInfo[id].name .. '</td><td>' .. playerInfo[id].ping .. '<small>ms</small></td></tr>')
                    end
                else
                    for _, i in ipairs(playerList) do
                        local id = tonumber(i)
                        table.insert(players, 
                        '<tr><td>' .. id .. '</td><td>' .. playerInfo[id].name ..'</td></tr>')
                    end
                end

                SendNUIMessage({
                    text = table.concat(players)
                })
                DisplayHud(false)
                DisplayRadar(false)
                open = true
                while open do
                    Wait(0)
                    if(IsControlPressed(0, Config.key) == false) then
                        open = false
                        DisplayHud(true)
                        DisplayRadar(true)
                        SendNUIMessage({
                            meta = 'close'
                        })
                        break
                    end
                end
            end
        end
    end
end)

RegisterNetEvent("redm_scoreboard:updatePlayers")
AddEventHandler("redm_scoreboard:updatePlayers", function(list)
    playerList = list
end)

RegisterNetEvent("redm_scoreboard:updatePlayerInfo")
AddEventHandler("redm_scoreboard:updatePlayerInfo", function(info)
    playerInfo = info
end)

Citizen.CreateThread(function() 
    while true do
        TriggerServerEvent("redm_scoreboard:GetBoard")
        Citizen.Wait(5000)
    end
end)
