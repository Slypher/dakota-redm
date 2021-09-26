local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

cAPI = Proxy.getInterface("API")
API = Tunnel.getInterface("API")

cam = nil
hided = false
spawnedCamera = nil
choosePed = {}
pedSelected = nil
sex = nil
zoom = 4.0
offset = 0.2
DeleteeEntity = true
local InterP = true
local adding = true

local showroomHorse_entity
local showroomHorse_model

local MyHorse_entity
local IdMyHorse
cameraUsing = {
    {
        name = "Horse",
        x = 0.2,
        y = 0.0,
        z = 1.8
    },
    {
        name = "Olhos",
        x = 0.0,
        y = -0.4,
        z = 0.65
    }
}

local saddlecloths = {}
local acshorn = {}
local bags = {}
local horsetails = {}
local manes = {}
local saddles = {}
local stirrups = {}
local acsluggage = {}
local lantern = {}
local Mask = {}

Citizen.CreateThread(
    function()
        while adding do
            Citizen.Wait(0)
            for i, v in ipairs(HorseComp) do
                if v.category == "Saddlecloths" then
                    table.insert(saddlecloths, v.Hash)
                elseif v.category == "AcsHorn" then
                    table.insert(acshorn, v.Hash)
                elseif v.category == "Bags" then
                    table.insert(bags, v.Hash)
                elseif v.category == "HorseTails" then
                    table.insert(horsetails, v.Hash)
                elseif v.category == "Manes" then
                    table.insert(manes, v.Hash)
                elseif v.category == "Saddles" then
                    table.insert(saddles, v.Hash)
                elseif v.category == "Stirrups" then
                    table.insert(stirrups, v.Hash)
                elseif v.category == "AcsLuggage" then
                    table.insert(acsluggage, v.Hash)
                elseif v.category == "Lantern" then
                    table.insert(lantern, v.Hash)
                elseif v.category == "Mask" then
                    table.insert(Mask, v.Hash)
                end
            end
            adding = false
        end
    end
)

RegisterCommand(
    "estabulo",
    function()
        OpenStable()
    end
)

function OpenStable()
    inCustomization = true
    horsesp = true

    local playerHorse = MyHorse_entity

    SetEntityHeading(playerHorse, 334)
    DeleteeEntity = true
    SetNuiFocus(true, true)
    InterP = true

    local hashm = GetEntityModel(playerHorse)

    if hashm ~= nil and IsPedOnMount(PlayerPedId()) then
        createCamera(PlayerPedId())
    else
        createCamera(PlayerPedId())
    end
    --  SetEntityVisible(PlayerPedId(), false)
    if not alreadySentShopData then
        SendNUIMessage(
            {
                action = "show",
                shopData = getShopData()
            }
        )
    else
        SendNUIMessage(
            {
                action = "show"
            }
        )
    end
    TriggerServerEvent("FRP:STABLE:AskForMyHorses")
end

local promptGroup
local varStringCasa = CreateVarString(10, "LITERAL_STRING", "Estabulo")
local blip
local prompts = {}
local SpawnPoint = {}
local StablePoint = {}
local HeadingPoint
local CamPos = {}


Citizen.CreateThread(
    function()
        while true do
            Wait(1)
            local coords = GetEntityCoords(PlayerPedId())
            for _, prompt in pairs(prompts) do
                if PromptIsJustPressed(prompt) then
                    for k, v in pairs(Config.Stables) do
                        if GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < 7 then
                            HeadingPoint = v.Heading
                            StablePoint = {v.Pos.x, v.Pos.y, v.Pos.z}
                            CamPos = {v.SpawnPoint.CamPos.x, v.SpawnPoint.CamPos.y}
                            SpawnPoint = {x = v.SpawnPoint.Pos.x, y = v.SpawnPoint.Pos.y, z = v.SpawnPoint.Pos.z, h = v.SpawnPoint.Heading}
                            Wait(300)
                        end
                    end
                    OpenStable()
                end
            end
        end
    end
)

Citizen.CreateThread(
    function()
        for _, v in pairs(Config.Stables) do
            -- blip = N_0x554d9d53f696d002(1664425300, v.Pos.x, v.Pos.y, v.Pos.z)
            SetBlipSprite(blip, -145868367, 1)
            Citizen.InvokeNative(0x9CB1A1623062F402, blip, "Estábulo")
            local prompt = PromptRegisterBegin()
            PromptSetActiveGroupThisFrame(promptGroup, varStringCasa)
            PromptSetControlAction(prompt, 0xE8342FF2)
            PromptSetText(prompt, CreateVarString(10, "LITERAL_STRING", "Acessar Estábulo"))
            PromptSetStandardMode(prompt, true)
            PromptSetEnabled(prompt, 1)
            PromptSetVisible(prompt, 1)
            PromptSetHoldMode(prompt, 1)
            PromptSetPosition(prompt, v.Pos.x, v.Pos.y, v.Pos.z)
            N_0x0c718001b77ca468(prompt, 3.0)
            PromptSetGroup(prompt, promptGroup)
            PromptRegisterEnd(prompt)
            table.insert(prompts, prompt)
        end
    end
)

