function getLootFromLoottable()
    local lootWeightSum = 0

    local currRange = 0
    local lootRange = { }

    for lootIndex, loot in ipairs(LOOTTABLE) do
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
            return LOOTTABLE[lootIndex].lootItemId
        end
    end

    return nil
end