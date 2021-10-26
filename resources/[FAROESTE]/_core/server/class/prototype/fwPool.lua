function fwPoolCreate()
    return setmetatable(
    { 
        add = function(self, entityId)
            local conflictingEntityIndex = self:getIndexById(entityId)

            if conflictingEntityIndex then
                self:removeByIndex(conflictingEntityIndex)
            end

            local entityIndex = #self.__pool + 1

            self.__pool[entityIndex] = entityId

            self.__reverse_pool[entityId] = entityIndex

            return entityIndex
        end,

        removeByIndex = function(self, entityIndex)
            local entityId = self.__pool[entityIndex]

            if not entityId then
                return false
            end

            table.remove(self.__pool, entityIndex)

            -- print('removeByIndex', entityId)

            self.__reverse_pool[entityId] = nil

            -- print('self.__pool', self.__pool, json.encode(self.__pool))
            -- print('self.__reverse_pool', self.__reverse_pool, json.encode(self.__reverse_pool))

            for itEntityIndex = entityIndex, #self.__pool do
                -- print('itEntityIndex', itEntityIndex)

                local itEntityId = self.__pool[itEntityIndex]

                self.__reverse_pool[itEntityId] = itEntityIndex
            end
        end,

        getIndexById = function(self, entityId)
            return self.__reverse_pool[entityId]
        end,

        getIdByIndex = function(self, entityIndex)
            return self.__pool[entityIndex]
        end,

        __pool = { },
        __reverse_pool = { },
    },
    {

    })
end