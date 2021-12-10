local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Tunnel.getInterface("API")
cAPI = Proxy.getInterface("API")

adding = true
cam = nil
spawnedCamera = nil
choosePed = {}
pedSelected = PlayerPedId()
sex = nil
positionBack = nil

InterP = false
zoom = 1.0
offset = 0.5
fixedCam = nil
tempCam2 = nil
tempCam = nil
groundCam = nil


cameraUsing = {
    {
        name = "Pernas",
        x = -1.0,
        y = 0.0,
        z = 0.5
    },
    {
        name = "Rosto",
        x=-0.5,
        y=0.0,
        z=0.6,
    },
    {
        name = "Corpo",
        x = -1.3,
        y = 0.0,
        z = 0.4
    }
}

function rotation(dir)
    local pedRot = GetEntityHeading(PlayerPedId()) + dir
    SetEntityHeading(PlayerPedId(), pedRot % 360)
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

function createCamera(playerPed, shopPosition)

    SetEntityCoords(playerPed, shopPosition.position)

    local offsetCamera = shopPosition.camera

    local cameraPosition = GetOffsetFromEntityInWorldCoords(playerPed, offsetCamera.x, offsetCamera.y, offsetCamera.z)

    SetFocusPosAndVel(shopPosition.position, vec3(0.0, 0.0, 0.0))

    groundCam = CreateCam('DEFAULT_SCRIPTED_CAMERA', cameraPosition)

    SetCamCoord(groundCam, cameraPosition)

    SetCamRot(groundCam, -10.0, 0.0, 152.09)

    SetCamActive(groundCam, true)

    RenderScriptCams(true, false, 1, true, true)

    fixedCam = CreateCam('DEFAULT_SCRIPTED_CAMERA')

    SetCamCoord(fixedCam, cameraPosition)

    SetCamRot(fixedCam, 90, 500, 80.09)

    Wait(3000)

    cAPI.OutFade(500)

    SetEntityHeading(playerPed, shopPosition.heading)

    TriggerEvent('FRP:NOTIFY:Simple', 'Utilize as teclas A e D para rotacionar o personagem, e as setas do teclado para selecionar as opções.', 10000)

    SetCamActive(fixedCam, true)

    SetCamActiveWithInterp(fixedCam, groundCam, 3900, true, true)

    Wait(3900)

    DestroyCam(groundCam)

end

function createPeds()
    for k, v in pairs(peds) do
        if choosePed[k] == nil then
            local waiting = 0
            local hash = GetHashKey(peds[k].genrer)
            RequestModel(hash)
            while not HasModelLoaded(hash) do
                Citizen.Wait(10)
            end
            choosePed[k] = CreatePed(hash, peds[k].x, peds[k].y, peds[k].z - 0.5, peds[k].h, false, 0)
            Citizen.InvokeNative(0x283978A15512B2FE, choosePed[k], true)
            Citizen.InvokeNative(0x58A850EAEE20FAA3, choosePed[k])
            -- NetworkSetEntityInvisibleToNetwork(choosePed[k], true)
            SetVehicleHasBeenOwnedByPlayer(choosePed[k], true)
        -- SetModelAsNoLongerNeeded(hash)
        end
    end
end

HairUsing = nil
MustacheUsing = nil
HatUsing = nil
ShirtsUsing = nil
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
necktiesUsing = nil
braceletsUsing = nil
suspendersUsing = nil
gauntletsUsing = nil
beltsUsing = nil
ponchosUsing = nil
offhandUsing = nil
beltbuckleUsing = nil
RegisterNUICallback(
    "FaceFeatured",
    function(data)
        if sex == "mp_male" then
            interpCamera2("Rosto", pedSelected)   
        else
            interpCamera2("Rosto", pedSelected)   
        end
        local ped = pedSelected
        local index = tonumber(data.facefeature)
        local value = tonumber(data.id)
        Citizen.InvokeNative(0x5653AB26C82938CF, ped, index, value)
        Citizen.InvokeNative(0xCC8CA3E88256E58F, ped, false, true, true, true, false)
    end
)

RegisterNUICallback(
    "PedSize",
    function(data)
        if sex == "mp_male" then
            interpCamera2("Rosto", pedSelected)   
        else
            interpCamera2("Rosto", pedSelected)   
        end
        local ped = pedSelected



        local value = tonumber(data.id)
        local isPositive =  value > 185
        local variation = (math.abs(185 - value) * 0.005333)
        if not isPositive then 
          variation = -(variation)
        end

        SetPedScale(ped, 1.0 + variation)

        PedScaleUsing = 1.0 + variation
    end
)
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
            ShirtsUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x2026C46D, 0) -- Set target category, here the hash is for hats
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            if sex == "mp_male" then
                local num = tonumber(data.id)
                hash = ("0x" .. shirts_m[num])
                setcloth(hash)
                ShirtsUsing = ("0x" .. shirts_m[num])
            else
                local num = tonumber(data.id)
                hash = ("0x" .. shirts_f[num])
                setcloth(hash)
                ShirtsUsing = ("0x" .. shirts_f[num])
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
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x662AC34, 0) -- Set target category, here the hash is for hats
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0xE06D30CE, 0) -- cloaks REMOVE
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
    "Cabelos",
    function(data)
        if tonumber(data.id) == 0 then
            num = 0
            HairUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x864B03AE, 0) -- Set target category, here the hash is for hats
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            if sex == "mp_male" then
                for k, v in pairs(MaleHairs) do
                    if MaleHairs[k].id == tonumber(data.id) then
                        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), MaleHairs[k].hash, true, true, true)
                        HairUsing = MaleHairs[k].hash
                    end
                end
            else
                for k, v in pairs(FemaleHairs) do
                    if FemaleHairs[k].id == tonumber(data.id) then
                        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), FemaleHairs[k].hash, true, true, true)
                        HairUsing = FemaleHairs[k].hash
                    end
                end
            end
        end
    end
)

