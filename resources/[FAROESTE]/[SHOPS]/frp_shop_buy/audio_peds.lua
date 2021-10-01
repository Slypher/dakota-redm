local gAudioPeds = { }

function CreatePedWithAudio(modelHash, position, heading)
    RequestModel(modelHash)
    
    while not HasModelLoaded(modelHash) do
        Wait(0)
    end

    local ped = CreatePed(modelHash, position, heading, false, true)
    Citizen.InvokeNative(0x283978A15512B2FE, ped, true)

    FreezeEntityPosition(ped,true)
    SetEntityInvincible(ped,true)
    SetBlockingOfNonTemporaryEvents(ped,true)

    table.insert(gAudioPeds, ped)
end

Citizen.CreateThread(function()
    -- SALOON VALENTINE
    CreatePedWithAudio(`U_M_M_TumBartender_01`, vec3(-313.366, 805.996, 117.955), 267.0)

    -- ARMAZEM VALENTINE
    CreatePedWithAudio(`U_F_M_TumGeneralStoreOwner_01`, vec3(-324.078,804.157,116.882), 289.0)

    -- HOTEL VALENTINE
    CreatePedWithAudio(`U_M_Y_CzPHomesteadSon_01`, vec3(-325.825, 773.059, 116.436), 20.0)

    -- BANCO VALENTINE
    CreatePedWithAudio(`U_M_O_BHT_DOCWORMWOOD`, vec3(-308.108, 773.999, 117.703), 20.0)

    -- DOCTOR VALENTINE
    CreatePedWithAudio(`U_M_M_ValDoctor_01`, vec3(-287.991, 804.201, 118.386), 290.0)

    -- PRISIONEIRO VALENTINE
    CreatePedWithAudio(`S_M_M_ValCowpoke_01`, vec3(-271.402,806.932,118.371), 45.0)
end)

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        
        for _, ped in ipairs(gAudioPeds) do
            DeleteEntity(ped)
        end
    end
end)