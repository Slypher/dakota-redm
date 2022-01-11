local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Tunnel.getInterface("API")
cAPI = Proxy.getInterface("API")

adding = true
inCustomization = false
cam = nil
hided = false
spawnedCamera = nil
choosePed = {}
pedSelected = PlayerPedId()
sex = nil
positionBack = nil

InterP = false
CamActive = false
zoom = 1.0
offset = 0.5
fixedCam = nil
tempCam2 = nil
tempCam = nil
groundCam = nil

local gClosestShopCenterPos
local gClosestShopHeading

local gZoomInterpolationCam

local adding2 = true
local adding = true

local hats_m = {} --hat
local hats_f = {}

local spurs_m = {} -- SPURS
local spurs_f = {}

local chaps_m = {}
local chaps_f = {}

local cloaks_m = {}
local cloaks_f = {}

local spats_m = {}
local spats_f = {}

local eyewear_m = {}
local eyewear_f = {}

local access_m = {}
local access_f = {}

local armor_m = {}
local armor_f = {}

local neckties_m = {}
local neckties_f = {}

local bracelets_m = {}
local bracelets_f = {}

local loadouts_m = {}
local loadouts_f = {}

local suspenders_m = {}
local suspenders_f = {}

local gauntlets_m = {}
local gauntlets_f = {}

local belts_m = {}
local belts_f = {}

local ponchos_m = {}
local ponchos_f = {}

local offhand_m = {}
local offhand_f = {}

local beltbuckle_m = {}
local beltbuckle_f = {}

----------------------------------------------------------------------------------------------------------------------------
local shirts_m = {} --shirt
local shirts_f = {}
--------------------------------------------------------------------------------------------------------------------------------------
local vests_m = {} --vest
local vests_f = {}
--------------------------------------------
local pants_m = {} --pants
local pants_f = {}
------------------------------------------
local masks_m = {} --mask
local masks_f = {}
------------------------------------------
local coats_m = {} --coats
local coats_f = {}
------------------------------------------
local coats2_m = {} --coats
local coats2_f = {}
-----------------------------------------
local boots_m = {} --coats
local boots_f = {}
---------------------------------------
local legs_m = {} --coats
local legs_f = {}

local gloves_m = {} --coats
local gloves_f = {}

local torsos_m = {}
local torsos_f = {}

local neckwear_m = {}
local neckwear_f = {}

local gunbelts_m = {}
local gunbelts_f = {}

local ringsr_m = {}
local ringsr_f = {}

local ringsl_m = {}
local ringsl_f = {}

local dresses_m = {}
local dresses_f = {}

local gunbeltaccs_m = {}
local gunbeltaccs_f = {}

local satchels_m = {}
local satchels_f = {}

local mustache_m = {}

local skirts_f = {}
--

cameraUsing = {
    {
        name = "Pernas",
        x = -1.0,
        y = 0.0,
        z = 0.5
    },
    {
        name = "Rosto",
        x = -0.5,
        y = 0.0,
        z = 0.6
    },
    {
        name = "Corpo",
        x = -1.3,
        y = 0.0,
        z = 0.4
    }
}

Citizen.CreateThread(
    function()
        while adding do
            Citizen.Wait(0)
            --print("Dzieje sie")
            for i, v in ipairs(MaleComp) do
                if v.category == "hats" then
                    table.insert(hats_m, v.Hash)
                elseif v.category == "spurs" then
                    table.insert(spurs_m, v.Hash)
                elseif v.category == "chaps" then
                    table.insert(chaps_m, v.Hash)
                elseif v.category == "cloaks" then
                    table.insert(cloaks_m, v.Hash)
                elseif v.category == "spats" then
                    table.insert(spats_m, v.Hash)
                elseif v.category == "eyewear" then
                    table.insert(eyewear_m, v.Hash)
                elseif v.category == "access" then
                    table.insert(access_m, v.Hash)
                elseif v.category == "armor" then
                    table.insert(armor_m, v.Hash)
                elseif v.category == "neckties" then
                    table.insert(neckties_m, v.Hash)
                elseif v.category == "bracelets" then
                    table.insert(bracelets_m, v.Hash)
                elseif v.category == "loadouts" then
                    table.insert(loadouts_m, v.Hash)
                elseif v.category == "suspenders" then
                    table.insert(suspenders_m, v.Hash)
                elseif v.category == "gauntlets" then
                    table.insert(gauntlets_m, v.Hash)
                elseif v.category == "belts" then
                    table.insert(belts_m, v.Hash)
                elseif v.category == "ponchos" then
                    table.insert(ponchos_m, v.Hash)
                elseif v.category == "offhand" then
                    table.insert(offhand_m, v.Hash)
                elseif v.category == "belt_buckles" then
                    table.insert(beltbuckle_m, v.Hash)
                elseif v.category == "shirts" then
                    table.insert(shirts_m, v.Hash)
                elseif v.category == "vests" then
                    table.insert(vests_m, v.Hash)
                elseif v.category == "pants" then
                    table.insert(pants_m, v.Hash)
                elseif v.category == "masks" then
                    table.insert(masks_m, v.Hash)
                elseif v.category == "coats" then
                    table.insert(coats_m, v.Hash)
                elseif v.category == "coats_closed" then
                    table.insert(coats2_m, v.Hash)
                elseif v.category == "boots" then
                    table.insert(boots_m, v.Hash)
                elseif v.category == "torsos" then
                    table.insert(torsos_m, v.Hash)
                elseif v.category == "legs" then
                    table.insert(legs_m, v.Hash)
                elseif v.category == "gloves" then
                    table.insert(gloves_m, v.Hash)
                elseif v.category == "neckwear" then
                    table.insert(neckwear_m, v.Hash)
                elseif v.category == "gunbelts" then
                    table.insert(gunbelts_m, v.Hash)
                elseif v.category == "ringsr" then
                    table.insert(ringsr_m, v.Hash)
                elseif v.category == "ringsl" then
                    table.insert(ringsl_m, v.Hash)
                elseif v.category == "dresses" then
                    table.insert(dresses_m, v.Hash)
                elseif v.category == "gunbeltaccs" then
                    table.insert(gunbeltaccs_m, v.Hash)
                elseif v.category == "satchels" then
                    table.insert(satchels_m, v.Hash)
                elseif v.category == "mustache" then
                    table.insert(mustache_m, v.Hash)
                end
            end
            adding = false
        end
    end
)

