local showMenu = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        for _, menuConfig in pairs(menuConfigs) do
            if menuConfig:enableMenu() then
                if IsControlJustReleased(0, 0x760A9C6F) then -- G
                    showMenu = true
                    SendNUIMessage({
                        type = 'init',
                        data = menuConfig.data,
                        resourceName = GetCurrentResourceName()
                    })
                    Citizen.InvokeNative(0xFC695459D4D0E219, 0.5, 0.5)
                    SetNuiFocus(true, true)
                    PlaySoundFrontend("BACK", "RDRO_Character_Creator_Sounds", true, 0)

                    while showMenu == true do Citizen.Wait(100) end
                    Citizen.Wait(100)
                    while IsControlPressed(0, keybindControl) do Citizen.Wait(100) end
                end
            end
            if IsControlJustPressed(0, 0xF3830D8E) then
                Citizen.Wait(0)
            
                -- Init UI and set focus
                showMenu = true
                SendNUIMessage({
                    type = 'init',
                    data = subMenuConfigs["submenu1"].data,
                    resourceName = GetCurrentResourceName()
                })
                SetNuiFocus(true, true)
            end
        end
    end
end)



RegisterCommand("submenu1", function(source, args, rawCommand)
    -- Wait for next frame just to be safe
    Citizen.Wait(0)

    -- Init UI and set focus
    showMenu = true
    SendNUIMessage({
        type = 'init',
        data = subMenuConfigs["submenu1"].data,
        resourceName = GetCurrentResourceName()
    })
    SetNuiFocus(true, true)
end, false)

RegisterCommand("submenu2", function(source, args, rawCommand)
    -- Wait for next frame just to be safe
    Citizen.Wait(0)

    -- Init UI and set focus
    showMenu = true
    SendNUIMessage({
        type = 'init',
        data = subMenuConfigs["submenu2"].data,
        resourceName = GetCurrentResourceName()
    })
    SetNuiFocus(true, true)
end, false)

--[[RegisterCommand("submenu3", function(source, args, rawCommand)
    -- Wait for next frame just to be safe
    Citizen.Wait(0)

    -- Init UI and set focus
    showMenu = true
    SendNUIMessage({
        type = 'init',
        data = subMenuConfigs["submenu3"].data,
        resourceName = GetCurrentResourceName()
    })
    SetNuiFocus(true, true)
end, false)

RegisterCommand("submenu4", function(source, args, rawCommand)
    -- Wait for next frame just to be safe
    Citizen.Wait(0)

    -- Init UI and set focus
    showMenu = true
    SendNUIMessage({
        type = 'init',
        data = subMenuConfigs["submenu4"].data,
        resourceName = GetCurrentResourceName()
    })
    SetNuiFocus(true, true)
end, false)

RegisterCommand("submenu5", function(source, args, rawCommand)
    -- Wait for next frame just to be safe
    Citizen.Wait(0)

    -- Init UI and set focus
    showMenu = true
    SendNUIMessage({
        type = 'init',
        data = subMenuConfigs["submenu5"].data,
        resourceName = GetCurrentResourceName()
    })
    SetNuiFocus(true, true)
end, false)

RegisterCommand("submenu6", function(source, args, rawCommand)
    -- Wait for next frame just to be safe
    Citizen.Wait(0)

    -- Init UI and set focus
    showMenu = true
    SendNUIMessage({
        type = 'init',
        data = subMenuConfigs["submenu6"].data,
        resourceName = GetCurrentResourceName()
    })
    SetNuiFocus(true, true)
end, false)

RegisterCommand("submenu7", function(source, args, rawCommand)
    -- Wait for next frame just to be safe
    Citizen.Wait(0)

    -- Init UI and set focus
    showMenu = true
    SendNUIMessage({
        type = 'init',
        data = subMenuConfigs["submenu7"].data,
        resourceName = GetCurrentResourceName()
    })
    SetNuiFocus(true, true)
end, false)]]

-- Callback function for closing menu
RegisterNUICallback('closemenu', function(data, cb)
    -- Clear focus and destroy UI
    showMenu = false
    SetNuiFocus(false, false)
    SendNUIMessage({
        type = 'destroy'
    })

    -- Play sound
    PlaySoundFrontend("BACK", "RDRO_Character_Creator_Sounds", true, 0)

    -- Send ACK to callback function
    cb('ok')
end)

-- Callback function for when a slice is clicked, execute command
RegisterNUICallback('sliceclicked', function(data, cb)
    -- Clear focus and destroy UI
    showMenu = false
    SetNuiFocus(false, false)
    SendNUIMessage({
        type = 'destroy'
    })

    -- Play sound
    PlaySoundFrontend("BACK", "RDRO_Character_Creator_Sounds", true, 0)

    -- Run command
    ExecuteCommand(data.command)

    -- Send ACK to callback function
    cb('ok')
end)

RegisterCommand('closeradial', function(data, cb)

    showMenu = false
    SendNUIMessage({
        type = 'destroy'
    })
    SetNuiFocus(false, false)

end)

