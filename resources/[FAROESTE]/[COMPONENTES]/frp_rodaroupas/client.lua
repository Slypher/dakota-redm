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

RegisterCommand("submenu3", function(source, args, rawCommand)
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
end, false)

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

RegisterCommand ('chapeu', function (data, cb)
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x9925C067, 0) -- Target Category Hat
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
end)
RegisterCommand ('camisa', function (data, cb)
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x2026C46D, 0) -- Target Category shirt
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
end)
RegisterCommand ('suspensorios', function (data, cb)
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x877A2CF7, 0) -- Target Category shirt
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
end)
RegisterCommand ('colete', function (data, cb)
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x485EE834, 0) -- Target Category shirt
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
end)
RegisterCommand ('gravatas', function (data, cb)
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x7A96FACA, 0) -- Target Category shirt
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
end)
RegisterCommand ('lencos', function (data, cb)
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x5FC29285, 0) -- Target Category shirt
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
end)
RegisterCommand ('calca', function (data, cb)
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x1D4C528A, 0) -- Target Category shirt
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
end)
RegisterCommand ('chaps', function (data, cb)
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x3107499B, 0) -- Target Category shirt
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
end)
RegisterCommand ('polainas', function (data, cb)
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x514ADCEA, 0) -- Target Category shirt
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
end)
RegisterCommand ('esporas', function (data, cb)
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x18729F39, 0) -- Target Category shirt
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
end)
RegisterCommand ('botas', function (data, cb)
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x777EC6EF, 0) -- Target Category shirt
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
end)
RegisterCommand ('luvas', function (data, cb)
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0xEABE0032, 0) -- Target Category shirt
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
end)
RegisterCommand ('casaco', function (data, cb)
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0xE06D30CE, 0) -- Target Category shirt
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
end)
RegisterCommand ('casacof', function (data, cb)
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x662AC34, 0) -- Target Category shirt
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
end)
RegisterCommand ('poncho', function (data, cb)
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0xAF14310B, 0) -- Target Category shirt
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
end)
RegisterCommand ('capas', function (data, cb)
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x3C1A74CD, 0) -- Target Category shirt
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
end)
RegisterCommand ('coldre', function (data, cb)
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x9B2C8B89, 0) -- Target Category shirt
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
end)
RegisterCommand ('coldre2', function (data, cb)
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0xB6B6122D, 0) -- Target Category shirt
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
end)
RegisterCommand ('cinto', function (data, cb)
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0xA6D134C6, 0) -- Target Category shirt
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
end)
RegisterCommand ('fivela', function (data, cb)
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0xFAE9107F, 0) -- Target Category shirt
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
end)
RegisterCommand ('cartucheira', function (data, cb) -- Munições que ficam penduradas no personagem
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x3F1F01E5, 0) -- Target Category shirt
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
end)
RegisterCommand ('acessorio', function (data, cb) -- Munições que ficam penduradas no personagem
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x79D7DF96, 0) -- Target Category shirt
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
end)
RegisterCommand ('bracelete', function (data, cb) -- Munições que ficam penduradas no personagem
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x7BC10759, 0) -- Target Category shirt
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
end)
RegisterCommand ('manoplas', function (data, cb) -- Munições que ficam penduradas no personagem
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x91CE9B20, 0) -- Target Category shirt
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
end)
RegisterCommand ('olhos', function (data, cb) -- Munições que ficam penduradas no personagem
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x5E47CA6, 0) -- Target Category shirt
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
end)
RegisterCommand ('aneis', function (data, cb) -- Munições que ficam penduradas no personagem
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x7A6BBD0B, 0) -- Target Category shirt
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0xF16A1D23, 0) -- Target Category shirt
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
end)


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


