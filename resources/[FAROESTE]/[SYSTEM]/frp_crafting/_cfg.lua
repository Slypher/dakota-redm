Config = {

        -----------------------------------------------------------------------------------------------------------------------------------------------------
        ---------------------------------------------------------------CRAFTS-SEM-PROPS----------------------------------------------------------------------
        -----------------------------------------------------------------------------------------------------------------------------------------------------


        {
            craftings = 
            {
                {
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
                    time = 20,
                    input = {
                        {item = "pedra", amount = 6},
                        {item = "madeiraboa", amount = 4, alias = {"madeiraruim"}}, 
                        
                    },
                    output = {
                        {item = "campfirebig", amount = 1, name = "Fogueira Grande"}
                    }
                },  
            }
        },
        
        -----------------------------------------------------------------------------------------------------------------------------------------------------
        ---------------------------------------------------------------------FOGUEIRA------------------------------------------------------------------------
        -----------------------------------------------------------------------------------------------------------------------------------------------------

        {
            campfire = true,
            craftings = 
            {
                -------------------------------------------- PEIXES ------------------------------------------
                
                {
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
                    time = 40,
                    input = {
                        {item = "largefish", amount = 1}, 
                        {item = "mentasilvestre", amount = 1, alias = {"oregano", "tomilhorastejante"}},
                    },
                    output = {
                        {item = "peixegrandeassado", amount = 1, name = "Peixe Grande Assado"}
                    }
                },
                --------------------------------------------- CARNES --------------------------------------
                {
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
                    time = 40,
                    input = {
                        {item = "carneruim", amount = 1},
                    },
                    output = {
                        {item = "carneruimassada", amount = 1, name = "Carne Assada"}
                    }
                },
                {
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
                    time = 20,
                    input = {
                        {item = "carneave", amount = 1},
                        {item = "gordura", amount = 2},
                    },
                    output = {
                        {item = "carneavefrita", amount = 1, name = "Ave Frita"}
                    }
                },
                -------------------------------- BEBIDA --------------------------------
                {
                    time = 15,
                    input = {
                        {item = "pocafe", amount = 1},
                        {item = "agua", amount = 1},
                    },
                    output = {
                        {item = "cafe", amount = 1, name = "Café"}
                        --{item = "melee_knife", amount = 1, remove = false}
                    }
                },
                -------------------------------- ITENS --------------------------------
                {
                    time = 15,
                    input = {
                        {item = "madeiraruim", amount = 5},
                    },
                    output = {
                        {item = "carvao", amount = 3, name = "Carvão"}
                        --{item = "melee_knife", amount = 1, remove = false}
                    }
                },
            }
        },

        ---------------------------------------------------------------------------------------------------
        --------------------------------------------- CARDERON --------------------------------------------
        ---------------------------------------------------------------------------------------------------

        {
            Calderon = true,
            craftings = 
            {
                
                {
                    time = 40,
                    input = {
                        {item = "cenoura", amount = 4},
                        {item = "batata", amount = 4},
                        {item = "agua", amount = 2},
                        {item = "milho", amount = 4},
                        {item = "carneave", amount = 4},
                    },
                    output = {
                        {item = "sopa", amount = 1, name = "Sopa"}
                    }
                },
                {
                    time = 40,
                    input = {
                        {item = "molhotomate", amount = 2},
                        {item = "carneperfeita", amount = 6},
                        {item = "agua", amount = 2},
                        {item = "batata", amount = 6},
                        {item = "cenoura", amount = 6},
                    },
                    output = {
                        {item = "sopadecarne", amount = 1, name = "Ensopado de Carne"}
                    }
                },
            }
        },


        {
            group = "indio",
            craftings = 
            {
                {-------------------------------------------- ERVAS MEDICINAL ------------------------------------------
                    time = 15,
                    input = {
                        {item = "milfolhas", amount = 5}, 
                        {item = "ginsengalaska", amount = 2}, 
                        {item = "gualteria", amount = 1}, 
                        {item = "melee_knife", amount = 1, remove = false}
                    },
                    output = {
                        {item = "ervamedicinal", amount = 1, name = "Erva Medicinal"},
                    }
                },
                -------------------------------------------- ERVAS DE VENENO ------------------------------------------
                {
                    time = 15,
                    input = {
                        {item = "asclepia", amount = 5}, 
                        {item = "beijaflor", amount = 5}, 
                        {item = "oleandro", amount = 5}, 
                        {item = "melee_knife", amount = 1, remove = false}
                    },
                    output = {
                        {item = "ervadeveneno", amount = 1, name = "Erva de Veneno"},
                    }
                },
                -------------------------------------------- ERVAS OLHOS DE ÁGUIA ------------------------------------------
                {
                    time = 20,
                    input = {
                        {item = "tabacoindiano", amount = 5}, 
                        {item = "tomilhorastejante", amount = 5}, 
                        {item = "violeta", amount = 5}, 
                        {item = "melee_knife", amount = 1, remove = false}
                    },
                    output = {
                        {item = "olhosdeaguia", amount = 1, name = "Visão de Águia"},
                    }
                },
                -------------------------------------------- ERVAS RAÍZES DA TERRA ------------------------------------------
                {
                    time = 15,
                    input = {
                        {item = "cantarelo", amount = 5}, 
                        {item = "maitake", amount = 3}, 
                        {item = "boletobaio", amount = 4}, 
                        {item = "melee_knife", amount = 1, remove = false}
                    },
                    output = {
                        {item = "raizesdaterra", amount = 1, name = "Raízes da Terra"},
                    }
                },
                -------------------------------------------- MADEIRA REFINADA ------------------------------------------
                {
                    time = 15,
                    input = {
                        {item = "madeiraboa", amount = 1}, 
                        {item = "melee_knife_jawbone", amount = 1, alias = {"thrown_tomahawk"}, remove = false},
                    },
                    output = {
                        {item = "madeirarefinada", amount = 1, name = "Madeira Refinada"},
                    }
                },
                -------------------------------------------- VARA DE PESCA ------------------------------------------
                {
                    time = 20,
                    input = {
                        {item = "corda", amount = 1}, 
                        {item = "madeirarefinada", amount = 3}, 
                    },
                    output = {
                        {item = "fishingrod", amount = 1, name = "Vara de Pesca"},
                    }
                },
                -------------------------------------------- FACA DE CAÇADOR ------------------------------------------
                {
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
                    time = 30,
                    input = {
                        {item = "madeirarefinada", amount = 1}, 
                        {item = "fibra", amount = 5, alias = {"tirascouro"}}, 
                        {item = "melee_knife_jawbone", amount = 2}, 
                    },
                    output = {
                        {item = "thrown_tomahawk", amount = 1, name = "Machadinha"},
                    }
                },
                -------------------------------------------- ARCO SIMPLES ------------------------------------------
                {
                    time = 30,
                    input = {
                        {item = "corda", amount = 2}, 
                        {item = "estruturasimples", amount = 1}, 
                    },
                    output = {
                        {item = "bow", amount = 1, name = "Arco Simples"},
                    }
                },
                -------------------------------------------- ARCO CURVADO ------------------------------------------
                {
                    time = 30,
                    input = {
                        {item = "corda", amount = 1}, 
                        {item = "estruturacurvada", amount = 1}, 
                    },
                    output = {
                        {item = "improved_bow", amount = 1, name = "Arco Curvado"},
                    }
                },
                -------------------------------------------- ESTRUTURA DE ARCO ------------------------------------------
                {
                    time = 30,
                    input = {
                        {item = "madeiraboa", amount = 3}, 
                        {item = "melee_knife_jawbone", amount = 1, alias = {"thrown_tomahawk"}, remove = false},
                    },
                    output = {
                        {item = "estruturasimples", amount = 1, name = "Estrutura de Arco"},
                    }
                },
                -------------------------------------------- ESTRUTURA DE ARCO CURVADA ------------------------------------------
                {
                    time = 30,
                    input = {
                        {item = "madeirarefinada", amount = 3}, 
                        {item = "melee_knife_jawbone", amount = 1, alias = {"thrown_tomahawk"}, remove = false},
                    },
                    output = {
                        {item = "estruturacurvada", amount = 1, name = "Estrutura de Arco Curvada"},
                    }
                },
                -------------------------------------------- LASSO ------------------------------------------
                {
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
                    time = 15,
                    input = {
                        {item = "pedra", amount = 1},                     
                    },
                    output = {
                        {item = "melee_knife_jawbone", amount = 1, name = "Pedra Afiada"},
                    }
                },
                -------------------------------------------- TOCHA ------------------------------------------
                
                --{
                --    time = 15,
                --    input = {
                --        {item = "madeiraboa", amount = 1, alias = {"madeiraruim", amount = 2}}, 
                --        {item = "gordura", amount = 1}, 
                --        {item = "fibra", amount = 2}, 
                --    },
                --    output = {
                --        {item = "melee_torch", amount = 1, name = "Tocha"},
                --    }
                --},
                -------------------------------------------- FLECHA NORMAL ------------------------------------------
                {
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
                {
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
                },
                -------------------------------------------- FLECHA PEQUENA ------------------------------------------
                {
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
            --position = vec3(-369.484,796.221,116.196),  -- No position, its global
            Ferreiro = true,
            craftings = 
            {
                {
                                    -- BARRA DE FERRO
                    time = 40,
                    input = {
                        {item = "minerioferro", amount = 6},
                        {item = "carvao", amount = 5},
                        {item = "ferramentas", amount = 1, remove = false}
                    },
                    output = {
                        {item = "barraferro", amount = 1, name = "Barra de Ferro"},
                    }
                },
                {
                                    -- BARRA DE COBRE
                    time = 40,
                    input = {
                        {item = "mineriocobre", amount = 6},
                        {item = "carvao", amount = 5},
                        {item = "ferramentas", amount = 1, remove = false}
                    },
                    output = {
                        {item = "barracobre", amount = 1, name = "Barra de Cobre"},
                    }
                },
                {
                                    -- BARRA DE OURO
                    time = 60,
                    input = {
                        {item = "pepitadeouro", amount = 50},
                        {item = "carvao", amount = 15},
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
            craftings = 
            {
                {
                                    -- FERRAMENTAS
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
                                    -- CABEÇA DE PICARETA
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
                    time = 25,
                    input = {
                        {item = "barraferro", amount = 1},
                        {item = "ferramentas", amount = 1, remove = false}
                    },
                    output = {
                        {item = "cabecapa", amount = 1, name = "Cabeça de Pá"}
                    }
                },
                {
                                    -- CABEÇA DE ENXADA
                    time = 25,
                    input = {
                        {item = "barraferro", amount = 1},
                        {item = "ferramentas", amount = 1, remove = false}
                    },
                    output = {
                        {item = "cabecaenxada", amount = 1, name = "Cabeça de Enxada"}
                    }
                },
                {
                                    -- LÂMINA
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
                    time = 25,
                    input = {
                        {item = "barraferro", amount = 1},
                        {item = "ferramentas", amount = 1, remove = false}
                    },
                    output = {
                        {item = "canodearma", amount = 1, name = "Cano de Arma"},
                    }
                },
                {
                                    -- CÃO DE ARMA
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
            craftings = 
            {
                {
                                    -- PICARETA
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
                {
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
                },
                {
                                    -- FACÃO
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
                    time = 20,
                    input = {
                        {item = "parafuso", amount = 5},
                        {item = "barracobre", amount = 1},
                        {item = "ferramentas", amount = 1, remove = false}
                    },
                    output = {
                        {item = "lockpick", amount = 1, name = "Gazua"},
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
            craftings = 
            {
                {
                                    -- REVOLVER DE AÇÃO-DUPLA
                    time = 25,
                    input = {
                        {item = "canodearma", amount = 1},
                        {item = "caodearma", amount = 1},
                        {item = "gatilhodearma", amount = 1},
                        {item = "corpoderevolver", amount = 1},
                        {item = "parafuso", amount = 5},
                        {item = "ferramentas", amount = 1, remove = false}
                    },
                    output = {
                        {item = "revolver_doubleaction", amount = 1, name = "Revólver de Ação-Dupla"},
                    }
                },
                {
                                    -- REVOLVER DE VAQUEIRO
                    time = 25,
                    input = {
                        {item = "canodearma", amount = 1},
                        {item = "caodearma", amount = 1},
                        {item = "gatilhodearma", amount = 1},
                        {item = "corpoderevolver", amount = 1},
                        {item = "parafuso", amount = 5},
                        {item = "ferramentas", amount = 1, remove = false}
                    },
                    output = {
                        {item = "revolver_cattleman", amount = 1, name = "Revólver de Vaqueiro"},
                    }
                },
                {
                                    -- REVOLVER SCHOTFIELD
                    time = 25,
                    input = {
                        {item = "canodearma", amount = 1},
                        {item = "caodearma", amount = 1},
                        {item = "gatilhodearma", amount = 1},
                        {item = "corpoderevolver", amount = 1},
                        {item = "parafuso", amount = 5},
                        {item = "ferramentas", amount = 1, remove = false}
                    },
                    output = {
                        {item = "revolver_schofield", amount = 1, name = "Revólver Schotfield"},
                    }
                },
                {
                                    -- REVOLVER LEMAT
                    time = 25,
                    input = {
                        {item = "canodearma", amount = 1},
                        {item = "caodearma", amount = 1},
                        {item = "gatilhodearma", amount = 1},
                        {item = "corpoderevolver", amount = 1},
                        {item = "parafuso", amount = 5},
                        {item = "ferramentas", amount = 1, remove = false}
                    },
                    output = {
                        {item = "revolver_lemat", amount = 1, name = "Revólver Lemat"},
                    }
                },
                {
                                    -- REVOLVER DA MARINHA
                    time = 25,
                    input = {
                        {item = "canodearma", amount = 1},
                        {item = "caodearma", amount = 1},
                        {item = "gatilhodearma", amount = 1},
                        {item = "corpoderevolver", amount = 1},
                        {item = "parafuso", amount = 5},
                        {item = "ferramentas", amount = 1, remove = false}
                    },
                    output = {
                        {item = "revolver_navy", amount = 1, name = "Revólver da Marinha"},
                    }
                },
                {
                                    -- PISTOLA VOLCANIC
                    time = 30,
                    input = {
                        {item = "canodearma", amount = 1},
                        {item = "caodearma", amount = 1},
                        {item = "gatilhodearma", amount = 1},
                        {item = "corpodepistola", amount = 1},
                        {item = "parafuso", amount = 6},
                        {item = "ferramentas", amount = 1, remove = false}
                    },
                    output = {
                        {item = "pistol_volcanic", amount = 1, name = "Pistola Volcanic"},
                    }
                },
                {
                                    -- PISTOLA MAUSER
                    time = 30,
                    input = {
                        {item = "canodearma", amount = 1},
                        {item = "caodearma", amount = 1},
                        {item = "gatilhodearma", amount = 1},
                        {item = "corpodepistola", amount = 1},
                        {item = "parafuso", amount = 6},
                        {item = "ferramentas", amount = 1, remove = false}
                    },
                    output = {
                        {item = "pistol_mauser", amount = 1, name = "Pistola Mauser"},
                    }
                },
                {
                                    -- PISTOLA SEMI-AUTO
                    time = 30,
                    input = {
                        {item = "canodearma", amount = 1},
                        {item = "caodearma", amount = 1},
                        {item = "gatilhodearma", amount = 1},
                        {item = "corpodepistola", amount = 1},
                        {item = "parafuso", amount = 6},
                        {item = "ferramentas", amount = 1, remove = false}
                    },
                    output = {
                        {item = "pistol_semiauto", amount = 1, name = "Pistola Semi-Auto"},
                    }
                },
                {
                                    -- CARABINA DE REPETIÇÃO
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
                        {item = "repeater_winchester", amount = 1, name = "Lancaster de Repetição"}
                    }
                },
                {
                                    -- CARABINA HENRY
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
                        {item = "repeater_henry", amount = 1, name = "Henry de Repetição"}
                    }
                },
                {
                                    -- CARABINA VARMINT
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
                        {item = "rifle_varmint", amount = 1, name = "Rifle Anti-Pragas"}
                    }
                },
                {
                                    -- CARABINA EVANS
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
                        {item = "repeater_evans", amount = 1, name = "Evans de Repetição"}
                    }
                },
                {
                                    -- RIFLE SPRINGFIELD
                    time = 50,
                    input = {
                        {item = "canodearma", amount = 1},
                        {item = "caodearma", amount = 1},
                        {item = "gatilhodearma", amount = 1},
                        {item = "corpoderifle", amount = 1},
                        {item = "parafuso", amount = 10},
                        {item = "ferramentas", amount = 1, remove = false}
                    },
                    output = {
                        {item = "rifle_springfield", amount = 1, name = "Rifle Springfield"}
                    }
                },
                {
                                    -- RIFLE DE FERROLHO
                    time = 50,
                    input = {
                        {item = "canodearma", amount = 1},
                        {item = "caodearma", amount = 1},
                        {item = "gatilhodearma", amount = 1},
                        {item = "corpoderifle", amount = 1},
                        {item = "parafuso", amount = 10},
                        {item = "ferramentas", amount = 1, remove = false}
                    },
                    output = {
                        {item = "rifle_boltaction", amount = 1, name = "Rifle de Ferrolho"}
                    }
                },
                {
                                    -- RIFLE ROLLING BLOCK
                    time = 70,
                    input = {
                        {item = "canodearma", amount = 1},
                        {item = "caodearma", amount = 1},
                        {item = "gatilhodearma", amount = 1},
                        {item = "corpodesniper", amount = 1},
                        {item = "parafuso", amount = 10},
                        {item = "ferramentas", amount = 1, remove = false}
                    },
                    output = {
                        {item = "sniperrifle_rollingblock", amount = 1, name = "Rifle Rolling Block"}
                    }
                },
                {
                                    -- ESCOPETA SERRADA
                    time = 60,
                    input = {
                        {item = "canodearma", amount = 2},
                        {item = "caodearma", amount = 2},
                        {item = "gatilhodearma", amount = 2},
                        {item = "corpodeescopeta", amount = 2},
                        {item = "parafuso", amount = 8},
                        {item = "ferramentas", amount = 1, remove = false}
                    },
                    output = {
                        {item = "shotgun_sawedoff", amount = 1, name = "Escopeta de Cano-Serrado"},
                    }
                },
                {
                                    -- ESCOPETA CANO-DUPLO
                    time = 70,
                    input = {
                        {item = "canodearma", amount = 2},
                        {item = "caodearma", amount = 2},
                        {item = "gatilhodearma", amount = 2},
                        {item = "corpodeescopeta", amount = 2},
                        {item = "parafuso", amount = 8},
                        {item = "ferramentas", amount = 1, remove = false}
                    },
                    output = {
                        {item = "shotgun_doublebarrel", amount = 1, name = "Escopeta de Cano-Duplo"},
                    }
                },
                --{
                                    -- ESCOPETA DE ELEFANTE
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
                    time = 10,
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
                    time = 10,
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
                    time = 10,
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
                    time = 10,
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
                    time = 10,
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
                    time = 10,
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

        ----------------------------------------------------------------------------------------------------------------------------------------------------
        ----------------------------------------------------------------- PADARIA | MESA -------------------------------------------------------------------
        ----------------------------------------------------------------------------------------------------------------------------------------------------
        
        {
            -- position = vec3(0, 0, 0) -- No position, its global
            group = "padeiro",
            Padaria = true,
            craftings = 
            {
                {
                    time = 20,
                    input = {
                        {item = "farinha", amount = 1},
                        {item = "acucar", amount = 1}
                    },
                    output = {
                        {item = "massadepao", amount = 1, name = "Massa de Pão"}
                    }
                },
                {
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
            craftings = 
            {
                {
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
                    time = 30,
                    input = {
                        {item = "carvao", amount = 1},
                        {item = "massadepao", amount = 1},
                    },
                    output = {
                        {item = "pao", amount = 4, name = "Pão"}
                    }
                },
            }
        },


        ---------------------------------------------------------------------------------------------------
        --------------------------------------- FAZENDEIRO | LATA -----------------------------------------
        ---------------------------------------------------------------------------------------------------

        {
            position = vec3(1357.599,-1248.308,79.951), -- No position, its global
            craftings = 
            {
                {
                    time = 15,
                    input = {
                        {item = "lata", amount = 1},
                        {item = "tomate", amount = 4},
                        --{item = "melee_knife", amount = 1, remove = false}
                    },
                    output = {
                        {item = "molhotomate", amount = 1, name = "Molho de Tomate"}
                    }
                },
                {
                    time = 15,
                    input = {
                        {item = "milho", amount = 6},
                        {item = "lata", amount = 1},
                    },
                    output = {
                        {item = "milholata", amount = 1, name = "Milho Enlatado"}
                    }
                },
                {
                    time = 15,
                    input = {
                        {item = "feijao", amount = 5},
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
            craftings = 
            {
                {
                    time = 15,
                    input = {
                        {item = "pa", amount = 1, remove = false},
                        {item = "osso", amount = 10},
                    },
                    output = {
                        {item = "podeosso", amount = 5, name = "Pó de Osso"}
                    }
                },
                {
                    time = 15,
                    input = {
                        {item = "pa", amount = 1, remove = false},
                        {item = "podeosso", amount = 10},
                        {item = "saco", amount = 1},
                    },
                    output = {
                        {item = "sacodeadubo", amount = 1, name = "Saco de Adubo"}
                    }
                }
            }
        },
-------------------------------------------------MOINHO--------------------------------------------
        {
            position = vec3(1053.885,-1123.756,67.891), -- No position, its global
            craftings = 
            {
                {
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
                    time = 15,
                    input = {
                        {item = "money", amount = 1},
                        {item = "canaacucar", amount = 4},
                    },
                    output = {
                        {item = "acucar", amount = 1, name = "Açúcar"}
                    }
                },
            }
        },

--------------------------------------ALFAIATE-------------------------------
        {
            position = vec3(1410.200,-1283.656,81.594), -- No position, its global
            craftings = 
            {
                {
                    time = 20,
                    input = {
                        {item = "algodao", amount = 10, alias = {"fibra"}},
                        --{item = "melee_knife", amount = 1, remove = false}
                    },
                    output = {
                        {item = "linha", amount = 5, name = "Rolo de Linha"}
                    }
                },
            }
        },
        {
            position = vec3(-766.793,-1291.068,43.839), -- No position, its global
            craftings = 
            {
                {
                    time = 30,
                    input = {
                        {item = "algodao", amount = 10},
                        {item = "linha", amount = 3},
                        {item = "agulha", amount = 1, remove = false}
                    },
                    output = {
                        {item = "tecidobranco", amount = 6, name = "Tecido Branco"}
                    }
                },
                {
                    time = 50,
                    input = {
                        {item = "tecidobranco", amount = 6},
                        {item = "linha", amount = 2},
                        {item = "agulha", amount = 1, remove = false}
                    },
                    output = {
                        {item = "roupas", amount = 1, name = "Peça de Roupa Branca"}
                    }
                },
                {
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
    --}
}