RegisterNUICallback(
    "BarbaMenu",
    function(data)
        if tonumber(data.id) == 0 then
            num = 0
            MustacheUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0xF8016BCA, 0) -- Set target category, here the hash is for hats
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            if sex == "mp_male" then
                for k, v in pairs(MaleMustache) do
                    if MaleMustache[k].id == tonumber(data.id) then
                        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), MaleMustache[k].hash, true, true, true)
                        MustacheUsing = MaleMustache[k].hash
                    end
                end
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
    "Beltbuckle",
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
    "Belts",
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
    "Access",
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
    "Cloaks",
    function(data)
        if tonumber(data.id) == 0 then
            num = 0
            cloaksUsing = num
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
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0xE06D30CE, 0) -- cloaks REMOVE
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x662AC34, 0) -- cloaks REMOVE
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

function setcloth2(hash)
    local model2 = hash
    if not HasModelLoaded(model2) then
        Citizen.InvokeNative(0xFA28FE3A6246FC30, model2)
    end

    NativeSetPedComponentEnabled(PlayerPedId(), tonumber(hash), true, true)
    --Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(hash), true, true, true)
end


function setcloth(hash)
    local model2 = GetHashKey(tonumber(hash))
    if not HasModelLoaded(model2) then
        Citizen.InvokeNative(0xFA28FE3A6246FC30, model2)
    end

    NativeSetPedComponentEnabled(PlayerPedId(), tonumber(hash), true, true)
    --Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(hash), true, true, true)
end



RegisterNUICallback(
    "Confirm",
    function()
        local dados = {
            ["mustache"] = MustacheUsing,
            ["hair"] = HairUsing
        }

        TriggerServerEvent("FRP:CLOTHES:payClothing", 150, dados, true)
        TriggerServerEvent("FRP:CLOTHES:SavePlayerClothing", dados, true)
        DestroyClothingMenu()
        cAPI.InFade(500)
        if positionBack ~= nil then
            SetEntityCoords(PlayerPedId(), positionBack)
        end
        Wait(4000)
        Citizen.InvokeNative(0xF1CA12B18AEF5298, PlayerPedId(), false)
        NetworkSetEntityInvisibleToNetwork(PlayerPedId(), false)
        --SetEntityVisible(PlayerPedId(), true)
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
        Wait(4000)
        Citizen.InvokeNative(0xF1CA12B18AEF5298, PlayerPedId(), false)
        NetworkSetEntityInvisibleToNetwork(PlayerPedId(), false)
        --SetEntityVisible(PlayerPedId(), true)
        cAPI.OutFade(500)
        ClearFocus()
    end
)


function DestroyClothingMenu()
    DestroyAllCams(true)
    SetNuiFocus(false, false)
    DisplayHud(true)

    SendNUIMessage(
        {
            action = "hide"
        }
    )
end

CreateThread(function()

    cAPI.OutFade(500)

    local shops = {
        -- Valentine
        {
            position = vec3(-307.851, 813.354, 118.012),
            heading = -101.76,
            camera = {
                x = 0.4,
                y = 0.8,
                z = 0.5
            }
        },
        -- Blackwater
        {
            position = vec3(-816.572, -1368.756, 42.773),
            heading = -105.00,
            camera = {
                x = 0.7,
                y = -0.4,
                z = 0.5
            }
        },
        {
            position = vec3(-816.724, -1367.107, 42.773),
            heading = -105.00,
            camera = {
                x = 0.7,
                y = -0.4,
                z = 0.5
            }
        }
    }

    while true do

        Wait(0)

        local playerPed = PlayerPedId()

        local playerPosition = GetEntityCoords(PlayerPedId())

        for i = 1, #shops do

            if #(playerPosition - shops[i].position) <= 1.5 then

                positionBack = shops[i].position

                DrawTxt("Pressione ALT para abrir a Barbearia.", 0.85, 0.95, 0.35, 0.35, true, 255, 255, 255, 200, true, 10000)

                if IsControlJustReleased(0, 0xE8342FF2) and not cAPI.GetWanted() then -- LEFT ALT

                    cAPI.InFade(500)

                    Wait(500)

                    Citizen.InvokeNative(0xF1CA12B18AEF5298, playerPed, true)

                    SetNuiFocus(true, true)

                    local pedHash = GetEntityModel(playerPed)

                    local female = -1481695040

                    local male = -171876066

                    if pedHash == female then
                        sex = 'mp_female'
                    elseif pedHash == male then
                        sex = 'mp_male'
                    else
                        sex = 'other'
                    end

                    createCamera(playerPed, shops[i])

                    SendNUIMessage({
                        action = 'show',
                        gender = sex
                    })

                end
            end
        end
    end
end)



function NativeSetPedComponentEnabled(ped, componentHash, immediately, isMp)
    local categoryHash = NativeGetPedComponentCategory(not IsPedMale(ped), componentHash)
    -- print(componentHash, categoryHash, NativeGetMetapedType(ped))

    NativeFixMeshIssues(ped, categoryHash)

    Citizen.InvokeNative(0xD3A7B003ED343FD9, ped, componentHash, immediately, isMp, true)
end

function NativeUpdatePedVariation(ped)
    Citizen.InvokeNative(0xCC8CA3E88256E58F, ped, false, true, true, true, false)
end

function NativeFixMeshIssues(ped, categoryHash)
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
