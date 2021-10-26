local gTransportIdPool    = fwPoolCreate()
local gHorseIdPool        = fwPoolCreate()
local gVehicleDraftIdPool = fwPoolCreate()

local gTransportsType      = { }
local gTransportsModelName = { }

local gStatesTransportCurrHealth    = { }
local gStatesTransportCurrDirtLevel = { }
local gStatesTransportLossType      = { }
local gStatesTransportDateOfLoss    = { }

local gStatesHorseIsInWrithe = { }
local gStatesHorseBodyWeight = { }

local gStatesVehicleDraftBrokenWheelFlags = { }
local gStatesVehicleDraftBrokenDoorFlags  = { }

enum 'eTransportType' {
    Unknown      = 0,
    Horse        = 1,
    VehicleDraft = 2,
    VehicleBoat  = 3,
}

function CreateTransportStoreInDatabase()
end

function RequestTransportKeepInMemory(transportId)
    local result = API_Database.query('transport/get-transport-include-all-scopes', { transportId = transportId })

    if not result then
        return
    end

    -- #REMOVE: Para teste, id temporário aleátorio para duplicatas.
    if gTransportIdPool:getIndexById(transportId) then
        transportId = GetGameTimer()
    end

    local transportWithAllScopes = result[1]

    AddTransportFromObject(transportId, transportWithAllScopes)
end

function AddTransportFromObject(transportId, object)
    local transportTypeName = object.type
    local transportTypeEnum = eTransportType[transportTypeName]

    -- print( ('RequestTransportKeepInMemory :: (%d) :: object ::'):format(transportId) , json.encode(object, { indent = true }))

    print('AddTransportFromObject :: transportType', transportTypeName)

    local transportIndex = gTransportIdPool:add(transportId)

    gTransportsType     [transportIndex] = transportTypeEnum
    gTransportsModelName[transportIndex] = object.modelName

    gStatesTransportCurrHealth   [transportIndex] = object.currHealth
    gStatesTransportCurrDirtLevel[transportIndex] = object.currDirtLevel
    gStatesTransportLossType     [transportIndex] = object.lossType
    gStatesTransportDateOfLoss   [transportIndex] = object.dateOfLoss

    if transportTypeEnum == eTransportType.Horse then
        local transportHorseIndex = gHorseIdPool:add(transportId)

        gStatesHorseIsInWrithe[transportHorseIndex] = object.isInWrithe
        gStatesHorseBodyWeight[transportHorseIndex] = object.bodyWeight
    end

    if transportTypeEnum == eTransportType.VehicleDraft then
        local transportVehicleDraftIndex = gVehicleDraftIdPool:add(transportId)

        gStatesVehicleDraftBrokenWheelFlags[transportVehicleDraftIndex] = object.brokenWheelFlags
        gStatesVehicleDraftBrokenDoorFlags [transportVehicleDraftIndex] = object.brokenDoorFlags
    end
end

function SetTransportAsNoLongerNeeded(transportId)
end

function ReleaseTransport(transportId)
    local transportIndex = gTransportIdPool:getIndexById(transportId)

    if not transportIndex then
        return
    end

    gTransportIdPool:removeByIndex(transportIndex)

    local transportType = gTransportsType[transportIndex]

    table.remove(gTransportsType     , transportIndex)
    table.remove(gTransportsModelName, transportIndex)

    table.remove(gStatesTransportCurrHealth   , transportIndex)
    table.remove(gStatesTransportCurrDirtLevel, transportIndex)
    table.remove(gStatesTransportLossType     , transportIndex)
    table.remove(gStatesTransportDateOfLoss   , transportIndex)

    if transportType == eTransportType.Horse then
        local transportHorseIndex = gHorseIdPool:getIndexById(transportId)

        gHorseIdPool:removeByIndex(transportHorseIndex)
        
        table.remove(gStatesHorseIsInWrithe, transportHorseIndex)
        table.remove(gStatesHorseBodyWeight, transportHorseIndex)
    end

    if transportType == eTransportType.VehicleDraft then
        local transportVehicleDraftIndex = gVehicleDraftIdPool:getIndexById(transportId)
        
        gVehicleDraftIdPool:removeByIndex(transportVehicleDraftIndex)

        table.remove(gStatesVehicleDraftBrokenWheelFlags, transportVehicleDraftIndex)
        table.remove(gStatesVehicleDraftBrokenDoorFlags , transportVehicleDraftIndex)
    end
end

