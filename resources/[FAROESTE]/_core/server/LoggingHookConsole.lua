local gLogListener = Logging.registerListener(function(formatId, formattedLog)
    print( ('Console: %s'):format(formattedLog) )
end)

-- gLogListener.registerFormat('ADD_INVENTORY_ITEM', '[%s] %s')

-- gLogListener.registerFormat('SHOP_TRANSACTION',
-- [[
-- User: %s(%d).
-- Char: %s(%d).
-- Item: %s(%s).
-- Qntd: %d.
-- Valor: %.2f(%s).
-- Motivo: %s.
-- ]]
-- )