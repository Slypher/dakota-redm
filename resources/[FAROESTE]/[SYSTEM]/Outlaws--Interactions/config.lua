Config = {}

-- Control to start/stop interactions. Comment this out to disable the control.
Config.InteractControl = `INPUT_PC_FREE_LOOK` -- LALT



Config.Label = {
    ["GENERIC_SEAT_BENCH_SCENARIO"] = "Sentar",
    ["GENERIC_SEAT_CHAIR_SCENARIO"] = "Sentar 2",
    ["MP_LOBBY_PROP_HUMAN_SEAT_CHAIR"] = "Sentar 3",
    ["GENERIC_SEAT_CHAIR_TABLE_SCENARIO"] = "Sentar a Mesa",
    ["MP_LOBBY_PROP_HUMAN_SEAT_BENCH_PORCH_DRINKING"] = "Sentar e Beber",
    ["MP_LOBBY_PROP_HUMAN_SEAT_BENCH_PORCH_SMOKING"] = "Sentar e Fumar",
    ["MP_LOBBY_PROP_HUMAN_SEAT_CHAIR_KNIFE_BADASS"] = "Sentar e Afiar",
    ["MP_LOBBY_PROP_HUMAN_SEAT_CHAIR_WHITTLE"] = "Sentar e Afiar 2",
    ["PROP_CAMP_FIRE_SEAT_CHAIR"] = "Sentar 4",
    ["PROP_HUMAN_CAMP_FIRE_SEAT_BOX"] = "Sentar 5",
    ["PROP_HUMAN_SEAT_BENCH_CONCERTINA"] = "Tocar Concertina",
    ["PROP_HUMAN_SEAT_BENCH_FIDDLE"] = "Bench Fiddle",
    ["PROP_HUMAN_SEAT_BENCH_JAW_HARP"] = "Tocar Espanta Espirito",
    ["PROP_HUMAN_SEAT_BENCH_MANDOLIN"] = "Tocar Mandolin",
    ["PROP_HUMAN_SEAT_CHAIR"] = "Sentar Relaxado",
    ["PROP_HUMAN_SEAT_CHAIR_BANJO"] = "Tocar Banjo",
    ["PROP_HUMAN_SEAT_CHAIR_CIGAR"] = "Sentar e Fumar Charuto",
    ["PROP_HUMAN_SEAT_CHAIR_CLEAN_RIFLE"] = "Sentar e Limpar Rifle",
    ["PROP_HUMAN_SEAT_CHAIR_CLEAN_SADDLE"] = "Sentar e Limpar Sela",
    ["PROP_HUMAN_SEAT_CHAIR_CRAB_TRAP"] = "Sentar 6",
    ["PROP_HUMAN_SEAT_CHAIR_GROOMING_GROSS"] = "Sentar Desleixado",
    ["PROP_HUMAN_SEAT_CHAIR_GROOMING_POSH"] = "Sentar 7",
    ["PROP_HUMAN_SEAT_CHAIR_GUITAR"] = "Tocar Violão",
    ["PROP_HUMAN_SEAT_CHAIR_KNIFE_BADASS"] = "Sentar com Faca",
    ["PROP_HUMAN_SEAT_CHAIR_KNITTING"] = "Sentar e Tricotar",
    ["PROP_HUMAN_SEAT_CHAIR_PORCH"] = "Sentar com bebida",
    ["PROP_HUMAN_SEAT_CHAIR_READING"] = "Sentar e ler",
    ["PROP_HUMAN_PIANO"] = "Piano Male",
    ["PROP_HUMAN_ABIGAIL_PIANO"] = "Tocar Piano",
    ["PROP_HUMAN_SEAT_BENCH_HARMONICA"] = "Tocar Gaita de Boca",
    ["PROP_HUMAN_SEAT_CHAIR_FAN"] = "Chair Fan Yourself",
}

