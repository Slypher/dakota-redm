exports('GetPedComponentAtIndex', function(ped, index)
{
    const buff = new ArrayBuffer(5 * 8);
    const view = new DataView(buff);

    const un_buff = new ArrayBuffer(5 * 8);
    const un_view = new DataView(un_buff);

    const shopitemHash = Citizen.invokeNative('0x77BA37622E22023B', ped, index, true, view, un_view);

    return shopitemHash
});