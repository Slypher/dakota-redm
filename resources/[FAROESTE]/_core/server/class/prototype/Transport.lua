gTransportPool = { }

local gTransportIdToIndex =  { }

function addTransport(transportId, type, modelName)
    local transportIndex = #gTransportPool + 1

    gTransportPool[transportIndex] = {
        transportId = transportId,
        type        = type,
        modelName   = modelName,

        isCreated   = false,
        entity      = nil,

        state       = { },
    }

    gTransportIdToIndex[transportId] = transportIndex

    return transportIndex
end

function removeTransportByIndex(transportIndex)
    local transportId = gTransportPool[transportIndex]

    if not transportId then
        return false
    end

    table.remove(gTransportPool, transportIndex)

    gTransportIdToIndex[transportId] = nil
    
    -- Reorganizar o mapeamento de id para index.
    for itTransportIndex = transportIndex, #gTransportPool do
        local itTransportId = gTransportPool[itTransportIndex]

        gTransportIdToIndex[itTransportId] = itTransportIndex
    end

    return true
end

function removeTransportById(transportId)
    local transportIndex = gTransportIdToIndex[transportId]
    
    if not transportIndex then
        return false
    end

    return removeTransportByIndex(transportIndex)
end

function assertTransportIndexIsValid(transportIndex)
    assert(gTransportPool[transportIndex] ~= nil)
end

function setTransportAsHorseForIndex(transportIndex, isMale, apparels)
    assertTransportIndexIsValid(transportIndex)

    local transportData = gTransportPool[transportIndex]

    transportData.isMale = isMale or true

    transportData.APPAREL_BEDROLL   = apparels[1]
    transportData.APPAREL_BLANKET   = apparels[2]
    transportData.APPAREL_HORN      = apparels[3]
    transportData.APPAREL_SADDLEBAG = apparels[4]
    transportData.APPAREL_STIRRUP   = apparels[5]
    transportData.APPAREL_SADDLE    = apparels[6]
    transportData.APPAREL_LATERN    = apparels[7]
    transportData.APPAREL_MANES     = apparels[8]
    transportData.APPAREL_TAILS     = apparels[9]

    -- Propriedades doa aforje quando ele está fora do cavalo.
    transportData.isSaddlebagDettached = false
    transportData.dettachedSaddlebagNetworkId = nil
end

function requestTransportKeepInMemory(transportId)
    local result = API_Database.query('transport/get-transport-include-all-scopes', { transportId = transportId })

    if not result then
        return
    end

    local transportWithAllScopes = result[1]

    addTransportFromDatabaseObject(transportWithAllScopes)
end

function addTransportFromDatabaseObject(object)
    local transportTypeName = object.type
    local transportTypeEnum = eTransportType[object.type]

    local transportIndex = addTransport(object.transportId, transportTypeEnum, object.modelName)

    setTransportStateForIndex(
        transportIndex,
        object.currHealth,
        object.currDirtLevel,
        object.lossType,
        object.dateOfLoss
    )

    if transportTypeEnum == eTransportType.Horse then
        setTransportStateHorseForIndex(
            transportIndex,
            object.isInWrithe,
            object.bodyWeight
        )
    end

    if transportTypeEnum == eTransportType.VehicleDraft then
        setTransportStateVehicleDraftForIndex(
            transportIndex,
            object.brokenWheelFlags,
            object.brokenDoorFlags
        )
    end
end

--[[
    # Cavalo Temporário: Cavalos que estão no processo de ser domados, não serão salvos ao banco de dados.

    # StateBag:
        transport__transportId
        transport__ownerServerId
    
    # Tasks: Todos os players vão manter um thread para verificar se algum cavalo em escopo(que o player seja netOwner) está precisando executar uma task.

    # Ações:
        > Mandar Fugir:
            * flag de `taskFlee`, principalmente no statebag (necessário?)
            * servidor aguardar X segundos, enviar para o netOwner verificar próximidade com outros players
            e se alguem está vendo o cavalo, caso a resposta seja negativa, deletar o cavalo.
        > Seguir:
            * flag de `taskFollow` no statebag.
            * netOwner vai pegar o ped do dono do cavalo via statebag: 'transport__ownerServerId'.

    # Alforje:
        * Quando desanexado, verificar caso a entidade seja deletada.
        * Enquanto desanexado, ter statebag `transport__isSaddlebag`.

    # Carroça:
        * Fazer o requesto da carroça, saber quais cavalos estão presos e fazer o request dos cavalos logo após.

    # Extras:
        Escolher o cavalo principal/secundario no estábulo em que ele foi colocado.

        Mas não faz sentido, ja que ninguem guarda o cavalo no estábulo :thinking:

        Jogador chama o cavalo preferido quando estiver proximo ao estábulo,
        esse cavalo agora vai ser o 'Cavalo Ativo' da sessão.
        
        Se o jogador mandar o cavalo fugir próximo ao estábulo, o jogador não
        terá mais um 'Cavalo Ativo'.

        Se o jogador mandar o 'Cavalo Ativo' longe do estábulo, ele ainda poderá
        chamar o cavalo novamente.

        //

        A 'Carroça Ativa', caso não tenha nenhuma cavalo preso a ela, sairá desse estado na primeira vez em que o player
        'mandar embora' a carroça, tendo que voltar no estábulo para selecionar ela de novo.
]]