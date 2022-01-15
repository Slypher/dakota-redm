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
    

    -- HOTEL VALENTINE
    CreatePedWithAudio(`U_M_Y_CzPHomesteadSon_01`, vec3(-325.825, 773.059, 116.436), 20.0)

    -- DOCTOR VALENTINE
    CreatePedWithAudio(`U_M_M_ValDoctor_01`, vec3(-287.991, 804.201, 118.386), 290.0)

    -- PRISIONEIRO VALENTINE
    CreatePedWithAudio(`S_M_M_ValCowpoke_01`, vec3(-271.402,806.932,118.371), 45.0)


--------------------------------------MINERADOR------------------------------------------------

-- FRANCIS
CreatePedWithAudio(`CS_SCOTTGRAY`, vec3(-363.320,799.896,115.280), 183.95)

--------------------------------------LENHADOR------------------------------------------------

-- CASTOR
CreatePedWithAudio(`CS_adamgray`, vec3(-857.451,-1279.038,42.581), 268.83)

--------------------------------------TRIBO------------------------------------------------

-- INDIO
CreatePedWithAudio(`CS_rainsfall`, vec3(437.505,2229.940,247.199), -88.16)

--------------------------------------ESTAÇÃO------------------------------------------------

    -- ESTAÇÃO VALENTINE
    CreatePedWithAudio(`U_M_M_TUMTRAINSTATIONWORKER_01`, vec3(-177.991,628.086,113.111), 149.19)
    -- ESTAÇÃO BLACKWATER
    CreatePedWithAudio(`U_M_M_BlWTrainStationWorker_01`, vec3(-875.065,-1327.072,42.990), 179.28)

--------------------------------------ARMEIROS------------------------------------------------

    -- ARMEIRO VALENTINE
    CreatePedWithAudio(`U_M_M_ValGunsmith_01`, vec3(-281.688,778.874,118.526), 359.29)

--------------------------------------SALOON------------------------------------------------

    -- SALOON VALENTINE
    CreatePedWithAudio(`U_M_M_TumBartender_01`, vec3(-313.366, 805.996, 117.955), 267.0)

--------------------------------------BANCOS------------------------------------------------

    -- BANCO BLACKWATER
    CreatePedWithAudio(`S_M_M_BankClerk_01`, vec3(-811.979,-1275.361,42.659), 183.42)

    -- BANCO VALENTINE
    CreatePedWithAudio(`U_M_O_BHT_DOCWORMWOOD`, vec3(-308.108, 773.999, 117.703), 20.0)

    -- BANCO RHODES
    CreatePedWithAudio(`CS_ansel_atherton`, vec3(1290.702,-1302.781,76.036), -12.24)

    -- BANCO SAINT DENIS
    CreatePedWithAudio(`A_M_M_SDObesemen_01`, vec3(2645.090,-1294.786,51.242), 22.0)

--------------------------------------BARBEIROS------------------------------------------------

    -- BARBEIRO BLACKWATER
    CreatePedWithAudio(`S_M_M_Barber_01`, vec3(-814.732,-1367.929,42.773), 87.99)

    -- BARBEIRO VALENTINE
    CreatePedWithAudio(`U_M_M_ValBarber_01`, vec3(-306.825,814.289,118.003), 160.37)

--------------------------------------ARMAZENS------------------------------------------------

    -- ARMAZÉM STRAWBERRY
    CreatePedWithAudio(`U_M_M_SKINNYOLDGUY_01`, vec3(-1789.913,-388.400,159.350), 45.0)

    -- ARMAZEM VALENTINE
    CreatePedWithAudio(`U_F_M_LAGMOTHER_01`, vec3(-323.996,803.384,116.903), 284.37)

    -- ARMAZEM BLACKWATER
    CreatePedWithAudio(`CS_watson_03`, vec3(-784.224,-1322.123,42.906), 179.86)
    
--------------------------------------AÇOUGUES------------------------------------------------
    -- AÇOUGUE STRAWBERRY
    CreatePedWithAudio(`S_M_M_UNIBUTCHERS_01`, vec3(-1753.029,-392.859,155.265), 184.54)

    -- AÇOUGUE VALENTINE
    CreatePedWithAudio(`U_M_M_VALBUTCHER_01`, vec3(-339.258,767.518,115.601), 101.22)

    -- AÇOUGUE BLACKWATER
    CreatePedWithAudio(`U_M_M_TumButcher_01`, vec3(-753.067,-1284.851,42.496), 268.86)

--------------------------------------LOJA DE INSUMOS------------------------------------------------
    -- VENDA DE INSUMOS
    CreatePedWithAudio(`CS_AberdeenPigFarmer`, vec3(1363.859,-1288.305,76.123), -102.83)

--------------------------------------ALFAIATARIA------------------------------------------------
    -- Alfaiataria de Saint Denis
    CreatePedWithAudio(`A_F_M_SDObeseWomen_01`, vec3(2554.386,-1166.607,52.684), 89.76)

--------------------------------------MOONSHINER------------------------------------------------
    -- MOONSHINER NEVE
    CreatePedWithAudio(`CS_famousgunslinger_02`, vec3(-1884.865,1335.750,199.918), -160.75)

-----------------------------------------CAPITÃO------------------------------------------------
    -- CAPITÃO PESCADOR
    CreatePedWithAudio(`CS_BeatenUpCaptain`, vec3(399.243,-1269.337,40.715), 83.72)

-----------------------------------------CLIVE------------------------------------------------
    -- CLIVE
    CreatePedWithAudio(`CS_dalemaroney`, vec3(-333.095,186.375,62.590),-67.22)

-----------------------------------------COLECIONADORA------------------------------------------------
    -- TIA MAGGIE
    CreatePedWithAudio(`CS_mrsgeddes`, vec3(-1676.415,-341.063,169.785), -120.00)

end)

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        
        for _, ped in ipairs(gAudioPeds) do
            DeleteEntity(ped)
        end
    end
end)