AddEventHandler(
    "onResourceStop",
    function(resourceName)
        if resourceName == GetCurrentResourceName() then
            for _, prompt in pairs(prompts) do
                PromptDelete(prompt)
                RemoveBlip(blip)
            end
        end
    end
)

-- function deletePrompt()
--     if prompt ~= nil then
--         PromptSetVisible(prompt, false)
--         PromptSetEnabled(prompt, false)
--         PromptDelete(prompt)
--         prompt = nil
--         promptGroup = nil
--     end
-- end


function rotation(dir)
    local playerHorse = MyHorse_entity
    local pedRot = GetEntityHeading(playerHorse) + dir
    SetEntityHeading(playerHorse, pedRot % 360)
end

RegisterNUICallback(
    "rotate",
    function(data, cb)
        if (data["key"] == "left") then
            rotation(20)
        else
            rotation(-20)
        end
        cb("ok")
    end
)

-- AddEventHandler(
--     'onResourceStop',
--     function(resourceName)
--         if resourceName == GetCurrentResourceName() then
--             for _, prompt in pairs(prompts) do
--                 PromptDelete(prompt)
-- 			end
--         end
--     end
-- )

AddEventHandler(
    "onResourceStop",
    function(resourceName)
        if (GetCurrentResourceName() ~= resourceName) then
            return
        end
        SetNuiFocus(false, false)
        SendNUIMessage(
            {
                action = "hide"
            }
        )
    end
)

function createCam(creatorType)
    for k, v in pairs(cams) do
        if cams[k].type == creatorType then
            cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", cams[k].x, cams[k].y, cams[k].z, cams[k].rx, cams[k].ry, cams[k].rz, cams[k].fov, false, 0) -- CAMERA COORDS
            SetCamActive(cam, true)
            RenderScriptCams(true, false, 3000, true, false)
            createPeds()
        end
    end
end

RegisterNUICallback(
    "Saddles",
    function(data)
        zoom = 4.0
        offset = 0.2
        if tonumber(data.id) == 0 then
            num = 0
            SaddlesUsing = num
            local playerHorse = MyHorse_entity
            Citizen.InvokeNative(0xD710A5007C2AC539, playerHorse, 0xBAA7E618, 0) -- HAT REMOVE
            Citizen.InvokeNative(0xCC8CA3E88256E58F, playerHorse, 0, 1, 1, 1, 0) -- Actually remove the component
        else
            local num = tonumber(data.id)
            hash = ("0x" .. saddles[num])
            setcloth(hash)
            SaddlesUsing = ("0x" .. saddles[num])
        end
    end
)

RegisterNUICallback(
    "Saddlecloths",
    function(data)
        zoom = 4.0
        offset = 0.2
        if tonumber(data.id) == 0 then
            num = 0
            SaddleclothsUsing = num
            local playerHorse = MyHorse_entity
            Citizen.InvokeNative(0xD710A5007C2AC539, playerHorse, 0x17CEB41A, 0) -- HAT REMOVE
            Citizen.InvokeNative(0xCC8CA3E88256E58F, playerHorse, 0, 1, 1, 1, 0) -- Actually remove the component
        else
            local num = tonumber(data.id)
            hash = ("0x" .. saddlecloths[num])
            setcloth(hash)
            SaddleclothsUsing = ("0x" .. saddlecloths[num])
        end
    end
)

RegisterNUICallback(
    "Stirrups",
    function(data)
        zoom = 4.0
        offset = 0.2
        if tonumber(data.id) == 0 then
            num = 0
            StirrupsUsing = num
            local playerHorse = MyHorse_entity
            Citizen.InvokeNative(0xD710A5007C2AC539, playerHorse, 0xDA6DADCA, 0) -- HAT REMOVE
            Citizen.InvokeNative(0xCC8CA3E88256E58F, playerHorse, 0, 1, 1, 1, 0) -- Actually remove the component
        else
            local num = tonumber(data.id)
            hash = ("0x" .. stirrups[num])
            setcloth(hash)
            StirrupsUsing = ("0x" .. stirrups[num])
        end
    end
)

RegisterNUICallback(
    "Bags",
    function(data)
        zoom = 4.0
        offset = 0.2
        if tonumber(data.id) == 0 then
            num = 0
            BagsUsing = num
            local playerHorse = MyHorse_entity
            Citizen.InvokeNative(0xD710A5007C2AC539, playerHorse, 0x80451C25, 0) -- HAT REMOVE
            Citizen.InvokeNative(0xCC8CA3E88256E58F, playerHorse, 0, 1, 1, 1, 0) -- Actually remove the component
        else
            local num = tonumber(data.id)
            hash = ("0x" .. bags[num])
            setcloth(hash)
            BagsUsing = ("0x" .. bags[num])
        end
    end
)

RegisterNUICallback(
    "Manes",
    function(data)
        zoom = 4.0
        offset = 0.2
        if tonumber(data.id) == 0 then
            num = 0
            ManesUsing = num
            local playerHorse = MyHorse_entity
            Citizen.InvokeNative(0xD710A5007C2AC539, playerHorse, 0xAA0217AB, 0) -- HAT REMOVE
            Citizen.InvokeNative(0xCC8CA3E88256E58F, playerHorse, 0, 1, 1, 1, 0) -- Actually remove the component
        else
            local num = tonumber(data.id)
            hash = ("0x" .. manes[num])
            setcloth(hash)
            ManesUsing = ("0x" .. manes[num])
        end
    end
)