CreateThread(function()
    API_Database.prepare(
        'transport/get-transport-include-all-scopes',
        [[
        SELECT
            t.transportId,
            t.type,
            t.modelName,

            th.isMale,
            th.apparels,

            ts.currHealth,
            ts.currDirtLevel,
            ts.lossType,
            ts.dateOfLoss,
            
            tsh.isInWrithe,
            tsh.bodyWeight,
            
            tsvd.brokenWheelFlags,
            tsvd.brokenDoorFlags
            
        FROM transport AS t
            LEFT JOIN transport_horse AS th
                ON t.transportId = th.transportId
                
            LEFT JOIN transport_state AS ts
                ON t.transportId = ts.transportId
                
            LEFT JOIN transport_state_horse AS tsh
                ON t.transportId = tsh.transportId
                
            LEFT JOIN transport_state_vehicle_draft AS tsvd
                ON t.transportId = tsvd.transportId
                
        WHERE t.transportId = @transportId
        LIMIT 1
        ]]
    )

    -- CREATE TABLE IF NOT EXISTS `transport` (
    -- `transportId` int(11) NOT NULL AUTO_INCREMENT,
    -- `type` enum('Unknown','Horse','VehicleDraft','VehicleBoat') NOT NULL DEFAULT 'Unknown',
    -- `modelName` tinytext NOT NULL,
    -- `createdAt` timestamp NOT NULL DEFAULT current_timestamp(),
    -- PRIMARY KEY (`transportId`)
    -- );

    -- CREATE TABLE IF NOT EXISTS `transport_horse` (
    -- `id` int(11) NOT NULL AUTO_INCREMENT,
    -- `transportId` int(11) NOT NULL,
    -- `isMale` tinyint(1) NOT NULL DEFAULT 1,
    -- `apparels` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '{}',
    -- PRIMARY KEY (`id`),
    -- UNIQUE KEY `transportId` (`transportId`),
    -- CONSTRAINT `FK_transport_horse_transport` FOREIGN KEY (`transportId`) REFERENCES `transport` (`transportId`) ON DELETE CASCADE ON UPDATE NO ACTION
    -- );

    -- -- Copiando estrutura para tabela dakota.transport_state
    -- CREATE TABLE IF NOT EXISTS `transport_state` (
    -- `id` int(11) NOT NULL AUTO_INCREMENT,
    -- `transportId` int(11) NOT NULL,
    -- `currHealth` float NOT NULL DEFAULT 100,
    -- `currDirtLevel` float NOT NULL DEFAULT 0,
    -- `lossType` enum('None','Dead','Destroyed') NOT NULL DEFAULT 'None',
    -- `dateOfLoss` timestamp NOT NULL DEFAULT current_timestamp(),
    -- PRIMARY KEY (`id`),
    -- UNIQUE KEY `transportId` (`transportId`),
    -- CONSTRAINT `FK_transport_state_transport` FOREIGN KEY (`transportId`) REFERENCES `transport` (`transportId`)
    -- );

    -- CREATE TABLE IF NOT EXISTS `transport_state_horse` (
    -- `id` int(11) NOT NULL AUTO_INCREMENT,
    -- `transportId` int(11) NOT NULL,
    -- `isInWrithe` tinyint(1) NOT NULL DEFAULT 0,
    -- `bodyWeight` float NOT NULL DEFAULT 0.5,
    -- PRIMARY KEY (`id`),
    -- UNIQUE KEY `transportId` (`transportId`),
    -- CONSTRAINT `FK_transport_state_horse_transport` FOREIGN KEY (`transportId`) REFERENCES `transport` (`transportId`)
    -- );

    -- CREATE TABLE IF NOT EXISTS `transport_state_vehicle_draft` (
    -- `id` int(11) NOT NULL AUTO_INCREMENT,
    -- `transportId` int(11) NOT NULL,
    -- `brokenWheelFlags` int(11) NOT NULL DEFAULT 0,
    -- `brokenDoorFlags` int(11) NOT NULL DEFAULT 0,
    -- PRIMARY KEY (`id`),
    -- UNIQUE KEY `transportId` (`transportId`),
    -- CONSTRAINT `FK__transport` FOREIGN KEY (`transportId`) REFERENCES `transport` (`transportId`)
    -- );

    -- run_test()
end)

function run_test()
    RequestTransportKeepInMemory(1)

    Wait(0)

    RequestTransportKeepInMemory(1)

    Wait(0)

    RequestTransportKeepInMemory(1)

    -- json_encode('gTransportsType', gTransportsType)
    -- json_encode('gTransportsModelName', gTransportsModelName)
    -- json_encode('gStatesTransportCurrHealth', gStatesTransportCurrHealth)
    -- json_encode('gStatesTransportCurrDirtLevel', gStatesTransportCurrDirtLevel)
    -- json_encode('gStatesTransportLossType', gStatesTransportLossType)
    -- json_encode('gStatesTransportDateOfLoss', gStatesTransportDateOfLoss)
    -- json_encode('gStatesHorseIsInWrithe', gStatesHorseIsInWrithe)
    -- json_encode('gStatesHorseBodyWeight', gStatesHorseBodyWeight)
    -- json_encode('gStatesVehicleDraftBrokenWheelFlags', gStatesVehicleDraftBrokenWheelFlags)
    -- json_encode('gStatesVehicleDraftBrokenDoorFlags', gStatesVehicleDraftBrokenDoorFlags)

    Wait(0)

    ReleaseTransport(1)

    -- json_encode('gTransportsType', gTransportsType)
    -- json_encode('gTransportsModelName', gTransportsModelName)
    -- json_encode('gStatesTransportCurrHealth', gStatesTransportCurrHealth)
    -- json_encode('gStatesTransportCurrDirtLevel', gStatesTransportCurrDirtLevel)
    -- json_encode('gStatesTransportLossType', gStatesTransportLossType)
    -- json_encode('gStatesTransportDateOfLoss', gStatesTransportDateOfLoss)
    -- json_encode('gStatesHorseIsInWrithe', gStatesHorseIsInWrithe)
    -- json_encode('gStatesHorseBodyWeight', gStatesHorseBodyWeight)
    -- json_encode('gStatesVehicleDraftBrokenWheelFlags', gStatesVehicleDraftBrokenWheelFlags)
    -- json_encode('gStatesVehicleDraftBrokenDoorFlags', gStatesVehicleDraftBrokenDoorFlags)
end

function json_encode(name, ref)
    print(name, json.encode(ref, { indent = true }))
end
