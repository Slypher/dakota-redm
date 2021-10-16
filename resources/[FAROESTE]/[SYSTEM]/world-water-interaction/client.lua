
local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

cAPI = Proxy.getInterface('API')
API = Tunnel.getInterface('API')

CreateThread(function()
	while true do
		Wait(0)

		local playerPed = PlayerPedId()

		local submergedLevel = GetEntitySubmergedLevel(playerPed)

		if (submergedLevel >= 0.25 and submergedLevel <= 0.40) and not IsPedSwimming(playerPed) then
			local playerPos = GetEntityCoords(playerPed)

			local animHandPos = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 0.60, -0.90)
	
			local hasWater, waterHeightZAtAnimPos = TestVerticalProbeAgainstAllWater(playerPos.x, playerPos.y, playerPos.z + 1.0, 1)

			if hasWater and waterHeightZAtAnimPos >= animHandPos.z then

				DrawTxt('[ENTER] Lavar-se',  .78, 0.95, 0.4, 0.4, true, 255, 255, 255, 150, false)
                DrawTxt('[C] Beber', 0.78, 0.90, 0.4, 0.4, true, 255, 255, 255, 150, false)

				-- ENTER key.
				if IsControlJustReleased(0, `INPUT_FRONTEND_ACCEPT`) then
					PlayWashingFaceInteraction()
				end

                -- C key.
                if IsControlJustReleased(0, `INPUT_LOOK_BEHIND`) then
                    PlayDrinkingInteraction()
                end
			end
		end
	end
end)

function PlayWashingFaceInteraction()
	local DICTIONARY  = 'amb_misc@world_human_wash_face_bucket@ground@male_a@idle_d'
	local ANIMATION = 'idle_l'

	RequestAnimDict(DICTIONARY)

    while not HasAnimDictLoaded(DICTIONARY) do
        Citizen.Wait(0)
    end

	local playerPed = PlayerPedId()

    TaskPlayAnim(playerPed, DICTIONARY, ANIMATION, 1.0, 8.0, 5000, 0, 0.0, false, false, false)

    Citizen.Wait(6000)

	-- Forma de se lavar usado pelo script da própria rockstar.
	-- Citizen.InvokeNative(0xEB8886E1065654CD, playerPed, 4, 'ALL', 0.5)
	-- Citizen.InvokeNative(0xEB8886E1065654CD, playerPed, 6, 'ALL', 0.5)
	-- Citizen.InvokeNative(0xEB8886E1065654CD, playerPed, 1, 'ALL', 0.5)
	-- Citizen.InvokeNative(0xA7A806677F8DE138, playerPed);

	ClearPedEnvDirt(playerPed)

	-- ClearPedWetness
    Citizen.InvokeNative(0x9C720776DAA43E7E, playerPed)

	N_0xe3144b932dfdff65(playerPed, 0.0, -1, 1, 1)

	ClearPedDamageDecalByZone(playerPed, 10, 'ALL')
	
	ClearPedBloodDamage(playerPed)

    TriggerEvent('dangy_stress:modify', -1.3)

    -- ClearPedBloodDamageFacial
    Citizen.InvokeNative(0x7F5D88333EE8A86F, PlayerPedId(), 1)

	RemoveAnimDict(DICTIONARY)
end

function PlayDrinkingInteraction()
    local playerPed = PlayerPedId()
    
    ClearPedTasks(playerPed)

    -- WORLD_HUMAN_BUCKET_DRINK_GROUND_NO_BUCKET
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_BUCKET_DRINK_GROUND'), -1, true, false, false, false)
    
    Citizen.Wait(15000)

    API.varyThirst(-20)

    ClearPedTasks(playerPed)
end

function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str)
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
	SetTextCentre(centre)
    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
	Citizen.InvokeNative(0xADA9255D, 1);
    DisplayText(str, x, y)
end