RegisterNUICallback(
    "HorseTails",
    function(data)
        zoom = 4.0
        offset = 0.2
        if tonumber(data.id) == 0 then
            num = 0
            HorseTailsUsing = num
            local playerHorse = MyHorse_entity
            Citizen.InvokeNative(0xD710A5007C2AC539, playerHorse, 0xA63CAE10, 0) -- HAT REMOVE -- OLD 0x17CEB41A
            Citizen.InvokeNative(0xCC8CA3E88256E58F, playerHorse, 0, 1, 1, 1, 0) -- Actually remove the component
        else
            local num = tonumber(data.id)
            hash = ("0x" .. horsetails[num])
            setcloth(hash)
            HorseTailsUsing = ("0x" .. horsetails[num])
        end
    end
)

RegisterNUICallback(
    "AcsHorn",
    function(data)
        zoom = 4.0
        offset = 0.2
        if tonumber(data.id) == 0 then
            num = 0
            AcsHornUsing = num
            local playerHorse = MyHorse_entity
            Citizen.InvokeNative(0xD710A5007C2AC539, playerHorse, 0x5447332, 0) -- HAT REMOVE
            Citizen.InvokeNative(0xCC8CA3E88256E58F, playerHorse, 0, 1, 1, 1, 0) -- Actually remove the component
        else
            local num = tonumber(data.id)
            hash = ("0x" .. acshorn[num])
            setcloth(hash)
            AcsHornUsing = ("0x" .. acshorn[num])
        end
    end
)

RegisterNUICallback(
    "AcsLuggage",
    function(data)
        zoom = 4.0
        offset = 0.2
        if tonumber(data.id) == 0 then
            num = 0
            AcsLuggageUsing = num
            local playerHorse = MyHorse_entity
            Citizen.InvokeNative(0xD710A5007C2AC539, playerHorse, 0xEFB31921, 0) -- HAT REMOVE
            Citizen.InvokeNative(0xCC8CA3E88256E58F, playerHorse, 0, 1, 1, 1, 0) -- Actually remove the component
        else
            local num = tonumber(data.id)
            hash = ("0x" .. acsluggage[num])
            setcloth(hash)
            AcsLuggageUsing = ("0x" .. acsluggage[num])
        end
    end
)

RegisterNUICallback(
    "Lantern",
    function(data)
        zoom = 4.0
        offset = 0.2
        if tonumber(data.id) == 0 then
            num = 0
            LanternUsing = num
            local playerHorse = MyHorse_entity
            Citizen.InvokeNative(0xD710A5007C2AC539, playerHorse, 0x1530BE1C, 0) -- HAT REMOVE
            Citizen.InvokeNative(0xCC8CA3E88256E58F, playerHorse, 0, 1, 1, 1, 0) -- Actually remove the component
        else
            local num = tonumber(data.id)
            hash = ("0x" .. lantern[num]) -- add .hash
            setcloth(hash)
            LanternUsing = ("0x" .. lantern[num]) -- add .hash
        end
    end
)
RegisterNUICallback(
    "Mask",
    function(data)
        zoom = 4.0
        offset = 0.2
        if tonumber(data.id) == 0 then
            num = 0
            MaskUsing = num
            local playerHorse = MyHorse_entity
            Citizen.InvokeNative(0xD710A5007C2AC539, playerHorse, 0xD3500E5D, 0) -- HAT REMOVE
            Citizen.InvokeNative(0xCC8CA3E88256E58F, playerHorse, 0, 1, 1, 1, 0) -- Actually remove the component
        else
            local num = tonumber(data.id)
            hash = ("0x" .. Mask[num]) -- add .hash
            setcloth(hash)
            MaskUsing = ("0x" .. Mask[num]) -- add .hash
        end
    end
)

myHorses = {}

function setcloth(hash)
    local model2 = GetHashKey(tonumber(hash))
    if not HasModelLoaded(model2) then
        Citizen.InvokeNative(0xFA28FE3A6246FC30, model2)
    end
    Citizen.InvokeNative(0xD3A7B003ED343FD9, MyHorse_entity, tonumber(hash), true, true, true)
end

RegisterNUICallback(
    "selectHorse",
    function(data)
        print(data.horseID)
        TriggerServerEvent("FRP:STABLE:SelectHorseWithId", tonumber(data.horseID))
    end
)

RegisterNUICallback(
    "sellHorse",
    function(data)
        print(data.horseID)
        DeleteEntity(showroomHorse_entity)
        TriggerServerEvent("FRP:STABLE:SellHorseWithId", tonumber(data.horseID))
        TriggerServerEvent("FRP:STABLE:AskForMyHorses")
    end
)

RegisterNetEvent("FRP:STABLE:ReceiveHorsesData")
AddEventHandler(
    "FRP:STABLE:ReceiveHorsesData",
    function(dataHorses)
        SendNUIMessage(
            {
                myHorsesData = dataHorses
            }
        )
    end
)

