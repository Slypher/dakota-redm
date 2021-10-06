local Proxy = module("_core", "lib/Proxy")

cAPI = Proxy.getInterface("API")

local protecaoFiscal
local fiscal
local oficial
local tenda
local tendaOficial
local poste
local lampada

function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str)
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
	SetTextCentre(centre)
    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
	Citizen.InvokeNative(0xADA9255D, 1);
    DisplayText(str, x, y)
end

local function fiscalBlip()
    Citizen.CreateThread(
        function(source)
            while protecaoFiscal ~= nil do
                Wait(1)
                local ped = PlayerPedId()
                local Coords = GetEntityCoords(ped)
                local coordFiscalEntrada = vector3(-1465.948,-2786.934,63.510)
                
                if #(Coords - coordFiscalEntrada) < 5 then
                    DrawTxt("[ Alt ] Para falar com o fiscal",  0.78, 0.95, 0.4, 0.4, true, 255, 255, 255, 150, false)
                    if IsControlJustReleased(0, 0x8AAA0AD4) then
                        DoScreenFadeOut(500)
                        Wait(700)
                        
                        StartPlayerTeleport(PlayerId(), -1459.540,-2803.775,63.965, 180.0, true, true, true, true)
                        Wait(800)
                        DoScreenFadeIn(500)
                        Wait(1000)
                        TriggerEvent('FRP:NOTIFY:Simple', "Bem vindo ao México, uma terra sem lei!", 10000)
                    end
                end

            end
        end
    )
end

Citizen.CreateThread(
    function()
        while true do
            Wait(1000)
            local ped = PlayerPedId()
            local Coords = GetEntityCoords(ped)
            local coordFiscalEntrada = {vector3(-1457.948,-2798.368,62.926)}
            for k,v in pairs(coordFiscalEntrada) do
                if #(Coords - v) < 100 then
                    if protecaoFiscal == nil then
                        RequestModel(`p_mp_cover_ss_cwb`) 
                        RequestModel(`re_policechase_males_01`) 
                        RequestModel(`mp005_s_posse_tent_bountyhunter05x`) 
                        RequestModel(`p_lamppost01x`) 
                        RequestModel(`p_lantern04xint`) 
                        RequestModel(`mp_s_m_m_pinlaw_01`) 
                        RequestModel(`mp001_p_mp_tent_leento03x`) 
                        while   not HasModelLoaded(`p_mp_cover_ss_cwb`)  or 
                                not HasModelLoaded(`re_policechase_males_01`) or
                                not HasModelLoaded(`mp005_s_posse_tent_bountyhunter05x`) or
                                not HasModelLoaded(`p_lamppost01x`) or
                                not HasModelLoaded(`p_lantern04xint`) or 
                                not HasModelLoaded(`mp_s_m_m_pinlaw_01`) or
                                not HasModelLoaded(`mp001_p_mp_tent_leento03x`)
                                do
                            Wait(0)
                        end

                        protecaoFiscal =  CreateObject(`p_mp_cover_ss_cwb`, v, false, false, false)
                        SetEntityRotation(protecaoFiscal, 1, 1, 180.0, 1, true)

                        fiscal =  CreatePed(`re_policechase_males_01`, -1458.452,-2799.857,64.011, 20.0, false, false, false, false)
                        Citizen.InvokeNative(0x283978A15512B2FE,fiscal, true )
                        
                        tenda = CreateObject(`mp005_s_posse_tent_bountyhunter05x`, -1458.120,-2800.000,62.600, false, false, false)
                        FreezeEntityPosition(tenda, true)
                        
                        poste = CreateObject(`p_lamppost01x`, -1462.759,-2796.992,62.510, false, false, false)
                        
                        lampada = CreateObject(`p_lantern04xint`, -1462.235,-2797.100,65.360, false, false, false)
                        
                        oficial =  CreatePed(`mp_s_m_m_pinlaw_01`, -1451.652,-2794.662,63.991, 150.0, false, false, false, false)
                        Citizen.InvokeNative(0x283978A15512B2FE,oficial, true )

                        tendaOficial = CreateObject(`mp001_p_mp_tent_leento03x`, -1451.105,-2794.191,64.123, false, false, false)
                        PlaceObjectOnGroundProperly(tendaOficial)
                        SetEntityRotation(tendaOficial, 1, 1, 295.0, 1, true)
                        FreezeEntityPosition(tendaOficial, true)
                        
                        
                        fiscalBlip()
                        
                    end
                else
                    protecaoFiscal = nil
                    fiscal = nil
                    tenda = nil
                    poste = nil
                    lampada = nil
                    oficial = nil
                    tendaOficial = nil
                    DeleteEntity(protecaoFiscal)                    
                    DeleteEntity(fiscal)                    
                    DeleteEntity(tenda)
                    DeleteEntity(poste)
                    DeleteEntity(lampada)
                    DeleteEntity(oficial)
                    DeleteEntity(tendaOficial)
                end
            end
        end
    end
)

AddEventHandler(
    "onResourceStop",
    function(resourceName)
        if resourceName == GetCurrentResourceName() then
            if protecaoFiscal ~= nil then
                DeleteEntity(protecaoFiscal)                    
                DeleteEntity(fiscal)
                DeleteEntity(tenda)
                DeleteEntity(poste)
                DeleteEntity(lampada) 
                DeleteEntity(oficial) 
                DeleteEntity(tendaOficial) 
            end
        end
    end
)
