local MyKey

Citizen.CreateThread(function()
    open = false
    while true do
        Wait(0)
        if IsControlPressed(0, Config.key) and IsInputDisabled(0) then
            if not open then
                MyKey = GetGameTimer()
                TriggerServerEvent("redm_scoreboard:GetBoard", GetPlayers(), MyKey)
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
AddEventHandler("redm_scoreboard:Show", function(html, key)
    if MyKey == key then
        DisplayHud(false)
        DisplayRadar(false)
        local players = {}
        for _,v in pairs(html) do
            if Config.Ping then
                local id = tonumber(v[1])
                local name = v[2]
                local ping = tonumber(v[3])
                table.insert(players, 
                '<tr><td>'..id..'</td><td>'..name..'</td><td>'..ping..'<small>ms</small></td></tr>')
            else
                local id = tonumber(v[1])
                local name = v[2]
                table.insert(players, 
                '<tr><td>'..id..'</td><td>'..name..'</td></tr>'
                )
            end
        end
        SendNUIMessage({ text = table.concat(players) })
    end
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
