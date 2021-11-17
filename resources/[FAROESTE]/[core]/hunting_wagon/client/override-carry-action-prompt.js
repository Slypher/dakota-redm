function overrideCarryActionPrompt(entity, carryAction, weight, setEnabled)
{
    const buff = new ArrayBuffer(8 * 8);
    const view = new DataView(buff);

    // {
    //     f_0__iCarriableEntity,
    //     f_1__eCarryAction,
    //     f_2__iCarryActionPromptFlags, // 1: disabling stow prompt against a horse
    //     f_6__fWeight,
    // }

    // iCarriableEntity
    view.setInt32(8 * 0, entity, true);

    // eCarryAction >  CARRY_ACTION_TYPE_PLACE_ON_VEHICLE
    view.setInt32(8 * 1, carryAction, true);

    // f_2__iCarryActionPromptFlags
    view.setInt32(8 * 2, (setEnabled == false) ? 1 : 0, true);

    // fWeight
    view.setFloat32(8 * 6, weight ?? 1.0, true);

    Citizen.invokeNative('0xF666EF30F4F0AC4E', view, Citizen.resultAsFloat());
}

exports('overrideCarryActionPrompt', overrideCarryActionPrompt);