-- List of interactable types of objects.
Config.Interactions = {
    -- Pianos
    {
        isCompatible = PlayerPedIsHuman,
        objects = {'p_piano03x'},
        radius = 2.0,
        scenarios = {
            {name = 'PROP_HUMAN_PIANO', isCompatible = PlayerPedIsMale , label = Config.Label["PROP_HUMAN_PIANO"]},
            {name = 'PROP_HUMAN_ABIGAIL_PIANO', isCompatible = PlayerPedIsFemale, label = Config.Label["PROP_HUMAN_ABIGAIL_PIANO"]}
        },
        x = 0.0,
        y = -0.70,
        z = 0.5,
        heading = 0.0
    },
    {
        isCompatible = PlayerPedIsHuman,
        objects = {'p_piano02x'},
        radius = 2.0,
        scenarios = {
            {name = 'PROP_HUMAN_PIANO', isCompatible = PlayerPedIsMale , label = Config.Label["PROP_HUMAN_PIANO"]},
            {name = 'PROP_HUMAN_ABIGAIL_PIANO', isCompatible = PlayerPedIsFemale, label = Config.Label["PROP_HUMAN_ABIGAIL_PIANO"]}
        },
        x = 0.0,
        y = -0.70,
        z = 0.5,
        heading = 0.0
    },
    {
        isCompatible = PlayerPedIsHuman,
        objects = {'p_nbxpiano01x'},
        radius = 2.0,
        scenarios = {
            {name = 'PROP_HUMAN_PIANO', isCompatible = PlayerPedIsMale , label = Config.Label["PROP_HUMAN_PIANO"]},
            {name = 'PROP_HUMAN_ABIGAIL_PIANO', isCompatible = PlayerPedIsFemale, label = Config.Label["PROP_HUMAN_ABIGAIL_PIANO"]}
        },
        x = -0.1,
        y = -0.75,
        z = 0.5,
        heading = 0.0
    },
    {
        isCompatible = PlayerPedIsHuman,
        objects = {'p_nbmpiano01x'},
        radius = 2.0,
        scenarios = {
            {name = 'PROP_HUMAN_PIANO', isCompatible = PlayerPedIsMale , label = Config.Label["PROP_HUMAN_PIANO"]},
            {name = 'PROP_HUMAN_ABIGAIL_PIANO', isCompatible = PlayerPedIsFemale, label = Config.Label["PROP_HUMAN_ABIGAIL_PIANO"]}
        },
        x = 0.0,
        y = -0.77,
        z = 0.5,
        heading = 0.0
    },
    {
        isCompatible = PlayerPedIsMale,
        objects = {'sha_man_piano01'},
        radius = 2.0,
        scenarios = {
            {name = 'PROP_HUMAN_PIANO', isCompatible = PlayerPedIsMale , label = Config.Label["PROP_HUMAN_PIANO"]},
            {name = 'PROP_HUMAN_ABIGAIL_PIANO', isCompatible = PlayerPedIsFemale, label = Config.Label["PROP_HUMAN_ABIGAIL_PIANO"]}
        },
        x = 0.0,
        y = -0.75,
        z = 0.5,
        heading = 0.0
    },
    {
        isCompatible = PlayerPedIsAdult,
        objects = GenericChairsAndBenches,
        radius = 1.5,
        scenarios = {
            {name = 'GENERIC_SEAT_BENCH_SCENARIO' , label = Config.Label["GENERIC_SEAT_BENCH_SCENARIO"]},
            {name = 'GENERIC_SEAT_CHAIR_SCENARIO', label = Config.Label["GENERIC_SEAT_CHAIR_SCENARIO"]},
            {name = 'GENERIC_SEAT_CHAIR_TABLE_SCENARIO' , label = Config.Label["GENERIC_SEAT_CHAIR_TABLE_SCENARIO"]},
            {name = 'MP_LOBBY_PROP_HUMAN_SEAT_BENCH_PORCH_DRINKING' , label = Config.Label["MP_LOBBY_PROP_HUMAN_SEAT_BENCH_PORCH_DRINKING"]},
            {name = 'MP_LOBBY_PROP_HUMAN_SEAT_BENCH_PORCH_SMOKING' , label = Config.Label["MP_LOBBY_PROP_HUMAN_SEAT_BENCH_PORCH_SMOKING"]},
            {name = 'MP_LOBBY_PROP_HUMAN_SEAT_CHAIR' , label = Config.Label["MP_LOBBY_PROP_HUMAN_SEAT_CHAIR"]},
            {name = 'MP_LOBBY_PROP_HUMAN_SEAT_CHAIR_KNIFE_BADASS' , label = Config.Label["MP_LOBBY_PROP_HUMAN_SEAT_CHAIR_KNIFE_BADASS"]},
            {name = 'MP_LOBBY_PROP_HUMAN_SEAT_CHAIR_WHITTLE' , label = Config.Label["MP_LOBBY_PROP_HUMAN_SEAT_CHAIR_WHITTLE"]},
            {name = 'PROP_CAMP_FIRE_SEAT_CHAIR' , label = Config.Label["PROP_CAMP_FIRE_SEAT_CHAIR"]},
            {name = 'PROP_HUMAN_CAMP_FIRE_SEAT_BOX' , label = Config.Label["PROP_HUMAN_CAMP_FIRE_SEAT_BOX"]},
            {name = 'PROP_HUMAN_SEAT_BENCH_CONCERTINA', isCompatible = PlayerPedIsMale , label = Config.Label["PROP_HUMAN_SEAT_BENCH_CONCERTINA"]},
            {name = 'PROP_HUMAN_SEAT_BENCH_FIDDLE', isCompatible = PlayerPedIsFemale , label = Config.Label["PROP_HUMAN_SEAT_BENCH_FIDDLE"]},
            {name = 'PROP_HUMAN_SEAT_BENCH_JAW_HARP', isCompatible = PlayerPedIsMale , label = Config.Label["PROP_HUMAN_SEAT_BENCH_JAW_HARP"]},
            {name = 'PROP_HUMAN_SEAT_BENCH_MANDOLIN', isCompatible = PlayerPedIsMale , label = Config.Label["PROP_HUMAN_SEAT_BENCH_MANDOLIN"]},
            {name = 'PROP_HUMAN_SEAT_CHAIR' , label = Config.Label["PROP_HUMAN_SEAT_CHAIR"]},
            {name = 'PROP_HUMAN_SEAT_CHAIR_BANJO', isCompatible = PlayerPedIsMale , label = Config.Label["PROP_HUMAN_SEAT_CHAIR_BANJO"]},
            {name = 'PROP_HUMAN_SEAT_CHAIR_CLEAN_RIFLE' , label = Config.Label["PROP_HUMAN_SEAT_CHAIR_CLEAN_RIFLE"]},
            {name = 'PROP_HUMAN_SEAT_CHAIR_CLEAN_SADDLE' , label = Config.Label["PROP_HUMAN_SEAT_CHAIR_CLEAN_SADDLE"]},
            {name = 'PROP_HUMAN_SEAT_CHAIR_CRAB_TRAP', isCompatible = PlayerPedIsMale , label = Config.Label["PROP_HUMAN_SEAT_CHAIR_CRAB_TRAP"]},
            {name = 'PROP_HUMAN_SEAT_CHAIR_CIGAR', isCompatible = PlayerPedIsMale , label = Config.Label["PROP_HUMAN_SEAT_CHAIR_CIGAR"]},
            {name = 'PROP_HUMAN_SEAT_CHAIR_GROOMING_GROSS', isCompatible = PlayerPedIsMale , label = Config.Label["PROP_HUMAN_SEAT_CHAIR_GROOMING_GROSS"]},
            {name = 'PROP_HUMAN_SEAT_CHAIR_GROOMING_POSH', isCompatible = PlayerPedIsFemale , label = Config.Label["PROP_HUMAN_SEAT_CHAIR_GROOMING_POSH"]},
            {name = 'PROP_HUMAN_SEAT_CHAIR_GUITAR', isCompatible = PlayerPedIsMale , label = Config.Label["PROP_HUMAN_SEAT_CHAIR_GUITAR"]},
            {name = 'PROP_HUMAN_SEAT_CHAIR_KNIFE_BADASS', isCompatible = PlayerPedIsMale , label = Config.Label["PROP_HUMAN_SEAT_CHAIR_KNIFE_BADASS"]},
            {name = 'PROP_HUMAN_SEAT_CHAIR_KNITTING', isCompatible = PlayerPedIsFemale , label = Config.Label["PROP_HUMAN_SEAT_CHAIR_KNITTING"]},
            {name = 'PROP_HUMAN_SEAT_CHAIR_PORCH', label = Config.Label["PROP_HUMAN_SEAT_CHAIR_PORCH"]},
            {name = 'PROP_HUMAN_SEAT_CHAIR_READING', isCompatible = PlayerPedIsFemale , label = Config.Label["PROP_HUMAN_SEAT_CHAIR_READING"]}
        },
        x = 0.0,
        y = 0.0,
        z = 0.5,
        heading = 180.0
    },
    {
        isCompatible = PlayerPedIsMale,
        objects = GenericChairsAndBenches,
        radius = 1.5,
        scenarios = {
            {name = 'PROP_HUMAN_SEAT_BENCH_HARMONICA' , label = Config.Label["PROP_HUMAN_SEAT_BENCH_HARMONICA"]}
        },
        x = 0.0,
        y = -0.3,
        z = 0.5,
        heading = 180.0
    },
    {
        isCompatible = PlayerPedIsAdultFemale,
        objects = GenericChairsAndBenches,
        radius = 1.5,
        scenarios = {
            {name = 'PROP_HUMAN_SEAT_CHAIR_FAN' , label = Config.Label["PROP_HUMAN_SEAT_CHAIR_FAN"]}
        },
        x = 0.0,
        y = 0.0,
        z = 0.5,
        heading = 240.0
    },
    {
        isCompatible = PlayerPedIsAdult,
        objects = {'p_chairrusticsav01x'},
        radius = 1.5,
        scenarios = {
            {name = 'GENERIC_SEAT_BENCH_SCENARIO' , label = Config.Label["GENERIC_SEAT_BENCH_SCENARIO"]},
            {name = 'GENERIC_SEAT_CHAIR_SCENARIO', label = Config.Label["GENERIC_SEAT_CHAIR_SCENARIO"]},
            {name = 'GENERIC_SEAT_CHAIR_TABLE_SCENARIO' , label = Config.Label["GENERIC_SEAT_CHAIR_TABLE_SCENARIO"]},
            {name = 'MP_LOBBY_PROP_HUMAN_SEAT_BENCH_PORCH_DRINKING' , label = Config.Label["MP_LOBBY_PROP_HUMAN_SEAT_BENCH_PORCH_DRINKING"]},
            {name = 'MP_LOBBY_PROP_HUMAN_SEAT_BENCH_PORCH_SMOKING' , label = Config.Label["MP_LOBBY_PROP_HUMAN_SEAT_BENCH_PORCH_SMOKING"]},
            {name = 'MP_LOBBY_PROP_HUMAN_SEAT_CHAIR' , label = Config.Label["MP_LOBBY_PROP_HUMAN_SEAT_CHAIR"]},
            {name = 'MP_LOBBY_PROP_HUMAN_SEAT_CHAIR_KNIFE_BADASS' , label = Config.Label["MP_LOBBY_PROP_HUMAN_SEAT_CHAIR_KNIFE_BADASS"]},
            {name = 'MP_LOBBY_PROP_HUMAN_SEAT_CHAIR_WHITTLE' , label = Config.Label["MP_LOBBY_PROP_HUMAN_SEAT_CHAIR_WHITTLE"]},
            {name = 'PROP_CAMP_FIRE_SEAT_CHAIR' , label = Config.Label["PROP_CAMP_FIRE_SEAT_CHAIR"]},
            {name = 'PROP_HUMAN_CAMP_FIRE_SEAT_BOX' , label = Config.Label["PROP_HUMAN_CAMP_FIRE_SEAT_BOX"]},
            {name = 'PROP_HUMAN_SEAT_BENCH_CONCERTINA', isCompatible = PlayerPedIsMale , label = Config.Label["PROP_HUMAN_SEAT_BENCH_CONCERTINA"]},
            {name = 'PROP_HUMAN_SEAT_BENCH_FIDDLE', isCompatible = PlayerPedIsFemale , label = Config.Label["PROP_HUMAN_SEAT_BENCH_FIDDLE"]},
            {name = 'PROP_HUMAN_SEAT_BENCH_JAW_HARP', isCompatible = PlayerPedIsMale , label = Config.Label["PROP_HUMAN_SEAT_BENCH_JAW_HARP"]},
            {name = 'PROP_HUMAN_SEAT_BENCH_MANDOLIN', isCompatible = PlayerPedIsMale , label = Config.Label["PROP_HUMAN_SEAT_BENCH_MANDOLIN"]},
            {name = 'PROP_HUMAN_SEAT_CHAIR' , label = Config.Label["PROP_HUMAN_SEAT_CHAIR"]},
            {name = 'PROP_HUMAN_SEAT_CHAIR_BANJO', isCompatible = PlayerPedIsMale , label = Config.Label["PROP_HUMAN_SEAT_CHAIR_BANJO"]},
            {name = 'PROP_HUMAN_SEAT_CHAIR_CLEAN_RIFLE' , label = Config.Label["PROP_HUMAN_SEAT_CHAIR_CLEAN_RIFLE"]},
            {name = 'PROP_HUMAN_SEAT_CHAIR_CLEAN_SADDLE' , label = Config.Label["PROP_HUMAN_SEAT_CHAIR_CLEAN_SADDLE"]},
            {name = 'PROP_HUMAN_SEAT_CHAIR_CRAB_TRAP', isCompatible = PlayerPedIsMale , label = Config.Label["PROP_HUMAN_SEAT_CHAIR_CRAB_TRAP"]},
            {name = 'PROP_HUMAN_SEAT_CHAIR_CIGAR', isCompatible = PlayerPedIsMale , label = Config.Label["PROP_HUMAN_SEAT_CHAIR_CIGAR"]},
            {name = 'PROP_HUMAN_SEAT_CHAIR_GROOMING_GROSS', isCompatible = PlayerPedIsMale , label = Config.Label["PROP_HUMAN_SEAT_CHAIR_GROOMING_GROSS"]},
            {name = 'PROP_HUMAN_SEAT_CHAIR_GROOMING_POSH', isCompatible = PlayerPedIsFemale , label = Config.Label["PROP_HUMAN_SEAT_CHAIR_GROOMING_POSH"]},
            {name = 'PROP_HUMAN_SEAT_CHAIR_GUITAR', isCompatible = PlayerPedIsMale , label = Config.Label["PROP_HUMAN_SEAT_CHAIR_GUITAR"]},
            {name = 'PROP_HUMAN_SEAT_CHAIR_KNIFE_BADASS', isCompatible = PlayerPedIsMale , label = Config.Label["PROP_HUMAN_SEAT_CHAIR_KNIFE_BADASS"]},
            {name = 'PROP_HUMAN_SEAT_CHAIR_KNITTING', isCompatible = PlayerPedIsFemale , label = Config.Label["PROP_HUMAN_SEAT_CHAIR_KNITTING"]},
            {name = 'PROP_HUMAN_SEAT_CHAIR_PORCH', label = Config.Label["PROP_HUMAN_SEAT_CHAIR_PORCH"]},
            {name = 'PROP_HUMAN_SEAT_CHAIR_READING', isCompatible = PlayerPedIsFemale , label = Config.Label["PROP_HUMAN_SEAT_CHAIR_READING"]}

        },
        x = 0.0,
        y = -0.1,
        z = 0.5,
        heading = 180.0
    },
    {
        isCompatible = PlayerPedIsAdult,
        objects = {'p_chairtall01x'},
        radius = 1.5,
        scenarios = {
            {name = 'GENERIC_SEAT_BENCH_SCENARIO' , label = Config.Label["GENERIC_SEAT_BENCH_SCENARIO"]},
            {name = 'GENERIC_SEAT_CHAIR_SCENARIO', label = Config.Label["GENERIC_SEAT_CHAIR_SCENARIO"]},
            {name = 'GENERIC_SEAT_CHAIR_TABLE_SCENARIO' , label = Config.Label["GENERIC_SEAT_CHAIR_TABLE_SCENARIO"]},
            {name = 'MP_LOBBY_PROP_HUMAN_SEAT_BENCH_PORCH_DRINKING' , label = Config.Label["MP_LOBBY_PROP_HUMAN_SEAT_BENCH_PORCH_DRINKING"]},
            {name = 'MP_LOBBY_PROP_HUMAN_SEAT_BENCH_PORCH_SMOKING' , label = Config.Label["MP_LOBBY_PROP_HUMAN_SEAT_BENCH_PORCH_SMOKING"]},
            {name = 'MP_LOBBY_PROP_HUMAN_SEAT_CHAIR' , label = Config.Label["MP_LOBBY_PROP_HUMAN_SEAT_CHAIR"]},
            {name = 'MP_LOBBY_PROP_HUMAN_SEAT_CHAIR_KNIFE_BADASS' , label = Config.Label["MP_LOBBY_PROP_HUMAN_SEAT_CHAIR_KNIFE_BADASS"]},
            {name = 'MP_LOBBY_PROP_HUMAN_SEAT_CHAIR_WHITTLE' , label = Config.Label["MP_LOBBY_PROP_HUMAN_SEAT_CHAIR_WHITTLE"]},
            {name = 'PROP_CAMP_FIRE_SEAT_CHAIR' , label = Config.Label["PROP_CAMP_FIRE_SEAT_CHAIR"]},
            {name = 'PROP_HUMAN_CAMP_FIRE_SEAT_BOX' , label = Config.Label["PROP_HUMAN_CAMP_FIRE_SEAT_BOX"]},
            {name = 'PROP_HUMAN_SEAT_BENCH_CONCERTINA', isCompatible = PlayerPedIsMale , label = Config.Label["PROP_HUMAN_SEAT_BENCH_CONCERTINA"]},
            {name = 'PROP_HUMAN_SEAT_BENCH_FIDDLE', isCompatible = PlayerPedIsFemale , label = Config.Label["PROP_HUMAN_SEAT_BENCH_FIDDLE"]},
            {name = 'PROP_HUMAN_SEAT_BENCH_JAW_HARP', isCompatible = PlayerPedIsMale , label = Config.Label["PROP_HUMAN_SEAT_BENCH_JAW_HARP"]},
            {name = 'PROP_HUMAN_SEAT_BENCH_MANDOLIN', isCompatible = PlayerPedIsMale , label = Config.Label["PROP_HUMAN_SEAT_BENCH_MANDOLIN"]},
            {name = 'PROP_HUMAN_SEAT_CHAIR' , label = Config.Label["PROP_HUMAN_SEAT_CHAIR"]},
            {name = 'PROP_HUMAN_SEAT_CHAIR_BANJO', isCompatible = PlayerPedIsMale , label = Config.Label["PROP_HUMAN_SEAT_CHAIR_BANJO"]},
            {name = 'PROP_HUMAN_SEAT_CHAIR_CLEAN_RIFLE' , label = Config.Label["PROP_HUMAN_SEAT_CHAIR_CLEAN_RIFLE"]},
            {name = 'PROP_HUMAN_SEAT_CHAIR_CLEAN_SADDLE' , label = Config.Label["PROP_HUMAN_SEAT_CHAIR_CLEAN_SADDLE"]},
            {name = 'PROP_HUMAN_SEAT_CHAIR_CRAB_TRAP', isCompatible = PlayerPedIsMale , label = Config.Label["PROP_HUMAN_SEAT_CHAIR_CRAB_TRAP"]},
            {name = 'PROP_HUMAN_SEAT_CHAIR_CIGAR', isCompatible = PlayerPedIsMale , label = Config.Label["PROP_HUMAN_SEAT_CHAIR_CIGAR"]},
            {name = 'PROP_HUMAN_SEAT_CHAIR_GROOMING_GROSS', isCompatible = PlayerPedIsMale , label = Config.Label["PROP_HUMAN_SEAT_CHAIR_GROOMING_GROSS"]},
            {name = 'PROP_HUMAN_SEAT_CHAIR_GROOMING_POSH', isCompatible = PlayerPedIsFemale , label = Config.Label["PROP_HUMAN_SEAT_CHAIR_GROOMING_POSH"]},
            {name = 'PROP_HUMAN_SEAT_CHAIR_GUITAR', isCompatible = PlayerPedIsMale , label = Config.Label["PROP_HUMAN_SEAT_CHAIR_GUITAR"]},
            {name = 'PROP_HUMAN_SEAT_CHAIR_KNIFE_BADASS', isCompatible = PlayerPedIsMale , label = Config.Label["PROP_HUMAN_SEAT_CHAIR_KNIFE_BADASS"]},
            {name = 'PROP_HUMAN_SEAT_CHAIR_KNITTING', isCompatible = PlayerPedIsFemale , label = Config.Label["PROP_HUMAN_SEAT_CHAIR_KNITTING"]},
            {name = 'PROP_HUMAN_SEAT_CHAIR_PORCH', label = Config.Label["PROP_HUMAN_SEAT_CHAIR_PORCH"]},
            {name = 'PROP_HUMAN_SEAT_CHAIR_READING', isCompatible = PlayerPedIsFemale , label = Config.Label["PROP_HUMAN_SEAT_CHAIR_READING"]}
        },
        x = 0.0,
        y = 0.0,
        z = 0.8,
        heading = 180.0
    },
    {
        isCompatible = PlayerPedIsChild,
        objects = GenericChairsAndBenches,
        radius = 1.5,
        scenarios = {
            {name = 'GENERIC_SEAT_BENCH_SCENARIO' , label = Config.Label["GENERIC_SEAT_BENCH_SCENARIO"]},
            {name = 'GENERIC_SEAT_CHAIR_TABLE_SCENARIO', label = Config.Label["GENERIC_SEAT_CHAIR_TABLE_SCENARIO"]},
            {name = 'MP_LOBBY_PROP_HUMAN_SEAT_BENCH_PORCH_DRINKING', label = Config.Label["MP_LOBBY_PROP_HUMAN_SEAT_BENCH_PORCH_DRINKING"]},
            {name = 'MP_LOBBY_PROP_HUMAN_SEAT_BENCH_PORCH_SMOKING', label = Config.Label["MP_LOBBY_PROP_HUMAN_SEAT_BENCH_PORCH_SMOKING"]},
            {name = 'MP_LOBBY_PROP_HUMAN_SEAT_CHAIR', label = Config.Label["MP_LOBBY_PROP_HUMAN_SEAT_CHAIR"]},
            {name = 'MP_LOBBY_PROP_HUMAN_SEAT_CHAIR_KNIFE_BADASS', label = Config.Label["MP_LOBBY_PROP_HUMAN_SEAT_CHAIR_KNIFE_BADASS"]},
            {name = 'MP_LOBBY_PROP_HUMAN_SEAT_CHAIR_WHITTLE', label = Config.Label["MP_LOBBY_PROP_HUMAN_SEAT_CHAIR_WHITTLE"]},
            {name = 'PROP_CAMP_FIRE_SEAT_CHAIR', label = Config.Label["PROP_CAMP_FIRE_SEAT_CHAIR"]},
            {name = 'PROP_HUMAN_CAMP_FIRE_SEAT_BOX', label = Config.Label["PROP_HUMAN_CAMP_FIRE_SEAT_BOX"]},
            {name = 'PROP_HUMAN_SEAT_CHAIR', label = Config.Label["PROP_HUMAN_SEAT_CHAIR"]},
            {name = 'PROP_HUMAN_SEAT_CHAIR_BANJO', isCompatible = PlayerPedIsMale, label = Config.Label["PROP_HUMAN_SEAT_CHAIR_BANJO"]},
            {name = 'PROP_HUMAN_SEAT_CHAIR_CLEAN_RIFLE', label = Config.Label["PROP_HUMAN_SEAT_CHAIR_CLEAN_RIFLE"]},
            {name = 'PROP_HUMAN_SEAT_CHAIR_CLEAN_SADDLE', label = Config.Label["PROP_HUMAN_SEAT_CHAIR_CLEAN_SADDLE"]},
            {name = 'PROP_HUMAN_SEAT_CHAIR_CRAB_TRAP', isCompatible = PlayerPedIsMale, label = Config.Label["PROP_HUMAN_SEAT_CHAIR_CRAB_TRAP"]},
            {name = 'PROP_HUMAN_SEAT_CHAIR_CIGAR', isCompatible = PlayerPedIsMale, label = Config.Label["PROP_HUMAN_SEAT_CHAIR_CIGAR"]},
            {name = 'PROP_HUMAN_SEAT_CHAIR_GUITAR', isCompatible = PlayerPedIsMale, label = Config.Label["PROP_HUMAN_SEAT_CHAIR_GUITAR"]}
        },
        x = 0.0,
        y = 0.0,
        z = 0.4,
        heading = 180.0
    }
}




