LOOKUP_AMMOTYPE_TO_SUPPORTED_WEAPONTYPES = { }
LOOKUP_AMMOHASH_TO_AMMOTYPE = { }

for weaponType, weaponInfo in pairs(WEAPON_INFO_DATABASE) do

    for _, ammoType in pairs(weaponInfo.useable_ammo_types) do
        ammoSupportedWeaponTypes = LOOKUP_AMMOTYPE_TO_SUPPORTED_WEAPONTYPES[ammoType]

        if not ammoSupportedWeaponTypes then
            ammoSupportedWeaponTypes = { }

            LOOKUP_AMMOTYPE_TO_SUPPORTED_WEAPONTYPES[ammoType] = ammoSupportedWeaponTypes
        end

        ammoSupportedWeaponTypes[weaponType] = true
    end

    -- LOOKUP_AMMOTYPE_TO_SUPPORTED_WEAPONTYPES[]
end

for ammoType, _ in pairs(LOOKUP_AMMOTYPE_TO_SUPPORTED_WEAPONTYPES) do
    LOOKUP_AMMOHASH_TO_AMMOTYPE[GetHashKey(ammoType)] = ammoType
end

-- LOOKUP_WEAPONGROUP_TO_WEAPONTYPE

--[[ Structure:

    ['ammo_revolver'] = {
        ['weapon_revolver_cattleman'] = true,
    }
]]