SaddlesUsing = nil
SaddleclothsUsing = nil
StirrupsUsing = nil
BagsUsing = nil
ManesUsing = nil
HorseTailsUsing = nil
AcsHornUsing = nil
AcsLuggageUsing = nil
LanternUsing = nil
MaskUsing = nil

--- /// ARRASTAR CAVALO

local alreadySentShopData = false



function getShopData()
    alreadySentShopData = true

    local ret = {
        {
            name = "Turkoman",
            ["A_C_Horse_Turkoman_DarkBay"] = {"70Kg - Escuro", 100, 70},
            ["A_C_Horse_Turkoman_Gold"] = {"70Kg - Ouro", 100, 70},
            ["A_C_Horse_Turkoman_Silver"] = {"70Kg - Prata", 100, 70},
            ["a_c_horse_turkoman_black"] = {"70Kg - Preto", 100, 70},   
            ["a_c_horse_turkoman_chestnut"] = {"70Kg - Castanho", 100, 70},
            ["a_c_horse_turkoman_grey"] = {"70Kg - Cinza", 100, 70},    
            ["a_c_horse_turkoman_perlino"] = {"70Kg - Perlino", 100, 70},
        },
            {
            name = "Appaloosa", -----------------------------------------------------------------------
            ["A_C_Horse_Appaloosa_BlackSnowflake"] = {"80Kg - Floco Negro", 125, 80},
            ["A_C_Horse_Appaloosa_Blanket"] = {"80Kg - Cobertor", 125, 80},
            ["A_C_Horse_Appaloosa_BrownLeopard"] = {"80Kg - Leopardo", 125, 80},            
            ["A_C_Horse_Appaloosa_LeopardBlanket"] = {"80Kg - Manta Leopardo", 125, 80},
            ["A_C_Horse_Appaloosa_FewSpotted_PC"] = {"80Kg - Poucos Manchados", 125, 80},
            ["A_C_Horse_Gang_Charles"] = {"80Kg - Charles", 125, 80},
            ["A_C_Horse_Appaloosa_Leopard"] = {"80Kg - Leopardo", 125, 80},
            ["A_C_Horse_Gang_Uncle_EndlessSummer"] = {"80Kg - Verão interminável", 125, 80},
        },
            {
            name = "Árabe", ----------------------------------------------------------------------------------------
            ["A_C_Horse_Arabian_RedChestnut"] = {"90Kg - Vermelho", 150, 90},
            ["A_C_Horse_Arabian_RoseGreyBay"] = {"90Kg - Rosa Cinzento", 150, 90},
            ["A_C_Horse_Arabian_WarpedBrindle_PC"] = {"90Kg - Tigrado", 150, 90},
            ["A_C_Horse_Arabian_White"] = {"90Kg - Branco", 150, 90},
            ["A_C_Horse_Arabian_Black"] = {"90Kg - Preto", 150, 90},
            ["A_C_Horse_Arabian_Grey"] = {"90Kg - Cinza", 150, 90},
        },
        {
            name = "American Paint", -----------------------------------------------------------------------
            ["A_C_Horse_AmericanPaint_Overo"] = {"40Kg - Overo", 30, 40},						-- 47 melhor
            ["A_C_Horse_AmericanPaint_Tobiano"] = {"40Kg - Tobiano", 30, 40},		   			-- 45 melhor 
            ["A_C_Horse_AmericanPaint_Greyovero"] = {"40Kg - Cinzento", 30, 40},      			-- 19 melhor
            ["A_C_Horse_AmericanPaint_SplashedWhite"] = {"40Kg - Branco Salpicado", 30, 40},   -- 42 melhor
        },
        {
            name = "Gypsy Cob", -----------------------------------------------------------------------------
            ["a_c_horse_gypsycob_whiteblagdon"] = {"60Kg - Branco", 50, 60},			   -- 26 melhor
            ["a_c_horse_gypsycob_piebald"] = {"60Kg - Piebald", 50, 60}, 				   -- 26 melhor
            ["a_c_horse_gypsycob_skewbald"] = {"60Kg - Skewbald", 50, 60},                -- 13 Melhor
            ["a_c_horse_gypsycob_palominoblagdon"] = {"60Kg - Palomino", 50, 60},         -- 13 Melhor
            ["a_c_horse_gypsycob_splashedpiebald"] = {"60Kg - Pintado", 50, 60},          -- 3 melhor
            ["a_c_horse_gypsycob_splashedbay"] = {"60Kg - Marrom", 50, 60},               -- 3 melhor
        },
        {
            name = "Trotador Americano", ------------------------------------------------------------------
            ["A_C_Horse_AmericanStandardbred_Black"] = {"35Kg - Preto", 40, 35},						-- 35 melhor
            ["A_C_Horse_AmericanStandardbred_Buckskin"] = {"35Kg - Camurça", 40, 35},					-- 32 melhor
            ["A_C_Horse_AmericanStandardbred_PalominoDapple"] = {"35Kg - Salpicado", 40, 35},          -- 25 melhor
            ["A_C_Horse_AmericanStandardbred_SilverTailBuckskin"] = {"35Kg - Rabo de Prata", 40, 35},  -- 25 melhor 
        },
        {
            name = "Andaluz", --------------------------------------------------------------------------------
            ["A_C_Horse_Andalusian_DarkBay"] = {"40Kg - Sombrio", 45, 40}, 			  -- 38 melhor
            ["A_C_Horse_Andalusian_RoseGray"] = {"40Kg - Rosa Cinzento", 45, 40},        -- 21 melhor
            ["A_C_Horse_Andalusian_Perlino"] = {"40Kg - Perlino", 45, 40},               -- 18 melhor
        },
        {
            name = "Ardennes", ---------------------------------------------------------------------------
            ["A_C_Horse_Ardennes_BayRoan"] = {"70Kg - Bege", 50, 70},  			   -- 39 melhor
            ["A_C_Horse_Ardennes_IronGreyRoan"] = {"70Kg - Prateado", 50, 70},        -- 23 melhor
            ["A_C_Horse_Gang_Bill"] = {"70Kg - Marrom", 50, 70},
            ["A_C_Horse_Ardennes_StrawberryRoan"] = {"70Kg - Morango Roan", 50, 70},  -- 20 melhor
        },
        {
            name = "Belga", --------------------------------------------------------------------------------------
            ["A_C_Horse_Belgian_BlondChestnut"] = {"60Kg - Castanha", 20, 60}, -- 56 melhor + peso = 100
            ["A_C_Horse_Belgian_MealyChestnut"] = {"60Kg - Caramelo", 20, 60}, -- 56 melhor + peso = 100
        },
        {
            name = "Warmblood Holandês", -------------------------------------------------------------------------
            ["A_C_Horse_DutchWarmblood_SealBrown"] = {"45Kg - Marrom", 20, 45},		         -- 37 melhor
            ["A_C_Horse_DutchWarmblood_ChocolateRoan"] = {"45Kg - Chocolate", 20, 45},          -- 22 melhor
            ["A_C_Horse_DutchWarmblood_SootyBuckskin"] = {"45Kg - Marrom Pintado", 20, 45},     -- 40 melhor
        },
        {
            name = "Mestiço Húngaro", ---------------------------------------------------------------------------
            ["A_C_Horse_HungarianHalfbred_FlaxenChestnut"] = {"55Kg - Castanho", 44, 55},   			-- 44 melhor 
            ["A_C_Horse_HungarianHalfbred_LiverChestnut"] = {"55Kg - Vermelho", 44, 55},
            ["A_C_Horse_HungarianHalfbred_PiebaldTobiano"] = {"55Kg - Piebald Tobiano", 44,55},  		-- 46 melhor
            ["A_C_Horse_HungarianHalfbred_DarkDappleGrey"] = {"30Kg - Cinza Manchado Escuro", 20, 30}, -- 41 melhor
            ["A_C_Horse_Gang_John"] = {"55Kg - Marrom", 44, 55},
        },
        {
            name = "Kentucky Saddle", ---------------------------------------------------------------------------
            ["A_C_Horse_KentuckySaddle_SilverBay"] = {"20Kg - Prata", 15, 20},  		    -- 54 melhor
            ["A_C_Horse_KentuckySaddle_ChestnutPinto"] = {"20Kg - Castanha Pinto", 15, 20}, -- 58 melhor
            ["A_C_Horse_KentuckySaddle_Grey"] = {"20Kg - Cinza", 15, 20}, 				    -- 62 melhor
            ["A_C_Horse_KentuckySaddle_Black"] = {"20Kg - Preto", 15, 20},   			    -- 54 melhor
            ["A_C_Horse_KentuckySaddle_ButterMilkBuckskin_PC"] = {"20Kg - Leite", 15, 20},  -- 50 melhor
        },
        {
            name = "Kladruber", ---------------------------------------------------------------------
            ["A_C_Horse_Kladruber_Black"] = {"55Kg - Preto", 25, 55},		   	  -- 28 melhor
            ["A_C_Horse_Kladruber_White"] = {"55Kg - Branco", 25, 55},		  	  -- 28 melhor
            ["A_C_Horse_Kladruber_Cremello"] = {"55Kg - Cremelo", 25, 55},    	  -- 15 Melhor
            ["A_C_Horse_Kladruber_Grey"] = {"55Kg - Prata", 25, 55},         	  -- 15 Melhor
            ["A_C_Horse_Kladruber_DappleRoseGrey"] = {"55Kg - Malhado", 25, 55}, -- 5 melhor
            ["A_C_Horse_Kladruber_Silver"] = {"55Kg - Prateado", 25, 55},        -- 5 melhor
        },
        {
            name = "Missouri Fox Trotter", -------------------------------------------------------------------------------
            ["A_C_Horse_MissouriFoxTrotter_AmberChampagne"] = {"40Kg - Champanhe", 44, 40},
            ["A_C_Horse_MissouriFoxTrotter_SableChampagne"] = {"40Kg - Champagne", 44, 40},
            ["A_C_Horse_MissouriFoxTrotter_SilverDapplePinto"] = {"40Kg - Fantasma", 44, 40},
            ["a_c_horse_missourifoxtrotter_blacktovero"] = {"40Kg - Tovero Preto", 44, 40},
            ["a_c_horse_missourifoxtrotter_blueroan"] = {"40Kg - Azulado", 44, 40},
            ["a_c_horse_missourifoxtrotter_buckskinbrindle"] = {"40Kg - Camurça", 44, 40},
            ["a_c_horse_missourifoxtrotter_dapplegrey"] = {"40Kg - Cinza Manchado", 44, 40},
        },
        {
            name = "Morgan", ---------------------------------------------------------------------------------------
            ["A_C_Horse_Morgan_Bay"] = {"25Kg - Marrom", 5, 25},  -- 58 melhor
            ["A_C_Horse_Morgan_BayRoan"] = {"25Kg - Rosado", 5, 25},  -- 60 melhor
            ["A_C_Horse_Morgan_FlaxenChestnut"] = {"25Kg - Lama", 5, 25},       -- 53 melhor
            ["A_C_Horse_Morgan_LiverChestnut_PC"] = {"25Kg - Sombrio", 5, 25},  -- 49 melhor
            ["A_C_Horse_Morgan_Palomino"] = {"25Kg - Palomino", 5, 25},  -- 60 melhor
        },
        {
            name = "Penco Velho", ------------------------------------------------------------------------------
            ["A_C_Horse_MP_Mangy_Backup"] = {"5Kg - Falhado", 1, 5},
        },
        {
            name = "Mustang",
            ["A_C_Horse_Mustang_GoldenDun"] = {"40Kg - Cinzento", 44, 50},
            ["A_C_Horse_Mustang_GrulloDun"] = {"40Kg - Sol Dourado", 44, 50},
            ["A_C_Horse_Mustang_TigerStripedBay"] = {"40Kg - Tigre Listrado", 40, 50},
            ["A_C_Horse_Mustang_WildBay"] = {"40Kg - Selvagem", 44, 50},
            ["a_c_horse_mustang_blackovero"] = {"40Kg - Preto", 44, 50},    
            ["a_c_horse_mustang_buckskin"] = {"40Kg - Buck Skin", 44, 50},  
            ["a_c_horse_mustang_chestnuttovero"] = {"40Kg - Honesto", 44, 50}, 
            ["a_c_horse_mustang_reddunovero"] = {"40Kg - Vermelho", 44, 50},   
        },
        {
            name = "Nokota", --------------------------------------------------------------------------------------
            ["A_C_Horse_Nokota_BlueRoan"] = {"25Kg - Azulado", 10, 25},  -- 34 melhor
            ["A_C_Horse_Nokota_ReverseDappleRoan"] = {"25Kg - Azul Invetido", 10, 25}, -- 11 Melhor
            ["A_C_Horse_Nokota_WhiteRoan"] = {"25Kg - Branco", 10, 25}, -- 32 melhor
        },
        {
            name = "Shire", ----------------------------------------------------------------------------------------------
            ["A_C_Horse_Shire_DarkBay"] = {"80Kg - Marrom Escuro", 40, 80},  -- 55 melhor + peso = 170
            ["A_C_Horse_Shire_LightGrey"] = {"80Kg - Branco", 40, 80},    -- 59 melhor + peso = 180
            ["A_C_Horse_Shire_RavenBlack"] = {"80Kg - Preto", 40, 80},  -- 51 melhor + peso = 160
        },
        {
            name = "Suffolk Punch", -------------------------------------------------------------------------------
            ["A_C_Horse_SuffolkPunch_RedChestnut"] = {"45Kg - Vermelho", 50, 45}, -- 59 melhor + peso = 90
            ["A_C_Horse_SuffolkPunch_Sorrel"] = {"45Kg - Sorrel", 50, 45},        -- 59 melhor + peso = 90
        },
        {
            name = "Tennessee Walker", ---------------------------------------------------------------------------
            ["A_C_Horse_TennesseeWalker_BlackRabicano"] = {"18Kg - Rabicano", 3, 18},  -- 57 melhor
            ["A_C_Horse_TennesseeWalker_Chestnut"] = {"18Kg - Sorrel", 3, 18},    -- 53 melhor
            ["A_C_Horse_TennesseeWalker_DappleBay"] = {"18Kg - Malhado", 3, 18}, -- 57 melhor
            ["A_C_Horse_TennesseeWalker_MahoganyBay"] = {"18Kg - Pintado", 3, 18}, -- 52 melhor
            ["A_C_Horse_TennesseeWalker_RedRoan"] = {"18Kg - Laranja", 3, 18},  -- 61 melhor
            ["A_C_Horse_TennesseeWalker_GoldPalomino_PC"] = {"18Kg - Plata", 3, 18},  -- 48 melhor
            ["A_C_Horse_TennesseeWalker_FlaxenRoan"] = {"18Kg - FlaxenRoan", 3, 18}, -- 36 melhor
        },
        {
            name = "Puro-Sangue Inglês", ---------------------------------------------------------------
            ["A_C_Horse_Thoroughbred_BlackChestnut"] = {"30Kg - Roxo", 50, 30},  -- 12 Melhor
            ["A_C_Horse_Thoroughbred_BloodBay"] = {"30Kg - Vermelho", 50, 30},   -- 33 melhor
            ["A_C_Horse_Thoroughbred_DappleGrey"] = {"30Kg - Cinza Invertido", 50, 30}, -- 31 melhor
            ["A_C_Horse_Thoroughbred_Brindle"] = {"30Kg - Listrado", 50, 30},           -- 10 Melhor
            ["A_C_Horse_Thoroughbred_ReverseDappleBlack"] = {"30Kg - Preto Invertido", 50, 30},
        },
        {
            name = "Crioulo", ------------------------------------------------------------------------------ 
            ["A_C_Horse_Criollo_Dun"] = {"50Kg - Bege", 35, 50},				 -- 29 melhor
            ["A_C_Horse_Criollo_BlueRoanOvero"] = {"50Kg - Azulado", 35, 50},   -- 29 melhor
            ["A_C_Horse_Criollo_BayBrindle"] = {"50Kg - Tigrado", 35, 50},      -- 16 melhor
            ["A_C_Horse_Criollo_SorrelOvero"] = {"50Kg - Malhado", 35, 50},     -- 16 melhor
            ["A_C_Horse_Criollo_MarbleSabino"] = {"50Kg - Pintado", 35, 50},    -- 6 melhor
            ["A_C_Horse_Criollo_BayFrameOvero"] = {"50Kg - Baia", 35, 50},      -- 6 melhor
        },
        {
            name = "Bretão", -------------------------------------------------------------------------------------
            ["A_C_Horse_Breton_MealyDappleBay"] = {"MealyDapple", 30, 10}, -- TESTE
            ["A_C_Horse_Breton_Sorrel"] = {"75Kg - Sorrel", 30, 75},					  -- 30 melhor
            ["A_C_Horse_Breton_RedRoan"] = {"75Kg - Rosado", 30, 75},				      -- 30 melhor
            ["A_C_Horse_Breton_GrulloDun"] = {"75Kg - Bege", 30, 75},					  -- 17 melhor
            ["A_C_Horse_Breton_SealBrown"] = {"75Kg - Vermelho", 30, 75},				  -- 17 melhor
            ["A_C_Horse_Breton_SteelGrey"] = {"75Kg - Aço cinza", 30, 75},               -- 7 melhor
        },
        { 
            name = "Norfolk Roadster", ----------------------------------------------------------------------------------
            ["A_C_HORSE_NORFOLKROADSTER_SPECKLEDGREY"] = {"50Kg - Branco", 50, 50},	  -- 27 melhor
            ["A_C_HORSE_NORFOLKROADSTER_BLACK"] = {"50Kg - Preto", 50, 50},              -- 27 melhor
            ["A_C_HORSE_NORFOLKROADSTER_PIEBALDROAN"] = {"50Kg - PIEBALDROAN", 50, 50},  -- 14 melhor
            ["A_C_HORSE_NORFOLKROADSTER_ROSEGREY"] = {"50Kg - Cinza Malhado", 50, 50},   -- 14 melhor
            ["A_C_HORSE_NORFOLKROADSTER_DAPPLEDBUCKSKIN"] = {"50Kg - Onça", 50, 50},     -- 4 melhor
            ["A_C_HORSE_NORFOLKROADSTER_SPOTTEDTRICOLOR"] = {"50Kg - Tricolor", 50, 50}, -- 4 melhor
        },
        {
            name = "Mula e Burro", -------------------------------------------------------------------------------
            ["A_C_HorseMulePainted_01"] = {"15Kg - Zebra", 10, 15},
            ["A_C_HorseMule_01"] = {"10Kg - Mula", 8, 10},
            ["A_C_Donkey_01"] = {"10Kg - Burro", 8, 10},
        }
    }

    return ret