Citizen.CreateThread(
    function()
        while adding2 do
            Citizen.Wait(0)
            --print("Dzieje sie 2")
            for i, v in ipairs(FemaleComp) do
                if v.category == "hats" then
                    table.insert(hats_f, v.Hash)
                elseif v.category == "spurs" then
                    table.insert(spurs_f, v.Hash)
                elseif v.category == "chaps" then
                    table.insert(chaps_f, v.Hash)
                elseif v.category == "cloaks" then
                    table.insert(cloaks_f, v.Hash)
                elseif v.category == "spats" then
                    table.insert(spats_f, v.Hash)
                elseif v.category == "eyewear" then
                    table.insert(eyewear_f, v.Hash)
                elseif v.category == "access" then
                    table.insert(access_f, v.Hash)
                elseif v.category == "armor" then
                    table.insert(armor_f, v.Hash)
                elseif v.category == "neckties" then
                    table.insert(neckties_f, v.Hash)
                elseif v.category == "bracelets" then
                    table.insert(bracelets_f, v.Hash)
                elseif v.category == "loadouts" then
                    table.insert(loadouts_f, v.Hash)
                elseif v.category == "suspenders" then
                    table.insert(suspenders_f, v.Hash)
                elseif v.category == "gauntlets" then
                    table.insert(gauntlets_f, v.Hash)
                elseif v.category == "belts" then
                    table.insert(belts_f, v.Hash)
                elseif v.category == "ponchos" then
                    table.insert(ponchos_f, v.Hash)
                elseif v.category == "offhand" then
                    table.insert(offhand_f, v.Hash)
                elseif v.category == "belt_buckles" then
                    table.insert(beltbuckle_f, v.Hash)
                elseif v.category == "shirts" then
                    table.insert(shirts_f, v.Hash)
                elseif v.category == "vests" then
                    table.insert(vests_f, v.Hash)
                elseif v.category == "pants" then
                    table.insert(pants_f, v.Hash)
                elseif v.category == "boots" then
                    table.insert(boots_f, v.Hash)
                elseif v.category == "masks" then
                    table.insert(masks_f, v.Hash)
                elseif v.category == "coats" then
                    table.insert(coats_f, v.Hash)
                elseif v.category == "coats_closed" then
                    table.insert(coats2_f, v.Hash)
                elseif v.category == "skirts" then
                    table.insert(skirts_f, v.Hash)
                elseif v.category == "torsos" then
                    table.insert(torsos_f, v.Hash)
                elseif v.category == "legs" then
                    table.insert(legs_f, v.Hash)
                elseif v.category == "gloves" then
                    table.insert(gloves_f, v.Hash)
                elseif v.category == "neckwear" then
                    table.insert(neckwear_f, v.Hash)
                elseif v.category == "gunbelts" then
                    table.insert(gunbelts_f, v.Hash)
                elseif v.category == "ringsr" then
                    table.insert(ringsr_f, v.Hash)
                elseif v.category == "ringsl" then
                    table.insert(ringsl_f, v.Hash)
                elseif v.category == "dresses" then
                    table.insert(dresses_f, v.Hash)
                elseif v.category == "gunbeltaccs" then
                    table.insert(gunbeltaccs_f, v.Hash)
                elseif v.category == "satchels" then
                    table.insert(satchels_f, v.Hash)
                else
                end
            end
            adding2 = false
        end
    end
)

--[[RegisterCommand(
    "openClothingShopMenu",
    function(source, args)
        inCustomization = true
        hided = false
        CamActive = false
        cAPI.InFade(500)

        SetEveryoneAsInvisible()
    end
)]]

RegisterNetEvent("FRP:STORECLOTHES:OpenClothingMenu")
AddEventHandler(
    "FRP:STORECLOTHES:OpenClothingMenu",
    function()
        if not cAPI.IsWanted() then
            inCustomization = true
            hided = false
            CamActive = false
            cAPI.InFade(500)

            SetEveryoneAsInvisible()

            TriggerServerEvent('FRP:RequestShouldStoreIntoClothingItemButtonBeEnabled')

            --TriggerServerEvent('PersonaCreatorHandler.setPlayerRoutingBucket')
        else
            TriggerEvent("FRP:NOTIFY:Simple", "Você ainda está como procurado, não pode trocar de roupa. ", 10000)
        end
    end
)

function rotation(dir)
    local pedRot = GetEntityHeading(PlayerPedId()) + dir
    SetEntityHeading(PlayerPedId(), pedRot % 360)
end

RegisterNUICallback(
    "rotate",
    function(data, cb)
        local VAR = 45.0

        local playerPed = PlayerPedId()

        local addHeading = data["key"] ~= "left" and VAR or -(VAR)

        local currHeading = GetEntityHeading(playerPed)

        local desiredHeading = GetEntityHeading(playerPed) + addHeading

        if desiredHeading > 360 then
            desiredHeading = desiredHeading - 360.0
        end

        if desiredHeading < 0 then
            desiredHeading = desiredHeading + 360.0
        end

        desiredHeading = desiredHeading + 0.0001

        TaskAchieveHeading(playerPed, desiredHeading, -1)

        cb("ok")
    end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
            if inCustomization and not hided then
                SetNuiFocus(true, true)
                local hashm = GetEntityModel(PlayerPedId())

                local female = -1481695040
                local male = -171876066

                if hashm == female then
                    sex = "mp_female"
                elseif hashm == male then
                    sex = "mp_male"
                else
                    sex = "other"
                end

                if not CamActive then
                    createCamera()
                    CamActive = true
                end
                SendNUIMessage(
                    {
                        action = "show",
                        gender = sex
                    }
                )
            end
        end
    end
)

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

        SetEveryoneAsInvisible(false)

        DestroyAllCams(true)
    end
)

function SetEveryoneAsInvisible(invisible)
    -- local playerId = PlayerId()

    -- if invisible then
    --     NetworkSetEntityInvisibleToNetwork(PlayerPedId(), true)
    --     while inCustomization do
    --         Citizen.Wait(0)
    --         for _, pid in pairs(GetActivePlayers()) do
    --             if pid ~= playerId then
    --                 SetEntityVisible(GetPlayerPed(pid), false)
    --             end
    --         end
    --     end
    -- end

    -- for _, pid in pairs(GetActivePlayers()) do
    --     if pid ~= playerId then
    --         SetEntityVisible(GetPlayerPed(pid), true)
    --     end
    -- end

    -- NetworkSetEntityInvisibleToNetwork(PlayerPedId(), false)
end

function createCamera(centerPos, pedHeading)
    centerPos = gClosestShopCenterPos
    pedHeading = gClosestShopHeading

    local playerPed = PlayerPedId()

    local _, groundZ, _ = GetGroundZAndNormalFor_3dCoord(centerPos.x, centerPos.y, centerPos.z)

    SetEntityCoords(playerPed, centerPos.xy, groundZ or centerPos.z)
    SetEntityHeading(playerPed, pedHeading)

    -- FreezeEntityPosition(playerPed, true)

    createCameraInternal()
end

function createCameraInternal()
    local playerPed = PlayerPedId()

    local offsetPos = GetOffsetFromEntityInWorldCoords(playerPed, 1.1, 1.1, 0.1)

    fixedCam = CreateCam('DEFAULT_SCRIPTED_CAMERA')

    SetCamCoord(fixedCam, offsetPos)
    PointCamAtEntity(fixedCam, playerPed, 0.0, 0.0, 0.0, false)
    SetCamActive(fixedCam, true)
    RenderScriptCams(true, false, 1, true, true)

    -- It is blocking?
    cAPI.OutFade(500)

    createZoomInterpCamera(offsetPos)
end

HatUsing = nil
shirtsUsing = nil
VestsUsing = nil
PantsUsing = nil
BootsUsing = nil
MasksUsing = nil
CoatsUsing = nil
SkirtsUsing = nil
LegsUsing = nil
GlovesUsing = nil
NeckwearUsing = nil
GunbeltsUsing = nil
cloaksUsing = nil
coats2Using = nil

spursUsing = nil
chapsUsing = nil
spatsUsing = nil
eyewearUsing = nil
accessUsing = nil
armorUsing = nil
necktiesUsing = nil
braceletsUsing = nil
suspendersUsing = nil
gauntletsUsing = nil
beltsUsing = nil
ponchosUsing = nil
offhandUsing = nil
beltbuckleUsing = nil

ringsrUsing = nil
ringslUsing = nil

dressesUsing = nil
satchelsUsing = nil

jewelryRingsRightUsing = nil
jewelryRingsLeftUsing = nil
gunbeltAccsUsing = nil

RegisterNUICallback(
    "Chapeu",
    function(data)
        if tonumber(data.id) == 0 then
            num = 0
            HatUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x9925C067, 0) -- HAT REMOVE
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            if sex == "mp_male" then
                local num = tonumber(data.id)
                hash = ("0x" .. hats_m[num])
                setcloth(hash)
                HatUsing = ("0x" .. hats_m[num])
            else
                local num = tonumber(data.id)
                print(json.encode(data))
                hash = ("0x" .. hats_f[num])
                setcloth(hash)
                HatUsing = ("0x" .. hats_f[num])
            end
        end
    end
)

