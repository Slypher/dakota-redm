MenuData = {}
TriggerEvent("redemrp_menu_base:getData",function(call)
    MenuData = call
end)

local list_hair = {}
local list_hair_length = 0
local list_hair_f = {}
local list_hair_f_length = 0
local list_mustache = {}
local list_mustache_length = 0
local adding = true


Citizen.CreateThread(function()
    while adding do
        Citizen.Wait(0)
        for i, v in ipairs(MaleComp) do
            if v.category == "hair" then
                list_hair_length = list_hair_length + 1
                table.insert(list_hair, v.Hash)
            elseif v.category == "mustache" then
                list_mustache_length = list_mustache_length + 1
                table.insert(list_mustache, v.Hash)
            end
        end
        for i, v in ipairs(FemaleComp) do
            if v.category == "hair" then
                list_hair_f_length = list_hair_f_length + 1
                table.insert(list_hair_f, v.hash)
            end
        end
        adding = false
    end
end)


-- Menu_base 
function barberMenu()
    MenuData.CloseAll()
    local myPed = PlayerPedId()
    local sex = IsPedMale(myPed)
    local elements = {}
    local currentHairList = {}
    local currentBeardList = {}
    if sex == 1 then
        elements = {
            {label = "Hair", cat = "hair", value = 1, type = 'slider', min = 1, max = list_hair_length, desc = "Choose your hairstyle"},
            {label = "Beard", cat = "mustache", value = 1, type = 'slider', min = 1, max = list_mustache_length, desc = "Choose your beardstyle"},
        }
        currentHairList = list_hair
        currentBeardList = list_mustache
    else
        elements = {
            {label = "Hair", cat = "hair", value = 1, type = 'slider', min = 1, max = list_hair_f_length, desc = "Choose your hairstyle"},
        }
        currentHairList = list_hair_f
    end
    
	MenuData.Open('default', GetCurrentResourceName(), 'barber_menu',{
		title    = "Barber Shope",	
		subtext  = 'Choose',
		align    = 'top-right',
		elements = elements,
	},
    function(data, menu)
        local elements2 = {}
        local OpenSub = false
        local title2 = ""
        local subtitle2 = ""
        local category = data.current.cat
        if category == 'hair' then
            title2 = "Buy?"
            subtitle2 = "current Hair"
            elements2 = {
                {label = "Yes", value = 'yes'},
                {label = "No", value = 'no'},
            }
            OpenSub = true
        elseif category == 'mustache' then
            title2 = "Buy?"
            subtitle2 = "current Mustache"
            elements2 = {
                {label = "Yes", value = 'yes'},
                {label = "No", value = 'no'},
            }
            OpenSub = true
        end

        if OpenSub == true then
            OpenSub = false
            MenuData.Open('default', GetCurrentResourceName(), 'barber_'..category, {
                title = title2,
                subtext = subtitle2,
                align = 'top-right',
                elements = elements2,
            }, 
            function(data2, menu2)
                if data.current.cat == "hair" and data2.current.value == "yes" then
                    TriggerServerEvent("FRP:CLOTHES:SavePlayerClothing2", selectedhairIndex)
                    menu2.close()       
                elseif data.current.cat == "mustache" and data2.current.value == "yes" then
                    TriggerServerEvent("FRP:CLOTHES:SavePlayerClothing2", selectedmustacheIndex)
                    menu2.close()  
                elseif data2.current.value == "no" then
                    menu2.close()
                end
                
            end, 
            function(data2, menu2)
                menu2.close()
            end) 
        end
    end,
	function(data, menu)
		print("closed Menu")
		menu.close()
        if ClearPedTasks(PlayerPedId()) then
            Citizen.Wait(5000)
            TriggerServerEvent('redemrp_skin:loadSkin')
        end
	end,
	function(data, menu)
        currenthairIndex = data.current.value
        selectedhairIndex = data.current.value
        currentmustacheIndex = data.current.value
        selectedmustacheIndex = data.current.value
        if data.current.cat == "hair" then
            local hash = ("0x" ..currentHairList[data.current.value])
            Citizen.InvokeNative(0xD3A7B003ED343FD9, myPed,tonumber(hash),true,true,true) -- HAIR
        elseif data.current.cat == "mustache" then
            local hash = ("0x" ..currentBeardList[data.current.value])
            Citizen.InvokeNative(0xD3A7B003ED343FD9, myPed,tonumber(hash),true,true,true) -- Facial hair
        end
	end)
end



-- Warmenu -- 

