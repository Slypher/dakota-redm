local Proxy = module("_core", "lib/Proxy")

cAPI = Proxy.getInterface("API")

local fogueira

function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str)
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
	SetTextCentre(centre)
    if enableShadow then
        SetTextDropshadow(1, 0, 0, 0, 255)
    end
	Citizen.InvokeNative(0xADA9255D, 1);
    DisplayText(str, x, y)
end

local function fumacaBlip()
    Citizen.CreateThread(
        function()
            while fogueira ~= nil do
                Wait(0)
                if cAPI.hasGroupOrInheritance("indio") then
                    local ped = PlayerPedId()
                    local Coords = GetEntityCoords(ped)
                    for k,v in pairs(Config.Coords) do
                        if #(Coords - v) < 3.5 then
                            if GlobalState.sinalFumacaCoolDown then
                                DrawTxt("Aguarde a fogueira fazer mais fogo", 0.78, 0.95, 0.4, 0.4, true, 255, 255, 255, 150, false)    
                            else
                                DrawTxt("[ Alt ] Para fazer um sinal de fumaça", 0.78, 0.95, 0.4, 0.4, true, 255, 255, 255, 150, false)
                                
                                if IsControlJustReleased(0, `INPUT_PC_FREE_LOOK`) then
                                    TriggerServerEvent("indio:fumaca")
                                end
                            end
                        end
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
            
            for k,v in pairs(Config.Coords) do
                if #(Coords - v) < 100 then
                    if fogueira == nil then
                        RequestModel(`mp001_s_campfire01x_mp`)

                        while not HasModelLoaded(`mp001_s_campfire01x_mp`) do
                            Wait(0)
                        end

                        fogueira = CreateObject(`mp001_s_campfire01x_mp`, v, false, false, false)

                        fumacaBlip()
                    end
                else
                    fogueira = nil
                    DeleteEntity(fogueira)                    
                end
            end
        end
    end
)

AddEventHandler(
    "onResourceStop",
    function(resourceName)
        if resourceName == GetCurrentResourceName() then
            if fogueira ~= nil then
                DeleteEntity(fogueira) 
            end
        end
    end
)
