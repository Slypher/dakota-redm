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

    if type(discordChannelWebhook) == 'table' then

        for i = 1, #discordChannelWebhook do
            gFormatIdToDiscordChannelWebhook[formatId] = discordChannelWebhook[i]
        end

    else
        gFormatIdToDiscordChannelWebhook[formatId] = discordChannelWebhook
    end

end

local CHANNEL_WEBHOOK__ADICIONAR_E_REMOVER_ITEM = 'https://discord.com/api/webhooks/898264157466525757/AiK3xbreQY9NFUnv7EaarwSkBrZ5xmSiAmOVTwe5C6o_wxX6CT-M569Og-e4lJ7pPIes'

registerDiscordLog('ADD_INVENTORY_ITEM',
[[
User: %s(%d).
Char: %s(%d).
Item: %s(%s).
Qntd: %d.
Motivo: Desconhecido.
]],
CHANNEL_WEBHOOK__ADICIONAR_E_REMOVER_ITEM
)

registerDiscordLog('REMOVE_INVENTORY_ITEM',
[[
User: %s(%d).
Char: %s(%d).
Item: %s(%s).
Qntd: %d.
Motivo: Desconhecido.
]],
CHANNEL_WEBHOOK__ADICIONAR_E_REMOVER_ITEM
)

registerDiscordLog('MOVE_INVENTORY_ITEM_TO_PRIMARY',
[[
User: %s(%d).
Char: %s(%d).
DeInventario: %s,
DeUser: %s(%d).
DeChar: %s(%d).
Item: %s(%s).
Qntd: %d.
Motivo: Desconhecido.
]],
CHANNEL_WEBHOOK__ADICIONAR_E_REMOVER_ITEM
)

registerDiscordLog('MOVE_INVENTORY_ITEM_TO_SECONDARY',
[[
User: %s(%d).
Char: %s(%d).
ParaInventario: %s,
ParaUser: %s(%d).
ParaChar: %s(%d).
Item: %s(%s).
Qntd: %d.
Motivo: Desconhecido.
]],
CHANNEL_WEBHOOK__ADICIONAR_E_REMOVER_ITEM
)

registerDiscordLog('SHOP_TRANSACTION',
[[
User: %s(%d).
Char: %s(%d).
Loja: %s.
Item: %s(%s).
Qntd: %d.
Valor: %.2f(%s).
Ação: %s.
]],
'https://discordapp.com/api/webhooks/915714930097917962/km7VhE0O4hGAGlzDQEu6n_gM8HGz-SNjgMtLziayK0s7ZGwr_1CSQCn8RMRQnoMifQG3'
)

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

local CHANNEL_WEBHOOK__BANCO = 'https://discordapp.com/api/webhooks/915705211396427837/cYdduh1tovWm4qaK5dJLaU5dXWzoVUImlnpwCiudc1Q83K9TOZo--QufpmyZpuA19-dJ'

registerDiscordLog('BANK_DOLLAR_WITHDRAW', [[
User: %s(%d).
Char: %s(%d).
Doláres: $%.2f.
]], {
    CHANNEL_WEBHOOK__ADICIONAR_E_REMOVER_ITEM,
    CHANNEL_WEBHOOK__BANCO
})

registerDiscordLog('BANK_DOLLAR_DEPOSIT', [[
User: %s(%d).
Char: %s(%d).
Doláres: $%.2f.
]], {
    CHANNEL_WEBHOOK__ADICIONAR_E_REMOVER_ITEM,
    CHANNEL_WEBHOOK__BANCO
})

local CHANNEL_WEBHOOK__ENTRANCE_AND_EXIT = 'https://discord.com/api/webhooks/932277739233357874/Z8Vn59zRwzIha6NNF3j0UKGcdYiwbksungcnJ9JJc4zLuVqaV5Zb-4rWMW9ZOoo5fjTN'

registerDiscordLog('PLAYER_JOINED', [[
Nome: %s.
]], CHANNEL_WEBHOOK__ENTRANCE_AND_EXIT)

registerDiscordLog('PLAYER_LEFT', [[
Nome: %s.
Motivo: %s.
]], CHANNEL_WEBHOOK__ENTRANCE_AND_EXIT)