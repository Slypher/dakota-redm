AddEventHandler(
    "FRP:EVENTS:PedFinishedGatheringEntity",
    function(ped, entity, bool_unk)
        if IsEntityAPed(entity) then
            local isHuman = IsPedHuman(entity)

            if ped == PlayerPedId() then

                local timeout = 15000
                local wait = 100

                while timeout > 0 do
                    Citizen.Wait(wait)
                    timeout = timeout - wait

                    -- IsEntityFullyLooted
                    if Citizen.InvokeNative(0x8DE41E9902E85756, entity) then

                        -- GetPedQuality
                        local quality = Citizen.InvokeNative(0x7BCC6087D130312A, entity, Citizen.ResultAsInteger())

                        TriggerServerEvent("FRP:GATHERING:Gathered", GetEntityModel(entity), isHuman, quality)
                        break
                    end
                end
            end
        end
    end
)