end


RegisterNUICallback(
    "loadHorse",
    function(data)
        local horseModel = data.horseModel

        if showroomHorse_model == horseModel then
            return
        end


        if showroomHorse_entity ~= nil then
            DeleteEntity(showroomHorse_entity)
            showroomHorse_entity = nil
        end

        if MyHorse_entity ~= nil then
            DeleteEntity(MyHorse_entity)
            MyHorse_entity = nil
        end


        showroomHorse_model = horseModel

        local modelHash = GetHashKey(showroomHorse_model)

        if not HasModelLoaded(modelHash) then
            RequestModel(modelHash)
            while not HasModelLoaded(modelHash) do
                Citizen.Wait(10)
            end
        end

        showroomHorse_entity = CreatePed(modelHash, SpawnPoint.x, SpawnPoint.y, SpawnPoint.z - 0.98, SpawnPoint.h, false, 0)
        Citizen.InvokeNative(0x283978A15512B2FE, showroomHorse_entity, true)
        Citizen.InvokeNative(0x58A850EAEE20FAA3, showroomHorse_entity)
        NetworkSetEntityInvisibleToNetwork(showroomHorse_entity, true)
        SetVehicleHasBeenOwnedByPlayer(showroomHorse_entity, true)
        -- SetModelAsNoLongerNeeded(modelHash)

        interpCamera("Horse", showroomHorse_entity)
    end
)


