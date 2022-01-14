Config = {}

-- priority list can be any identifier. (hex steamid, steamid32, ip) Integer = power over other people with priority
-- a lot of the steamid converting websites are broken rn and give you the wrong steamid. I use https://steamid.xyz/ with no problems.
-- you can also give priority through the API, read the examples/readme.

-- Advocate 10
-- Defender 20
-- Protector 30
-- Crusader 40
-- Champion 50
-- Management 60

Config.Priority = {
    ["steam:110000116fd4d07"] =  10000, -- examples
    ["steam:110000109aae847"] =  10000, -- examples
}

-- require people to run steam
Config.RequireSteam = true

-- "whitelist" only server
Config.PriorityOnly = false

-- disables hardcap, should keep this true
Config.DisableHardCap = true

-- will remove players from connecting if they don't load within: __ seconds; May need to increase this if you have a lot of downloads.
-- i have yet to find an easy way to determine whether they are still connecting and downloading content or are hanging in the loadscreen.
-- This may cause session provider errors if it is too low because the removed player may still be connecting, and will let the next person through...
-- even if the server is full. 10 minutes should be enough
Config.ConnectTimeOut = 240

-- will remove players from queue if the server doesn't recieve a message from them within: __ seconds
Config.QueueTimeOut = 90

-- will give players temporary priority when they disconnect and when they start loading in
Config.EnableGrace = false

-- how much priority power grace time will give
Config.GracePower = 10

-- how long grace time lasts in seconds
Config.GraceTime = 90

-- on resource start, players can join the queue but will not let them join for __ milliseconds
-- this will let the queue settle and lets other resources finish initializing
Config.JoinDelay = 30000

-- will show how many people have temporary priority in the connection message
Config.ShowTemp = false

-- simple localization
Config.Language = {
    joining = "\xF0\x9F\x8E\x89Entrando...",
    connecting = "\xE2\x8F\xB3Conectando...",
    idrr = "\xE2\x9D\x97[Fila] Erro: Erro ao procurar seu ID, tente reiniciar todos os aplicativos necessários para jogar RedM.",
    err = "\xE2\x9D\x97[Fila] Ocorreu algum erro.",
    pos = "\xF0\x9F\x90\x8CVocê esta em %d/%d na fila \xF0\x9F\x95\x9C%s",
    connectingerr = "\xE2\x9D\x97[Fila] Erro: Erro ao adicionar você na lista.",
    timedout = "\xE2\x9D\x97[Fila] Erro: Tempo limite excedido.",
    wlonly = "\xE2\x9D\x97[Fila] Você precisa estar aprovado na Whitelist | discord.gg/dakotarp",
    steam = "\xE2\x9D\x97 [Fila] Erro: A Steam precisa estar aberta."
}