Keys = {
  -- Mouse buttons
  ["MOUSE1"] = 0x07CE1E61, ["MOUSE2"] = 0xF84FA74F, ["MOUSE3"] = 0xCEE12B50, ["MWUP"] = 0x3076E97C,
  -- keyboard
  ["A"] = 0x7065027D, ["B"] = 0x4CC0E2FE, ["C"] = 0x9959A6F0, ["D"] = 0xB4E465B4, ["E"] = 0xCEFD9220,
  ["F"] = 0xB2F377E8, ["G"] = 0x760A9C6F, ["H"] = 0x24978A28, ["I"] = 0xC1989F95, ["J"] = 0xF3830D8E,
  ["L"] = 0x80F28E95, ["M"] = 0xE31C6A41, ["N"] = 0x4BC9DABB, ["O"] = 0xF1301666, ["P"] = 0xD82E0BD2,
  ["Q"] = 0xDE794E3E, ["R"] = 0xE30CD707, ["S"] = 0xD27782E3, ["U"] = 0xD8F73058, ["V"] = 0x7F8D09B8,
  ["W"] = 0x8FD015D8, ["X"] = 0x8CC9CD42, ["Z"] = 0x26E9DC00, ["RIGHTBRACKET"] = 0xA5BDCD3C,
  ["LEFTBRACKET"] = 0x430593AA, ["CTRL"] = 0xDB096B85, ["TAB"] = 0xB238FE0B, ["SHIFT"] = 0x8FFC75D6,
  ["SPACEBAR"] = 0xD9D0E1C0, ["ENTER"] = 0xC7B5340A, ["BACKSPACE"] = 0x156F7119, ["LALT"] = 0x8AAA0AD4,
  ["DEL"] = 0x4AF4D473, ["PGUP"] = 0x446258B6, ["PGDN"] = 0x3C3DD371, ["F1"] = 0xA8E3F467,
  ["F4"] = 0x1F6D95E5, ["F6"] = 0x3C0A40F2, ["1"] = 0xE6F612E4, ["2"] = 0x1CE6D9EB, ["3"] = 0x4F49CC4C,
  ["4"] = 0x8F9F9E58, ["5"] = 0xAB62E997, ["6"] = 0xA1FDE2A6, ["7"] = 0xB03A913B, ["8"] = 0x42385422,
  ["DOWN"] = 0x05CA7C52, ["UP"] = 0x6319DB71, ["LEFT"] = 0xA65EBAB4, ["RIGHT"] = 0xDEB34313,
}
