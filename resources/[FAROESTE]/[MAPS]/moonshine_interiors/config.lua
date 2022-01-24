Config = {}

Config.UseTeleports = true
Config.Blips = false

-- Change interior_sets with the interior you want at that location
-- https://github.com/femga/rdr3_discoveries/blob/399df3278b5101af1044f205c045648d2c8bcb38/interiors/interior_sets/README.md

Config.Shacks = {

    ['lemoyne'] = {
        ['outside'] = vector3(1048.384,-1829.544,48.862), -- GOVERNADOR
        ['inside'] = vector3(1785.01,-821.53,191.01),
        ['interior'] = 77313,
        ['interior_sets'] = {
            "mp006_mshine_band1",
            --"mp006_mshine_bar_benchAndFrame",
            "mp006_mshine_dressing_2",
            "mp006_mshine_hidden_door_open",
            "mp006_mshine_location3",
            --"mp006_mshine_pic_04",
            "mp006_mshine_shelfwall1",
            "mp006_mshine_shelfwall2",
            "mp006_mshine_Still_01",
            "mp006_mshine_still_hatch",
            "mp006_mshine_theme_refined",
        },
    },

    ['cattail_pond'] = {
        ['outside'] = vector3(-339.759,796.486,117.116), -- VALENTINE
        ['inside'] = vector3(-1085.63, 714.14, 83.23),
        ['interior'] = 77569,
        ['interior_sets'] = {
            "mp006_mshine_band1",
            --"mp006_mshine_bar_benchAndFrame",
            "mp006_mshine_dressing_3",
            "mp006_mshine_hidden_door_open",
            "mp006_mshine_location3",
            "mp006_mshine_pic_02",
            "mp006_mshine_shelfwall1",
            "mp006_mshine_shelfwall2",
            --"mp006_mshine_Still_01",
            --"mp006_mshine_still_hatch",
            "mp006_mshine_theme_hunter",
        },
    },

    ['new_austin'] = {
        ['outside'] = vector3(-3955.325,-2138.864,-4.261), -- TWIN ROCK
        ['inside'] = vector3(-2769.3, -3048.87, -9.7),
        ['interior'] = 78337,
        ['interior_sets'] = {
            "mp006_mshine_band1",
            --"mp006_mshine_bar_benchAndFrame",
            "mp006_mshine_dressing_1",
            "mp006_mshine_hidden_door",
            "mp006_mshine_location3",
            --"mp006_mshine_pic_04",
            "mp006_mshine_shelfwall1",
            "mp006_mshine_shelfwall2",
            --"mp006_mshine_Still_01",
            --"mp006_mshine_still_hatch",
            "mp006_mshine_theme_floral",
        },
    },

    ['hanover'] = {
        ['outside'] = vector3(-762.818,-1454.833,55.565), -- EMERALD
        ['inside'] = vector3(1626.033,829.608,125.004),
        ['interior'] = 78593,
        ['interior_sets'] = {
            "mp006_mshine_band1",
            --"mp006_mshine_bar_benchAndFrame",
            "mp006_mshine_dressing_2",
            "mp006_mshine_hidden_door",
            --"mp006_mshine_location3",
            --"mp006_mshine_pic_03",
            "mp006_mshine_shelfwall1",
            "mp006_mshine_shelfwall2",
            --"mp006_mshine_Still_01",
            --"mp006_mshine_still_hatch",,
            --"mp006_mshine_theme_goth",
        },
    },

    ['manzanita_post'] = {
        ['outside'] = vector3(-810.301,-1346.528,43.731), -- BLACKWATER
        ['inside'] = vector3(-1861.7, -1722.17, 88.35),
        ['interior'] = 77825,
        ['interior_sets'] = {
            "mp006_mshine_band1",
            --"mp006_mshine_bar_benchAndFrame",
            "mp006_mshine_dressing_3",
            "mp006_mshine_hidden_door_open",
            "mp006_mshine_location3",
            --"mp006_mshine_pic_04",
            "mp006_mshine_shelfwall1",
            "mp006_mshine_shelfwall2",
            --"mp006_mshine_Still_01",
            --"mp006_mshine_still_hatch",
            --"mp006_mshine_theme_refined",
        },
    },
}


-- DESTILADORES
-- mp006_mshine_Still_01
-- mp006_mshine_Still_02
-- mp006_mshine_Still_03


-- ROUPAS/PANOS PENDURADOS NO TETO
-- mp006_mshine_dressing_1
-- mp006_mshine_dressing_2
-- mp006_mshine_dressing_3


-- BANDA
-- "mp006_mshine_band2",
-- "mp006_mshine_band2",
 

-- QUADROS
-- mp006_mshine_pic_01
-- mp006_mshine_pic_02
-- mp006_mshine_pic_03
-- mp006_mshine_pic_04

-- PORTA SECRETA
-- mp006_mshine_hidden_door_open
-- mp006_mshine_hidden_door

-- THEMES
-- mp006_mshine_theme_hunter
-- mp006_mshine_theme_christmas
-- mp006_mshine_theme_floral
-- mp006_mshine_theme_refined
-- mp006_mshine_theme_goth