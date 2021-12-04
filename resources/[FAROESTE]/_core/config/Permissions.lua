config_file_GROUPS = {
    -- ["none"] = 0,        -- 0
    ["admin"]     = 1 <<  0, -- 1
    ["moderator"] = 1 <<  1, -- 2
    ["sheriff"]   = 1 <<  2, -- 4
    ["trooper"]   = 1 <<  3, -- 8
    ["medic"]     = 1 <<  4, -- 16
    ["armeiro"]   = 1 << 5,
    ["padeiro"]   = 1 << 6,
    ["ferreiro"]  = 1 << 7,
    ["alfaiate"]  = 1 << 8,
    ["indio"]     = 1 << 9,
    ["xama"]      = 1 << 10,
    ["marshall"]  = 1 << 11,
    ["delegado"]  = 1 << 12,
    ["recruta"]   = 1 << 13,
    ["governador"] = 1 << 14,
    ["secretario"] = 1 << 15,
    ["jornalista"] = 1 << 16
    --[[["house:1"]   = 1 <<  5, -- 32
    ["house:2"]   = 1 <<  6, -- 64
    ["house:3"]   = 1 <<  7, -- 128
    ["house:4"]   = 1 <<  8, -- 256
    ["house:5"]   = 1 <<  9, -- 
    ["house:6"]   = 1 << 10,
    ["house:7"]   = 1 << 11,]]
}

config_file_INHERITANCE = {
    ["admin"] = "moderator",

    ["marshall"] = "delegado",
    ["delegado"] = "sheriff",
    ["sheriff"] = "trooper",
    ["trooper"] = "recruta",

    ["xama"] = "indio",

    ["governador"] = "secretario",
}