RegisterNUICallback(
    "loadMyHorse",
    function(data)
        local horseModel = data.horseModel
        IdMyHorse = data.IdHorse
        if showroomHorse_model == horseModel then
            return
        end

        if showroomHorse_entity ~= nil then
            DeleteEntity(showroomHorse_entity)
            showroomHorse_entity = nil
        end

        if MyHorse_entity ~= nil then
            DeleteEntity(MyHorse_entity)
            MyHorse_entity = nil
        end

        showroomHorse_model = horseModel

        local modelHash = GetHashKey(showroomHorse_model)

        if not HasModelLoaded(modelHash) then
            RequestModel(modelHash)
            while not HasModelLoaded(modelHash) do
                Citizen.Wait(10)
            end
        end

        MyHorse_entity = CreatePed(modelHash, SpawnPoint.x, SpawnPoint.y, SpawnPoint.z - 0.98, SpawnPoint.h, false, 0)
        Citizen.InvokeNative(0x283978A15512B2FE, MyHorse_entity, true)
        Citizen.InvokeNative(0x58A850EAEE20FAA3, MyHorse_entity)
        NetworkSetEntityInvisibleToNetwork(MyHorse_entity, true)
        SetVehicleHasBeenOwnedByPlayer(MyHorse_entity, true)

        local componentsHorse = json.decode(data.HorseComp)

        if componentsHorse ~= '[]' then
            for _, Key in pairs(componentsHorse) do
                local model2 = GetHashKey(tonumber(Key))
                if not HasModelLoaded(model2) then
                    Citizen.InvokeNative(0xFA28FE3A6246FC30, model2)
                end
                Citizen.InvokeNative(0xD3A7B003ED343FD9, MyHorse_entity, tonumber(Key), true, true, true)
            end
        end

        -- SetModelAsNoLongerNeeded(modelHash)

        interpCamera("Horse", MyHorse_entity)
    end
)


