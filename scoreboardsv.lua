local characters = {}

RegisterServerEvent("redm_scoreboard:GetBoard")
AddEventHandler("redm_scoreboard:GetBoard", function()
    local _source = source
    local players = GetPlayers()
    if Config.RPnames then
        if Config.Ping then
            if Config.RPframework == "REDEMRP" then
                for _, i in ipairs(players) do
                    local id = tonumber(i)
                    if characters[id] then
                        if GetPlayerPing(id) then
                            characters[id].ping = GetPlayerPing(id)
                        end
                    else
                        TriggerEvent('redemrp:getPlayerFromId', tonumber(id), function(user)
                            if user ~= nil then
                                if GetPlayerPing(id) then
                                    characters[id] = {name = HtmlEscape(user.getName()), ping = GetPlayerPing(id)}
                                end
                            end
                        end)
                    end
                end
            elseif Config.RPframework == "VORP" then
                for _, i in ipairs(players) do
                    local id = tonumber(i)
                    if characters[id] then
                        if GetPlayerPing(id) then
                            characters[id].ping = GetPlayerPing(id)
                        end
                    else
                        TriggerEvent('vorp:getCharacter', id, function(user)
                            if user.firstname ~= nil then
                                if GetPlayerPing(id) then
                                    characters[id] = {name = HtmlEscape(user.firstname..' '..user.lastname), ping = GetPlayerPing(id)}
                                end
                            end
                        end)
                    end
                end
            end
        else
            if Config.RPframework == "REDEMRP" then
                for _, i in ipairs(players) do
                    local id = tonumber(i)
                    if characters[id] then
                    else
                        TriggerEvent('redemrp:getPlayerFromId', tonumber(id), function(user)
                            if user ~= nil then
                                characters[id] = {name = HtmlEscape(user.getName())}
                            end
                        end)
                    end
                end
            elseif Config.RPframework == "VORP" then
                for _, i in ipairs(players) do
                    local id = tonumber(i)
                    if characters[id] then
                    else
                        TriggerEvent("vorp:getCharacter", id, function(user)
                            if user.firstname ~= nil then
                                characters[id] = {name = HtmlEscape(user.firstname..' '..user.lastname)}
                            end
                        end)
                    end
                end
            end
        end
    elseif Config.Ping then
        for _, i in ipairs(players) do
            local id = tonumber(i)
            if GetPlayerPing(id) then
                characters[id] = {name = HtmlEscape(GetPlayerName(id)), ping = GetPlayerPing(id)}
            end
        end
    else
        for _, i in ipairs(players) do
            local id = tonumber(i)
            if GetPlayerName(id) then
                characters[id] = {name = HtmlEscape(GetPlayerName(id))}
            end
        end
    end
    TriggerClientEvent("redm_scoreboard:updatePlayers", _source, players)
    TriggerClientEvent("redm_scoreboard:updatePlayerInfo", _source, characters)
end)

function HtmlEscape(text)
    local SpecialCharacters = { ['&' ] = '&amp;', ['"']='&quot;', ['<' ] = '&lt;', ['>' ] = '&gt;', ['\n'] = '<br/>' }
    return text:gsub('[&"<>\n]', SpecialCharacters):gsub(' +', function(s) return ' '..('&nbsp;'):rep(#s-1) end)
end
