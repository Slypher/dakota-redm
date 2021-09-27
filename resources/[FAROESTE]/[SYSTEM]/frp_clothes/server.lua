local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")
dbAPI = Proxy.getInterface("API_DB")

RegisterServerEvent("FRP:CLOTHES:payClothing")
AddEventHandler(
    "FRP:CLOTHES:payClothing",
    function(price)
        local _source = source
        local User = API.getUserFromSource(_source)
        local Inventory = User:getCharacter():getInventory()

        if Inventory:getItemAmount("money") < price then
            local Character = User:getCharacter()
            local model = Character:getModel()
            local clothes = Character:getClothes()

            User:notify("error", "Dinheiro insuficiente!")
            TriggerClientEvent('FRP:CLOTHES:DrawOldClothing', _source)
            TriggerClientEvent("FRP:ADMIN:Model", _source, model, clothes)
            return
        end
        User:notify("item", "money", -price) 
        Inventory:removeItem(-1, "money", price)
        TriggerEvent('FRP:CLOTHES:SaveClothing')
    end
)

RegisterServerEvent("FRP:CLOTHES:fechar")
AddEventHandler(
    "FRP:CLOTHES:fechar",
    function()
        local _source = source
        local User = API.getUserFromSource(_source)
        local Character = User:getCharacter()
        local model = Character:getModel()
        local clothes = Character:getClothes()
            TriggerClientEvent("FRP:ADMIN:Model", _source, clothes)
            return
    end
)


RegisterNetEvent("FRP:CLOTHES:SavePlayerClothing")
AddEventHandler(
    "FRP:CLOTHES:SavePlayerClothing",
    function(dataClothes, securePayment)
        local _source = source
        local User = API.getUserFromSource(_source)
        local Character = User:getCharacter()
        if Character ~= nil then            

            -- for k, v in pairs(data) do
            --     Character:setData(Character:getId(), 'clothes', k, v)
            -- end

            -- local data = json.encode(dataClothes)

            local Inventory = Character:getInventory()

          --  if Inventory:removeItem(-1, "money", #data * 0.2) then            
              --  TriggerClientEvent('FRP:CLOTHES:ClearOldClothing', _source)                
                for k, v in pairs(dataClothes) do 
                    if v ~= nil then
                      --  print(k,v)
                        Character:setData(Character:getId(), 'clothes', k, v)
                    end
                   -- dbAPI.execute("UPDATE:character_data_clothing", {charid = Character:getId(), clothing = data})
                end              
            --else
               -- TriggerClientEvent('FRP:CLOTHES:DrawOldClothing', _source)
             --   User:notify('error', 'Dinheiro insuficiente!')
          --  end
            
        end
    end
)
RegisterCommand('calca',function(source,args,rawCommand)
	local user_id = API.getUserId(source)
	if cAPI.getHealth(source) > 101 then
		if not cAPI.isHandcuffed(source) then
			if not API.searchReturn(source,user_id) then
				if user_id then
					TriggerClientEvent("setcalca",source,args[1],args[2])
				end
			end
		end
	end
end)

local CLOTHING_STORAGE_ITEM = 'roupas'

RegisterNetEvent('FRP:RequestShouldStoreIntoClothingItemButtonBeEnabled', function()
    local playerId = source

    local user = API.getUserFromSource(playerId)

    if not user then
        return
    end

    local character = user:getCharacter()

    if not character then
        return
    end

    local inventory = character:getInventory()

    local hasAnyEmptyMetadata = false

    for slotId, slot in pairs(inventory:getSlotsWithItemId(CLOTHING_STORAGE_ITEM)) do
        local metadata = slot:getItemMetaData()

        local isMetadataEmpty = metadata == '[]'

        if isMetadataEmpty then
            hasAnyEmptyMetadata = true
            break
        end
    end

    TriggerClientEvent('FRP:ResponseShouldStoreIntoClothingItemButtonBeEnabled', playerId, hasAnyEmptyMetadata)
end)

RegisterNetEvent('FRP:RequestStoreComponentsIntoClothingItem', function(clothingComponentsAsHex)
    local playerId = source

    local user = API.getUserFromSource(playerId)

    if not user then
        return
    end

    local character = user:getCharacter()

    if not character then
        return
    end

    local inventory = character:getInventory()

    if not inventory:hasItem(CLOTHING_STORAGE_ITEM) then
        local itemData = API.getItemDataFromId(CLOTHING_STORAGE_ITEM)
        user:notify('error', ('Você precisar ter o item \'%s\'.'):format(itemData:getName()) )
        return
    end

    for slotId, slot in pairs(inventory:getSlotsWithItemId(CLOTHING_STORAGE_ITEM)) do
        local metadata = slot:getItemMetaData()

        local isMetadataEmpty = metadata == '[]'

        if isMetadataEmpty then
            -- Gambiarra, remover o item atual
            -- só para reaplicar o metadata.
            if inventory:removeItem(slotId, CLOTHING_STORAGE_ITEM, 1) then
                if inventory:addItem(CLOTHING_STORAGE_ITEM, 1, clothingComponentsAsHex) then
                    user:notify('success', 'Suas roupas atuais foram salvas em um item.')
                    return
                end
            end
        end
    end

    user:notify('error', 'Você não tem nenhum item de roupa vazia.')
end)