RegisterNUICallback(
    "Camisa",
    function(data)
        if tonumber(data.id) == 0 then
            num = 0
            shirtsUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x2026C46D, 0) -- Set target category, here the hash is for hats
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            if sex == "mp_male" then
                local num = tonumber(data.id)
                hash = ("0x" .. shirts_m[num])
                setcloth(hash)
                shirtsUsing = ("0x" .. shirts_m[num])
            else
                local num = tonumber(data.id)
                hash = ("0x" .. shirts_f[num])
                setcloth(hash)
                shirtsUsing = ("0x" .. shirts_f[num])
            end
        end
    end
)

RegisterNUICallback(
    "Colete",
    function(data)
        if tonumber(data.id) == 0 then
            num = 0
            VestsUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x485EE834, 0) -- Set target category, here the hash is for hats
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            if sex == "mp_male" then
                local num = tonumber(data.id)
                hash = ("0x" .. vests_m[num])
                setcloth(hash)
                VestsUsing = ("0x" .. vests_m[num])
            else
                local num = tonumber(data.id)
                hash = ("0x" .. vests_f[num])
                setcloth(hash)
                VestsUsing = ("0x" .. vests_f[num])
            end
        end
    end
)

RegisterNUICallback(
    "Calca",
    function(data)
        if tonumber(data.id) == 0 then
            num = 0
            PantsUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x1D4C528A, 0) -- Set target category, here the hash is for hats
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            if sex == "mp_male" then
                local num = tonumber(data.id)
                hash = ("0x" .. pants_m[num])
                setcloth(hash)
                PantsUsing = ("0x" .. pants_m[num])
            else
                local num = tonumber(data.id)
                hash = ("0x" .. pants_f[num])
                setcloth(hash)
                PantsUsing = ("0x" .. pants_f[num])
            end
        end
    end
)

RegisterNUICallback(
    "Sapato",
    function(data)
        if tonumber(data.id) == 0 then
            num = 0
            BootsUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x777EC6EF, 0) -- Set target category
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- REMOVE COMPONENT
        else
            if sex == "mp_male" then
                local num = tonumber(data.id)
                hash = ("0x" .. boots_m[num])
                setcloth(hash)
                BootsUsing = ("0x" .. boots_m[num])
            else
                local num = tonumber(data.id)
                hash = ("0x" .. boots_f[num])
                setcloth(hash)
                BootsUsing = ("0x" .. boots_f[num])
            end
        end
    end
)

RegisterNUICallback(
    "Mascara",
    function(data)
        if tonumber(data.id) == 0 then
            num = 0
            MasksUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x7505EF42, 0) -- Set target category, here the hash is for hats
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            if sex == "mp_male" then
                local num = tonumber(data.id)
                hash = ("0x" .. masks_m[num])
                setcloth(hash)
                MasksUsing = ("0x" .. masks_m[num])
            else
                local num = tonumber(data.id)
                hash = ("0x" .. masks_f[num])
                setcloth(hash)
                MasksUsing = ("0x" .. masks_f[num])
            end
        end
    end
)

RegisterNUICallback(
    "Casaco",
    function(data)
        if tonumber(data.id) == 0 then
            num = 0
            CoatsUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), `coats`, 0) -- Set target category, here the hash is for hats
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), `coats_closed`, 0) -- cloaks REMOVE
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
            if sex == "mp_male" then
                local num = tonumber(data.id)
                hash = ("0x" .. coats_m[num])
                setcloth(hash)
                CoatsUsing = ("0x" .. coats_m[num])
                coats2Using = 0
            else
                local num = tonumber(data.id)
                hash = ("0x" .. coats_f[num])
                setcloth(hash)
                CoatsUsing = ("0x" .. coats_f[num])
                coats2Using = 0
            end
        end
    end
)

RegisterNUICallback(
    "dresses",
    function(data)
        if tonumber(data.id) == 0 then
            num = 0
            dressesUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0xA2926F9B, 0) -- Set target category, here the hash is for hats
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0xA2926F9B, 0) -- cloaks REMOVE
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
            if sex == "mp_male" then
                local num = tonumber(data.id)
                hash = ("0x" .. dresses_m[num])
                setcloth(hash)
                dressesUsing = ("0x" .. dresses_m[num])
            else
                local num = tonumber(data.id)
                hash = ("0x" .. dresses_f[num])
                setcloth(hash)
                dressesUsing = ("0x" .. dresses_f[num])
            end
        end
    end
)

RegisterNUICallback(
    "gunbeltaccs",
    function(data)
        if tonumber(data.id) == 0 then
            num = 0
            gunbeltAccsUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0xF1542D11, 0) -- Set target category, here the hash is for hats
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0xF1542D11, 0) -- cloaks REMOVE
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
            if sex == "mp_male" then
                local num = tonumber(data.id)
                hash = ("0x" .. gunbeltaccs_m[num])
                setcloth(hash)
                gunbeltAccsUsing = ("0x" .. gunbeltaccs_m[num])
            else
                local num = tonumber(data.id)
                hash = ("0x" .. gunbeltaccs_f[num])
                setcloth(hash)
                gunbeltAccsUsing = ("0x" .. gunbeltaccs_f[num])
            end
        end
    end
)
RegisterNUICallback(
    "satchels",
    function(data)
        if tonumber(data.id) == 0 then
            num = 0
            satchelsUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x94504D26, 0) -- Set target category, here the hash is for hats
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x94504D26, 0) -- cloaks REMOVE
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
            if sex == "mp_male" then
                local num = tonumber(data.id)
                hash = ("0x" .. satchels_m[num])
                setcloth(hash)
                satchelsUsing = ("0x" .. satchels_m[num])
            else
                local num = tonumber(data.id)
                hash = ("0x" .. satchels_f[num])
                setcloth(hash)
                satchelsUsing = ("0x" .. satchels_f[num])
            end
        end
    end
)

RegisterNUICallback(
    "Saia",
    function(data)
        if tonumber(data.id) == 0 then
            num = 0
            SkirtsUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0xA0E3AB7F, 0) -- Set target category, here the hash is for hats
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            if sex == "mp_male" then
                -- local num = tonumber(data.id)
                -- hash = ("0x" .. mustache_m[num])
                -- setcloth(hash)
            else
                local num = tonumber(data.id)
                hash = ("0x" .. skirts_f[num])
                setcloth(hash)
                SkirtsUsing = ("0x" .. skirts_f[num])
            end
        end
    end
)

-- RegisterNUICallback(
--     'Legs',
--     function(data)
--         if tonumber(data.id) == 0 then
--             num = 0
--             LegsUsing = num
--         else
--             if sex == 'mp_male' then
--                 local num = tonumber(data.id)
--                 hash = ("0x" .. legs_m[num])
--                 setcloth(hash)
--                 LegsUsing = ("0x" .. legs_m[num])
--             else
--                 local num = tonumber(data.id)
--                 hash = ("0x" .. legs_f[num])
--                 setcloth(hash)
--                 LegsUsing = ("0x" .. legs_f[num])
--             end
--         end
--     end
-- )

RegisterNUICallback(
    "Luva",
    function(data)
        if tonumber(data.id) == 0 then
            num = 0
            GlovesUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0xEABE0032, 0) -- Set target category, here the hash is for hats
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            if sex == "mp_male" then
                local num = tonumber(data.id)
                hash = ("0x" .. gloves_m[num])
                setcloth(hash)
                GlovesUsing = ("0x" .. gloves_m[num])
            else
                local num = tonumber(data.id)
                hash = ("0x" .. gloves_f[num])
                setcloth(hash)
                GlovesUsing = ("0x" .. gloves_f[num])
            end
        end
    end
)

