Config = {

    -----------------------------------------------------------------------------------------------------------------------------------------------------
    ---------------------------------------------------------------CRAFTS-SEM-PROPS----------------------------------------------------------------------
    -----------------------------------------------------------------------------------------------------------------------------------------------------

    {
        useTextDescriptionAll = true,
        craftings = 
        {
            {
                descriptionTextOverride = 'Madeira e algo para bom para queimar.',
                time = 5,
                input = {
                    {item = "madeiraboa", amount = 1, alias = {"madeiraruim"}}, 
                    {item = "gordura", amount = 1, alias = {"carvao"}}, 
                },
                output = {
                    {item = "melee_torch", amount = 1, name = "Tocha"}
                }
            },
            {
                descriptionTextOverride = 'Madeira e pedras',
                time = 20,
                input = {
                    {item = "pedra", amount = 6},
                    {item = "madeiraboa", amount = 4, alias = {"madeiraruim"}}, 
                    
                },
                output = {
                    {item = "campfiresmall", amount = 1, name = "Fogueira Pequena"}
                }
            },
            {
                descriptionTextOverride = 'Madeira e pedras',
                time = 20,
                input = {
                    {item = "pedra", amount = 6},
                    {item = "madeiraboa", amount = 4, alias = {"madeiraruim"}}, 
                    
                },
                output = {
                    {item = "campfirebig", amount = 1, name = "Fogueira Grande"}
                }
            },  
            {
                descriptionTextOverride = 'Couro e algo afiado',
                time = 10,
                input = {
                    {item = "couro", amount = 1},
                    {item = "melee_knife", amount = 1, alias = {"melee_hatchet,melee_knife_jawbone"}, remove = false},
                },
                output = {
                    {item = "tirascouro", amount = 6, name = "Tiras de Couro"}
                }
            },  
        }
    },
    
    -----------------------------------------------------------------------------------------------------------------------------------------------------
    ---------------------------------------------------------------------FOGUEIRA------------------------------------------------------------------------
    -----------------------------------------------------------------------------------------------------------------------------------------------------

    {
        campfire = true,
        useTextDescriptionAll = true,
        craftings = 
        {
            -------------------------------------- PEIXES 
            
            {
                descriptionTextOverride = 'Peixe pequeno e alguma erva de tempero.',
                time = 30,
                input = {
                    {item = "smallfish", amount = 1},
                    {item = "mentasilvestre", amount = 1, alias = {"oregano", "tomilhorastejante"}},
                },
                output = {
                    {item = "peixepequenoassado", amount = 1, name = "Peixe Pequeno Assado"},
                }
            },
            {
                descriptionTextOverride = 'Peixe médio e alguma erva de tempero.',
                time = 35,
                input = {
                    {item = "mediumfish", amount = 1},
                    {item = "mentasilvestre", amount = 1, alias = {"oregano", "tomilhorastejante"}},
                },
                output = {
                    {item = "peixemedioassado", amount = 1, name = "Peixe Médio Assado"}
                }
            },
            {
                descriptionTextOverride = 'Peixe grande e alguma erva de tempero.',
                time = 40,
                input = {
                    {item = "largefish", amount = 1}, 
                    {item = "mentasilvestre", amount = 1, alias = {"oregano", "tomilhorastejante"}},
                },
                output = {
                    {item = "peixegrandeassado", amount = 1, name = "Peixe Grande Assado"}
                }
            },

            -------------------------------------- PLANTAS 
            {
                descriptionTextOverride = 'Ehhh... Milho?!',
                time = 15,
                input = {
                    {item = "milho", amount = 1}, 
                },
                output = {
                    {item = "milhoassado", amount = 1, name = "Milho Assado"}
                }
            },
            {
                descriptionTextOverride = 'Batatas?',
                time = 15,
                input = {
                    {item = "batata", amount = 1}, 
                },
                output = {
                    {item = "batataassada", amount = 1, name = "Batata Assada"}
                }
            },

            -------------------------------------- CARNES 
            {
                descriptionTextOverride = 'Carne e gordura.',
                time = 40,
                input = {
                    {item = "carneruim", amount = 1, alias = {"carneboa", "carneperfeita"}},
                    {item = "gordura", amount = 1}, 
                },
                output = {
                    {item = "carnefrita", amount = 1, name = "Carne Frita"}
                }
            },
            {
                descriptionTextOverride = 'Carne...',
                time = 40,
                input = {
                    {item = "carneruim", amount = 1, alias = {"carneboa", "carneperfeita"}},
                },
                output = {
                    {item = "carneruimassada", amount = 1, name = "Carne Assada"}
                }
            },
            {
                descriptionTextOverride = 'Carne boa e tomilho.',
                time = 50,
                input = {
                    {item = "carneboa", amount = 1}, 
                    {item = "tomilhorastejante", amount = 3},
                },
                output = {
                    {item = "carneboaassada", amount = 1, name = "Carne Boa Assada"}
                }
            },
            {
                descriptionTextOverride = 'Carne perfeita, oregano e tomilho.',
                time = 60,
                input = {
                    {item = "carneperfeita", amount = 1},
                    {item = "oregano", amount = 3},
                    {item = "tomilhorastejante", amount = 3},
                },
                output = {
                    {item = "carneprimeiraassada", amount = 1, name = "Carne de Primeira Assada"}
                }
            },
            {
                descriptionTextOverride = 'Carne de ave e gordura.',
                time = 20,
                input = {
                    {item = "carneave", amount = 1},
                    {item = "gordura", amount = 2},
                },
                output = {
                    {item = "carneavefrita", amount = 1, name = "Ave Frita"}
                }
            },

            -------------------------------------- BEBIDA 
            {
                descriptionTextOverride = 'Café em pó e água.',
                time = 15,
                input = {
                    {item = "pocafe", amount = 1},
                    {item = "agua", amount = 1},
                },
                output = {
                    {item = "cafe", amount = 1, name = "Café"}
                }
            },

            -------------------------------------- ITENS 
            {
                descriptionTextOverride = 'Madeira ruim é boa para virar carvão, na verdade é pra isso que ela serve...',
                time = 15,
                input = {
                    {item = "madeiraruim", amount = 3},
                },
                output = {
                    {item = "carvao", amount = 3, name = "Carvão"}
                }
            },
        }
    },


    ---------------------------------------------------------------------------------------------------
    --------------------------------------------- CARDERON --------------------------------------------
    ---------------------------------------------------------------------------------------------------
    {
        useTextDescriptionAll = true,
        Calderon = true,
        craftings = 
        {
            -------------------------------------- SOPAS
            {
                descriptionTextOverride = 'Materiais: Cenoura, batatas, água, milho e carne de ave.',
                time = 40,
                input = {
                    {item = "cenoura", amount = 4},
                    {item = "batata", amount = 4},
                    {item = "agua", amount = 2},
                    {item = "milho", amount = 4},
                    {item = "carneave", amount = 2},
                },
                output = {
                    {item = "sopa", amount = 2, name = "Sopa"}
                }
            },
            {
                descriptionTextOverride = 'Materiais: Molho de tomate, carne perfeita, água, batata e cenoura.',
                time = 40,
                input = {
                    {item = "molhotomate", amount = 2},
                    {item = "carneperfeita", amount = 4},
                    {item = "agua", amount = 2},
                    {item = "batata", amount = 6},
                    {item = "cenoura", amount = 6},
                },
                output = {
                    {item = "sopadecarne", amount = 2, name = "Ensopado de Carne"}
                }
            },
            --[[{
                time = 40,
                input = {
                    {item = "agua", amount = 2},
                    {item = "oregano", amount = 3},
                    {item = "cantarelo", amount = 3},
                    {item = "cenouraselvagem", amount = 6},
                },
                output = {
                    {item = "sopaselvagem", amount = 1, name = "Ensopado Selvagem"}
                }
            },]]
            -------------------------------------- COMIDAS 
            {
                descriptionTextOverride = 'Materiais: Umas 5 batatas deve encher uma tigela',
                time = 30,
                input = {
                    {item = "batata", amount = 5},
                },
                output = {
                    {item = "puredebatata", amount = 1, name = "Pure de Batata"}
                }
            },
        }
    },

    ---------------------------------------------------------------------------------------------------
    -------------------------------------------- XAMA -------------------------------------------------
    ---------------------------------------------------------------------------------------------------

    {
        useTextDescriptionAll = true,
        group = "xama",
        craftings = 
        {
            
            -------------------------------------------- ERVAS MEDICINAL ------------------------------------------
            {
                descriptionTextOverride = 'Flores vermelhas, Ginseng do Alaska, Tabaco indigena e algo para picar tudo.',
                time = 15,
                input = {
                    {item = "milfolhas", amount = 5}, 
                    {item = "ginsengalaska", amount = 2}, 
                    {item = "tabacoindiano", amount = 1}, 
                    {item = "melee_knife_jawbone", amount = 1, remove = false}
                },
                output = {
                    {item = "ervamedicinal", amount = 1, name = "Erva Medicinal"},
                }
            },
            -------------------------------------------- ERVAS DE VENENO ------------------------------------------
            --[[{
                time = 15,
                input = {
                    {item = "asclepia", amount = 5}, 
                    {item = "beijaflor", amount = 5}, 
                    {item = "oleandro", amount = 5}, 
                    {item = "melee_knife_jawbone", amount = 1, remove = false}
                },
                output = {
                    {item = "ervadeveneno", amount = 1, name = "Erva de Veneno"},
                }
            },]]
            -------------------------------------------- ERVAS OLHOS DE ÁGUIA ------------------------------------------
            --[[{
                time = 20,
                input = {
                    {item = "tabacoindiano", amount = 5}, 
                    {item = "tomilhorastejante", amount = 5}, 
                    {item = "violeta", amount = 5}, 
                    {item = "melee_knife_jawbone", amount = 1, remove = false}
                },
                output = {
                    {item = "olhosdeaguia", amount = 1, name = "Visão de Águia"},
                }
            },]]
            -------------------------------------------- ERVAS RAÍZES DA TERRA ------------------------------------------
            --[[
                time = 15,
                input = {
                    {item = "cantarelo", amount = 5}, 
                    {item = "maitake", amount = 3}, 
                    {item = "boletobaio", amount = 4}, 
                    {item = "melee_knife_jawbone", amount = 1, remove = false}
                },
                output = {
                    {item = "raizesdaterra", amount = 1, name = "Raízes da Terra"},
                }
            },]]
        }
    },


    {
        group = "indio",
        useTextDescriptionAll = true,
        craftings = 
        {
            -------------------------------------------- MADEIRA REFINADA ------------------------------------------
            {
                descriptionTextOverride = 'Materiais: Madeira boa e algo afiado.',
                time = 15,
                input = {
                    {item = "madeiraboa", amount = 1}, 
                    --{item = "melee_knife_jawbone", amount = 1, alias = {"thrown_tomahawk"}, remove = false},
                    {item = "melee_knife_jawbone", amount = 1, alias = {"melee_hatchet"}, remove = false},
                },
                output = {
                    {item = "madeirarefinada", amount = 1, name = "Madeira Refinada"},
                }
            },
            -------------------------------------------- VARA DE PESCA ------------------------------------------
            --[[
            {
                time = 20,
                input = {
                    {item = "corda", amount = 1}, 
                    {item = "madeirarefinada", amount = 3}, 
                },
                output = {
                    {item = "fishingrod", amount = 1, name = "Vara de Pesca"},
                }
            },]]
            -------------------------------------------- FACA DE CAÇADOR ------------------------------------------
            {
                descriptionTextOverride = 'Materiais: Madeira refinada e algo afiado.',
                time = 20,
                input = {
                    {item = "madeirarefinada", amount = 1}, 
                    {item = "melee_knife_jawbone", amount = 1}, 
                },
                output = {
                    {item = "melee_knife", amount = 1, name = "Faca de Caça"},
                }
            },
            -------------------------------------------- MACHADINHA ------------------------------------------
            {
                descriptionTextOverride = 'Materiais: Madeira refinada, fibras vegetais ou tiras de couro, e algo afiado.',
                time = 30,
                input = {
                    {item = "madeirarefinada", amount = 2}, 
                    {item = "fibra", amount = 5, alias = {"tirascouro"}}, 
                    {item = "melee_knife_jawbone", amount = 2}, 
                },
                output = {
                    --{item = "thrown_tomahawk", amount = 1, name = "Machadinha"},
                    {item = "melee_hatchet", amount = 1, name = "Machadinha"},
                }
            },
            -------------------------------------------- ARCO SIMPLES ------------------------------------------
            {
                descriptionTextOverride = 'Materiais: Fibras vegetais e uma estrutura simples.',
                time = 30,
                input = {
                    {item = "fibra", amount = 10}, 
                    {item = "estruturasimples", amount = 1}, 
                },
                output = {
                    {item = "bow", amount = 1, name = "Arco Simples"},
                }
            },
            -------------------------------------------- ARCO CURVADO ------------------------------------------
            {
                descriptionTextOverride = 'Materiais: Corda, tiras de couro, e uma estrutura curvada.',
                time = 30,
                input = {
                    {item = "corda", amount = 1},
                    {item = "tirascouro", amount = 2},
                    {item = "estruturacurvada", amount = 1},
                },
                output = {
                    {item = "bow_improved", amount = 1, name = "Arco Curvado"},
                }
            },
            -------------------------------------------- ESTRUTURA DE ARCO ------------------------------------------
            {
                descriptionTextOverride = 'Materiais: Madeira boa e algo afiado.',
                time = 30,
                input = {
                    {item = "madeiraboa", amount = 3}, 
                    --{item = "melee_knife_jawbone", amount = 1, alias = {"thrown_tomahawk"}, remove = false},
                    {item = "melee_knife_jawbone", amount = 1, alias = {"melee_hatchet"}, remove = false},
                },
                output = {
                    {item = "estruturasimples", amount = 1, name = "Estrutura de Arco"},
                }
            },
            -------------------------------------------- ESTRUTURA DE ARCO CURVADA ------------------------------------------
            {
                descriptionTextOverride = 'Materiais: Madeira refinada e algo afiado.',
                time = 30,
                input = {
                    {item = "madeirarefinada", amount = 4}, 
                    --{item = "melee_knife_jawbone", amount = 1, alias = {"thrown_tomahawk"}, remove = false},
                    {item = "melee_knife_jawbone", amount = 1, alias = {"melee_hatchet"}, remove = false},
                },
                output = {
                    {item = "estruturacurvada", amount = 1, name = "Estrutura de Arco Curvada"},
                }
            },
            -------------------------------------------- LASSO ------------------------------------------
            {
                descriptionTextOverride = 'Materiais: Algumas cordas.',
                time = 30,
                input = { 
                    {item = "corda", amount = 3,}
                },
                output = {
                    {item = "lasso", amount = 1, name = "Laço"},
                }
            },
            -------------------------------------------- CORDA ------------------------------------------
            {
                descriptionTextOverride = 'Materiais: Fibras e algo afiado.',
                time = 20,
                input = {
                    {item = "fibra", amount = 10}, 
                    {item = "melee_knife_jawbone", amount = 1, remove = false}
                },
                output = {
                    {item = "corda", amount = 1, name = "Corda"},
                }
            },
            -------------------------------------------- LINHA ------------------------------------------
            {
                descriptionTextOverride = 'Materiais: Alguns algodões.',
                time = 15,
                input = {
                    {item = "algodao", amount = 10, alias = {"fibra"}},
                },
                output = {
                    {item = "linha", amount = 5, name = "Rolo de Linha"}
                }
            },
            -------------------------------------------- PONTA DE FLECHA ------------------------------------------
            {
                descriptionTextOverride = 'Materiais: Algumas pedras.',
                time = 20,
                input = {
                    {item = "pedra", amount = 10}, 
                },
                output = {
                    {item = "pontadeflecha", amount = 40, name = "Ponta de Flecha"},
                }
            },
            -------------------------------------------- PEDRA AFIADA ------------------------------------------
            {
                descriptionTextOverride = 'Materiais: Duas pedras quando se batem ficam...',
                time = 15,
                input = {
                    {item = "pedra", amount = 2},                     
                },
                output = {
                    {item = "melee_knife_jawbone", amount = 1, name = "Pedra Afiada"},
                }
            },
            -------------------------------------------- FLECHA NORMAL ------------------------------------------
            {
                descriptionTextOverride = 'Materiais: Algumas fibras ou tiras de couro, madeira refinada, penas e pontas de flecha.',
                time = 10,
                input = {
                    {item = "fibra", amount = 10, alias = {"tirascouro"}}, 
                    {item = "madeirarefinada", amount = 4},
                    {item = "pena", amount = 10},
                    {item = "pontadeflecha", amount = 20}, 
                },
                output = {
                    {item = "ammo_arrow", amount = 40, name = "Flecha Normal"},
                }
            },
            
            -------------------------------------------- FLECHA APRIMORADA ------------------------------------------
            --[[{
                time = 20,
                input = {
                    {item = "fibra", amount = 10, alias = {"tirascouro"}}, 
                    {item = "madeirarefinada", amount = 4},
                    {item = "penarapina", amount = 5},
                    {item = "melee_knife_jawbone", amount = 5}, 
                },
                output = {
                    {item = "ammo_arrow_improved", amount = 10, name = "Flecha Melhorada"},
                }
            },]]
            -------------------------------------------- FLECHA PEQUENA ------------------------------------------
            {
                descriptionTextOverride = 'Materiais: Madeira refinada.',
                time = 10,
                input = {
                    {item = "madeirarefinada", amount = 4},
                },
                output = {
                    {item = "ammo_arrow_small_game", amount = 40, name = "Flecha Pequena"},
                }
            },
            -------------------------------------------- FLECHA ENVENENADA ------------------------------------------
            {
                descriptionTextOverride = 'Materiais: Flechas e ervas de veneno.',
                time = 20,
                input = {
                    {item = "ammo_arrow", amount = 2}, 
                    {item = "ervadeveneno", amount = 2},                    
                },
                output = {
                    {item = "ammo_arrow_poison", amount = 5, name = "Flecha Envenenada"},
                }
            },
            -------------------------------------------- FLECHA INCENDIÁRIA ------------------------------------------
            {
                descriptionTextOverride = 'Materiais: Flechas e gorduras.',
                time = 20,
                input = {
                    {item = "ammo_arrow", amount = 1}, 
                    {item = "gordura", amount = 1},  
                },
                output = {
                    {item = "ammo_arrow_fire", amount = 5, name = "Flecha Incendiária"},
                }
            },
        }
    },

    ---------------------------------------------------------------------------------------------------
    ---------------------------------------- FERREIRO | FUNDIÇÃO --------------------------------------
    ---------------------------------------------------------------------------------------------------
    

    {    
        group = "ferreiro",
        position = vec3(-369.409,796.127,116.192),  -- No position, its global
        --Ferreiro = true,
        useTextDescriptionAll = true,
        craftings = 
        {
            {
                                -- CARVÃO
                descriptionTextOverride = 'Materiais: Madeira de boa ou má qualidade.',
                time = 10,
                input = {
                    {item = "madeiraboa", amount = 1, alias = {"madeiraruim"}},
                },
                output = {
                    {item = "carvao", amount = 1, name = "Carvão"},
                }
            },
            {
                                -- BARRA DE FERRO
                descriptionTextOverride = 'Materiais: Minério de ferro, carvão e ferramentas.',
                time = 30,
                input = {
                    {item = "minerioferro", amount = 3},
                    {item = "carvao", amount = 2},
                    {item = "ferramentas", amount = 1, remove = false}
                },
                output = {
                    {item = "barraferro", amount = 1, name = "Barra de Ferro"},
                }
            },
            {
                                -- BARRA DE COBRE
                descriptionTextOverride = 'Materiais: Minério de cobre, carvão e ferramentas.',
                time = 30,
                input = {
                    {item = "mineriocobre", amount = 3},
                    {item = "carvao", amount = 2},
                    {item = "ferramentas", amount = 1, remove = false}
                },
                output = {
                    {item = "barracobre", amount = 1, name = "Barra de Cobre"},
                }
            },
            {
                                -- PEPITA DE OURO
                descriptionTextOverride = 'Materiais: Minério de ouro, carvão e ferramentas.',
                time = 40,
                input = {
                    {item = "minerioouro", amount = 1},
                    {item = "carvao", amount = 5},
                    {item = "ferramentas", amount = 1, remove = false}
                },
                output = {
                    {item = "pepitadeouro", amount = 4, name = "Pepita de ouro"}
                }
            },
            {
                                -- BARRA DE OURO
                descriptionTextOverride = 'Materiais: Pepita de ouro, carvão e ferramentas.',
                time = 40,
                input = {
                    {item = "pepitadeouro", amount = 25},
                    {item = "carvao", amount = 10},
                    {item = "ferramentas", amount = 1, remove = false}
                },
                output = {
                    {item = "barraouro", amount = 1, name = "Barra de Ouro"}
                }
            },
        }
    },
    ---------------------------------------------------------------------------------------------------
    ---------------------------------------- FERREIRO | BIGORNA ---------------------------------------
    ---------------------------------------------------------------------------------------------------
    {
        group = "ferreiro",
        --position = vec3(-369.484,796.221,116.196),  -- No position, its global
        Ferreiro2 = true,
        useTextDescriptionAll = true,
        craftings = 
        {
            {
                                -- FERRAMENTAS
                descriptionTextOverride = 'Materiais: Barra de ferro, madeira refinada e ferramentas.',
                time = 20,
                input = {
                    {item = "barraferro", amount = 1},
                    {item = "madeirarefinada", amount = 1},
                    {item = "ferramentas", amount = 1, remove = false}
                },
                output = {
                    {item = "ferramentas", amount = 1, name = "Caixa de Ferramentas"},
                }
            },
            {
                                -- LAMPIÃO
                descriptionTextOverride = 'Materiais: Barra de cobre, gordura, tecido e ferramentas.',
                time = 20,
                input = {
                    {item = "barracobre", amount = 1},
                    {item = "gordura", amount = 1},
                    {item = "tecidobranco", amount = 1},
                    {item = "ferramentas", amount = 1, remove = false}
                },
                output = {
                    {item = "melee_davy_lantern", amount = 1, name = "Lampião"},
                }
            },
            {
                                -- LATA
                descriptionTextOverride = 'Materiais: Barra de cobre e ferramentas.',
                time = 20,
                input = {
                    {item = "barracobre", amount = 1},
                    {item = "ferramentas", amount = 1, remove = false}
                },
                output = {
                    {item = "lata", amount = 10, name = "Latas"},
                }
            },
            {
                                -- BALDE
                descriptionTextOverride = 'Materiais: Barra de ferro e ferramentas.',
                time = 20,
                input = {
                    {item = "barraferro", amount = 2},
                    {item = "ferramentas", amount = 1, remove = false}
                },
                output = {
                    {item = "wateringcan", amount = 1, name = "Balde"},
                }
            },
            {
                                -- GARIMPO
                descriptionTextOverride = 'Materiais: Barra de ferro e ferramentas.',
                time = 20,
                input = {
                    {item = "barraferro", amount = 2},
                    {item = "ferramentas", amount = 1, remove = false}
                },
                output = {
                    {item = "garimpo", amount = 1, name = "Bateia de garimpo"},
                }
            },
            {
                                -- CABEÇA DE PICARETA
                descriptionTextOverride = 'Materiais: Barra de ferro e ferramentas.',
                time = 25,
                input = {
                    {item = "barraferro", amount = 1},
                    {item = "ferramentas", amount = 1, remove = false}
                },
                output = {
                    {item = "cabecapicareta", amount = 1, name = "Cabeça de Picareta"},
                }
            },
            {
                                -- CABEÇA DE MACHADO
                descriptionTextOverride = 'Materiais: Barra de ferro e ferramentas.',
                time = 25,
                input = {
                    {item = "barraferro", amount = 1},
                    {item = "ferramentas", amount = 1, remove = false}
                },
                output = {
                    {item = "cabecamachado", amount = 1, name = "Cabeça de Machado"},
                }
            },
            {
                                -- CABEÇA DE PÁ
                descriptionTextOverride = 'Materiais: Barra de ferro e ferramentas.',
                time = 25,
                input = {
                    {item = "barraferro", amount = 1},
                    {item = "ferramentas", amount = 1, remove = false}
                },
                output = {
                    {item = "cabecapa", amount = 1, name = "Cabeça de Pá"}
                }
            },
            --[[{
                                -- CABEÇA DE ENXADA
                time = 25,
                input = {
                    {item = "barraferro", amount = 1},
                    {item = "ferramentas", amount = 1, remove = false}
                },
                output = {
                    {item = "cabecaenxada", amount = 1, name = "Cabeça de Enxada"}
                }
            },]]
            {
                                -- LÂMINA
                descriptionTextOverride = 'Materiais: Barra de ferro e ferramentas.',
                time = 25,
                input = {
                    {item = "barraferro", amount = 1},
                    {item = "ferramentas", amount = 1, remove = false}
                },
                output = {
                    {item = "lamina", amount = 1, name = "Lâmina"},
                }
            },
            {
                                -- CANO DE ARMA
                descriptionTextOverride = 'Materiais: Barra de ferro e ferramentas.',
                time = 25,
                input = {
                    {item = "barraferro", amount = 1},
                    {item = "ferramentas", amount = 1, remove = false}
                },
                output = {
                    {item = "canodearma", amount = 2, name = "Cano de Arma"},
                }
            },
            {
                                -- CÃO DE ARMA
                descriptionTextOverride = 'Materiais: Barra de ferro e ferramentas.',
                time = 25,
                input = {
                    {item = "barraferro", amount = 1},
                    {item = "ferramentas", amount = 1, remove = false}
                },
                output = {
                    {item = "caodearma", amount = 4, name = "Cães de Arma"},
                }
            },
            {
                                -- GATILHO DE ARMA
                descriptionTextOverride = 'Materiais: Barra de ferro e ferramentas.',
                time = 25,
                input = {
                    {item = "barraferro", amount = 1},
                    {item = "ferramentas", amount = 1, remove = false}
                },
                output = {
                    {item = "gatilhodearma", amount = 4, name = "Gatilhos de Arma"},
                }
            },
            {
                                -- PREGOS
                descriptionTextOverride = 'Materiais: Barra de ferro e ferramentas.',
                time = 10,
                input = {
                    {item = "barraferro", amount = 1},
                    {item = "ferramentas", amount = 1, remove = false}
                },
                output = {
                    {item = "prego", amount = 20, name = "Pregos"},
                }
            },
            {
                                -- PARAFUSOS
                descriptionTextOverride = 'Materiais: Barra de ferro e ferramentas.',
                time = 10,
                input = {
                    {item = "barraferro", amount = 1},
                    {item = "ferramentas", amount = 1, remove = false}
                },
                output = {
                    {item = "parafuso", amount = 10, name = "Parafusos"},
                }
            },
        }
    },

    ---------------------------------------------------------------------------------------------------------------
    ------------------------------------------------FERREIRO | CRIAÇÃO---------------------------------------------
    ---------------------------------------------------------------------------------------------------------------

    {    
        group = "ferreiro",
        --position = vec3(-277.220,779.328,119.504),  -- No position, its global
        Ferreiro3 = true,
        useTextDescriptionAll = true,
        craftings = 
        {
            {
                                -- PICARETA
                descriptionTextOverride = 'Materiais: Uma cabeça de picareta, madeira refinada, pregos e ferramentas.',
                time = 20,
                input = {
                    {item = "cabecapicareta", amount = 1},
                    {item = "madeirarefinada", amount = 1},
                    {item = "prego", amount = 4},
                    {item = "ferramentas", amount = 1, remove = false}
                },
                output = {
                    {item = "picareta", amount = 1, name = "Picareta"},
                }
            },
            {
                                -- MACHADO
                descriptionTextOverride = 'Materiais: Uma cabeça de machado, madeira refinada, pregos e ferramentas.',
                time = 20,
                input = {
                    {item = "cabecamachado", amount = 1},
                    {item = "madeirarefinada", amount = 1},
                    {item = "prego", amount = 3},
                    {item = "ferramentas", amount = 1, remove = false}
                },
                output = {
                    {item = "melee_hatchet", amount = 1, name = "Machado"},
                }
            },
            {
                                -- PÁ
                descriptionTextOverride = 'Materiais: Uma cabeça de pá, madeira refinada, pregos e ferramentas.',
                time = 20,
                input = {
                    {item = "cabecapa", amount = 1},
                    {item = "madeirarefinada", amount = 1},
                    {item = "prego", amount = 2},
                    {item = "ferramentas", amount = 1, remove = false}
                },
                output = {
                    {item = "pa", amount = 1, name = "Pá"}
                }
            },
            --[[{
                                -- ENXADA
                time = 20,
                input = {
                    {item = "cabecaenxada", amount = 1},
                    {item = "madeirarefinada", amount = 1},
                    {item = "prego", amount = 2},
                    {item = "ferramentas", amount = 1, remove = false}
                },
                output = {
                    {item = "enxada", amount = 1, name = "Enxada"}
                }
            },]]
            {
                                -- FACÃO
                descriptionTextOverride = 'Materiais: Uma lâmina, madeira refinada, pregos e ferramentas.',
                time = 20,
                input = {
                    {item = "lamina", amount = 1},
                    {item = "madeirarefinada", amount = 1},
                    {item = "prego", amount = 3},
                    {item = "ferramentas", amount = 1, remove = false}
                },
                output = {
                    {item = "melee_machete", amount = 1, name = "Facão"},
                }
            },
            {
                                -- FACA
                descriptionTextOverride = 'Materiais: Uma lâmina, madeira refinada, pregos e ferramentas.',                                
                time = 20,
                input = {
                    {item = "lamina", amount = 1},
                    {item = "madeirarefinada", amount = 1},
                    {item = "prego", amount = 3},
                    {item = "ferramentas", amount = 1, remove = false}
                },
                output = {
                    {item = "melee_knife", amount = 1, name = "Faca de Caça"},
                }
            },
            {
                                -- GAZUA
                descriptionTextOverride = 'Materiais: Parafusos, ferramentas e uma barra de cobre.',
                time = 20,
                input = {
                    {item = "parafuso", amount = 10},
                    {item = "barracobre", amount = 1},
                    {item = "ferramentas", amount = 1, remove = false}
                },
                output = {
                    {item = "lockpick", amount = 5, name = "Gazua"},
                }
            },
        }
    },

    ----------------------------------------------------------------------------------------------------------------------------------------------------
    -----------------------------------------------------------------ARMEIRO | CRIAÇÃO------------------------------------------------------------------
    ----------------------------------------------------------------------------------------------------------------------------------------------------


    {
        group = "armeiro",
        position = vec3(-277.121,779.223,119.504),  -- No position, its global
        --Armeiro = true,
        useTextDescriptionAll = true,
        craftings = 
        {
            {
                                -- REVOLVER DE AÇÃO-DUPLA
                descriptionTextOverride = 'Materiais: Peças de Armas, ferramentas, parafusos e o corpo de um Revólver de Ação-Dupla',
                time = 25,
                input = {
                    {item = "canodearma", amount = 1},
                    {item = "caodearma", amount = 1},
                    {item = "gatilhodearma", amount = 1},
                    {item = "corpodeacaodupla", amount = 1},
                    {item = "parafuso", amount = 5},
                    {item = "ferramentas", amount = 1, remove = false}
                },
                output = {
                    {item = "revolver_doubleaction", amount = 1, name = "Revólver de Ação-Dupla"},
                }
            },
            {
                                -- REVOLVER DE VAQUEIRO
                descriptionTextOverride = 'Materiais: Peças de Armas, ferramentas, parafusos e o corpo de um Revólver de Vaqueiro',
                time = 25,
                input = {
                    {item = "canodearma", amount = 1},
                    {item = "caodearma", amount = 1},
                    {item = "gatilhodearma", amount = 1},
                    {item = "corpodevaqueiro", amount = 1},
                    {item = "parafuso", amount = 5},
                    {item = "ferramentas", amount = 1, remove = false}
                },
                output = {
                    {item = "revolver_cattleman", amount = 1, name = "Revólver de Vaqueiro"},
                }
            },
            {
                                -- REVOLVER SCHOTFIELD
                descriptionTextOverride = 'Materiais: Peças de Armas, ferramentas, parafusos e o corpo de um Revólver Schotfield',
                time = 25,
                input = {
                    {item = "canodearma", amount = 1},
                    {item = "caodearma", amount = 1},
                    {item = "gatilhodearma", amount = 1},
                    {item = "corpodeschotfield", amount = 1},
                    {item = "parafuso", amount = 5},
                    {item = "ferramentas", amount = 1, remove = false}
                },
                output = {
                    {item = "revolver_schofield", amount = 1, name = "Revólver Schotfield"},
                }
            },
            {
                                -- REVOLVER LEMAT
                descriptionTextOverride = 'Materiais: Peças de Armas, ferramentas, parafusos e o corpo de um Revólver Lemat',
                time = 25,
                input = {
                    {item = "canodearma", amount = 1},
                    {item = "caodearma", amount = 1},
                    {item = "gatilhodearma", amount = 1},
                    {item = "corpodelemat", amount = 1},
                    {item = "parafuso", amount = 5},
                    {item = "ferramentas", amount = 1, remove = false}
                },
                output = {
                    {item = "revolver_lemat", amount = 1, name = "Revólver Lemat"},
                }
            },
            {
                                -- REVOLVER DA MARINHA
                descriptionTextOverride = 'Materiais: Peças de Armas, ferramentas, parafusos e o corpo de um Revólver da Marinha',
                time = 25,
                input = {
                    {item = "canodearma", amount = 1},
                    {item = "caodearma", amount = 1},
                    {item = "gatilhodearma", amount = 1},
                    {item = "corpodenavy", amount = 1},
                    {item = "parafuso", amount = 5},
                    {item = "ferramentas", amount = 1, remove = false}
                },
                output = {
                    {item = "revolver_navy", amount = 1, name = "Revólver da Marinha"},
                }
            },
            {
                                -- PISTOLA VOLCANIC
                descriptionTextOverride = 'Materiais: Peças de Armas, ferramentas, parafusos e o corpo de uma Pistola Volcanic',
                time = 30,
                input = {
                    {item = "canodearma", amount = 1},
                    {item = "caodearma", amount = 1},
                    {item = "gatilhodearma", amount = 1},
                    {item = "corpodevolcanic", amount = 1},
                    {item = "parafuso", amount = 6},
                    {item = "ferramentas", amount = 1, remove = false}
                },
                output = {
                    {item = "pistol_volcanic", amount = 1, name = "Pistola Volcanic"},
                }
            },
            {
                                -- PISTOLA MAUSER
                descriptionTextOverride = 'Materiais: Peças de Armas, ferramentas, parafusos e o corpo de uma Pistola Mauser',
                time = 30,
                input = {
                    {item = "canodearma", amount = 1},
                    {item = "caodearma", amount = 1},
                    {item = "gatilhodearma", amount = 1},
                    {item = "corpodemauser", amount = 1},
                    {item = "parafuso", amount = 6},
                    {item = "ferramentas", amount = 1, remove = false}
                },
                output = {
                    {item = "pistol_mauser", amount = 1, name = "Pistola Mauser"},
                }
            },
            {
                                -- PISTOLA SEMI-AUTO
                descriptionTextOverride = 'Materiais: Peças de Armas, ferramentas, parafusos e o corpo de uma Pistola Semi-Automatica',
                time = 30,
                input = {
                    {item = "canodearma", amount = 1},
                    {item = "caodearma", amount = 1},
                    {item = "gatilhodearma", amount = 1},
                    {item = "corpodesemiauto", amount = 1},
                    {item = "parafuso", amount = 6},
                    {item = "ferramentas", amount = 1, remove = false}
                },
                output = {
                    {item = "pistol_semiauto", amount = 1, name = "Pistola Semi-Auto"},
                }
            },
            {
                                -- CARABINA DE REPETIÇÃO
                descriptionTextOverride = 'Materiais: Peças de Armas, ferramentas, parafusos e o corpo de uma Carabina de Repetição',
                time = 40,
                input = {
                    {item = "canodearma", amount = 1},
                    {item = "caodearma", amount = 1},
                    {item = "gatilhodearma", amount = 1},
                    {item = "corpodecarabina", amount = 1},
                    {item = "parafuso", amount = 8},
                    {item = "ferramentas", amount = 1, remove = false}
                },
                output = {
                    {item = "repeater_carbine", amount = 1, name = "Carabina de Repetição"}
                }
            },
            {
                                -- CARABINA LANCASTER
                descriptionTextOverride = 'Materiais: Peças de Armas, ferramentas, parafusos e o corpo de uma Lancaster de Repetição',
                time = 40,
                input = {
                    {item = "canodearma", amount = 1},
                    {item = "caodearma", amount = 1},
                    {item = "gatilhodearma", amount = 1},
                    {item = "corpodelancaster", amount = 1},
                    {item = "parafuso", amount = 8},
                    {item = "ferramentas", amount = 1, remove = false}
                },
                output = {
                    {item = "repeater_winchester", amount = 1, name = "Lancaster de Repetição"}
                }
            },
            {
                                -- CARABINA HENRY
                descriptionTextOverride = 'Materiais: Peças de Armas, ferramentas, parafusos e o corpo de uma Henry de Repetição',
                time = 40,
                input = {
                    {item = "canodearma", amount = 1},
                    {item = "caodearma", amount = 1},
                    {item = "gatilhodearma", amount = 1},
                    {item = "corpodehenry", amount = 1},
                    {item = "parafuso", amount = 8},
                    {item = "ferramentas", amount = 1, remove = false}
                },
                output = {
                    {item = "repeater_henry", amount = 1, name = "Henry de Repetição"}
                }
            },
            {
                                -- CARABINA VARMINT
                descriptionTextOverride = 'Materiais: Peças de Armas, ferramentas, parafusos e o corpo de um Rifle Anti-Pragas',
                time = 40,
                input = {
                    {item = "canodearma", amount = 1},
                    {item = "caodearma", amount = 1},
                    {item = "gatilhodearma", amount = 1},
                    {item = "corpodepragas", amount = 1},
                    {item = "parafuso", amount = 8},
                    {item = "ferramentas", amount = 1, remove = false}
                },
                output = {
                    {item = "rifle_varmint", amount = 1, name = "Rifle Anti-Pragas"}
                }
            },
            {
                                -- CARABINA EVANS
                descriptionTextOverride = 'Materiais: Peças de Armas, ferramentas, parafusos e o corpo de uma Evans de Repetição',
                time = 40,
                input = {
                    {item = "canodearma", amount = 1},
                    {item = "caodearma", amount = 1},
                    {item = "gatilhodearma", amount = 1},
                    {item = "corpodeevans", amount = 1},
                    {item = "parafuso", amount = 8},
                    {item = "ferramentas", amount = 1, remove = false}
                },
                output = {
                    {item = "repeater_evans", amount = 1, name = "Evans de Repetição"}
                }
            },
            {
                                -- RIFLE SPRINGFIELD
                descriptionTextOverride = 'Materiais: Peças de Armas, ferramentas, parafusos e o corpo de um Rifle Springfield',
                time = 50,
                input = {
                    {item = "canodearma", amount = 1},
                    {item = "caodearma", amount = 1},
                    {item = "gatilhodearma", amount = 1},
                    {item = "corpodespringfield", amount = 1},
                    {item = "parafuso", amount = 10},
                    {item = "ferramentas", amount = 1, remove = false}
                },
                output = {
                    {item = "rifle_springfield", amount = 1, name = "Rifle Springfield"}
                }
            },
            {
                                -- RIFLE DE FERROLHO
                descriptionTextOverride = 'Materiais: Peças de Armas, ferramentas, parafusos e o corpo de um Rifle de Ferrolho',
                time = 50,
                input = {
                    {item = "canodearma", amount = 1},
                    {item = "caodearma", amount = 1},
                    {item = "corpodeferrolho", amount = 1},
                    {item = "parafuso", amount = 10},
                    {item = "ferramentas", amount = 1, remove = false}
                },
                output = {
                    {item = "rifle_boltaction", amount = 1, name = "Rifle de Ferrolho"}
                }
            },
            {
                                -- RIFLE ROLLING BLOCK
                descriptionTextOverride = 'Materiais: Peças de Armas, ferramentas, parafusos e o corpo de um Rifle Rolling Block',
                time = 60,
                input = {
                    {item = "canodearma", amount = 1},
                    {item = "caodearma", amount = 1},
                    {item = "gatilhodearma", amount = 1},
                    {item = "corpoderolling", amount = 1},
                    {item = "parafuso", amount = 10},
                    {item = "ferramentas", amount = 1, remove = false}
                },
                output = {
                    {item = "sniperrifle_rollingblock", amount = 1, name = "Rifle Rolling Block"}
                }
            },
            {
                                -- ESCOPETA SERRADA
                descriptionTextOverride = 'Materiais: Peças de Armas, ferramentas, parafusos e o corpo de uma Escopeta de Cano-Serrado',
                time = 60,
                input = {
                    {item = "canodearma", amount = 2},
                    {item = "caodearma", amount = 2},
                    {item = "gatilhodearma", amount = 2},
                    {item = "corpodeserrada", amount = 1},
                    {item = "parafuso", amount = 8},
                    {item = "ferramentas", amount = 1, remove = false}
                },
                output = {
                    {item = "shotgun_sawedoff", amount = 1, name = "Escopeta de Cano-Serrado"},
                }
            },
            {
                                -- ESCOPETA CANO-DUPLO
                descriptionTextOverride = 'Materiais: Peças de Armas, ferramentas, parafusos e o corpo de uma Escopeta de Cano-Duplo',
                time = 60,
                input = {
                    {item = "canodearma", amount = 2},
                    {item = "caodearma", amount = 2},
                    {item = "gatilhodearma", amount = 2},
                    {item = "corpodeescopeta", amount = 1},
                    {item = "parafuso", amount = 8},
                    {item = "ferramentas", amount = 1, remove = false}
                },
                output = {
                    {item = "shotgun_doublebarrel", amount = 1, name = "Escopeta de Cano-Duplo"},
                }
            },
            --{
                                -- ESCOPETA DE ELEFANTE
            --    descriptionTextOverride = 'Materiais: Peças de Armas, ferramentas, parafusos e o corpo de uma Escopeta de Elefante',
            --    time = 60,
            --    input = {
            --        {item = "canodearma", amount = 2},
            --        {item = "caodearma", amount = 2},
            --        {item = "gatilhodearma", amount = 2},
            --        {item = "corpodeescopeta", amount = 2},
            --        {item = "parafuso", amount = 8},
            --        {item = "ferramentas", amount = 1, remove = false}
            --    },
            --    output = {
            --        {item = "barradeferro", amount = 1, name = "Escopeta de Elefante"},
            --    }
            --},
            {
                                -- MUNIÇÕES REVOLVER
                descriptionTextOverride = 'Materiais: Um saquinho de pólvora e uma caixa de cartuchos',
                time = 5,
                input = {
                    {item = "caixacartuchos", amount = 1},
                    {item = "sacopolvora", amount = 1},
                },
                output = {
                    {item = "ammo_revolver", amount = 10, name = "Munição de Revolver"},
                }
            },
            {
                                -- MUNIÇÕES PISTOLA
                descriptionTextOverride = 'Materiais: Um saquinho de pólvora e uma caixa de cartuchos',
                time = 5,
                input = {
                    {item = "caixacartuchos", amount = 1},
                    {item = "sacopolvora", amount = 1},
                },
                output = {
                    {item = "ammo_pistol", amount = 10, name = "Munição de Pistola"},
                }
            },
            {
                                -- MUNIÇÕES ANTI-PRAGAS
                descriptionTextOverride = 'Materiais: Um saquinho de pólvora e uma caixa de cartuchos',
                time = 5,
                input = {
                    {item = "caixacartuchos", amount = 1},
                    {item = "sacopolvora", amount = 1},
                },
                output = {
                    {item = "ammo_22", amount = 10, name = "Munição Anti-Pragas"},
                }
            },
            {
                                -- MUNIÇÕES CARABINA
                descriptionTextOverride = 'Materiais: Dois saquinhos de pólvora e uma caixa de cartuchos',
                time = 5,
                input = {
                    {item = "caixacartuchos", amount = 1},
                    {item = "sacopolvora", amount = 2},
                },
                output = {
                    {item = "ammo_repeater", amount = 10, name = "Munição de Carabina"},
                }
            },
            {
                                -- MUNIÇÕES RIFLE
                descriptionTextOverride = 'Materiais: Três saquinhos de pólvora e uma caixa de cartuchos',
                time = 5,
                input = {
                    {item = "caixacartuchos", amount = 1},
                    {item = "sacopolvora", amount = 3},
                },
                output = {
                    {item = "ammo_rifle", amount = 10, name = "Munição de Rifle"},
                }
            },
            {
                                -- MUNIÇÕES ESCOPETA
                descriptionTextOverride = 'Materiais: Quatro saquinhos de pólvora e uma caixa de cartuchos',
                time = 5,
                input = {
                    {item = "caixacartuchos", amount = 1},
                    {item = "sacopolvora", amount = 4},
                },
                output = {
                    {item = "ammo_shotgun", amount = 10, name = "Munição de Escopeta"},
                }
            },
        }
    },


    ------------------------------------------------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------- EXPLOSIVOS -----------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------------------------------------------------

    {
        position = vec3(-1416.017,1131.219,225.540), -- No position, its global
        useTextDescriptionAll = true,

        craftings = 
        {
            {
                descriptionTextOverride = 'Uma banana, pólvora e algo para servir de pávio.',
                time = 20,
                input = {
                    {item = "bananadinamite", amount = 1},
                    {item = "sacopolvora", amount = 1},
                    {item = "linha", amount = 1}
                },
                output = {
                    {item = "thrown_dynamite", amount = 1, name = "Banana de dinamite"}
                }
            },
            {
                descriptionTextOverride = 'Um uísque, gordura e tecido.',
                time = 20,
                input = {
                    {item = "whisky", amount = 1},
                    {item = "gordura", amount = 1},
                    {item = "tecidobranco", amount = 1}
                },
                output = {
                    {item = "thrown_molotov", amount = 1, name = "Garrafa Incendiária"}
                }
            },
            
        }
    },

    ----------------------------------------------------------------------------------------------------------------------------------------------------
    ----------------------------------------------------------------- PADARIA | MESA -------------------------------------------------------------------
    ----------------------------------------------------------------------------------------------------------------------------------------------------

    {
        -- position = vec3(0, 0, 0) -- No position, its global
        group = "padeiro",
        Padaria = true,

        useTextDescriptionAll = true,

        craftings = 
        {
            {
                descriptionTextOverride = 'Receita de Pão: 500g de Farinha, 500g de Açúcar e um pouco de gordura.',
                time = 20,
                input = {
                    {item = "farinha", amount = 1},
                    {item = "acucar", amount = 1},
                    {item = "gordura", amount = 1}
                },
                output = {
                    {item = "massadepao", amount = 1, name = "Massa de Pão"}
                }
            },
            {
                descriptionTextOverride = 'Receita de Pão: 500g de Farinha, 500g de Açúcar.',
                time = 20,
                input = {
                    {item = "farinha", amount = 1},
                    {item = "acucar", amount = 1}
                },
                output = {
                    {item = "massadebiscoito", amount = 1, name = "Massa de Biscoito"}
                }
            },
            {
                descriptionTextOverride = 'Receita de Pão: 500g de Farinha, 500g de Açúcar.',
                time = 20,
                input = {
                    {item = "farinha", amount = 1},
                    {item = "acucar", amount = 1}
                },
                output = {
                    {item = "massadebolacha", amount = 1, name = "Massa de Bolacha"}
                }
            },
        }
    },


    ----------------------------------------------------------------------------------------------------------------------------------------------------
    ---------------------------------------------------------------PADARIA | FORNO----------------------------------------------------------------------
    ----------------------------------------------------------------------------------------------------------------------------------------------------


    {
        -- position = vec3(0, 0, 0) -- No position, its global
        group = "padeiro",
        Padaria2 = true,

        useTextDescriptionAll = true,

        craftings = 
        {
            {
                                -- CARVÃO
                descriptionTextOverride = 'Materiais: Madeira de boa ou má qualidade.',
                time = 10,
                input = {
                    {item = "madeiraboa", amount = 1, alias = {"madeiraruim"}},
                },
                output = {
                    {item = "carvao", amount = 1, name = "Carvão"},
                }
            },
            {
                descriptionTextOverride = 'Agora é só acender o fogo com carvão e assar a massa das bolachas.',
                time = 30,
                input = {
                    {item = "carvao", amount = 1},
                    {item = "massadebolacha", amount = 1}
                },
                output = {
                    {item = "bolacha", amount = 6, name = "Bolacha"}
                }
            },
            {
                descriptionTextOverride = 'Agora é só acender o fogo com carvão e assar a massa dos biscoitos.',
                time = 30,
                input = {
                    {item = "carvao", amount = 1},
                    {item = "massadebiscoito", amount = 1}
                },
                output = {
                    {item = "biscoito", amount = 6, name = "Biscoito"}
                }
            },
            {
                descriptionTextOverride = 'Agora é só acender o fogo com carvão e assar a massa dos pães.',
                time = 30,
                input = {
                    {item = "carvao", amount = 1},
                    {item = "massadepao", amount = 1},
                },
                output = {
                    {item = "pao", amount = 6, name = "Pão"}
                }
            },
        }
    },


    ---------------------------------------------------------------------------------------------------
    --------------------------------------- FAZENDEIRO | LATA -----------------------------------------
    ---------------------------------------------------------------------------------------------------

    {
        position = vec3(1357.599,-1248.308,79.951), -- No position, its global
        useTextDescriptionAll = true,
        craftings = 
        {
            {
                descriptionTextOverride = 'Alguns tomates e uma lata.',
                time = 15,
                input = {
                    {item = "lata", amount = 1},
                    {item = "tomate", amount = 3},
                    --{item = "melee_knife", amount = 1, remove = false}
                },
                output = {
                    {item = "molhotomate", amount = 1, name = "Molho de Tomate"}
                }
            },
            {
                descriptionTextOverride = 'Alguns grãos de milho e uma lata.',
                time = 15,
                input = {
                    {item = "milho", amount = 3},
                    {item = "lata", amount = 1},
                },
                output = {
                    {item = "milholata", amount = 1, name = "Milho Enlatado"}
                }
            },
            {
                descriptionTextOverride = 'Alguns punhados de feijão e uma lata.',
                time = 15,
                input = {
                    {item = "feijao", amount = 3},
                    {item = "lata", amount = 1},
                },
                output = {
                    {item = "feijaolata", amount = 1, name = "Feijão Enlatado"}
                }
            },
        }
    },
    ---------------------------------------------ADUBO---------------------------------
    {
        position = vec3(-873.196,318.333,96.283), -- No position, its global
        useTextDescriptionAll = true,
        craftings = 
        {
            {
                descriptionTextOverride = 'Fazer a decomposição de ossos usando uma pá e alguns ossos pode ser muito útil.',
                time = 15,
                input = {
                    {item = "pa", amount = 1, remove = false},
                    {item = "osso", amount = 10},
                    {item = "terra", amount = 3},
                },
                output = {
                    {item = "adubo", amount = 5, name = "Adubo"}
                }
            },
            {
                descriptionTextOverride = 'Agora é só pegar umas 5 pazadas de pó de osso e colocar em um saco vázio.',
                time = 15,
                input = {
                    {item = "pa", amount = 1, remove = false},
                    {item = "Adubo", amount = 5},
                    {item = "saco", amount = 1},
                },
                output = {
                    {item = "sacodeadubo", amount = 1, name = "Saco de Adubo"}
                }
            }
        }
    },
