RegisterServerEvent("fireworks:MakeAmericaGreatAgain")
AddEventHandler("fireworks:MakeAmericaGreatAgain", function(coords)
    local _source = source
	TriggerClientEvent('fireworks:firework', -1, coords)
end)

RegisterServerEvent("fireworks:USA-USA-USA")
AddEventHandler("fireworks:USA-USA-USA", function(coords)
    local _source = source
	TriggerClientEvent('fireworks:popsmoke', -1, coords)
end)