Citizen.CreateThread(function()
	local currenthairIndex = 1
    local selectedhairIndex = 1
    local currentmustacheIndex = 1
    local selectedmustacheIndex = 1
	
    if not DoesEntityExist(florencewatson) then
        local hash = GetHashKey("S_M_M_Barber_01")
        --RequestModel(hash)

        while not HasModelLoaded(hash) do
            Wait(100)
        end

        local florencewatson = CreatePed(hash, -815.861, -1364.531, 43.750, 272.97, false, true)
        SetPedRandomComponentVariation(florencewatson, 0)
        SetBlockingOfNonTemporaryEvents(florencewatson, true)
        SetEntityInvincible(florencewatson, true)
        SetPedCanBeTargettedByPlayer(florencewatson, GetPlayerPed(), false)
    end


    WarMenu.CreateMenu('BarberMenu', "Barbers")
    WarMenu.SetSubTitle('BarberMenu', ' ')
    --WarMenu.SetMenuWidth('BarberMenu', 0.222)
    WarMenu.SetMenuX('BarberMenu', 0.16)
    WarMenu.SetMenuMaxOptionCountOnScreen('BarberMenu', 15)

    WarMenu.CreateSubMenu('HairMenu', 'BarberMenu', ' ')
    WarMenu.CreateSubMenu('BeardMenu', 'BarberMenu', ' ')
	WarMenu.CreateSubMenu('fHairMenu', 'BarberMenu', ' ')

    while true do
        Citizen.Wait(0)

        if WarMenu.IsMenuOpened('BarberMenu') then
            if IsPedModel(GetPlayerPed(), GetHashKey("mp_male")) then
                
            

            if WarMenu.MenuButton('Hair styles', 'HairMenu') then
            end
			
			if WarMenu.MenuButton('Beard styles', 'BeardMenu') then
            end
			
			else
			
			if WarMenu.MenuButton('Female Hair styles', 'fHairMenu') then
            end

            end

            if WarMenu.IsMenuAboutToBeClosed() then
                ClearPedTasks(GetPlayerPed())
                TriggerEvent("redemrp_db:retrieveSkin")
            end

            WarMenu.Display()
        end

        --Sub menus
		
        if WarMenu.IsMenuOpened('HairMenu') then
		if WarMenu.ComboBox('Hair: < '..currenthairIndex..' >', list_hair, currenthairIndex, selectedhairIndex, function(currenthair, selectedhair)
                        currenthairIndex = currenthair
                        selectedhairIndex = selectedhair
                        local hash = ("0x" ..list_hair[currenthairIndex])
                        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),tonumber(hash),true,true,true) -- HAIR
                    end) then
                    TriggerServerEvent("diack_barbers:SaveHair", selectedhairIndex)
           -- for key, value in pairs(hair) do
                --if WarMenu.Button(value.name, "") then
                 --   Citizen.InvokeNative(0xD3A7B003ED343FD9, GetPlayerPed(), value.hash, true, true, true)
                   -- TriggerServerEvent("Barbers:SaveHair", key)
               -- end
            end

            WarMenu.Display()
        end

        if WarMenu.IsMenuOpened('BeardMenu') then
		if WarMenu.ComboBox('Beard: < '..currentmustacheIndex..' >', list_mustache, currentmustacheIndex, selectedmustacheIndex, function(currentmustache, selectedmustache)
                        currentmustacheIndex = currentmustache
                        selectedmustacheIndex = selectedmustache
                        local hash = ("0x" ..list_mustache[currentmustacheIndex])
                        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),tonumber(hash),true,true,true) -- Facial hair
                    end) then
                   TriggerServerEvent("diack_barbers:SaveBeard", selectedmustacheIndex)
           -- for key, value in pairs(beards) do
             --   if WarMenu.Button(value.name, "") then
               --     Citizen.InvokeNative(0xD3A7B003ED343FD9, GetPlayerPed(), value.hash, true, true, true)
               --     TriggerServerEvent("Barbers:SaveBeard", key)
              --  end
            end

            WarMenu.Display()
        end
		
		if WarMenu.IsMenuOpened('fHairMenu') then
		if WarMenu.ComboBox('Hair: < '..currenthairIndex..' >', list_hair_f, currenthairIndex, selectedhairIndex, function(currenthair, selectedhair)
                        currenthairIndex = currenthair
                        selectedhairIndex = selectedhair
                        local hash = ("0x" ..list_hair_f[currenthairIndex])
                        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),tonumber(hash),true,true,true) -- HAIR
                    end) then
                    TriggerServerEvent("diack_barbers:SaveHair", selectedhairIndex)
          --  for key, value in pairs(fhair) do
             --   if WarMenu.Button(value.name, "") then
                 --   Citizen.InvokeNative(0xD3A7B003ED343FD9, GetPlayerPed(), value.hash, true, true, true)
                 --   TriggerServerEvent("Barbers:SaveHair", key)
              --  end
            end

            WarMenu.Display()
        end		
    end
