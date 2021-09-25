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
