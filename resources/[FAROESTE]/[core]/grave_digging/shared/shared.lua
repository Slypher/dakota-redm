enum 'eDiggingSitePointState' {
    INVALID              = -1,
    -- INIT                 =  0,
    HAS_LOOT_NONE        =  0,
    HAS_LOOT_FULL        =  1,
    CREATE_ENTITIES      =  2,
    REQUEST_ANIM_SCENE   =  3,
    LOAD_ANIM_SCENE      =  5,
    PLAY_ANIM_SCENE_WAIT =  6,
    WAIT_TO_BE_DONE      =  7,
    LOOT_WAIT            =  8,
    DONE                 =  9,
    EMPTY                = 10,
}