RegisterNUICallback(
    "BuyHorse",
    function(data)
        local HorseName = cAPI.prompt("Nome do Cavalo:", "")
        
        if HorseName == "" then
            return
        end
        SetNuiFocus(true, true)

        TriggerServerEvent('FRP:STABLE:BuyHorse', data, HorseName)
    end
)



RegisterNUICallback(
    "CloseStable",
    function()
        SetNuiFocus(false, false)

        SendNUIMessage(
            {
                action = "hide"
            }
        )
        SetEntityVisible(PlayerPedId(), true)

        showroomHorse_model = nil

        if showroomHorse_entity ~= nil then
            DeleteEntity(showroomHorse_entity)
        end

        if MyHorse_entity ~= nil then
            DeleteEntity(MyHorse_entity)
        end

        DestroyAllCams(true)
        showroomHorse_entity = nil
        CloseStable()
    end
)


function CloseStable()
        local dados = {
            -- ['saddles'] = SaddlesUsing,
            -- ['saddlescloths'] = SaddleclothsUsing,
            -- ['stirrups'] = StirrupsUsing,
            -- ['bags'] = BagsUsing,
            -- ['manes'] = ManesUsing,
            -- ['horsetails'] = HorseTailsUsing,
            -- ['acshorn'] = AcsHornUsing,
            -- ['ascluggage'] = AcsLuggageUsing
            SaddlesUsing,
            SaddleclothsUsing,
            StirrupsUsing,
            BagsUsing,
            ManesUsing,
            HorseTailsUsing,
            AcsHornUsing,
            AcsLuggageUsing,
            LanternUsing,
            MaskUsing
        }
        local DadosEncoded = json.encode(dados)

        if DadosEncoded ~= "[]" then            
            TriggerServerEvent("FRP:STABLE:UpdateHorseComponents", dados, IdMyHorse ) 
        end

       
