local LISTENERS = { }

Logging = { }

function Logging.log(formatId, ...)
    local anyListeners = false

    for _, listener in ipairs(LISTENERS) do

        local format = listener.formats[formatId]

        if format then
            anyListeners = true

            local ok, formattedLog = pcall(string.format, format, ...)

            if not ok then
                error( ('Logging(%s): %s'):format(formatId, formattedLog) )
                return
            end

            listener.hookFn( formatId, formattedLog )
        end
    end

    if not anyListeners then
        error('No Listeners to format ....')
    end
end

function Logging.registerListener(hookFn)
    local listenerId = #LISTENERS + 1

    local listener = {
        hookFn = hookFn,

        formats = { },
    }

    LISTENERS[listenerId] = listener

    return {
        registerFormat = function(formatId, format)
            listener.formats[formatId] = format
        end,
    }
end

API.log = Logging.log

-- CreateThread(function()
--     Wait(1000)

--     Logging.log('ADD_INVENTORY_ITEM',
--         'key_value'     ,      1,
--         'Valor da Chave',      1,
--         'Água'          , 'agua',
--         1
--     )
-- end)