RegisterNUICallback(
    "spats",
    function(data)
        if tonumber(data.id) == 0 then
            num = 0
            SpatsUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x514ADCEA, 0) -- Set target category, here the hash is for hats
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            if sex == "mp_male" then
                local num = tonumber(data.id)
                hash = ("0x" .. spats_m[num])
                setcloth(hash)
                SpatsUsing = ("0x" .. spats_m[num])
            else
                local num = tonumber(data.id)
                hash = ("0x" .. spats_f[num])
                setcloth(hash)
                SpatsUsing = ("0x" .. spats_f[num])
            end
        end
    end
)

RegisterNUICallback(
    "Bandana",
    function(data)
        if tonumber(data.id) == 0 then
            num = 0
            NeckwearUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x5FC29285, 0) -- Set target category, here the hash is for hats
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            if sex == "mp_male" then
                local num = tonumber(data.id)
                hash = ("0x" .. neckwear_m[num])
                setcloth(hash)
                NeckwearUsing = ("0x" .. neckwear_m[num])
            else
                local num = tonumber(data.id)
                hash = ("0x" .. neckwear_f[num])
                setcloth(hash)
                NeckwearUsing = ("0x" .. neckwear_f[num])
            end
        end
    end
)

RegisterNUICallback(
    "Coldre",
    function(data)
        if tonumber(data.id) == 0 then
            num = 0
            GunbeltsUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x9B2C8B89, 0) -- Set target category, here the hash is for hats
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            if sex == "mp_male" then
                local num = tonumber(data.id)
                hash = ("0x" .. gunbelts_m[num])
                setcloth(hash)
                GunbeltsUsing = ("0x" .. gunbelts_m[num])
            else
                local num = tonumber(data.id)
                hash = ("0x" .. gunbelts_f[num])
                setcloth(hash)
                GunbeltsUsing = ("0x" .. gunbelts_f[num])
            end
        end
    end
)

RegisterNUICallback(
    "belt_buckles",
    function(data)
        if tonumber(data.id) == 0 then
            num = 0
            beltbuckleUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0xFAE9107F, 0) -- beltbuckle REMOVE
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            if sex == "mp_male" then
                local num = tonumber(data.id)
                hash = ("0x" .. beltbuckle_m[num])
                setcloth(hash)
                beltbuckleUsing = ("0x" .. beltbuckle_m[num])
            else
                local num = tonumber(data.id)
                hash = ("0x" .. beltbuckle_f[num])
                setcloth(hash)
                beltbuckleUsing = ("0x" .. beltbuckle_f[num])
            end
        end
    end
)

RegisterNUICallback(
    "Offhand",
    function(data)
        if tonumber(data.id) == 0 then
            num = 0
            offhandUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0xB6B6122D, 0) -- offhand REMOVE
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            if sex == "mp_male" then
                local num = tonumber(data.id)
                hash = ("0x" .. offhand_m[num])
                setcloth(hash)
                offhandUsing = ("0x" .. offhand_m[num])
            else
                local num = tonumber(data.id)
                hash = ("0x" .. offhand_f[num])
                setcloth(hash)
                offhandUsing = ("0x" .. offhand_f[num])
            end
        end
    end
)

RegisterNUICallback(
    "Ponchos",
    function(data)
        if tonumber(data.id) == 0 then
            num = 0
            ponchosUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0xAF14310B, 0) -- ponchos REMOVE
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            if sex == "mp_male" then
                local num = tonumber(data.id)
                hash = ("0x" .. ponchos_m[num])
                setcloth(hash)
                ponchosUsing = ("0x" .. ponchos_m[num])
            else
                local num = tonumber(data.id)
                hash = ("0x" .. ponchos_f[num])
                setcloth(hash)
                ponchosUsing = ("0x" .. ponchos_f[num])
            end
        end
    end
)

RegisterNUICallback(
    "belts",
    function(data)
        if tonumber(data.id) == 0 then
            num = 0
            beltsUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0xA6D134C6, 0) -- Belts REMOVE
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            if sex == "mp_male" then
                local num = tonumber(data.id)
                hash = ("0x" .. belts_m[num])
                setcloth(hash)
                beltsUsing = ("0x" .. belts_m[num])
            else
                local num = tonumber(data.id)
                hash = ("0x" .. belts_f[num])
                setcloth(hash)
                beltsUsing = ("0x" .. belts_f[num])
            end
        end
    end
)

RegisterNUICallback(
    "Gauntlets",
    function(data)
        if tonumber(data.id) == 0 then
            num = 0
            gauntletsUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x91CE9B20, 0) -- Gauntlets REMOVE
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            if sex == "mp_male" then
                local num = tonumber(data.id)
                hash = ("0x" .. gauntlets_m[num])
                setcloth(hash)
                gauntletsUsing = ("0x" .. gauntlets_m[num])
            else
                local num = tonumber(data.id)
                hash = ("0x" .. gauntlets_f[num])
                setcloth(hash)
                gauntletsUsing = ("0x" .. gauntlets_f[num])
            end
        end
    end
)

RegisterNUICallback(
    "Suspenders",
    function(data)
        if tonumber(data.id) == 0 then
            num = 0
            suspendersUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x877A2CF7, 0) -- Suspenders REMOVE
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            if sex == "mp_male" then
                local num = tonumber(data.id)
                hash = ("0x" .. suspenders_m[num])
                setcloth(hash)
                suspendersUsing = ("0x" .. suspenders_m[num])
            else
                local num = tonumber(data.id)
                hash = ("0x" .. suspenders_f[num])
                setcloth(hash)
                suspendersUsing = ("0x" .. suspenders_f[num])
            end
        end
    end
)

RegisterNUICallback(
    "ringsr",
    function(data)
        if tonumber(data.id) == 0 then
            num = 0
            jewelryRingsRightUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x7A6BBD0B, 0) -- Bracelets REMOVE
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            if sex == "mp_male" then
                local num = tonumber(data.id)
                hash = ("0x" .. ringsr_m[num])
                setcloth(hash)
                jewelryRingsRightUsing = ("0x" .. ringsr_m[num])
            else
                local num = tonumber(data.id)
                hash = ("0x" .. ringsr_f[num])
                setcloth(hash)
                jewelryRingsRightUsing = ("0x" .. ringsr_f[num])
            end
        end
    end
)
RegisterNUICallback(
    "ringsl",
    function(data)
        if tonumber(data.id) == 0 then
            num = 0
            jewelryRingsLeftUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0xF16A1D23, 0) -- Bracelets REMOVE
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            if sex == "mp_male" then
                local num = tonumber(data.id)
                hash = ("0x" .. ringsl_m[num])
                setcloth(hash)
                jewelryRingsLeftUsing = ("0x" .. ringsl_m[num])
            else
                local num = tonumber(data.id)
                hash = ("0x" .. ringsl_f[num])
                setcloth(hash)
                jewelryRingsLeftUsing = ("0x" .. ringsl_f[num])
            end
        end
    end
)
RegisterNUICallback(
    "Bracelets",
    function(data)
        if tonumber(data.id) == 0 then
            num = 0
            braceletsUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x7BC10759, 0) -- Bracelets REMOVE
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            if sex == "mp_male" then
                local num = tonumber(data.id)
                hash = ("0x" .. bracelets_m[num])
                setcloth(hash)
                braceletsUsing = ("0x" .. bracelets_m[num])
            else
                local num = tonumber(data.id)
                hash = ("0x" .. bracelets_f[num])
                setcloth(hash)
                braceletsUsing = ("0x" .. bracelets_f[num])
            end
        end
    end
)