end


Citizen.CreateThread(
    function()
       while true do
        Citizen.Wait(100)
            if MyHorse_entity ~= nil then
                SendNUIMessage(
                    {
                        EnableCustom = "true"
                    }
                )
            else
                SendNUIMessage(
                    {
                        EnableCustom = "false"
                    }
                )
            end
       end
    end
)

function interpCamera(cameraName, entity)
    for k, v in pairs(cameraUsing) do
        if cameraUsing[k].name == cameraName then
            tempCam = CreateCam("DEFAULT_SCRIPTED_CAMERA")
            AttachCamToEntity(tempCam, entity, cameraUsing[k].x + CamPos[1], cameraUsing[k].y + CamPos[2], cameraUsing[k].z)
            SetCamActive(tempCam, true)
            SetCamRot(tempCam, -30.0, 0, HeadingPoint + 50.0)
            if InterP then
                SetCamActiveWithInterp(tempCam, fixedCam, 1200, true, true)
                InterP = false
            end
        end
    end
end

function createCamera(entity)
    groundCam = CreateCam("DEFAULT_SCRIPTED_CAMERA")
    SetCamCoord(groundCam, StablePoint[1] + 0.5, StablePoint[2] - 3.6, StablePoint[3] )
    SetCamRot(groundCam, -20.0, 0.0, HeadingPoint + 20)
    SetCamActive(groundCam, true)
    RenderScriptCams(true, false, 1, true, true)
    --Wait(3000)
    -- last camera, create interpolate
    fixedCam = CreateCam("DEFAULT_SCRIPTED_CAMERA")
    SetCamCoord(fixedCam, StablePoint[1] + 0.5, StablePoint[2] - 3.6, StablePoint[3] +1.8)
    SetCamRot(fixedCam, -20.0, 0, HeadingPoint + 50.0)
    SetCamActive(fixedCam, true)
    SetCamActiveWithInterp(fixedCam, groundCam, 3900, true, true)
    Wait(3900)
    DestroyCam(groundCam)
end
