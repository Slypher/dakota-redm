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

-- FRANCIS          G_M_M_UniGrays_01
CreatePedWithAudio(`G_M_M_UniGrays_01`, vec3(-363.320,799.896,115.280), 183.95)
CreatePedWithAudio(`CS_SCOTTGRAY`, vec3(-865.743,-1390.978,42.569), 103.29)

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
    CreatePedWithAudio(`U_M_M_TumGunsmith_01`, vec3(-5506.516,-2963.867,-1.571), 102.33)-- Tumbleweed

--------------------------------------SALOON------------------------------------------------

    -- SALOON VALENTINE
    CreatePedWithAudio(`U_M_M_ValBarber_01`, vec3(-313.366, 805.996, 117.955), 267.0)
    CreatePedWithAudio(`U_M_M_TumBartender_01`, vec3(-817.864,-1318.892,42.679), -96.26)
    CreatePedWithAudio(`CS_rhodessaloonbouncer`, vec3(1340.119,-1374.981,79.546), -95.41)
    CreatePedWithAudio(`U_M_M_BHT_BANDITOMINE`, vec3(-3699.800,-2596.091,-14.255), 88.68)
    CreatePedWithAudio(`U_M_O_BlWBartender_01`, vec3(-5518.199,-2906.305,-2.686), -150.92)
    

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

    -- ARMAZEM RHODES
    CreatePedWithAudio(`U_F_M_EMRDAUGHTER_01`, vec3(1329.695,-1294.477,76.087), 63.60)

    -- ARMAZEM ARMADILLO
    CreatePedWithAudio(`CS_DrMalcolmMacIntosh`, vec3(-3687.323,-2623.488,-14.422), -87.37)

    -- ARMAZEM TUMBLEWEED
    CreatePedWithAudio(`U_F_M_LagMother_01`, vec3(-5485.805,-2938.221,-1.334), 128.16)
    
--------------------------------------AÇOUGUES------------------------------------------------
    -- AÇOUGUE STRAWBERRY
    CreatePedWithAudio(`S_M_M_UNIBUTCHERS_01`, vec3(-1753.029,-392.859,155.265), 184.54)

    -- AÇOUGUE VALENTINE
    CreatePedWithAudio(`U_M_M_VALBUTCHER_01`, vec3(-339.258,767.518,115.601), 101.22)

    -- AÇOUGUE BLACKWATER
    CreatePedWithAudio(`U_M_M_TumButcher_01`, vec3(-753.067,-1284.851,42.496), 268.86)

    -- AÇOUGUE TUMBLEWEED
    CreatePedWithAudio(`U_M_O_PSHRancher_01`, vec3(-5509.960,-2947.104,-2.829), -111.94)

--------------------------------------LOJA DE INSUMOS------------------------------------------------
    -- VENDA DE INSUMOS
    CreatePedWithAudio(`CS_AberdeenPigFarmer`, vec3(1436.071,332.756,87.748), -135.16)
--------------------------------------MOINHOS------------------------------------------------
    -- Eva
    CreatePedWithAudio(`CS_ROCKYSEVEN_WIDOW`, vec3(1056.941,-1127.715,66.898),158.43)
    -- Kab
    CreatePedWithAudio(`CS_creolecaptain`, vec3(-947.695,-1336.027,49.693), -162.43)

--------------------------------------ALFAIATARIA------------------------------------------------
    -- Alfaiataria de Saint Denis
    CreatePedWithAudio(`A_F_M_SDObeseWomen_01`, vec3(2554.386,-1166.607,52.684), 89.76)

--------------------------------------MOONSHINER------------------------------------------------
    -- MOONSHINER NEVE
    CreatePedWithAudio(`CS_famousgunslinger_02`, vec3(-1358.562,2427.654,307.930), 170.22)

-----------------------------------------CAPITÃO------------------------------------------------
    -- CAPITÃO PESCADOR
    CreatePedWithAudio(`CS_BeatenUpCaptain`, vec3(-1356.928,-2290.907,45.199), 83.72)

-----------------------------------------CLIVE------------------------------------------------
    -- CLIVE
    CreatePedWithAudio(`CS_dalemaroney`, vec3(-333.095,186.375,62.590),-67.22)

-----------------------------------------COLECIONADORA------------------------------------------------
    -- TIA MAGGIE
    CreatePedWithAudio(`CS_mrsgeddes`, vec3(-1676.415,-341.063,169.785), -120.00)
    -- JOIAS
    CreatePedWithAudio(`CS_EXOTICCOLLECTOR`, vec3(2586.457,-1011.329,43.249), -79.48)

end)

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        
        for _, ped in ipairs(gAudioPeds) do
            DeleteEntity(ped)
        end
    end
end)