RegisterNUICallback(
    "Neckties",
    function(data)
        if tonumber(data.id) == 0 then
            num = 0
            necktiesUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x7A96FACA, 0) -- Neckties REMOVE
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            if sex == "mp_male" then
                local num = tonumber(data.id)
                hash = ("0x" .. neckties_m[num])
                setcloth(hash)
                necktiesUsing = ("0x" .. neckties_m[num])
            else
                local num = tonumber(data.id)
                hash = ("0x" .. neckties_f[num])
                setcloth(hash)
                necktiesUsing = ("0x" .. neckties_f[num])
            end
        end
    end
)

RegisterNUICallback(
    "access",
    function(data)
        if tonumber(data.id) == 0 then
            num = 0
            accessUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x79D7DF96, 0) -- Access REMOVE
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            if sex == "mp_male" then
                local num = tonumber(data.id)
                hash = ("0x" .. access_m[num])
                setcloth(hash)
                accessUsing = ("0x" .. access_m[num])
            else
                local num = tonumber(data.id)
                hash = ("0x" .. access_f[num])
                setcloth(hash)
                accessUsing = ("0x" .. access_f[num])
            end
        end
    end
)

RegisterNUICallback(
    "armor",
    function(data)
        if tonumber(data.id) == 0 then
            num = 0
            armorUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x72E6EF74, 0) -- Access REMOVE
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            if sex == "mp_male" then
                local num = tonumber(data.id)
                hash = ("0x" .. armor_m[num])
                setcloth(hash)
                armorUsing = ("0x" .. armor_m[num])
            else
                local num = tonumber(data.id)
                hash = ("0x" .. armor_f[num])
                setcloth(hash)
                armorUsing = ("0x" .. armor_f[num])
            end
        end
    end
)

RegisterNUICallback(
    "Cloaks",
    function(data)
        if tonumber(data.id) == 0 then
            num = 0
            cloaksUsing = num

            print('cloack is 0')

            --Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), `cloaks`, 0) -- cloaks REMOVE
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x3C1A74CD, 0) -- cloaks REMOVE
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            if sex == "mp_male" then
                local num = tonumber(data.id)
                hash = ("0x" .. cloaks_m[num])
                setcloth(hash)
                cloaksUsing = ("0x" .. cloaks_m[num])
            else
                local num = tonumber(data.id)
                hash = ("0x" .. cloaks_f[num])
                setcloth(hash)
                cloaksUsing = ("0x" .. cloaks_f[num])
            end
        end
    end
)

RegisterNUICallback(
    "Jaqueta",
    function(data)
        if tonumber(data.id) == 0 then
            num = 0
            coats2Using = num
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), `coats`, 0) -- cloaks REMOVE
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), `coats_closed`, 0) -- cloaks REMOVE
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
            if sex == "mp_male" then
                local num = tonumber(data.id)
                hash = ("0x" .. coats2_m[num])
                setcloth(hash)
                coats2Using = ("0x" .. coats2_m[num])
                CoatsUsing = 0
            else
                local num = tonumber(data.id)
                hash = ("0x" .. coats2_f[num])
                setcloth(hash)
                coats2Using = ("0x" .. coats2_f[num])
                CoatsUsing = 0
            end
        end
    end
)

RegisterNUICallback(
    "Eyewear",
    function(data)
        if tonumber(data.id) == 0 then
            num = 0
            eyewearUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x5E47CA6, 0) -- Eyewear REMOVE
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            if sex == "mp_male" then
                local num = tonumber(data.id)
                hash = ("0x" .. eyewear_m[num])
                setcloth(hash)
                eyewearUsing = ("0x" .. eyewear_m[num])
            else
                local num = tonumber(data.id)
                hash = ("0x" .. eyewear_f[num])
                setcloth(hash)
                eyewearUsing = ("0x" .. eyewear_f[num])
            end
        end
    end
)

RegisterNUICallback(
    "Chaps",
    function(data)
        if tonumber(data.id) == 0 then
            num = 0
            chapsUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x3107499B, 0) -- Chaps REMOVE
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            if sex == "mp_male" then
                local num = tonumber(data.id)
                hash = ("0x" .. chaps_m[num])
                setcloth(hash)
                chapsUsing = ("0x" .. chaps_m[num])
            else
                local num = tonumber(data.id)
                hash = ("0x" .. chaps_f[num])
                setcloth(hash)
                chapsUsing = ("0x" .. chaps_f[num])
            end
        end
    end
)

RegisterNUICallback(
    "Spurs",
    function(data)
        if tonumber(data.id) == 0 then
            num = 0
            spursUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x18729F39, 0) -- SPURS REMOVE
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            if sex == "mp_male" then
                local num = tonumber(data.id)
                hash = ("0x" .. spurs_m[num])
                setcloth(hash)
                spursUsing = ("0x" .. spurs_m[num])
            else
                local num = tonumber(data.id)
                hash = ("0x" .. spurs_f[num])
                setcloth(hash)
                spursUsing = ("0x" .. spurs_f[num])
            end
        end
    end
)

RegisterNUICallback(
    "loadouts",
    function(data)
        if tonumber(data.id) == 0 then
            num = 0
            loadoutsUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x83887E88, 0) -- SPURS REMOVE
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            if sex == "mp_male" then
                local num = tonumber(data.id)
                hash = ("0x" .. loadouts_m[num])
                setcloth(hash)
                loadoutsUsing = ("0x" .. loadouts_m[num])
            else
                local num = tonumber(data.id)
                hash = ("0x" .. loadouts_f[num])
                setcloth(hash)
                loadoutsUsing = ("0x" .. loadouts_f[num])
            end
        end
    end
)

RegisterNUICallback(
    "Outfit",
    function(data)
        if tonumber(data.id) == 0 then
            num = 0
            OutfitUsing = num
        else
            local num = tonumber(data.id)
            SetPedOutfitPreset(PlayerPedId(), num)
            OutfitUsing = num
        end
    end
)

local Badge = false
RegisterCommand(
    "badge",
    function(source, args, rawCommand)
        if cAPI.hasGroupOrInheritance("recruta") or ("sheriff") or ("delegado") then
            if not Badge then
                setcloth2(IsPedMale(PlayerPedId()) and 0x1FC12C9C or `CLOTHING_ITEM_F_BADGE_000_TINT_001`)
                --  SetPedAsCop(PlayerPedId(),true)
                Citizen.InvokeNative(0xBB03C38DD3FB7FFD, PlayerPedId(), true)
                Badge = true
            else
                Citizen.InvokeNative(0xBB03C38DD3FB7FFD, PlayerPedId(), false)

                Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x3F7F3587, 0) -- Set target category, here the hash is for badges
                Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
                Badge = false
            end
        end
    end
)

function setcloth2(hash)
    NativeSetPedComponentEnabled(PlayerPedId(), tonumber(hash), true, true)

    NativeUpdatePedVariation(PlayerPedId())
end

function setcloth(hash)
    NativeSetPedComponentEnabled(PlayerPedId(), tonumber(hash), true, true)

    NativeUpdatePedVariation(PlayerPedId())
end

