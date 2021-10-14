local PickerIsOpen = false
local CurrentInteraction = nil
local lastobj
local menu_elements = {}

function IsPlayerNearCoords(coords, radius)
    local playerCoords = GetEntityCoords(PlayerPedId())
    return Vdist(playerCoords.x, playerCoords.y, playerCoords.z, coords.x, coords.y, coords.z) <= radius
end

function IsPedUsingScenarioHash(ped, scenarioHash)
    return Citizen.InvokeNative(0x34D6AC1157C8226C, ped, scenarioHash)
end

function HasCompatibleModel(entity, models)
    local entityModel = GetEntityModel(entity)

    for _, model in ipairs(models) do
        if entityModel  == GetHashKey(model) then
            return true
        end
    end
    return false
end

function CanStartInteractionAtObject(interaction, object)
    return IsPlayerNearCoords(GetEntityCoords(object), interaction.radius) and HasCompatibleModel(object, interaction.objects)
end

function StartInteractionAtObject(interaction)
    local objectHeading = GetEntityHeading(interaction.object)
    local objectCoords = GetEntityCoords(interaction.object)

    local r = math.rad(objectHeading)
    local cosr = math.cos(r)
    local sinr = math.sin(r)

    local x = interaction.x * cosr - interaction.y * sinr + objectCoords.x
    local y = interaction.y * cosr + interaction.x * sinr + objectCoords.y
    local z = interaction.z + objectCoords.z
    local h = interaction.heading + objectHeading

    TaskStartScenarioAtPosition(PlayerPedId(), GetHashKey(interaction.scenario), x, y, z, h, -1, true, false)

    CurrentInteraction = interaction
end

function IsCompatible(t)
    return not t.isCompatible or t.isCompatible()
end


function GetObjects()
    local playerped = PlayerPedId()
    local itemSet = CreateItemset(true)
    local obj_table = {}
    local size = Citizen.InvokeNative(0x59B57C4B06531E1E, GetEntityCoords(playerped), 2.0, itemSet, 3, Citizen.ResultAsInteger())
    if size > 0 then
        for index = 0, size - 1 do
            local entity = GetIndexedItemInItemset(index, itemSet)
            if not IsPedAPlayer(entity) then
                table.insert(obj_table , entity)
            end
        end
    end
    if IsItemsetValid(itemSet) then
        DestroyItemset(itemSet)
    end
    return obj_table
end

function StartInteraction()
    lastobj = nil
    menu_elements = {}
    if IsPedUsingAnyScenario(PlayerPedId()) then

        return false
    end
    local availableInteractions = {}

    for _, interaction in ipairs(Config.Interactions) do
        if IsCompatible(interaction) then
            for _ , object in pairs(GetObjects()) do
                if CanStartInteractionAtObject(interaction, object, objectCoords) then
                    if not lastobj then
                        lastobj = object
                    end
                    Wait(0)
                    if  lastobj == object then
                        for _, scenario in ipairs(interaction.scenarios) do
                            Wait(0)
                            if IsCompatible(scenario) then
                                table.insert(menu_elements, {label = scenario.label, value = 0,
                                    x = interaction.x,
                                    y = interaction.y,
                                    z = interaction.z,
                                    heading = interaction.heading,
                                    scenario = scenario.name,
                                    object = object,
                                    desc = "Choose Sitting Interactions"
                                })
                            end
                        end
                    end
                end
            end
        end
    end
    if #menu_elements > 0 then
        OpenMenu()
        PickerIsOpen = true
    else
        PickerIsOpen = false
    end
end

MenuData = {}
TriggerEvent("redemrp_menu_base:getData", function(call) MenuData = call end)

function OpenMenu()
    --print("sdsd")
    MenuData.CloseAll()
    MenuData.Open(
        'default', GetCurrentResourceName(), 'interact_menu_manage',

        {

            title    = 'Interactions',

            subtext    = 'Choose a Seat Style',

            align    = 'top-right',

            elements = menu_elements,

        },

        function(data, menu)
            menu.close()
            StartInteractionAtObject(data.current)
            PickerIsOpen = false
        end,

        function(data, menu)
            menu.close()
            PickerIsOpen = false
        end

    )

end

function StopInteraction()
    ClearPedTasks(PlayerPedId())
    SetCurrentPedWeapon(PlayerPedId(), -1569615261, true)
    CurrentInteraction = nil
end

function ToggleInteraction()
    if CurrentInteraction then
        StopInteraction()
    else
        StartInteraction()
    end
end

RegisterCommand('stopanime', function(source, args, raw)
    StopInteraction()
end, false)

CreateThread(function()
  while true do Wait(0)
    local E = IsControlJustReleased(0, Keys['LALT'])
    if ((E) and not CheckForStop) then CheckForStop = true StartInteraction() end
    if ((E) and CheckForStop) then CheckForStop = false StopInteraction() end
  end
end)

CreateThread(function()
    while true do
        Wait(0)
		if IsControlJustPressed(0, Config.InteractControl) then
            StartInteraction()
        end
        if PickerIsOpen then
            Citizen.InvokeNative(0x2A32FAA57B937173, -1795314153, GetEntityCoords(lastobj), 1.0, 1.0, 1.0, 0.0, 0.0, 0.0, 1.0, 1.0, 0.1, 227, 48, 48, 180, true, false, 1, true)
        end
    end
end)
