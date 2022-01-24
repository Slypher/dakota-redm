local Proxy = module('_core', 'lib/Proxy')

local ServerAPI = Proxy.getInterface('API')
local LootTableGen = Proxy.getInterface('LootTableGen')

local LOOT_TABLE = {
    {
        lootItemId = 'cristal',
        lootWeight = 50,
    },
    {
        lootItemId = 'pepitadeouro',
        lootWeight = 20,
    },
    {
        lootItemId = 'esmeralda',
        lootWeight = 9,
    },
    {
        lootItemId = 'rubi',
        lootWeight = 6,
    },
    {
        lootItemId = 'diamante',
        lootWeight = 3,
    },

    --[[
        cristal      : 55.12%
        pepitadeouro : 23.62%
        esmeralda    : 9.45%
        rubi         : 7.87%
        diamante     : 3.94%
    ]]
}

local GOLD_PANNING_REWARD_DICE_INTERVAL = 35
local GOLD_PANNING_WIN_GOLD_CHANCE = 0.15 -- 15% de chance de achar alguma coisa.

local gPlayersGoldPanning = { }

local gIsRewardTimerRunning = false

RegisterNetEvent('net.playerStartedGoldPanning', function()
    local playerId = source

    gPlayersGoldPanning[playerId] = GetGameTimer() + (GOLD_PANNING_REWARD_DICE_INTERVAL * 1000)

    ensureGoldPanningRewardTimer()
end)

RegisterNetEvent('net.playerStoppedGoldPanning', function()
    local playerId = source

    playerStoppedGoldPanning(playerId)
end)

function playerStoppedGoldPanning(playerId)
    gPlayersGoldPanning[playerId] = nil

    local n = 0
    for _, _ in pairs(gPlayersGoldPanning) do
        n = n + 1
    end

    if n <= 0 then
        gIsRewardTimerRunning = false
    end
end

function ensureGoldPanningRewardTimer()
    if gIsRewardTimerRunning then
        return
    end

    gIsRewardTimerRunning = true

    CreateThread(function()
        while gIsRewardTimerRunning do
            Wait(1000)

            local now = GetGameTimer()

            for playerId, nextDiceAt in pairs(gPlayersGoldPanning) do
                if now >= nextDiceAt then
                    local user = ServerAPI.getUserFromSource(playerId)

                    local character = user:getCharacter()
                    local inventory = character:getInventory()

                    if inventory:getItemAmount('terra') >= 1 and inventory:removeItem(-1, 'terra', 1) then
                        math.randomseed(GetGameTimer())
                        local rnd = math.random()

                        if rnd <= GOLD_PANNING_WIN_GOLD_CHANCE then
                            TriggerClientEvent('net.playerGoldPanningFoundGold', playerId)

                            -- Aguardar um pouco para adicionar o ouro por conta da animação.
                            CreateThread(function()
                                Wait(1000)

                                local singleItemLootTable = LootTableGen.getOneItemFromLootTable(LOOT_TABLE)

                                inventory:addItem(singleItemLootTable, 1)
                                user:notify('item', singleItemLootTable, 1)
                            end)
                            -- #TODO: Adicionar item.
                        else
                            TriggerClientEvent('net.playerGoldPanningFoundNothing', playerId)
                        end
                    else
                        user:notify('error', 'Você precisar ter no mínimo 1x Terra para poder garimpar.')
                    end

                    gPlayersGoldPanning[playerId] = now + (GOLD_PANNING_REWARD_DICE_INTERVAL * 1000)
                end
            end
        end

        -- print('broke reawrd timer')

        gIsRewardTimerRunning = false
    end)
end

AddEventHandler('playerDropped', playerStoppedGoldPanning)