-------------------------------------------------MOINHO--------------------------------------------
-- useTextDescriptionAll = true,
    -- descriptionTextOverride = 'Tradição de corno',
    {
        position = vec3(1053.885,-1123.756,67.891), -- No position, its global
        useTextDescriptionAll = true,
        craftings = 
        {
            {
                descriptionTextOverride = 'Pague 1c e entregue 4 maços de Trigo para receber um saco de farinha.',
                time = 15,
                input = {
                    {item = "money", amount = 1},
                    {item = "trigo", amount = 4},
                    --{item = "melee_knife", amount = 1, remove = false}
                },
                output = {
                    {item = "farinha", amount = 1, name = "Pacote de Farinha"}
                }
            },
            {
                descriptionTextOverride = 'Pague 1c e entregue 4 canas-de-açúcar para receber um saco de Açúcar.',
                time = 15,
                input = {
                    {item = "money", amount = 1},
                    {item = "canaacucar", amount = 4},
                },
                output = {
                    {item = "acucar", amount = 1, name = "Açúcar"}
                }
            },
            {
                descriptionTextOverride = 'Pague 10c e entregue 4 canas-de-açúcar para receber um pouco de álcool.',
                time = 15,
                input = {
                    {item = "money", amount = 10},
                    {item = "canaacucar", amount = 4},
                },
                output = {
                    {item = "alcool", amount = 1, name = "Álcool"}
                }
            },
        }
    },

