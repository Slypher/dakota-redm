VORP = exports.vorp_inventory:vorp_inventoryApi()


VORP.RegisterUsableItem("cigarette", function(data)
	VORP.subItem(data.source, "cigarette", 1)
	TriggerClientEvent('prop:cigarettes', data.source)
end)

VORP.RegisterUsableItem("hairpomade", function(data)
	VORP.subItem(data.source, "hairpomade", 1)
	TriggerClientEvent('prop:hairpomade', data.source)
end)

VORP.RegisterUsableItem("cigar", function(data)
	VORP.subItem(data.source, "cigar", 1)
	TriggerClientEvent('prop:cigar', data.source)
end)

VORP.RegisterUsableItem("relogiovelho", function(data)
	TriggerClientEvent('prop:relogiovelho', data.source)
end)

VORP.RegisterUsableItem("gibana", function(data)
	VORP.subItem(data.source, "gibana", 1)
	TriggerClientEvent('prop:gibana', data.source)
end)

--[[VORP.RegisterUsableItem("SopaCogumelos", function(data)
	VORP.subItem(data.source, "SopaCogumelos", 1)
	TriggerClientEvent('prop:sopacogumelo', data.source)
end)]]

VORP.RegisterUsableItem("tomenta", function(data)
	VORP.subItem(data.source, "tomenta", 1)
	TriggerClientEvent('prop:tomenta', data.source)
end)

VORP.RegisterUsableItem("cidrica", function(data)
	VORP.subItem(data.source, "cidrica", 1)
	TriggerClientEvent('prop:cidrica', data.source)
end)

VORP.RegisterUsableItem("pipe", function(data)
	TriggerClientEvent('prop:pipe', data.source)
end)

VORP.RegisterUsableItem("fan", function(data)
	TriggerClientEvent('prop:fan', data.source)
end)

VORP.RegisterUsableItem("chewingtobacco", function(data)
	VORP.subItem(data.source, "chewingtobacco", 1)
	TriggerClientEvent('prop:chewingtobacco', data.source)
end)


