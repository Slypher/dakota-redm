local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

cAPI = Proxy.getInterface("API")
API = Tunnel.getInterface("API")

Citizen.CreateThread(
    function()
        local coldThreshold = 0

        local categoryTempVariation = {
            [0x9925C067] = 1.0, -- Hat
            [0x864B03AE] = 2.7, -- Hair
            [0x2026C46D] = 3.0, -- Shirts
            [0x485EE834] = 3.0, -- Vests
            [0x1D4C528A] = 2.7, -- Pants
            [0x15D3C7F2] = 1.5, -- Goatees
            [0x18729F39] = 1.25, -- Spurs
            [0x3107499B] = 1.25, -- Chaps
            [0x3C1A74CD] = 2.5, --Cloaks
            [0xA0E3AB7F] = 1.2, -- Skirts (MP)
            [0x4A73515C] = 1.7, -- Masks
            [0x7505EF42] = 1.7, -- Masks (MP)
            [0x514ADCEA] = 1.5, -- Spats
            [0x5FC29285] = 3.5, -- Neckwear
            [0x76F0E272] = 1.0, -- Aprons
            [0x777EC6EF] = 3.0, -- Boots
            [0x91CE9B20] = 2.5, -- Gauntlets (MP)
            [0x7A96FACA] = 1.8, -- Neckties
            -- [0x9B2C8B89] = 0.7, -- Gunbelts
            [0xA6D134C6] = 0.8, -- Belts
            [0xFAE9107F] = 0.8, -- Belt Buckle
            [0xE06D30CE] = 10.0, -- Coats
            [0x662AC34] = 10.0, -- Coats (MP)
            [0xAF14310B] = 5.0, -- Ponchos (MP)
            [0x72E6EF74] = 5.0, -- Armor (MP)
            [0xEABE0032] = 4.0, -- Gloves
            [0xECC8B25A] = 1.5, -- Mustache
            [0xF8016BCA] = 1.5 -- Mustache (MP)
        }

        while true do
            Citizen.Wait(500)

            local ped = PlayerPedId()
            local tempAtPed = GetTemperatureAtCoords(GetEntityCoords(ped))

            local oldTempt = tempAtPed

            for i = 0, NativeGetNumOfCategoriesUsesByPed(ped) do
                local componentCategory = NativeGetPedCategoryAtIndex(ped, i)

                if categoryTempVariation[componentCategory] then
                    -- print('var', componentCategory, categoryTempVariation[componentCategory])

                    tempAtPed = tempAtPed + categoryTempVariation[componentCategory]
                end
            end

            -- print(oldTempt, "->", tempAtPed)

            gTakeColdDamageNextTick = false

            if tempAtPed >= 40 then
                if GetEntityHealth(PlayerPedId()) >= 5 then
                    cAPI.VaryPlayerStamina(-2)
                    SetPedWetnessHeight(ped, 1.0)
                end
            elseif tempAtPed <= 0 then
                Citizen.InvokeNative(0xCB9401F918CB0F75, ped, "Cold_Stamina", 1, 500)

                gTakeColdDamageNextTick = true
            end
        end
    end
)

CreateThread(function()
    while true do
        Wait(3000)

        if gTakeColdDamageNextTick then
            cAPI.VaryPlayerHealth(-1)
        end
    end
end)

-- function NativeApplyDamageToPed(ped, damage)
--     Citizen.InvokeNative(0x697157CED63F18D4, ped, damage, false, true, true)
-- end

function NativeGetNumOfCategoriesUsesByPed(ped)
    return Citizen.InvokeNative(0x90403E8107B60E81, ped, Citizen.ResultAsInteger())
end

function NativeGetPedCategoryAtIndex(ped, index)
    return Citizen.InvokeNative(0x9B90842304C938A7, ped, index, 0)
end
