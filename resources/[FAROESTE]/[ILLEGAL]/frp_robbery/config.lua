HEIST_BANK_INFO = {
    {
        isDisabled = true,
        
        staticName = 'Banco de BlackWater',

        interiorId = 72962,

        staticReward = 50000,
        staticSecondsToReward = 10 * 60,
        staticMaxParticipants = 3,

        explodableDoorSystemHash = 1462330364,
        explodableDoorModelHash = `p_door_bla_bankvault`,
        explodableDoorPosition = vec3(-817.78656005859,-1274.3852539063,42.662132263184),

        interiorDoors = {
            {
                -- Cofre
                doorHash = 1462330364,
            },
            {
                -- Primeira antes do cofre.
                doorHash = 2117902999,
            },
            {
                -- Reta ao entrar no banco. Banking Office.
                doorHash = 2817192481,
            }
        }
    },
    {
        staticName = 'Banco de Saint Dennis',

        interiorId = 42754,

        staticReward = 35000,
        staticSecondsToReward = 10 * 60,
        staticMaxParticipants = 3,

        explodableDoorSystemHash = 1751238140,
        explodableDoorModelHash = `p_door_val_bankvault02x`,
        explodableDoorPosition = vec3(2643.3005371094, -1300.4267578125, 51.255825042725),

        interiorDoors = {
            {
                -- Cofre.
                doorHash = 1751238140,
            },
        }
    },
    {
        staticName = 'Banco Rhodes',

        interiorId = 29442,

        staticReward = 50000,
        staticSecondsToReward = 10 * 60,
        staticMaxParticipants = 3,

        explodableDoorSystemHash = 3483244267,
        explodableDoorModelHash = `p_door_val_bankvault`,
        explodableDoorPosition = vec3(1282.5363769531, -1309.3159179688, 76.036422729492),

        interiorDoors = {
            {
                -- Cofre.
                doorHash = 3483244267,
            },
            {
                -- Porta entrando para a direita.
                doorHash = 2058564250,
            },
            {
                -- Porta traseira, de madeira.
                doorHash = 3142122679,
            }
        }
    },
    {
        isDisabled = true,
        
        staticName = 'Banco Valentine',

        interiorId = 0,

        staticReward = 50000,
        staticSecondsToReward = 10 * 60,
        staticMaxParticipants = 3,

        explodableDoorSystemHash = 576950805,
        explodableDoorModelHash = `p_door_val_bankvault`,
        explodableDoorPosition = vec3(-307.75375366211,766.34899902344,117.7015914917),

        interiorDoors = {
            {
                -- Cofre.
                doorHash = 576950805,
            },
            {
                -- Primeira porta a direita.
                doorHash = 1340831050,
            },
            {
                -- Segunda porta a direita.
                doorHash = 3718620420,
            },
            {
                -- Porta dos fundos a esquerda.
                doorHash = 334467483,
            },
            {
                -- Porta dos fundos.
                doorHash = 2307914732,
            }
        }
    }
}