local MENU_COMMAND_TO_COMPONENTCATEGORY_HASH = {
    ['chapeu']       = 0x9925C067,
    ['camisa']       = 0x2026C46D,
    ['suspensorios'] = 0x877A2CF7,
    ['colete']       = 0x485EE834,
    ['gravatas']     = 0x7A96FACA,
    ['lencos']       = 0x5FC29285,
    ['calca']        = 0x1D4C528A,
    ['chaps']        = 0x3107499B,
    ['polainas']     = 0x514ADCEA,
    ['esporas']      = 0x18729F39,
    ['botas']        = 0x777EC6EF,
    ['luvas']        = 0xEABE0032,
    ['casaco']       = 0xE06D30CE,
    ['casacof']      = 0x662AC34,
    ['poncho']       = 0xAF14310B,
    ['capas']        = 0x3C1A74CD,
    ['coldre']       = 0x9B2C8B89,
    ['coldre2']      = 0xB6B6122D,
    ['cinto']        = 0xA6D134C6,
    ['fivela']       = 0xFAE9107F,
    ['cartucheira']  = 0x3F1F01E5,
    ['acessorio']    = 0x79D7DF96,
    ['bracelete']    = 0x7BC10759,
    ['manoplas']     = 0x91CE9B20,
    ['olhos']        = 0x5E47CA6,
    ['aneis']        = { 0x7A6BBD0B, 0xF16A1D23 },
}

do
    for commandName, componentCategoriesOrHash in pairs(MENU_COMMAND_TO_COMPONENTCATEGORY_HASH) do
        RegisterCommand(commandName, function()

            if type(componentCategoriesOrHash) == 'table' then
                for _, categoryHash in ipairs(componentCategoriesOrHash) do
                    cacheOrApplyComponentByCategory(categoryHash)
                end
            else
                cacheOrApplyComponentByCategory(componentCategoriesOrHash)
            end
        end)
    end
end

local gHiddenClothingComponentsCache = { }

function cacheOrApplyComponentByCategory(componentHash)
    local playerPed = PlayerPedId()

    if not applyComponentOfCategoryFromCache(playerPed, componentHash) then
        -- Player não tem nenhum componente dessa categoria em cache,
        -- então a gente joga o componte atual para o cache e remove ele.
        cacheAndRemoveComponentByCategory(playerPed, componentHash)
    end
end

function getComponentByCategory(ped, categoryHash)
    -- GetNumComponentsInPed
    local numMetaAssets = Citizen.InvokeNative(0x90403E8107B60E81, ped)

    if numMetaAssets <= 0 then
        return
    end

    -- GetMetaPedType
    local metaPedType = Citizen.InvokeNative(0xEC9A1261BF0CE510, ped)

    for i = 0, numMetaAssets - 1 do

        -- GetPedComponentAtIndex
        local shopItemHash = exports['frp_clothes']:GetPedComponentAtIndex(ped, i) -- Citizen.InvokeNative(0x77BA37622E22023B, ped, i, true, Citizen.PointerValueInt(), Citizen.PointerValueInt())

        -- GetPedComponentCategory
        local shopItemCategoryHash = Citizen.InvokeNative(0x5FF9A878C3D115B8, shopItemHash, metaPedType, true)

        -- UNSIGNED
        if shopItemCategoryHash and (shopItemCategoryHash & 0xFFFFFFFF) == categoryHash then
            return shopItemHash
        end
    end

    return
end

function applyComponentOfCategoryFromCache(ped, categoryHash)
    local shopItemHashOfCategory = getComponentByCategory(ped, categoryHash)

    -- Não aplicar o cache caso o player esteja usando um componente
    if shopItemHashOfCategory then
        return false
    end

    local shopItemHash = gHiddenClothingComponentsCache[categoryHash]
    if shopItemHash then
        
        -- ApplyShopItemToPed
        Citizen.InvokeNative(0xD3A7B003ED343FD9, ped, shopItemHash, true, true, true)

        -- UpdatePedVariation
        Citizen.InvokeNative(0xCC8CA3E88256E58F, ped, 0, 1, 1, 1, 0)

        -- Remover do cache :)
        gHiddenClothingComponentsCache[categoryHash] = nil

        return true
    end

    return false
end

function cacheAndRemoveComponentByCategory(ped, categoryHash)
    local shopItemHashOfCategory = getComponentByCategory(ped, categoryHash)

    if not shopItemHashOfCategory then
        return false
    end

    gHiddenClothingComponentsCache[categoryHash] = shopItemHashOfCategory

    -- RemoveTagFromMetaPed
    Citizen.InvokeNative(0xD710A5007C2AC539, ped, categoryHash, 0)

    -- UpdatePedVariation
    Citizen.InvokeNative(0xCC8CA3E88256E58F, ped, 0, 1, 1, 1, 0)

    return true
end

--[[


0x15D3C7F2=Goatees,
0x1AECF7DC=Unknown,
0xA0E3AB7F=Skirts,
0x3F7F3587=Badges,
0x49C89D9B=Guns,
0x4A73515C=Masks,
0x7505EF42=Masks2,
0x76F0E272=Aprons,
0x7BE77792=Sheaths,
0x7C00A8F0=Unknown,
0x823687F5=Legs,
0xF1542D11=Leg, 
0x83887E88=Loadouts,
0x8EFB276A=Unknown,
0x94504D26=Satchels,
0xB6B63737 = Sideburns, -- Patte barbe
0xB9E2FA01=PrimaryHolsters,
0xDA0E2C55=BandoilerAmmunition,
0xDB64A390=Unknown,
0x72E6EF74=Armor, 
}]]


