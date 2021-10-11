local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

cAPI = Proxy.getInterface("API")
API = Tunnel.getInterface("API")

local FirstSpawn = false

local gStageCoachVehicle
local gCoachDriverPed

local gPopulationBudgedMultiplierCache

local END_POSITION = vector3(-352.705, 787.453, 116.041)

RegisterNetEvent("FRP:CREATOR:FirstSpawn")
AddEventHandler(
    "FRP:CREATOR:FirstSpawn",
    function()
        if not FirstSpawn and Config.EnableCutscene then
            TriggerMusicEvent("REHR_START")

            TriggerEvent('hideBasicNeedsUI')

            local playerPed = PlayerPedId()

            SetEntityInvincible(playerPed, true)

            while IsScreenFadingIn() do
                Wait(0)
            end

            DoScreenFadeOut(500)

            while IsScreenFadingOut() do
                Wait(0)
            end

            TriggerServerEvent('PersonaCreatorHandler.setPlayerRoutingBucket')

            -- Desabilitar a população por aqui por enquanto, parece que a native
            -- especifica para routing bucket não funciona.

            -- GetPopulationBudgetMultiplier
            gPopulationBudgedMultiplierCache = Citizen.InvokeNative(0x8A3945405B31048F, Citizen.ResultAsFloat())

            -- SetPopulationBudgetMultiplier
            Citizen.InvokeNative(0x2F9AC754FE179D58, 0.0)

            StartPlayerTeleport(PlayerId(), 2520.09, -358.05, 41.61, 0.0, false, true, true, false --[[ bDisableSeamlessTeleport ]])

            local hasFinishedTeleporting = false
            local hasFinishedRenderingEntities = false

            local function afterLoad()
                if FirstSpawn then
                    return
                end

                DoScreenFadeIn(1000)

                SetPedIntoVehicle(playerPed, gStageCoachVehicle, 1)

                -- Parece que nem funciona essa native em peds :?
                SetEntityHealth(playerPed, 20)

                -- SetAttributeCoreValue
                Citizen.InvokeNative(0xC6258F41D86676E0, playerPed, 0, 1)
    
                TriggerEvent('FRP:CREATOR:StartNotify')
                
                FirstSpawn = true

                createThreadShowHelperAudioAndText()
            end
            
            -- Não bloquear o teleporte.
            CreateThread(function()
                createStageCoachVehicle()
                createCoachDriverPed()

                hasFinishedRenderingEntities = true

                if hasFinishedTeleporting then
                    afterLoad()
                end
            end)

            while IsPlayerTeleportActive() do
                Wait(0)
            end

            hasFinishedTeleporting = true

            if hasFinishedRenderingEntities then
                afterLoad()
            end
        else            
            TriggerEvent('FRP:CREATOR:StartNotify')

            SetEntityCoords(playerPed, Config.FirstSpawnCoords)

            FirstSpawn = false
        end
    end
)

function createThreadShowHelperAudioAndText()
    while true do
        Wait(10)
        
        local playerPed = PlayerPedId()
        local playerPos = GetEntityCoords(playerPed)

        if #(END_POSITION - playerPos) <= 10.0 then
            RemovePedFromGroup(gCoachDriverPed, GetPedGroupIndex(playerPed))

            Wait(100)

            DisableAllControlActions(0)                  
            SetCinematicModeActive(0)

            N_0x69d65e89ffd72313(false)   

            Wait(1000)

            TaskLeaveVehicle(playerPed, gStageCoachVehicle, 0, 0)

            SetEntityInvincible(playerPed, false)

            TriggerServerEvent('PersonaCreatorHandler.setPlayerToGlobalRoutingBucket')

            -- SetPopulationBudgetMultiplier
            Citizen.InvokeNative(0x2F9AC754FE179D58, gPopulationBudgedMultiplierCache)
            gPopulationBudgedMultiplierCache = nil

            TriggerEvent('showBasicNeedsUI')

            Wait(2000)              

            -- Old driving style: 67633207
            TaskVehicleDriveToCoord(gCoachDriverPed, GetVehiclePedIsIn(gCoachDriverPed, false), 2600.436, -1205.932, 53.323, 10.0, 1.0, GetEntityModel(GetVehiclePedIsIn(playerPed)), 262708, 5.0, false)
            
            TriggerEvent('FRP:NOTIFY:Simple', 'Sua viagem foi longa, voce nao esta muito bem, dirija-se ao banco para sacar o dinheiro para pagar seu tratamento...', 10000)
            TriggerEvent("vrp_sound:source", 'Intro6', 0.55)
            TriggerMusicEvent("MC_MUSIC_STOP") 

            Wait(10000)
            
            --  TriggerEvent('FRP:NOTIFY:Simple', 'Digite /guiainiciante ver o Jornal Guia de Iniciante.', 10000)
            DeleteVehicle(gStageCoachVehicle)
            DeleteEntity(gCoachDriverPed)

            break
        else               
            N_0x69d65e89ffd72313(true)
            SetCinematicModeActive(1)
            DisableAllControlActions(1)
        end 
    end
