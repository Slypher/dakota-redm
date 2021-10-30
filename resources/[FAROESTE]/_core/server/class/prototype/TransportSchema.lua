

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

CreateThread(function()
    API_Database.prepare('transport__schema_0',
        [[
            CREATE TABLE IF NOT EXISTS `transport` (
            `transportId` int(11) NOT NULL AUTO_INCREMENT,
            `type` enum('Unknown','Horse','VehicleDraft','VehicleBoat') NOT NULL DEFAULT 'Unknown',
            `modelName` tinytext NOT NULL,
            `createdAt` timestamp NOT NULL DEFAULT current_timestamp(),
            PRIMARY KEY (`transportId`)
            );
        ]]
    )

    API_Database.prepare('transport__schema_1',
        [[
            CREATE TABLE IF NOT EXISTS `transport_horse` (
            `id` int(11) NOT NULL AUTO_INCREMENT,
            `transportId` int(11) NOT NULL,
            `isMale` tinyint(1) NOT NULL DEFAULT 1,
            `apparels` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '{}',
            PRIMARY KEY (`id`),
            UNIQUE KEY `transportId` (`transportId`),
            CONSTRAINT `FK_transport_horse_transport` FOREIGN KEY (`transportId`) REFERENCES `transport` (`transportId`) ON DELETE CASCADE
            );
        ]]
    )

    API_Database.prepare('transport__schema_2',
        [[
            CREATE TABLE IF NOT EXISTS `transport_state` (
            `id` int(11) NOT NULL AUTO_INCREMENT,
            `transportId` int(11) NOT NULL,
            `currHealth` float NOT NULL DEFAULT 100,
            `currDirtLevel` float NOT NULL DEFAULT 0,
            `lossType` enum('None','Dead','Destroyed') NOT NULL DEFAULT 'None',
            `dateOfLoss` timestamp NOT NULL DEFAULT current_timestamp(),
            PRIMARY KEY (`id`),
            UNIQUE KEY `transportId` (`transportId`),
            CONSTRAINT `FK_transport_state_transport` FOREIGN KEY (`transportId`) REFERENCES `transport` (`transportId`) ON DELETE CASCADE
            );
        ]]
    )

    API_Database.prepare('transport__schema_3',
        [[
            CREATE TABLE IF NOT EXISTS `transport_state_horse` (
            `id` int(11) NOT NULL AUTO_INCREMENT,
            `transportId` int(11) NOT NULL,
            `isInWrithe` tinyint(1) NOT NULL DEFAULT 0,
            `bodyWeight` float NOT NULL DEFAULT 0.5,
            PRIMARY KEY (`id`),
            UNIQUE KEY `transportId` (`transportId`),
            CONSTRAINT `FK_transport_state_horse_transport` FOREIGN KEY (`transportId`) REFERENCES `transport` (`transportId`) ON DELETE CASCADE
            );
        ]]
    )

    API_Database.prepare('transport__schema_4',
        [[
            CREATE TABLE IF NOT EXISTS `transport_state_vehicle_draft` (
            `id` int(11) NOT NULL AUTO_INCREMENT,
            `transportId` int(11) NOT NULL,
            `brokenWheelFlags` int(11) NOT NULL DEFAULT 0,
            `brokenDoorFlags` int(11) NOT NULL DEFAULT 0,
            PRIMARY KEY (`id`),
            UNIQUE KEY `transportId` (`transportId`),
            CONSTRAINT `FK__transport` FOREIGN KEY (`transportId`) REFERENCES `transport` (`transportId`) ON DELETE CASCADE
            );
        ]]
    )

    API_Database.execute('transport__schema_0')
    API_Database.execute('transport__schema_1')
    API_Database.execute('transport__schema_2')
    API_Database.execute('transport__schema_3')
    API_Database.execute('transport__schema_4')

    prepareQueries()

    -- run_test()
end)

function prepareQueries()
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
end