-- Menu configuration, array of menus to display
menuConfigs = {
    ['menu'] = {
        enableMenu = function()
            return false
        end,
        data = {
            keybind = "F6",
            style = {
                sizePx = 600,
                slices = {
                    default = { ['fill'] = '#000000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.60 },
                    hover = { ['fill'] = '#b30000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.80 },
                    selected = { ['fill'] = '#b30000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.80 }
                },
                titles = {
                    default = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' },
                    hover = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' },
                    selected = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' }
                },
                icons = {
                    width = 64,
                    height = 64
                }
            },
            wheels = {
                {
                    navAngle = 0,                 -- Oritentation of wheel
                    minRadiusPercent = 0.0,         -- Minimum radius of wheel in percentage
                    maxRadiusPercent = 0.3,         -- Maximum radius of wheel in percentage
                    labels = {"CLOSE", "STOP"},
                    commands = {"closewheel", "cancelemote"}
                },
                {
                    navAngle = 270,
                    minRadiusPercent = 0.3,
                    maxRadiusPercent = 0.6,
                    labels = {"STANCE", "EMOTES", "EMOTES II", "EMOTES III", "EMOTES IV", "EMOTES V", "SCENARIOS"},
                    commands = {"submenu1", "submenu2", "submenu3", "submenu4", "submenu5", "submenu6", "submenu7"}
                }
            }
        }
    }
}

-- Submenu configuration
subMenuConfigs = {
    --[[['submenu1'] = {
        data = {
            keybind = "F6",
            style = {
                sizePx = 600,
                slices = {
                    default = { ['fill'] = '#000000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.60 },
                    hover = { ['fill'] = '#b30000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.80 },
                    selected = { ['fill'] = '#b30000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.80 }
                },
                titles = {
                    default = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' },
                    hover = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' },
                    selected = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' }
                },
                icons = {
                    width = 64,
                    height = 64
                }
            },
            wheels = {
                {
                    navAngle = 0,                 -- Oritentation of wheel
                    minRadiusPercent = 0.0,         -- Minimum radius of wheel in percentage
                    maxRadiusPercent = 0.3,         -- Maximum radius of wheel in percentage
                    labels = {"CLOSE", "STOP"},
                    commands = {"closewheel", "cancelemote"}
                },
                {
                    navAngle = 270,
                    minRadiusPercent = 0.3,
                    maxRadiusPercent = 0.6,
                    labels = {"STANCE", "EMOTES", "EMOTES II", "EMOTES III", "EMOTES IV", "EMOTES V", "SCENARIOS"},
                    commands = {"submenu1", "submenu2", "submenu3", "submenu4", "submenu5", "submenu6", "submenu7"}
                },
                {
                    navAngle = 285,
                    minRadiusPercent = 0.6,
                    maxRadiusPercent = 0.9,
                    labels = {"SLEEP", "SIT GROUND", "IDLE", "IDLE 2", "LEAN RAIL", "DRUNK", "WRITE LEDGER", "COUGH", "PUKE", "DANCE"},
                    commands = {"sleep1", "sitground2", "idle1", "idle2", "leanrail1", "drunk1", "writeledger1", "cough1", "puke1", "dance1"}
                }
            }
        }
    },
    ['submenu2'] = {
        data = {
            keybind = "F6",
            style = {
                sizePx = 600,
                slices = {
                    default = { ['fill'] = '#000000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.60 },
                    hover = { ['fill'] = '#b30000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.80 },
                    selected = { ['fill'] = '#b30000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.80 }
                },
                titles = {
                    default = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' },
                    hover = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' },
                    selected = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' }
                },
                icons = {
                    width = 64,
                    height = 64
                }
            },
            wheels = {
                {
                    navAngle = 0,                 -- Oritentation of wheel
                    minRadiusPercent = 0.0,         -- Minimum radius of wheel in percentage
                    maxRadiusPercent = 0.3,         -- Maximum radius of wheel in percentage
                    labels = {"CLOSE", "STOP"},
                    commands = {"closewheel", "cancelemote"}
                },
                {
                    navAngle = 270,
                    minRadiusPercent = 0.3,
                    maxRadiusPercent = 0.6,
                    labels = {"STANCE", "EMOTES", "EMOTES II", "EMOTES III", "EMOTES IV", "EMOTES V", "SCENARIOS"},
                    commands = {"submenu1", "submenu2", "submenu3", "submenu4", "submenu5", "submenu6", "submenu7"}
                },
                {
                    navAngle = 285,
                    minRadiusPercent = 0.6,
                    maxRadiusPercent = 0.9,
                    labels = {"STINKY", "WAVE", "THUMBS UP", "THUMBS DOWN", "DRAW", "YES", "NO", "HELL YEAH", "SPIT", "APPLAUSE", "SLOW CLAP", "TA-DA"},
                    commands = {"stinky1", "wave1", "thumbsup1", "thumbsdown1", "draw1", "yes1", "no1", "hellyeah1", "idlespit1", "applause1", "slowclap1", "tada1"}
                },
            }
        }
    },
    ['submenu3'] = {
        data = {
            keybind = "F6",
            style = {
                sizePx = 600,
                slices = {
                    default = { ['fill'] = '#000000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.60 },
                    hover = { ['fill'] = '#b30000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.80 },
                    selected = { ['fill'] = '#b30000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.80 }
                },
                titles = {
                    default = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' },
                    hover = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' },
                    selected = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' }
                },
                icons = {
                    width = 64,
                    height = 64
                }
            },
            wheels = {
                {
                    navAngle = 0,                 -- Oritentation of wheel
                    minRadiusPercent = 0.0,         -- Minimum radius of wheel in percentage
                    maxRadiusPercent = 0.3,         -- Maximum radius of wheel in percentage
                    labels = {"CLOSE", "STOP"},
                    commands = {"closewheel", "cancelemote"}
                },
                {
                    navAngle = 270,
                    minRadiusPercent = 0.3,
                    maxRadiusPercent = 0.6,
                    labels = {"STANCE", "EMOTES", "EMOTES II", "EMOTES III", "EMOTES IV", "EMOTES V", "SCENARIOS"},
                    commands = {"submenu1", "submenu2", "submenu3", "submenu4", "submenu5", "submenu6", "submenu7"}
                },
                {
                    navAngle = 285,
                    minRadiusPercent = 0.6,
                    maxRadiusPercent = 0.9,
                    labels = {"BLOW KISS", "BOAST", "FLEX", "FOLLOW ME", "LET'S GO", "LET'S CRAFT", "WANNA FISH?", "PLAY CARDS?", "LOOK DISTANCE", "LOOK YONDER", "POINT"},
                    commands = {"blowkiss1", "boast1", "flex1", "followme1", "letsgo1", "letscraft1", "wannafish1", "playcards1", "lookdistance1", "lookyonder1", "point1"}
                }
            }
        }
    },
    ['submenu4'] = {
        data = {
            keybind = "F6",
            style = {
                sizePx = 600,
                slices = {
                    default = { ['fill'] = '#000000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.60 },
                    hover = { ['fill'] = '#b30000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.80 },
                    selected = { ['fill'] = '#b30000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.80 }
                },
                titles = {
                    default = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' },
                    hover = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' },
                    selected = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' }
                },
                icons = {
                    width = 64,
                    height = 64
                }
            },
            wheels = {
                {
                    navAngle = 0,                 -- Oritentation of wheel
                    minRadiusPercent = 0.0,         -- Minimum radius of wheel in percentage
                    maxRadiusPercent = 0.3,         -- Maximum radius of wheel in percentage
                    labels = {"CLOSE", "STOP"},
                    commands = {"closewheel", "cancelemote"}
                },
                {
                    navAngle = 270,
                    minRadiusPercent = 0.3,
                    maxRadiusPercent = 0.6,
                    labels = {"STANCE", "EMOTES", "EMOTES II", "EMOTES III", "EMOTES IV", "EMOTES V", "SCENARIOS"},
                    commands = {"submenu1", "submenu2", "submenu3", "submenu4", "submenu5", "submenu6", "submenu7"}
                },
                {
                    navAngle = 285,
                    minRadiusPercent = 0.6,
                    maxRadiusPercent = 0.9,
                    labels = {"POSSE UP", "PROSPECTOR JIG", "SCHEME", "SHOOT EM UP", "SHOOT THE SKY", "LET'S STOP", "FANCY BOW", "GENTLE WAVE", "GOOD TO SEE YA", "TIP HAT", "RESPECTFUL BOW"},
                    commands = {"posseup1", "prospectorjig1", "scheme1", "shootemup1", "shootthesky1", "letsstop1", "fancybow1", "gentlewave1", "goodtoseeya1", "hattipping1", "respectfulbow1"}
                }
            }
        }
    },
    ['submenu5'] = {
        data = {
            keybind = "F6",
            style = {
                sizePx = 600,
                slices = {
                    default = { ['fill'] = '#000000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.60 },
                    hover = { ['fill'] = '#b30000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.80 },
                    selected = { ['fill'] = '#b30000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.80 }
                },
                titles = {
                    default = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' },
                    hover = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' },
                    selected = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' }
                },
                icons = {
                    width = 64,
                    height = 64
                }
            },
            wheels = {
                {
                    navAngle = 0,                 -- Oritentation of wheel
                    minRadiusPercent = 0.0,         -- Minimum radius of wheel in percentage
                    maxRadiusPercent = 0.3,         -- Maximum radius of wheel in percentage
                    labels = {"CLOSE", "STOP"},
                    commands = {"closewheel", "cancelemote"}
                },
                {
                    navAngle = 270,
                    minRadiusPercent = 0.3,
                    maxRadiusPercent = 0.6,
                    labels = {"STANCE", "EMOTES", "EMOTES II", "EMOTES III", "EMOTES IV", "EMOTES V", "SCENARIOS"},
                    commands = {"submenu1", "submenu2", "submenu3", "submenu4", "submenu5", "submenu6", "submenu7"}
                },
                {
                    navAngle = 285,
                    minRadiusPercent = 0.6,
                    maxRadiusPercent = 0.9,
                    labels = {"TOUGH GUY NOD", "BEG FOR MERCY", "GAG", "HUSH YOUR MOUTH", "POINT & LAUGH", "I'M HIT", "WEEP", "WHO, ME?", "HEY YOU!", "YEEHAW"},
                    commands = {"toughguynod1", "begformercy1", "gag1", "hushyourmouth1", "pointandlaugh1", "imhit1", "weep1", "whome1", "heyyou1", "yeehaw1"}
                }
            }
        }
    },]]
    ['submenu2'] = {
        data = {
            keybind = "F6",
            style = {
                sizePx = 600,
                slices = {
                    default = { ['fill'] = '#000000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.60 },
                    hover = { ['fill'] = '#b30000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.80 },
                    selected = { ['fill'] = '#b30000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.80 }
                },
                titles = {
                    default = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' },
                    hover = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' },
                    selected = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' }
                },
                icons = {
                    width = 64,
                    height = 64
                }
            },
            wheels = {
                {
                    navAngle = 0,                 -- Oritentation of wheel
                    minRadiusPercent = 0.0,         -- Minimum radius of wheel in percentage
                    maxRadiusPercent = 0.0,         -- Maximum radius of wheel in percentage
                    labels = {"FECHAR, E NÃO \nMEXER EM NADA"},-- "STOP"},
                    commands = {"closewheel"},-- "cancelemote"}
                },
                {
                    navAngle = 270,
                    minRadiusPercent = 0.3,
                    maxRadiusPercent = 0.6,
                    labels = {"Roupas", "Acessórios",},-- "EMOTES II", "EMOTES III", "EMOTES IV", "EMOTES V", "SCENARIOS"},
                    commands = {"submenu1", "submenu2",}-- "submenu3", "submenu4", "submenu5", "submenu6", "submenu7"}
                },
                {
                    navAngle = 285,
                    minRadiusPercent = 0.6,
                    maxRadiusPercent = 0.9,
                    labels = {"Chaps", "Esporas", "Polainas", "Luvas", "Cartucheira", "Coldre\nPrimario", "Coldre\nSecundário","Cinto", "Anéis", "Fivela", "Mascara", "Lenços", "Gravatas", "Bracelete", "Manoplas"},
                    commands = {"chaps", "esporas", "polainas", "luvas", "cartucheira", "coldre", "coldre2","cinto", "aneis", "fivela", "mascara", "lencos", "gravatas", "bracelete", "manoplas"}
                }
            }
        }
    },
    ['submenu1'] = {
        data = {
            keybind = "F6",
            style = {
                sizePx = 600,
                slices = {
                    default = { ['fill'] = '#000000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.60 },
                    hover = { ['fill'] = '#b30000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.80 },
                    selected = { ['fill'] = '#b30000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.80 }
                },
                titles = {
                    default = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' },
                    hover = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' },
                    selected = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' }
                },
                icons = {
                    width = 64,
                    height = 64
                }
            },
            wheels = {
                {
                    navAngle = 0,                 -- Oritentation of wheel
                    minRadiusPercent = 0.0,         -- Minimum radius of wheel in percentage
                    maxRadiusPercent = 0.0,         -- Maximum radius of wheel in percentage
                    labels = {"FECHAR, E NÃO \nMEXER EM NADA"},-- "STOP"},
                    commands = {"closewheel"},-- "cancelemote"}
                },
                {
                    navAngle = 270,
                    minRadiusPercent = 0.3,
                    maxRadiusPercent = 0.6,
                    labels = {"Roupas", "Acessórios"},-- "EMOTES II", "EMOTES III", "EMOTES IV", "EMOTES V", "SCENARIOS"},
                    commands = {"submenu1", "submenu2"}-- "submenu3", "submenu4", "submenu5", "submenu6", "submenu7"}
                },
                {
                    navAngle = 285,
                    minRadiusPercent = 0.6,
                    maxRadiusPercent = 0.9,
                    labels = {"Chapéu", "Camisa", "Suspensórios", "Colete", "Jaqueta", "Casaco \nFechado", "Calça",  "Botas", "Poncho", "Capas", "Acessórios", "Olhos"},
                    commands = {"chapeu", "camisa", "suspensorios", "colete", "casaco", "casacof", "calca", "botas", "poncho", "capas", "acessorio", "olhos"}
                }
            }
        }
    },
}
    
RegisterCommand("closewheel", function(source, args, rawCommand)
    TriggerEvent('wwrp:closewheel')
end)
    
RegisterNetEvent('wwrp:closewheel')
AddEventHandler('wwrp:closewheel', function()
    SetNuiFocus(false, false)
end)

RegisterCommand("cancelemote", function(source, args, rawCommand)
    TriggerEvent('wwrp:cancelemote')
end)
    
RegisterNetEvent('wwrp:cancelemote')
AddEventHandler('wwrp:cancelemote', function()
    ClearPedTasks(PlayerPedId())
    SetCurrentPedWeapon(PlayerPedId(), `WEAPON_UNARMED`, true)
end)

function loadAnimDict(dict)
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(100)
	end
end