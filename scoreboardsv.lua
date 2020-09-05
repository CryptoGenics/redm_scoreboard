local characters = {}

RegisterServerEvent("redm_scoreboard:GetBoard")
AddEventHandler("redm_scoreboard:GetBoard", function(ptable, key)
    local _source = source
    local players = {}
    if Config.RPnames then
        if Config.Ping then
            if Config.RPframework == "REDEMRP" then
                for _, i in ipairs(ptable) do
                    if characters[i] then
                        if GetPlayerPing(i) then
                            table.insert(players, {i, characters[i], GetPlayerPing(i)})
                        end
                    else
                        TriggerEvent('redemrp:getPlayerFromId', i, function(user)
                            if user ~= nil then
                                if GetPlayerPing(i) then
                                    characters[i] = HtmlEscape(user.getName())
                                    table.insert(players, {i, characters[i], GetPlayerPing(i)})
                                end
                            end
                        end)
                    end
                end
            elseif Config.RPframework == "VORP" then
                for _, i in ipairs(ptable) do
                    if characters[i] then
                        if GetPlayerPing(i) then
                            table.insert(players, {i, characters[i], GetPlayerPing(i)})
                        end
                    else
                        TriggerEvent('vorp:getCharacter', i, function(user)
                            if user.firstname ~= nil then
                                if GetPlayerPing(i) then
                                    characters[i] = HtmlEscape(user.firstname..' '..user.lastname)
                                    table.insert(players, {i, characters[i], GetPlayerPing(i)})
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
                        table.insert(players, {i, characters[i]})
                    else
                        TriggerEvent('redemrp:getPlayerFromId', i, function(user)
                            if user ~= nil then
                                characters[i] = HtmlEscape(user.getName())
                                table.insert(players, {i, characters[i]})
                            end
                        end)
                    end
                end
            elseif Config.RPframework == "VORP" then
                if characters[i] then
                    table.insert(players, {i, characters[i]})
                else
                    TriggerEvent("vorp:getCharacter", i, function(user)
                        if user.firstname ~= nil then
                            characters[i] = HtmlEscape(user.firstname..' '..user.lastname)
                            table.insert(players, {i, characters[i]})
                        end
                    end)
                end
            end
        end
    elseif Config.Ping then
        for _, i in ipairs(ptable) do
            if GetPlayerPing(i) then
                characters[i] = HtmlEscape(GetPlayerName(i))
                table.insert(players, {i, characters[i], GetPlayerPing(i)})
            end
        end
    else
        for _, i in ipairs(ptable) do
            if GetPlayerName(i) then
                characters[i] = HtmlEscape(GetPlayerName(i))
                table.insert(players, {i, characters[i]})
            end
        end
    end
	TriggerClientEvent("redm_scoreboard:Show", _source, players, key)
end)

function HtmlEscape(text)
    local characters = { ['&' ] = '&amp;', ['"']='&quot;', ['<' ] = '&lt;', ['>' ] = '&gt;', ['\n'] = '<br/>' }
    return text:gsub('[&"<>\n]', characters):gsub(' +', function(s) return ' '..('&nbsp;'):rep(#s-1) end)
end
