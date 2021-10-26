Transport = { }

-- @param type eTransportType
-- @param id number
function Transport:constructor(type, id)
    self.type = type
    self.id = id
end

function Transport:getId()
    return self.id
end

function Transport:getType()
    return self.type
end

function API.createTransport(...)
    local instance = table.clone(Transport)

    instance:constructor(eTransportType.Unknown, ...)

    return instance
end

-- print('Horse', eTransportType.Horse, eTransportType[eTransportType.Horse])

-- local gEntityPool = {
--     ['Transport'] = { },
--     ['']
-- }

--[[
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