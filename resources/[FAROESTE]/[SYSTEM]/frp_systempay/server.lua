local Tunnel = module('_core', 'lib/Tunnel')

local Proxy = module('_core', 'lib/Proxy')

local API = Proxy.getInterface('API')

local HOURLY_PAYMENT_PER_GROUP = {

	['marshall'] = 1600,
	['delegado'] = 1400,
	['sheriff'] = 1200,
	['trooper'] = 800,
	['recruta'] = 400,

	['medic'] = 400,

	['governador'] = 2500,
	['secretario'] = 900,

	['jornalista'] = 200
}

CreateThread(function()

	while true do

		local players = GetPlayers()

		for i = 1, #players do

			local user = API.getUserFromSource(tonumber(players[i]))

			if user then

				local character = user:getCharacter()

				if character then

					local characterGroups = character:getGroupNames()

					local payment

					if table.type(characterGroups) ~= 'empty' then

						if #characterGroups > 1 then

							local salaries = {}

							for i = 1, #characterGroups do

								payment = HOURLY_PAYMENT_PER_GROUP[characterGroups[i]]

								if payment then
									table.insert(salaries, payment)
								end
							end

							table.sort(salaries)

							payment = salaries[#salaries]
						else
							payment = HOURLY_PAYMENT_PER_GROUP[characterGroups[1]]
						end

						if payment then

							local inventory = character:getInventory()

							if inventory:addItem('money', payment) then

								user:notify('alert', 'Você acabou de receber o seu salário. Aproveite!')

								character:varyExp(10.0)

							end
						end
					end
				end
			end
		end

		Wait(1000 * 60 * 60) -- Minutos
	end
end)

-- RegisterCommand('emprego', function(source, args, rawCommand)

-- 	local user = API.getUserFromSource(source)

--     local character = user:getCharacter()

-- 	print(character:getGroupNames())

-- end, false)