RegisterNUICallback(
    "Confirm",
    function()
        local dados = {
            ["hats"] = HatUsing,
            ["shirts"] = shirtsUsing,
            ["vests"] = VestsUsing,
            ["pants"] = PantsUsing,
            ["boots"] = BootsUsing,
            ["masks"] = MasksUsing,
            ["coats"] = CoatsUsing,
            ["skirts"] = SkirtsUsing,
            ["legs"] = LegsUsing,
            ["gloves"] = GlovesUsing,
            ["neckwear"] = NeckwearUsing,
            ["gunbelts"] = GunbeltsUsing,
            ["spurs"] = spursUsing,
            ["chaps"] = chapsUsing,
            ["spats"] = spatsUsing,
            ["eyewear"] = eyewearUsing,
            ["access"] = accessUsing,
            ["neckties"] = necktiesUsing,
            ["jewelry_bracelets"] = braceletsUsing,
            ["suspenders"] = suspendersUsing,
            ["gauntlets"] = gauntletsUsing,
            ["belts"] = beltsUsing,
            ["ponchos"] = ponchosUsing,
            ["offhand"] = offhandUsing,
            ["belt_buckles"] = beltbuckleUsing,
            ["cloaks"] = cloaksUsing,
            ["coats_closed"] = coats2Using,
            ["Outfit"] = OutfitUsing,
            ['jewelryRingsRight'] = jewelryRingsRightUsing,
            ['jewelryRingsLeft'] = jewelryRingsLeftUsing,
            ['gunbeltAccs'] = gunbeltAccsUsing,
        }

        TriggerServerEvent("FRP:CLOTHES:payClothing", 0, dados, true)
        
        DestroyClothingMenu()

        cAPI.InFade(500)

        if positionBack ~= nil then
            SetEntityCoords(PlayerPedId(), positionBack)
        end

        cAPI.OutFade(500)
    end
)

RegisterNUICallback(
    "fechar",
    function()
        TriggerServerEvent("FRP:CLOTHES:fechar", dados, true)

        DestroyClothingMenu()

        cAPI.InFade(500)

        if positionBack ~= nil then
            SetEntityCoords(PlayerPedId(), positionBack)
        end
        
        cAPI.OutFade(500)
    end
)

RegisterNetEvent("FRP:CLOTHES:DrawOldClothing")
AddEventHandler(
    "FRP:CLOTHES:DrawOldClothing",
    function()
        DestroyClothingMenu()

        cAPI.InFade(500)
        
        if positionBack ~= nil then
            SetEntityCoords(PlayerPedId(), positionBack)
        end
        
        cAPI.OutFade(500)
    end
)

RegisterNetEvent("FRP:CLOTHES:SaveClothing")
AddEventHandler(
    "FRP:CLOTHES:SaveClothing",
    function()
        local dados = {
            ["hat"] = HatUsing,
            ["shirts"] = shirtsUsing,
            ["vests"] = VestsUsing,
            ["pants"] = PantsUsing,
            ["boots"] = BootsUsing,
            ["masks"] = MasksUsing,
            ["coats"] = CoatsUsing,
            ["skirts"] = SkirtsUsing,
            ["legs"] = LegsUsing,
            ["gloves"] = GlovesUsing,
            ["neckwear"] = NeckwearUsing,
            ["gunbelts"] = GunbeltsUsing,
            ["spurs"] = spursUsing,
            ["chaps"] = chapsUsing,
            ["spats"] = spatsUsing,
            ["eyewear"] = eyewearUsing,
            ["access"] = accessUsing,
            ["neckties"] = necktiesUsing,
            ["bracelets"] = braceletsUsing,
            ["suspenders"] = suspendersUsing,
            ["gauntlets"] = gauntletsUsing,
            ["belts"] = beltsUsing,
            ["ponchos"] = ponchosUsing,
            ["offhand"] = offhandUsing,
            ["beltbuckle"] = beltbuckleUsing,
            ["cloaks"] = cloaksUsing,
            ["coats2"] = coats2Using,
            ["Outfit"] = OutfitUsing
        }

        -- Esse codepath se quer é usado?
        -- TriggerServerEvent("FRP:CLOTHES:SavePlayerClothing", dados, true)
        DestroyClothingMenu()
        
        if positionBack ~= nil then
            SetEntityCoords(PlayerPedId(), positionBack)
        end

        cAPI.OutFade(500)
    end
)


function DestroyClothingMenu()
    DestroyAllCams(true)
    SetNuiFocus(false, false)
    DisplayHud(true)

    inCustomization = false
    hided = false

    DestroyCam(fixedCam)
    DestroyCam(gZoomInterpolationCam)

    FreezeEntityPosition(PlayerPedId(), false)

    fixedCam = nil
    gZoomInterpolationCam = nil

    CamActive = false

    SendNUIMessage(
        {
            action = "hide"
        }
    )

    --TriggerServerEvent('PersonaCreatorHandler.setPlayerToGlobalRoutingBucket')
end

Citizen.CreateThread(
    function()
        local shops = {
            --    vector3(-762.85, -1291.97, 43.84), -- Blackwater
            --    vector3(2549.83, -1160.05, 53.73), -- SAINT DENIS

            -- Valentine
            {
                position = vec3(-329.393, 774.892, 120.834),
                heading = 286.07,
            },
            {
                position = vec3(-325.872,759.647,120.655),
                heading = -45.34,
            },

            -- BlackWater.
            {
                position = vec3(-767.693, -1294.545, 43.041),
                heading = 286.07,
            },

            -- Saint Denis
            {
                position = vec3(2556.891, -1160.544, 52.723),
                heading = 89.69,
            },

            -- Strawberry
            {
                position = vec3(-1820.330,-367.655,166.506),
                heading = -119.0,
            },

            -- Indios Wallace.
            {
                position = vec3(468.504, 2242.064, 248.158),
                heading = -100.0,
            },

            -- Indios Manzanita.
            {
                position = vec3(-2680.817,-1460.656,146.288),
                heading = -40.27,
            },

            -- Indios Neve.
            {
                position = vec3(-1630.792,1251.754,347.326),
                heading = -74.32,
            },
        }

        while true do
            Citizen.Wait(0)

            local pPosition = GetEntityCoords(PlayerPedId())

            for _, shopInfo in pairs(shops) do
                local shopPos = shopInfo.position

                if #(pPosition - shopPos) <= 1.5 then
                    positionBack = shopPos

                    gClosestShopCenterPos = shopPos
                    gClosestShopHeading = shopInfo.heading

                    DrawTxt("Pressione ALT para abrir a loja de roupas.", 0.85, 0.95, 0.35, 0.35, true, 255, 255, 255, 200, true, 10000)

                    if IsControlJustReleased(0, 0xE8342FF2) then -- LEFT ALT
                        TriggerEvent("FRP:STORECLOTHES:OpenClothingMenu")
                    end
                end
            end
        end
    end
)

function NativeSetPedComponentEnabled(ped, componentHash, immediately, isMp)
    local categoryHash = NativeGetPedComponentCategory(not IsPedMale(ped), componentHash)
    -- print(componentHash, categoryHash, NativeGetMetapedType(ped))

    Citizen.InvokeNative(0xD3A7B003ED343FD9, ped, componentHash, immediately, isMp, true)

    RefreshShopItemsOnMetaped(ped, categoryHash)
end

function NativeUpdatePedVariation(ped)
    Citizen.InvokeNative(0xCC8CA3E88256E58F, ped, false, true, true, true, false)
end

function RefreshShopItemsOnMetaped(ped, categoryHash)
    -- _REFRESH_SHOP_ITEMS_ON_METAPED
    Citizen.InvokeNative(0x59BD177A1A48600A, ped, categoryHash)
end

function NativeIsPedComponentEquipped(ped, componentHash)
    return Citizen.InvokeNative(0xFB4891BD7578CDC1, ped, componentHash)
end

function NativeGetPedComponentCategory(isFemale, componentHash)
    return Citizen.InvokeNative(0x5FF9A878C3D115B8, componentHash, isFemale, true)
end

