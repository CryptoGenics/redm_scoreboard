local open = false

Citizen.CreateThread(function()
    open = false
    while true do
        Wait(0)

        if IsControlPressed(0, 0x26E9DC00) then
        if not open then
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

            open = true
            while open do
                Wait(0)
                    if(IsControlPressed(0, 0x26E9DC00) == false) then
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

function GetPlayers()
    local players = {}

    for i = 0, 256 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end

    return players
end