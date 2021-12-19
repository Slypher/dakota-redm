local Tunnel = module('_core', 'lib/Tunnel')

local Proxy = module('_core', 'lib/Proxy')

local API = Proxy.getInterface('API')

local HOURLY_PAYMENT_PER_GROUP = {

	['marshall'] = 1600,
	['delegado'] = 1400,
	['sheriff'] = 1200,
	['trooper'] = 800, -- $2.50
	['recruta'] = 400, -- $0.75

	['medic'] = 400,

	['governador'] = 2500, -- $25.00
	['secretario'] = 900,  -- $9.00

	['jornalista'] = 200  -- $2.00
}

CreateThread(function()

	while true do

		Wait(1000 * 60 * 60) -- Minutos

		local players = GetPlayers()

		for i = 1, #players do

			local user = API.getUserFromSource(tonumber(players[i]))

			local character = user:getCharacter()

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

				local inventory = character:getInventory()

				if inventory:addItem('money', payment) then

					user:notify('alert', 'Você acabou de receber o seu salário. Aproveite!')

					character:varyExp(10.0)

				end
			end
		end
	end
end)

-- RegisterCommand('emprego', function(source, args, rawCommand)

-- 	local user = API.getUserFromSource(source)

--     local character = user:getCharacter()

-- 	print(character:getGroupNames())

-- end, false)