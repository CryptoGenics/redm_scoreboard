local characters = {}

RegisterServerEvent("redm_scoreboard:GetBoard")
AddEventHandler("redm_scoreboard:GetBoard", function(ptable)
    local _source = source
    local players = {}
    if Config.RPnames then
        if Config.Ping then
            if Config.RPframework == "REDEMRP" then
                for _, i in ipairs(ptable) do
                    if characters[i] then
                        if GetPlayerPing(i) then
                            table.insert(players, '<tr><td>' .. i .. '</td><td>' .. characters[i] .. '</td><td>' .. GetPlayerPing(i) .. '<small>ms</small></td></tr>')
                        end
                    else
                        TriggerEvent('redemrp:getPlayerFromId', i, function(user)
                            if user ~= nil then
                                if GetPlayerPing(i) then
                                    characters[i] = user.getName()
                                    table.insert(players, '<tr><td>' .. i .. '</td><td>' .. characters[i] .. '</td><td>' .. GetPlayerPing(i) .. '<small>ms</small></td></tr>')
                                end
                            end
                        end)
                    end
                end
            elseif Config.RPframework == "VORP" then
                for _, i in ipairs(ptable) do
                    if characters[i] then
                        if GetPlayerPing(i) then
                            table.insert(players, '<tr><td>' .. i .. '</td><td>' .. characters[i] .. '</td><td>' .. GetPlayerPing(i) .. '<small>ms</small></td></tr>')
                        end
                    else
                        TriggerEvent('vorp:getCharacter', i, function(user)
                            if user ~= nil then
                                if GetPlayerPing(i) then
                                    characters[i] = user.firstname..' '..user.lastname
                                    table.insert(players, '<tr><td>' .. i .. '</td><td>' .. characters[i] .. '</td><td>' .. GetPlayerPing(i) .. '<small>ms</small></td></tr>')
                                end
                            end
                        end)
                    end
                end
            end
        else
            if Config.RPframework == "REDEMRP" then
                for _, i in ipairs(ptable) do
                    if characters[i] then
                        table.insert(players, '<tr><td>' .. i .. '</td><td>' .. characters[i] .. '</td></tr>')
                    else
                        TriggerEvent('redemrp:getPlayerFromId', i, function(user)
                            if user ~= nil then
                                characters[i] = user.getName()
                                table.insert(players, '<tr><td>' .. i .. '</td><td>' .. characters[i] .. '</td></tr>')
                            end
                        end)
                    end
                end
            elseif Config.RPframework == "VORP" then
                if characters[i] then
                    table.insert(players, '<tr><td>' .. i .. '</td><td>' .. characters[i] .. '</td></tr>')
                else
                    TriggerEvent("vorp:getCharacter", i, function(user)
                        if user ~= nil then
                            characters[i] = user.firstname..' '..user.lastname
                            table.insert(players, '<tr><td>' .. i .. '</td><td>' .. characters[i] .. '</td></tr>')
                        end
                    end)
                end
            end
        end
    elseif Config.Ping then
        for _, i in ipairs(ptable) do
            if GetPlayerPing(i) then
                table.insert(players, '<tr><td>' .. i .. '</td><td>' .. GetPlayerName(i) .. '</td><td>' .. GetPlayerPing(i) .. '<small>ms</small></td></tr>')
            end
        end
    end
	TriggerClientEvent("redm_scoreboard:Show", _source, table.concat(players))
end)