function NativeGetMetapedType(ped)
    return Citizen.InvokeNative(0xEC9A1261BF0CE510, ped)
end

function NativeHasPedComponentLoaded(ped)
    return Citizen.InvokeNative(0xA0BC8FAED8CFEB3C, ped)
end

function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str, Citizen.ResultAsLong())
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
    SetTextCentre(centre)
    if enableShadow then
        SetTextDropshadow(1, 0, 0, 0, 255)
    end
    Citizen.InvokeNative(0xADA9255D, 10)
    DisplayText(str, x, y)
end

RegisterNetEvent('FRP:ResponseShouldStoreIntoClothingItemButtonBeEnabled', function(shouldBeEnabled)
    SendNUIMessage({
        action = 'setStoreIntoClothingItemButtonAsEnabled',
        value = shouldBeEnabled,
    })
end)

local ACTUAL_CLOTHING_PIECE_SHOPITEM_CATEGORIES = {
    [`BOOT_ACCESSORIES`] = 'boot_accessories',
    [`PANTS`] = 'pants',
    [`CLOAKS`] = 'cloaks',
    [`HATS`] = 'hats',
    [`VESTS`] = 'vests',
    [`CHAPS`] = 'chaps',
    [`SHIRTS`] = 'shirts',
    [`SHIRTS_FULL`] = 'shirts_full',
    [`BADGES`] = 'badges',
    [`MASKS`] = 'masks',
    [`SPATS`] = 'spats',
    [`NECKWEAR`] = 'neckwear',
    [`BOOTS`] = 'boots',
    [`ACCESSORIES`] = 'access',
    [`JEWELRY_RINGS_RIGHT`] = 'jewelry_rings_right',
    [`JEWELRY_RINGS_LEFT`] = 'jewelry_rings_left',
    [`JEWELRY_BRACELETS`] = 'jewelry_bracelets',
    [`GAUNTLETS`] = 'gauntlets',
    [`NECKTIES`] = 'neckties',
    [`HOLSTERS_KNIFE`] = 'holsters_knife',
    [`TALISMAN_HOLSTER`] = 'talisman_holster',
    [`LOADOUTS`] = 'loadouts',
    [`SUSPENDERS`] = 'suspenders',
    [`TALISMAN_SATCHEL`] = 'talisman_satchel',
    [`SATCHELS`] = 'satchels',
    [`GUNBELTS`] = 'gunbelts',
    [`BELTS`] = 'belts',
    [`BELT_BUCKLES`] = 'belt_buckles',
    [`HOLSTERS_LEFT`] = 'holsters_left',
    [`HOLSTERS_RIGHT`] = 'holsters_right',
    [`AMMO_RIFLES`] = 'ammo_rifles',
    [`TALISMAN_WRIST`] = 'talisman_wrist',
    [`COATS`] = 'coats',
    [`COATS_CLOSED`] = 'coats2',
    [`PONCHOS`] = 'ponchos',
    [`ARMOR`] = 'armor',
    [`GLOVES`] = 'gloves',
    [`TALISMAN_BELT`] = 'talisman_belt',
    [`AMMO_PISTOLS`] = 'ammo_pistols',
    [`HOLSTERS_CROSSDRAW`] = 'holsters_crossdraw',
    [`APRONS`] = 'aprons',
    [`SKIRTS`] = 'skirts',
    [`MASKS_LARGE`] = 'MASKS_LARGE',
    [`EYEWEAR`] = 'eyewear',
    [`GUNBELT_ACCS`] = 'gunbelt_accs',
    [`DRESSES`] = 'dresses',
}

RegisterNetEvent('storeCurrentComponentsIntoClothingItem', function(slotId)
    local clothingPieceShopitemsAsHex = { }

    local playerPed = PlayerPedId()

    -- GetMetaPedType
    local metapedType = N_0xec9a1261bf0ce510(playerPed)

    local toRemoveClothingPieces = { }

    RefreshShopItemsOnMetaped()

    -- GetNumComponentsInPed
    for i = 1, N_0x90403e8107b60e81(playerPed) do

        local shopitemHash = exports[GetCurrentResourceName()]:GetPedComponentAtIndex(playerPed, i - 1);

        if shopitemHash ~= 0 then
            -- GetPedComponentCategory
            local shopitemCategoryHash = N_0x5ff9a878c3d115b8(shopitemHash, metapedType, true)

            if ACTUAL_CLOTHING_PIECE_SHOPITEM_CATEGORIES[shopitemCategoryHash] then
                table.insert(clothingPieceShopitemsAsHex, ('0x%x'):format(shopitemHash & 0xFFFFFFFF) )

                -- Remover também o componente atual, já que a gente tá guardando a informação no item.
                -- RemoveTagFromMetaPed
                Citizen.InvokeNative(0xD710A5007C2AC539, playerPed, shopitemCategoryHash, true)

                NativeUpdatePedVariation(playerPed)

                local thisScriptCategoryEquivalent = ACTUAL_CLOTHING_PIECE_SHOPITEM_CATEGORIES[shopitemCategoryHash]
    
                if thisScriptCategoryEquivalent and thisScriptCategoryEquivalent ~= true then
                    toRemoveClothingPieces[thisScriptCategoryEquivalent] = true
                end
            end
        end
    end

    TriggerServerEvent('FRP:RequestStoreComponentsIntoClothingItem', slotId, clothingPieceShopitemsAsHex)

    TriggerServerEvent('RemovePlayerClothingPieces', toRemoveClothingPieces, true)

    RefreshShopItemsOnMetaped()
end)

RegisterNetEvent('FRP:SetPlayerClothingFromClothingItem', function(clothingPieceShopitemsAsHex)
    local playerPed = PlayerPedId()

    RefreshShopItemsOnMetaped()

    -- Remover todas os componentes atuais.
    for shopitemCategoryHash, _ in pairs(ACTUAL_CLOTHING_PIECE_SHOPITEM_CATEGORIES) do
        -- RemoveShopItemFromPedByCategory
        -- Citizen.InvokeNative(0xDF631E4BCE1B1FC4, playerPed, shopitemCategoryHash, 0, 1)

        -- RemoveTagFromMetaPed
        Citizen.InvokeNative(0xD710A5007C2AC539, playerPed, shopitemCategoryHash, true)

        NativeUpdatePedVariation(playerPed)
    end 

    local toAddClothingPieces = { }

    -- GetMetaPedType
    local metapedType = N_0xec9a1261bf0ce510(playerPed)

    -- Aplicar os componentes do item.
    for _, clothingShopitemAsHex in ipairs(clothingPieceShopitemsAsHex) do
        local shopitemHash = tonumber(clothingShopitemAsHex)

        NativeSetPedComponentEnabled(playerPed, shopitemHash, false, true, true)
        NativeUpdatePedVariation(playerPed)

        local shopitemCategoryHash = N_0x5ff9a878c3d115b8(shopitemHash, metapedType, true)

        if ACTUAL_CLOTHING_PIECE_SHOPITEM_CATEGORIES[shopitemCategoryHash] then
            local thisScriptCategoryEquivalent = ACTUAL_CLOTHING_PIECE_SHOPITEM_CATEGORIES[shopitemCategoryHash]

            if thisScriptCategoryEquivalent and thisScriptCategoryEquivalent ~= true then
                toAddClothingPieces[thisScriptCategoryEquivalent] = ('0x%x'):format(shopitemHash & 0xFFFFFFFF)
            end
        end
    end

    TriggerServerEvent('AddPlayerClothingPieces', toAddClothingPieces)

    RefreshShopItemsOnMetaped()
end)

