Citizen.CreateThread(function()
    open = false
    while true do
        Wait(0)
        if IsControlPressed(0, Config.key) and IsInputDisabled(0) then
            if not open then
                if Config.Ping or Config.RPnames then
                    TriggerServerEvent("redm_scoreboard:GetBoard", GetPlayers())
                else
                    local players = {}
                    ptable = GetPlayers()
                    for _, i in ipairs(ptable) do
                        table.insert(players, 
                        '<tr style="color: rgb(255, 255, 255); font-weight: 500;"><td>' .. GetPlayerServerId(i) .. '</td><td>' ..GetPlayerName(i)..'</td></tr>'
                        )
                    end
                    DisplayHud(false)
                    DisplayRadar(false)
                    SendNUIMessage({ text = table.concat(players) })
                end

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

RegisterNetEvent("redm_scoreboard:Show")
AddEventHandler("redm_scoreboard:Show", function(html)
    DisplayHud(false)
    DisplayRadar(false)
	SendNUIMessage({ text = html })
end)

function GetPlayers()
    local players = {}

    for i = 0, 256 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, GetPlayerServerId(i))
        end
    end

    return players
end