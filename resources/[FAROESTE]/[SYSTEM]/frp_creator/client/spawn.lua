local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

cAPI = Proxy.getInterface("API")
API = Tunnel.getInterface("API")

local FirstSpawn = false

local car = nil
local ped = nil

local coordsSpawn = vector3(-284.436,796.012,118.737)

RegisterNetEvent("FRP:CREATOR:FirstSpawn")
AddEventHandler(
    "FRP:CREATOR:FirstSpawn",
    function()
        if not FirstSpawn and Config.EnableCutscene then
            TriggerMusicEvent("REHR_START")
            NetworkSetEntityInvisibleToNetwork(PlayerPedId(), true)           
            Wait(100)
            SetEntityCoords(PlayerPedId(), 2520.09,-358.05,41.61)
            Wait(2500)
            TriggerEvent('FRP:CREATOR:CreateVehicle', 'STAGECOACH001X')
            Wait(1000)
            TriggerEvent('FRP:CREATOR:CreatePedOnVehicle', 'CS_BivCoachDriver')
            Wait(3000)
            SetPedIntoVehicle(PlayerPedId(), car, 1)
            Wait(2000)               
            TriggerEvent('FRP:CREATOR:StartNotify')
            Wait(2000) 
            SetEntityHealth(PlayerPedId(), 20)
            FirstSpawn = true
        else            
            TriggerEvent('FRP:CREATOR:StartNotify')            
            SetEntityCoords(PlayerPedId(), Config.FirstSpawnCoords)
            FirstSpawn = false
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            Wait(10)
            if FirstSpawn then	
                local pcoords = GetEntityCoords(PlayerPedId())                
                local dst = #(coordsSpawn - pcoords)	   
                if dst < 5 then
                    RemovePedFromGroup(ped, GetPedGroupIndex(PlayerPedId()))
                    Wait(100)
                    DisableAllControlActions(0)                  
                    NetworkSetEntityInvisibleToNetwork(PlayerPedId(), false)
                    SetEntityInvincible(PlayerPedId(), false)  
                    SetCinematicModeActive(0)                    
                    FirstSpawn = false
                    N_0x69d65e89ffd72313(false)    
                    Wait(1000)
                    TaskLeaveVehicle(PlayerPedId(), car, 0, 0) 
                    Wait(2000)                         
                    TaskVehicleDriveToCoord(ped, GetVehiclePedIsIn(ped, false), 2600.436,-1205.932,53.323, 10.0, 1.0, GetEntityModel(GetVehiclePedIsIn(PlayerPedId())), 67633207, 5.0, false)
                    TriggerEvent('FRP:NOTIFY:Simple', 'Sua viagem foi longa, voce nao esta muito bem, dirija-se ao banco para sacar o dinheiro para pagar seu tratamento...', 10000)
                    TriggerEvent("vrp_sound:source",'Intro6',0.55)
                    TriggerMusicEvent("MC_MUSIC_STOP")                    
                    Wait(10000)
                  --  TriggerEvent('FRP:NOTIFY:Simple', 'Digite /guiainiciante ver o Jornal Guia de Iniciante.', 10000)
                    DeleteVehicle(car)
					Citizen.InvokeNative(0x971D38760FBC02EF, ped, false)
                    DeleteEntity(ped)
                else               
                    N_0x69d65e89ffd72313(true)
                    SetCinematicModeActive(1)
                    DisableAllControlActions(1)
                end 
            end	
        end
    end
)

RegisterNetEvent("FRP:CREATOR:CreateVehicle")
AddEventHandler(
	"FRP:CREATOR:CreateVehicle",
	function(vModel)
		local veh = GetHashKey(vModel)
		local ply = GetPlayerPed()
		local coords = GetEntityCoords(ply)
		Citizen.CreateThread(
			function()
				RequestModel(veh)
				while not HasModelLoaded(veh) do
                    Wait(1000)                    
				end
				if HasModelLoaded(veh) then
                    car = CreateVehicle(veh, 74.183,93.763,103.161, true, false)
					SetVehicleOnGroundProperly(car)
				end
			end
		)
	end
)
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


function StopSoundJS (sound)
    SendNUIMessage({ event = 'stopSound', sound = sound})
  end


  
  
RegisterCommand(
	"testarsom",
	function()
        StopSoundJS('Intro1.ogg')
	end
)
RegisterNetEvent("FRP:CREATOR:CreatePedOnVehicle")
AddEventHandler(
    "FRP:CREATOR:CreatePedOnVehicle",    
    function(pedModel)
        
        local pedModelHash = GetHashKey(pedModel)
		if not IsModelValid(pedModelHash) then
			return
		end

		if not HasModelLoaded(pedModelHash) then
			RequestModel(pedModelHash)
			while not HasModelLoaded(pedModelHash) do
				Citizen.Wait(10)
			end
        end
        
		ped = CreatePed(pedModelHash, coordsSpawn, GetEntityHeading(PlayerPedId()), false, 0)        
        Citizen.InvokeNative(0x283978A15512B2FE, ped, true)
        Citizen.InvokeNative(0x58A850EAEE20FAA3, ped)
		
		SetEntityNoCollisionEntity(PlayerPedId(), ped, false)
        SetEntityCanBeDamaged(ped, false)
        SetEntityInvincible(ped, true)
        Wait(1000)
        SetBlockingOfNonTemporaryEvents(ped, true)

        SetEntityAsMissionEntity(ped)

        -- SetModelAsNoLongerNeeded(pedModelHash)
        Citizen.Wait(150)
        SetPedAsGroupMember(ped, GetPedGroupIndex(PlayerPedId()))
		
		SetEntityAsMissionEntity(car, false, false)
        SetEntityAsMissionEntity(ped, false, false)
            
        npc_group = GetPedRelationshipGroupHash(ped)
        SetRelationshipBetweenGroups(1 , GetHashKey("PLAYER") , npc_group)

        SetPedIntoVehicle(ped, car, -1)
        TaskVehicleDriveToCoord(ped, GetVehiclePedIsIn(ped, false), -284.436,796.012,118.737, 10.0, 1.0, GetEntityModel(GetVehiclePedIsIn(PlayerPedId())), 67633207, 5.0, false)
        Citizen.InvokeNative(0x971D38760FBC02EF, ped, true)
        
        Citizen.Wait(250)
	end
)