function createZoomInterpCamera(cameraPos)
    if not gZoomInterpolationCam then
        gZoomInterpolationCam = CreateCam("DEFAULT_SCRIPTED_CAMERA")

        SetCamCoord(gZoomInterpolationCam, cameraPos)
        PointCamAtEntity(gZoomInterpolationCam, PlayerPedId(), 0.0, 0.0, 0.0, false)
        SetCamActive(gZoomInterpolationCam, true)
    end
end

RegisterNUICallback('mouseWheelMovement', function(data, cb)
    -- Do not zoom in/out if one of the cams is interpolating.
    if not fixedCam or IsCamInterpolating(fixedCam) or IsCamInterpolating(gZoomInterpolationCam) then
        return
    end
    
    local isZoomIn = data.isUp

    local function interpolateToCamWithFovKeepPointing(from, to)
        -- clear cam pointing because it will override setting rotation.
        StopCamPointing(to)

        SetCamRot(to, GetCamRot(from, 2), 2)

        local FOV_VAR = 25.0

        local fromCamFov = GetCamFov(from)

        local newFov = isZoomIn and (fromCamFov - FOV_VAR) or (fromCamFov + FOV_VAR)
        newFov = math.min(newFov, 70.0)

        SetCamFov(to, newFov)
        SetCamActiveWithInterp(to, from, 100, true, true)
    end

    if IsCamRendering(fixedCam) then
        interpolateToCamWithFovKeepPointing(fixedCam, gZoomInterpolationCam)
    else
        interpolateToCamWithFovKeepPointing(gZoomInterpolationCam, fixedCam)
    end

    cb({ })
end)

RegisterNUICallback('mouseLeftClick', function(data, cb)
    if not fixedCam or IsCamInterpolating(fixedCam) or IsCamInterpolating(gZoomInterpolationCam) then
        return
    end

    local _, hit, raycastHitPos = GetRaycastHitPositionFromNUIMouse(data.screenW, data.screenH, data.mouseX, data.mouseY)

    if hit == 0 then
        return
    end

    local function interpolateToCamKeepFov(from, to)
        local pointAtXY = GetEntityCoords(PlayerPedId()).xy
        local pointAtZ = raycastHitPos.z -- math.min(raycastHitPos.z, 122.0)

        PointCamAtCoord(to, pointAtXY, pointAtZ)

        -- Keep the old camera's FOV.
        SetCamFov(to, GetCamFov(from))
    
        SetCamActiveWithInterp(to, from, 500, true, true)
    end

    if IsCamRendering(fixedCam) then
        interpolateToCamKeepFov(fixedCam, gZoomInterpolationCam)
    else
        interpolateToCamKeepFov(gZoomInterpolationCam, fixedCam)
    end

    cb({ })
end)

local glm = require("glm")

function ScreenPositionToCameraRay(screenX, screenY, screenW, screenH)
    local pos = GetFinalRenderedCamCoord()
    local rot = glm.rad(GetFinalRenderedCamRot(2))

    local q = glm.quatEulerAngleZYX(rot.z, rot.y, rot.x)
    return pos,glm.rayPicking(
        q * glm.forward(),
        q * glm.up(),
        glm.rad(GetFinalRenderedCamFov()),
        (screenW / screenH),
        0.10000, -- GetFinalRenderedCamNearClip(),
        10000.0, -- GetFinalRenderedCamFarClip(),
        screenX * 2 - 1, -- scale mouse coordinates from [0, 1] to [-1, 1]
        screenY * 2 - 1
    )
end

function GetRaycastHitPositionFromNUIMouse(w, h, mouseX, mouseY)
    local mx = mouseX / w
    local my = mouseY / h

    -- Create a ray from the camera origin that extends through the mouse cursor
    local r_pos, r_dir = ScreenPositionToCameraRay(mx, my, w, h)
    local b = r_pos + 10000 * r_dir

    -- StartExpensiveSynchronousShapeTestLosProbe
    local handle = Citizen.InvokeNative(0x377906D8A31E5586, r_pos.x, r_pos.y, r_pos.z, b.x, b.y, b.z, 4 | 8, 0, 7)

    local _, hit, pos, surface, entity = GetShapeTestResult(handle)
    
    return _, hit, pos, surface, entity
end

-- local CATEGORIES = {
    -- "boot_accessories",
    -- "pants",
    -- "cloaks",
    -- "hats",
    -- "vests",
    -- "chaps",
    -- "shirts",
    -- "shirts_full",
    -- "badges",
    -- "masks",
    -- "spats",
    -- "neckwear",
    -- "boots",
    -- "accessories",
    -- "jewelry_rings_right",
    -- "jewelry_rings_left",
    -- "jewelry_bracelets",
    -- "gauntlets",
    -- "neckties",
    -- "holsters_knife",
    -- "talisman_holster",
    -- "loadouts",
    -- "suspenders",
    -- "talisman_satchel",
    -- "satchels",
    -- "gunbelts",
    -- "belts",
    -- "belt_buckles",
    -- "holsters_left",
    -- "holsters_right",
    -- "ammo_rifles",
    -- "talisman_wrist",
    -- "coats",
    -- "coats_closed",
    -- "ponchos",
    -- "armor",
    -- "eyewear",
    -- "gloves",
    -- "talisman_belt",
    -- "ammo_pistols",
    -- "holsters_crossdraw",
    -- "aprons",
    -- "skirts",
    -- "MASKS_LARGE",
    -- "heads",
    -- "hair",
    -- "BODIES_LOWER",
    -- "teeth",
    -- "BODIES_UPPER",
    -- "eyes",
    -- "beards_chin",
    -- "beards_chops",
    -- "beards_mustache",
    -- "gunbelt_accs",
    -- "hair_accessories",
    -- "dresses",
-- }

-- local CATEGORY_HASH_TO_NAME = { }

-- do
--     for _, categoryName in ipairs(CATEGORIES) do
--         CATEGORY_HASH_TO_NAME[GetHashKey(categoryName)] = categoryName
--     end
-- end

-- CreateThread(function()

--     local jsonComponents = json.decode(json.encode(COMPONENTS))

--     local playerPed = PlayerPedId()

--     -- GetMetaPedType
--     -- local pedMetapedType = Citizen.InvokeNative(0xEC9A1261BF0CE510, playerPed, Citizen.ResultAsInteger())

--     -- print('pedMetapedType', pedMetapedType)

--     print('9CDC866A', Citizen.InvokeNative(0x5FF9A878C3D115B8, tonumber('0x9CDC866A'), 0, true))

--     local pedMetapedTypeMale = 0 -- MPT_MALE
--     local pedMetapedTypeFemale = 1 -- MPT_FEMALE

--     local outIndex = 1
--     local outJson = { }

--     local left = 1

--     for i, entry in pairs(jsonComponents) do

--         if left <= 0 then
--             break
--         end

--         local shopItemCategoryHashAssumed = entry.Hash

--         local shopItemHash = tonumber('0x' .. shopItemCategoryHashAssumed)

--         -- GetPedComponentCategory
--         local shopItemCategoryHash = Citizen.InvokeNative(0x5FF9A878C3D115B8, shopItemHash, pedMetapedTypeMale, true)
--                                     or Citizen.InvokeNative(0x5FF9A878C3D115B8, shopItemHash, pedMetapedTypeFemale, true)

--         if not shopItemCategoryHash then
--             goto continue
--         end

--         local shopItemCategoryName = CATEGORY_HASH_TO_NAME[shopItemCategoryHash]

--         if not shopItemCategoryName then
--             goto continue
--         end

--         print( ('{ Hash = \'%s\', category = \'%s\' },'):format(shopItemCategoryHashAssumed, shopItemCategoryName) )

--         outIndex = outIndex + 1

--         :: continue ::
--     end
-- end)