-------------------------------------------------LENHADOR--------------------------------------------
    {
        position = vec3(-1821.705,-423.195,160.052), -- No position, its global
        useTextDescriptionAll = true,
        craftings = 
        {
            {
                descriptionTextOverride = 'Madeira boa, um bom machado ou um facão bem afiado.',
                time = 15,
                input = {
                    {item = "madeiraboa", amount = 1},
                    {item = "melee_hatchet", amount = 1, alias = {"melee_machete"}, remove = false},
                },
                output = {
                    {item = "madeirarefinada", amount = 1, name = "Madeira Refinada"}
                }
            },
            {
                descriptionTextOverride = 'Madeira Refinada e todas as ferramentas necessárias.',
                time = 15,
                input = {
                    {item = "madeirarefinada", amount = 2},
                    {item = "ferramentas", amount = 1, remove = false},
                },
                output = {
                    {item = "tabua", amount = 1, name = "Tábua"}
                }
            },
        }
    },

--------------------------------------ALFAIATE-------------------------------
    {
        position = vec3(1410.200,-1283.656,81.594), -- No position, its global
        useTextDescriptionAll = true,
        craftings = 
        {
            {
                descriptionTextOverride = 'Material: Algodão',
                time = 20,
                input = {
                    {item = "algodao", amount = 5},
                },
                output = {
                    {item = "linha", amount = 5, name = "Rolo de Linha"}
                }
            },
        }
    },

    {
        group = "alfaiate",
        position = vec3(-766.793,-1291.068,43.839), -- No position, its global
        useTextDescriptionAll = true,
        craftings = 
        {
            {
                descriptionTextOverride = 'Material: Fibras de Plantas',
                time = 20,
                input = {
                    {item = "fibra", amount = 10},
                    {item = "melee_knife", amount = 1, remove = false}
                },
                output = {
                    {item = "linha", amount = 5, name = "Rolo de Linha"}
                }
            },
            {
                descriptionTextOverride = 'Material: Algodão, Linha e Agulha',
                time = 20,
                input = {
                    {item = "algodao", amount = 5},
                    {item = "linha", amount = 3},
                    {item = "agulha", amount = 1, remove = false}
                },
                output = {
                    {item = "tecidobranco", amount = 5, name = "Tecido Branco"}
                }
            },
            {
                descriptionTextOverride = 'Material: Algodão, Linha e Agulha',
                time = 30,
                input = {
                    {item = "tecidobranco", amount = 5},
                    {item = "linha", amount = 2},
                    {item = "agulha", amount = 1, remove = false}
                },
                output = {
                    {item = "roupas", amount = 1, name = "Conjunto de Roupas"}
                }
            },
            {
                descriptionTextOverride = 'Material: Tecido, Linha e Agulha',
                time = 30,
                input = {
                    {item = "tecidobranco", amount = 5},
                    {item = "linha", amount = 2},
                    {item = "agulha", amount = 1, remove = false}
                },
                output = {
                    {item = "pecaroupabranca", amount = 1, name = "Peças de Roupa Branca"}
                }
            },
            {
                descriptionTextOverride = 'Material: Tecido, Linha e Agulha',
                time = 15,
                input = {
                    {item = "tecidobranco", amount = 2},
                    {item = "linha", amount = 1},
                    {item = "agulha", amount = 1, remove = false}
                },
                output = {
                    {item = "saco", amount = 1, name = "Saco"}
                }
            },
        }
    },


    ----------------------------------------------------------------------------------------------------------------------------------------------------
    --------------------------------------------------------------- MOONSHINE --------------------------------------------------------------------------
    ----------------------------------------------------------------------------------------------------------------------------------------------------
    
    {
        position = vec3(-25.380,1225.333,173.119), -- No position, its global

        useTextDescriptionAll = true,

        craftings =
        {
            {
                descriptionTextOverride = 'Comum entre fazendeiros e enlatadores, fácil de fazer, mas demorado devido a fermentação.',
                
                time = 60,

                input = {
                    {item = "milholata", amount = 3},
                    {item = "alcool", amount = 1},
                    {item = "mostofraco", amount = 1},
                },

                output = {
                    {item = "moonshinetradicional", amount = 1, name = "Tradição ilegal"}
                },
            },
            {
                descriptionTextOverride = 'Refrescante, cheiro de álcool e um mosto razoável.',

                time = 40,

                input = {
                    {item = "cassisdourado", amount = 6},
                    {item = "mentasilvestre", amount = 6},
                    {item = "alcool", amount = 3},
                    {item = "mostomedio", amount = 1},
                },

                output = {
                    {item = "moonshinedourado", amount = 1, name = "Refresco Dourado"}
                }
            },
            {
                descriptionTextOverride = 'Cor de violetas, e cheiro de inverno, muito álcool, e um mosto muito forte.',

                time = 50,

                input = {
                    {item = "gualteria", amount = 8},
                    {item = "violeta", amount = 8},
                    {item = "alcool", amount = 3},
                    {item = "mostoforte", amount = 1},
                },

                output = {
                    {item = "moonshineinverno", amount = 1, name = "Lágrimas de inverno"}
                }
            },
        }
    },
    

    ----------------------------------------------------------------------------------------------------------------------------------------------------
    ----------------------------------------------------------------- BEBIDAS --------------------------------------------------------------------------
    ----------------------------------------------------------------------------------------------------------------------------------------------------

    {
        position = vec3(-828.745,-1319.372,43.587), -- No position, its global
        useTextDescriptionAll = true,
        craftings = 
        {
            {
                descriptionTextOverride = 'Lúpulos, álcool e água.',
                time = 22,
                input = {
                    {item = "lupulo", amount = 4},
                    {item = "alcool", amount = 1},
                    {item = "agua", amount = 2},
                },
                output = {
                    {item = "cerveja", amount = 1, name = "Cerveja"}
                }
            },
            {
                descriptionTextOverride = 'Grãos de milho, trigo, álcool e água.',
                time = 22,
                input = {
                    {item = "milho", amount = 6},
                    {item = "trigo", amount = 6},
                    {item = "alcool", amount = 1},
                    {item = "agua", amount = 1},
                },
                output = {
                    {item = "whisky", amount = 1, name = "Whisky"}
                }
            },
            {
                descriptionTextOverride = 'Agaves, álcool e água.',
                time = 22,
                input = {
                    {item = "agave", amount = 10},
                    {item = "alcool", amount = 3},
                    {item = "agua", amount = 2},
                },
                output = {
                    {item = "tequila", amount = 1, name = "Tequila"}
                }
            },
        }
    },


    ----------------------------------------------------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------ OPIO ----------------------------------------------------------------------------
    ----------------------------------------------------------------------------------------------------------------------------------------------------


    {
        position = vec3(192.208,992.101,189.931), -- No position, its global
        
        useTextDescriptionAll = true,

        craftings = 
        {
            {
                descriptionTextOverride = 'A materia prima, quimicos e um frasco.',

                time = 15,
                
                input = {
                    {item = "papola", amount = 4},
                    {item = "quimicos", amount = 2},
                    {item = "frasco", amount = 1},
                },
                output = {
                    {item = "extratodepapoula", amount = 1, name = "Extrato de Papoula"}
                }
            },
            {
                descriptionTextOverride = 'O extrato, algo para filtrar e mais quimicos.',
                
                time = 20,

                input = {
                    {item = "extratodepapoula", amount = 1},
                    {item = "quimicos", amount = 1},
                    {item = "tecidobranco", amount = 1},
                },
                output = {
                    {item = "opio", amount = 1, name = "Ópio"}
                }
            },
        }
    },



    ----------------------------------------------------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------ JORNAL ----------------------------------------------------------------------------
    ----------------------------------------------------------------------------------------------------------------------------------------------------

--[[
    {
        group = "jornalista",
        position = vec3(1178.750,427.240,96.215), -- No position, its global
        
        useTextDescriptionAll = true,

        craftings = 
        {
            {
                descriptionTextOverride = 'Pedaços de papel, pena de rápina e tinta.',

                time = 10,
                
                input = {
                    {item = "papel", amount = 5},
                    {item = "penarapina", amount = 1, remove = false},
                    {item = "tinta", amount = 1}
                },
                output = {
                    {item = "jornal", amount = 1, name = "Jornal"}
                }
            },
            {
                descriptionTextOverride = 'Recicle seu jornal',
                
                time = 10,

                input = {
                    {item = "jornal", amount = 1},
                },
                output = {
                    {item = "jornal", amount = 1, name = "Jornal Reciclado"}
                }
            },
        }
    },]]




















--}
}