end

function createStageCoachVehicle()
    local modelHash = `STAGECOACH001X`
    if not HasModelLoaded(modelHash) then
        RequestModel(modelHash)

        while not HasModelLoaded(modelHash) do
            Wait(0)
        end
    end

    gStageCoachVehicle = CreateVehicle(modelHash, 74.183,93.763,103.161, true, false)
    SetModelAsNoLongerNeeded(modelHash)

    SetVehicleOnGroundProperly(gStageCoachVehicle)
end

local soundDistanceMax = 8.0

RegisterNetEvent("FRP:CREATOR:StartNotify")
AddEventHandler(
	"FRP:CREATOR:StartNotify",
    function()
        Wait(15000)
        TriggerEvent('FRP:NOTIFY:Simple', 'Seja muito bem vindo ao condado de Dakota.', 5000)
        TriggerEvent("vrp_sound:source",'Intro1',0.55)
        Wait(6000)
        TriggerEvent('FRP:NOTIFY:Simple', 'Atente-se as leis para que você não tenha problemas com as autoridades.', 6000)
        TriggerEvent("vrp_sound:source",'Intro2',0.55)
        Wait(9000)
        TriggerEvent('FRP:NOTIFY:Simple', 'Tome muito cuidado ao vagar pelas estradas, florestas e becos. Principalmente a noite... há muitos perigos te aguardando nestes locais.', 9000)
        TriggerEvent("vrp_sound:source",'Intro3',0.55)
        Wait(20000)
        TriggerEvent('FRP:NOTIFY:Simple', 'Esta é Valentine, a primeira cidade que você irá conhecer. Aqui você encontrará tudo o que precisa para começar a sua história.', 10000)
        TriggerEvent("vrp_sound:source",'Intro4',0.55)
        Wait(12000)
        TriggerEvent('FRP:NOTIFY:Simple', 'Este condado é repleto de surpresas. Uma região rica em fauna, flora e cultura. Onde você poderá facilmente encontrar meios de cumprir seus objetivos e ambições. Tenha uma excelente estadia!', 12000)
        TriggerEvent("vrp_sound:source",'Intro5',0.55)
    end)


function StopSoundJS(sound)
    SendNUIMessage({ event = 'stopSound', sound = sound})
end

function createCoachDriverPed()
    local modelHash = `CS_BivCoachDriver`

    if not HasModelLoaded(modelHash) then
        RequestModel(modelHash)

        while not HasModelLoaded(modelHash) do
            Citizen.Wait(0)
        end
    end
    
    local playerPed = PlayerPedId()

    gCoachDriverPed = CreatePed(modelHash, END_POSITION, GetEntityHeading(playerPed), false, 0)     
    SetModelAsNoLongerNeeded(modelHash)
    
    -- SetRandomOutfitVariation
    Citizen.InvokeNative(0x283978A15512B2FE, gCoachDriverPed, true)

    -- PlaceEntityOnGroundProperly
    Citizen.InvokeNative(0x9587913B9E772D29, gCoachDriverPed, true)
    
    SetEntityNoCollisionEntity(playerPed, gCoachDriverPed, false)
    SetEntityCanBeDamaged(gCoachDriverPed, false)
    SetEntityInvincible(gCoachDriverPed, true)

    -- Wait(1000)

    SetBlockingOfNonTemporaryEvents(gCoachDriverPed, true)
    SetEntityAsMissionEntity(gCoachDriverPed)

    -- Wait(150)

    SetPedAsGroupMember(gCoachDriverPed, GetPedGroupIndex(playerPed))
    
    SetEntityAsMissionEntity(gStageCoachVehicle, false, false)
    SetEntityAsMissionEntity(gCoachDriverPed, false, false)
    
    SetRelationshipBetweenGroups(1 , `PLAYER`, GetPedRelationshipGroupHash(gCoachDriverPed))

    SetPedIntoVehicle(gCoachDriverPed, gStageCoachVehicle, -1)
    
    TaskVehicleDriveToCoord(gCoachDriverPed, GetVehiclePedIsIn(gCoachDriverPed, false), END_POSITION, 10.0, 1.0, modelHash, 67633207, 5.0, false)
    
    -- SetPedKeepTask
    Citizen.InvokeNative(0x971D38760FBC02EF, gCoachDriverPed, true)
    
    -- IsPedReadyToRender
    while not Citizen.InvokeNative(0xA0BC8FAED8CFEB3C, gCoachDriverPed) do
        Wait(0)
    end

    -- Wait(250)
end

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        DeleteEntity(gStageCoachVehicle)
        DeleteEntity(gCoachDriverPed)

        SetEntityInvincible(PlayerPedId(), false)

        TriggerEvent('showBasicNeedsUI')
    end
end)