end)

function IsPlayerNearCoords(x, y, z)
    local playerx, playery, playerz = table.unpack(GetEntityCoords(GetPlayerPed(), 0))
    local distance = GetDistanceBetweenCoords(playerx, playery, playerz, x, y, z, true)

    if distance < 10 then
        return true
    end
end

local active = false
local ShopPrompt
local hasAlreadyEnteredMarker, lastZone
local currentZone = nil

-- Config --
local blips = {
    --Blackwater
    { name = 'Barber', sprite = -2090472724, x = -812.67, y = -1366.81, z = 43.75 },
    { name = 'Barber', sprite = -2090472724, x = -307.45, y = 812.17, z = 118.98 },
    { name = 'Barber', sprite = -2090472724, x = 2655.69, y = -1179.83, z = 53.28 },

}


-- Leave --
Citizen.CreateThread(function()
	for _, info in pairs(blips) do
        local blip = N_0x554d9d53f696d002(1664425300, info.x, info.y, info.z)
        SetBlipSprite(blip, info.sprite, 1)
		SetBlipScale(blip, 0.2)
		Citizen.InvokeNative(0x9CB1A1623062F402, blip, info.name)
    end  
end)





function SetupShopPrompt()
    Citizen.CreateThread(function()
        local str = 'Barber'
        ShopPrompt = PromptRegisterBegin()
        PromptSetControlAction(ShopPrompt, 0xE8342FF2)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(ShopPrompt, str)
        PromptSetEnabled(ShopPrompt, false)
        PromptSetVisible(ShopPrompt, false)
        PromptSetHoldMode(ShopPrompt, true)
        PromptRegisterEnd(ShopPrompt)

    end)
end

AddEventHandler('diack_barber:hasEnteredMarker', function(zone)
    currentZone = zone
end)

AddEventHandler('diack_barber:hasExitedMarker', function(zone)
    if active == true then
        PromptSetEnabled(ShopPrompt, false)
        PromptSetVisible(ShopPrompt, false)
        active = false
    end
	currentZone = nil
end)

Citizen.CreateThread(function()
    SetupShopPrompt()
    while true do
        Citizen.Wait(0)
        local player = PlayerPedId()
        local coords = GetEntityCoords(player)
        local isInMarker, currentZone = false

        for k,v in ipairs(blips) do
            if (Vdist(coords.x, coords.y, coords.z, v.x, v.y, v.z) < 1.5) then
                isInMarker  = true
                currentZone = 'blips'
                lastZone    = 'blips'
            end
        end

		if isInMarker and not hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = true
			TriggerEvent('diack_barber:hasEnteredMarker', currentZone)
		end

		if not isInMarker and hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = false
			TriggerEvent('diack_barber:hasExitedMarker', lastZone)
		end

    end
end)



Citizen.CreateThread(function()
	while true do
        Citizen.Wait(0)
        if currentZone then
            if active == false then
                PromptSetEnabled(ShopPrompt, true)
                PromptSetVisible(ShopPrompt, true)
                active = true
            end
            if PromptHasHoldModeCompleted(ShopPrompt) then
                if Config.menuChoice == true then
                    WarMenu.OpenMenu('BarberMenu')
                elseif Config.menuChoice == false then
                    barberMenu()
                end


                if IsPlayerNearCoords(-814.263, -1364.779, 43.750) then
                    TaskStartScenarioAtPosition(GetPlayerPed(), GetHashKey("PROP_PLAYER_BARBER_SEAT"), -815.3, -1367.018, 43.50, 90.60, 100000, true, 0)
                elseif IsPlayerNearCoords(-307.45, 812.17, 118.98) then
                    TaskStartScenarioAtPosition(GetPlayerPed(), GetHashKey("PROP_PLAYER_BARBER_SEAT"), -306.45, 813.60, 118.95, 99.96, 100000, true, 0)
                elseif IsPlayerNearCoords(2655.05, -1179.92, 53.28) then
                    TaskStartScenarioAtPosition(GetPlayerPed(), GetHashKey("PROP_PLAYER_BARBER_SEAT"), 2655.30, -1180.95, 53.01, 182.8, 100000, true, 0)
                end

                         
                PromptSetEnabled(ShopPrompt, false)
                PromptSetVisible(ShopPrompt, false)
                active = false

				currentZone = nil
			end
        else
			Citizen.Wait(500)
		end
	end
end)


RegisterCommand("cancel", function()

    ClearPedTasks(PlayerPedId())


end)
