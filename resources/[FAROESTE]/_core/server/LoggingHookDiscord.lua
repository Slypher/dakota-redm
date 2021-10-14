local DISCORD_NAME = 'DakotaBot'

local DISCORD_FALLBACK_WEBHOOK = 'https://discord.com/api/webhooks/872569454142308353/Yf1XUXU4Dev5a_5GCKl4-QU3yHdGYlmqo7KUcuBNABtCJXJdu5mCTdiqN9E2EYH3XgHO'

local DISCORD_IMAGE = '' -- default is FiveM logo

local gFormatIdToDiscordChannelWebhook = { }

local gLogListener = Logging.registerListener(function(formatId, formattedLog)

    local content = {
        {
            ['color'] = color,
            ['description'] = formatId,
            ['footer'] = {
                ['text'] = formattedLog,
            }
        }
    }

    local webhook = gFormatIdToDiscordChannelWebhook[formatId] or DISCORD_FALLBACK_WEBHOOK

    PerformHttpRequest(
        webhook,
        function(err, text, headers)
        end,
        'POST',
        json.encode({
            avatar_url = DISCORD_IMAGE,
            username = DISCORD_NAME,
            
            embeds = content,
        }),
        {['Content-Type'] = 'application/json'}
    )
end)

function registerDiscordLog(formatId, format, discordChannelWebhook)
    gLogListener.registerFormat(formatId, format)

    gFormatIdToDiscordChannelWebhook[formatId] = discordChannelWebhook
end

registerDiscordLog('ADD_INVENTORY_ITEM',
[[
User: %s(%d).
Char: %s(%d).
Item: %s(%s).
Qntd: %d.
Motivo: Desconhecido.
]],
'https://discord.com/api/webhooks/898264157466525757/AiK3xbreQY9NFUnv7EaarwSkBrZ5xmSiAmOVTwe5C6o_wxX6CT-M569Og-e4lJ7pPIes'
)

registerDiscordLog('REMOVE_INVENTORY_ITEM',
[[
User: %s(%d).
Char: %s(%d).
Item: %s(%s).
Qntd: %d.
Motivo: Desconhecido.
]],
'https://discord.com/api/webhooks/898264157466525757/AiK3xbreQY9NFUnv7EaarwSkBrZ5xmSiAmOVTwe5C6o_wxX6CT-M569Og-e4lJ7pPIes'
)

-- registerDiscordLog('SHOP_TRANSACTION',
-- [[
-- User: %s(%d).
-- Char: %s(%d).
-- Item: %s(%s).
-- Qntd: %d.
-- Valor: %.2f(%s).
-- Motivo: %s.
-- ]],
-- 'https://discord.com/api/webhooks/898264157466525757/AiK3xbreQY9NFUnv7EaarwSkBrZ5xmSiAmOVTwe5C6o_wxX6CT-M569Og-e4lJ7pPIes'
-- )

registerDiscordLog('ADMIN_ADD_ITEM',
[[
AdminUser: %s(%d).
AdminChar: %s(%d).
ParaUser: %s(%d).
ParaChar: %s(%d).
Item: %s(%s).
Qntd: %d.
]],
'https://discord.com/api/webhooks/898282685242417222/arijhRRcRTi_GrP1At9KeRs0533vKV-dbdDG0OI7pkhlh_7qrysK-EBJVDNfnPZMo3iS'
)