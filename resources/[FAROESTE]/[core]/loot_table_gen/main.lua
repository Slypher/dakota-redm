local Proxy = module('_core', 'lib/Proxy')

local LootTableGen = { }
Proxy.addInterface('LootTableGen', LootTableGen)

function getOneItemFromLootTable(lootTable)
    local lootWeightSum = 0

    local currRange = 0
    local lootRange = { }

    for lootIndex, loot in ipairs(lootTable) do
        local lootWeight = loot.lootWeight

        lootWeightSum += lootWeight

        local rangeStart = (currRange + 1)
        local rangeEnd = (rangeStart + lootWeight) - 1

        currRange = rangeEnd

        lootRange[lootIndex] = { rangeStart,  rangeEnd}
    end

    local rnd = math.random(1, lootWeightSum)

    for lootIndex, range in ipairs(lootRange) do
        
        local rangeStart, rangeEnd = range[1], range[2]

        if rangeStart <= rnd and rnd <= rangeEnd then
            return lootTable[lootIndex].lootItemId
        end
    end

    return nil
end

LootTableGen.getOneItemFromLootTable = getOneItemFromLootTable