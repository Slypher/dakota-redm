local Tunnel = module('_core', 'lib/Tunnel')

local Proxy = module('_core', 'lib/Proxy')

local ClientAPI = Proxy.getInterface('API')

local gCam = nil

local gSex = nil

local MaleMustache = json.decode(LoadResourceFile(GetCurrentResourceName(), 'data/MaleMustache.json'))

local MaleHairs = json.decode(LoadResourceFile(GetCurrentResourceName(), 'data/MaleHairs.json'))

local FemaleHairs = json.decode(LoadResourceFile(GetCurrentResourceName(), 'data/FemaleHairs.json'))

RegisterNUICallback('rotate', function(data, cb)

    local VAR = 45.0

    local playerPed = PlayerPedId()

    local addHeading = data['key'] ~= 'left' and VAR or -(VAR)

    local currHeading = GetEntityHeading(playerPed)

    local desiredHeading = GetEntityHeading(playerPed) + addHeading

    if desiredHeading > 360 then
        desiredHeading = desiredHeading - 360.0
    end

    if desiredHeading < 0 then
        desiredHeading = desiredHeading + 360.0
    end

    desiredHeading = desiredHeading + 0.0001

    TaskAchieveHeading(playerPed, desiredHeading, 1000)

    cb('ok')

end)

local gSceneCamera

local function SetLocalPlayerInvisibleLocallyAndForNetwork(bool)
    SetEntityVisible(PlayerPedId(), not bool, false)
end

local function CreateCamera(shop)

    local playerPed = PlayerPedId()

    SetEntityCoordsAndHeading(playerPed, shop.position, shop.heading, false, false, false)

    local gCam = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', vec3(0.0, 0.0, 0.0), vec3(0.0, 0.0, 0.0), 35.00, false, 0)

    SetCamActive(gCam, true)

    RenderScriptCams(true, false, 1, true, true)

    if gSceneCamera then
        DestroyCam(gSceneCamera)
    end

    gSceneCamera = gCam

    SetFocusPosAndVel(shop.position, vec3(0.0, 0.0, 0.0))

    SetCamCoord(gSceneCamera, GetOffsetFromEntityInWorldCoords(playerPed, 0, 1.2, 0.5))

    -- PointCamAtEntity(gSceneCamera, playerPed, 0.0, 0.0, 0.5, false)

    local playerPosition = GetEntityCoords(playerPed)

    PointCamAtCoord(gSceneCamera, playerPosition.x, playerPosition.y - 0.2, playerPosition.z + 0.5)

end

local function FlushScene()

    if gSceneCamera then
        DestroyCam(gSceneCamera, false)
        gSceneCamera = nil
    end

    ClearFocus()

    SetLocalPlayerInvisibleLocallyAndForNetwork(false)

    SetNuiFocus(false, false)

    SendNUIMessage({
        action = 'hide'
    })

end

AddEventHandler('onResourceStop', function(resourceName)

    if (GetCurrentResourceName() ~= resourceName) then
        return
    end

    FlushScene()

end)

CreateThread(function()

    local shops = {
        -- Valentine
        {
            position = vec3(-307.851, 813.354, 118.012),
            heading = -101.76
        },
        -- Blackwater
        {
            position = vec3(-816.572, -1368.756, 42.773),
            heading = -105.00
        },
        {
            position = vec3(-816.724, -1367.107, 42.773),
            heading = -105.00
        }
    }

    while true do

        Wait(0)

        local playerPed = PlayerPedId()

        local playerPosition = GetEntityCoords(PlayerPedId())

        for i = 1, #shops do

            if #(playerPosition - shops[i].position) <= 1.5 then

                DrawTxt('Pressione ALT para abrir a Barbearia.', 0.85, 0.95, 0.35, 0.35, true, 255, 255, 255, 200, true, 10000)

                if IsControlJustReleased(0, 0xE8342FF2) and not ClientAPI.GetWanted() then -- LEFT ALT

                    local playerPedHash = GetEntityModel(playerPed)

                    if playerPedHash == `mp_female` then
                        gSex = 'mp_female'
                    elseif playerPedHash == `mp_male` then
                        gSex = 'mp_male'
                    else
                        gSex = 'other'
                    end

                    CreateCamera(shops[i])

                    SetNuiFocus(true, true)

                    SendNUIMessage({
                        action = 'show',
                        gender = gSex
                    })

                end
            end
        end
    end
end)

local gHairUsing = nil

local gMustacheUsing = nil

RegisterNUICallback('Confirm', function()

    local data = {
        ['mustache'] = gHairUsing,
        ['hair'] = gMustacheUsing
    }

    TriggerServerEvent('FRP:CLOTHES:payClothing', 150, data, true)

    TriggerServerEvent('FRP:CLOTHES:SavePlayerClothing', data, true)

    FlushScene()
end)

RegisterNUICallback('fechar', function()

    TriggerServerEvent('FRP:CLOTHES:fechar', data, true)

    FlushScene()
end)

RegisterNUICallback('BarbaMenu', function(data)
    if tonumber(data.id) == 0 then
        num = 0
        gMustacheUsing = num
        Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0xF8016BCA, 0) -- Set target category, here the hash is for hats
        Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
    else
        if gSex == 'mp_male' then
            for i = 1, #MaleMustache do
                print(MaleMustache[i].componentHash)
                if i == tonumber(data.id) then
                    Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), MaleMustache[i].componentHash, true, true, true)
                    gMustacheUsing = MaleMustache[i].componentHash
                end
            end
        end
    end
end)

RegisterNUICallback('Cabelos', function(data)
    if tonumber(data.id) == 0 then
        num = 0
        gHairUsing = num
        Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x864B03AE, 0) -- Set target category, here the hash is for hats
        Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
    else
        if gSex == 'mp_male' then
            for i = 1, #MaleHairs do
                if i == tonumber(data.id) then
                    Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), MaleHairs[i].componentHash, true, true, true)
                    gHairUsing = MaleHairs[i]
                end
            end
        else
            for i = 1, #FemaleHairs do
                if i == tonumber(data.id) then
                    Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), FemaleHairs[i].componentHash, true, true, true)
                    gHairUsing = FemaleHairs[i].componentHash
                end
            end
        end
    end
end)

function SetEntityCoordsAndHeading(...)
    return Citizen.InvokeNative(0x203BEFFDBE12E96A, ...)
end

function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, 'LITERAL_STRING', str, Citizen.ResultAsLong())
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
    SetTextCentre(centre)
    if enableShadow then
        SetTextDropshadow(1, 0, 0, 0, 255)
    end
    Citizen.InvokeNative(0xADA9255D, 10)
    DisplayText(str, x, y)
end