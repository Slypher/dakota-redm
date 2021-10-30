function run_test()
    requestTransportKeepInMemory(1)

    Wait(0)

    requestTransportKeepInMemory(1)

    Wait(0)

    requestTransportKeepInMemory(1)

    print('gTransportPool', json.encode(gTransportPool, { indent = true }))

    Wait(0)

    removeTransportById(1)

    print('gTransportPool', json.encode(gTransportPool, { indent = true }))
end

function json_encode(name, ref)
    print(name, json.encode(ref, { indent = true }))
end

CreateThread(function()
    Wait(1000)

    run_test()
end)