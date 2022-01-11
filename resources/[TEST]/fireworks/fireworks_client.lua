smokeduration = 10 --Duration of colored smoke in seconds

fireworklist = {}
coloredsmoke = {}

RegisterCommand('firework', function()
    pedcoords = GetEntityCoords(PlayerPedId())
    TriggerServerEvent('fireworks:MakeAmericaGreatAgain', pedcoords)
end)
RegisterCommand('usa', function()
    local ped = PlayerPedId()
    local smokecoords = {
        {['location'] = vector3(GetOffsetFromEntityInWorldCoords(ped,  2.0,0.0,-2.0)), ['rgb']=vector3(1.0,0.0,0.0)},--red
        {['location'] = vector3(GetOffsetFromEntityInWorldCoords(ped,  0.0,0.0,-2.0)), ['rgb']=vector3(1.0,1.0,1.0)},--white
        {['location'] = vector3(GetOffsetFromEntityInWorldCoords(ped, -2.0,0.0,-2.0)), ['rgb']=vector3(0.0,0.0,1.0)},--blue
    }
    TriggerServerEvent('fireworks:USA-USA-USA', smokecoords)
end)

--Firework Inventory Item Script
RegisterNetEvent('fireworks:firework')
AddEventHandler('fireworks:firework', function(coords)
    print(coords)
    RequestNamedPtfxAsset(GetHashKey('scr_ind1'))
    while not HasNamedPtfxAssetLoaded(GetHashKey('scr_ind1')) do
        Wait(10)
        print('waiting on ptfx')
    end
    UseParticleFxAsset('scr_ind1')
    fireworks = StartParticleFxLoopedAtCoord('scr_ind1_firework', coords, 0.0,0.0,0.0, 0.25, false, false, false, true) --the 0.25 here is scale
    UseParticleFxAsset('scr_ind1')
    groundeffects = StartParticleFxLoopedAtCoord('scr_ind1_firework_lights', coords+vector3(0.0,0.0,2.0), 0.0,0.0,0.0, 2.0, false, false, false, true)
    Citizen.InvokeNative(0x9DDC222D85D5AF2A, fireworks, 10.0)
    Citizen.InvokeNative(0x9DDC222D85D5AF2A, groundeffects, 10.0)
    SetParticleFxLoopedAlpha(fireworks, 1.0)
    SetParticleFxLoopedAlpha(groundeffects, 1.0)
    table.insert(fireworklist, fireworks)
    table.insert(fireworklist, groundeffects)
    SetParticleFxLoopedColour(groundeffects, 1.0,0.0,1.0, false)
    Wait(1000)
    SetParticleFxLoopedColour(groundeffects, 0.0,0.0,1.0, false)
    Wait(1000)
    SetParticleFxLoopedColour(groundeffects, 1.0,0.0,0.0, false)
    Wait(1000)
    SetParticleFxLoopedColour(groundeffects, 0.0,1.0,0.0, false)
    Wait(1000)
    SetParticleFxLoopedColour(groundeffects, 0.0,1.0,1.0, false)
    Wait(1000)
    for k,v in pairs(fireworklist) do
        StopParticleFxLooped(v, true)
    end
end)

RegisterNetEvent('fireworks:popsmoke')
AddEventHandler('fireworks:popsmoke', function(locations)
    RequestNamedPtfxAsset(GetHashKey('SCR_ADV_SOK'))
    while not HasNamedPtfxAssetLoaded(GetHashKey('SCR_ADV_SOK')) do
        Wait(10)
        print('waiting on ptfx')
    end
    for k,v in pairs(locations) do
        PopSmoke(v.location, v.rgb)
    end
    Wait(smokeduration*1000)
    for k,v in pairs(coloredsmoke) do
        StopParticleFxLooped(v, true)
    end
end)

function PopSmoke(location, rgb)
    UseParticleFxAsset("SCR_ADV_SOK")
    smoke = StartParticleFxLoopedAtCoord("scr_adv_sok_torchsmoke", location, 0.0,0.0,0.0, 3.0, false, false, false, true)
    Citizen.InvokeNative(0x9DDC222D85D5AF2A, smoke, 10.0)
    SetParticleFxLoopedAlpha(smoke, 1.0)
    SetParticleFxLoopedColour(smoke, rgb, false)
    table.insert(coloredsmoke, smoke)
end