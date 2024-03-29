﻿/*
License (MIT)

Copyright 2019 Mooshe
https://github.com/MoosheTV/redm-external

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

using System;
using CitizenFX.Core;
using CitizenFX.Core.Native;

namespace RedM.External
{
    public class Ped : Entity
    {
        public Tasks Tasks { get; }

        public Ped(int handle) : base(handle)
        {
            this.Tasks = new Tasks(this);
        }

        public bool IsPlayer => API.IsPedAPlayer(this.Handle);

        public bool IsSwimming => API.IsPedSwimming(Handle);
        public bool IsSwimmingUnderWater => API.IsPedSwimmingUnderWater(Handle);

        public async void PlayFacialAnimation(string animDict, string animName)
        {
            if (!API.HasAnimDictLoaded(animDict))
                API.RequestAnimDict(animDict);

            int end = API.GetGameTimer() + 1000;

            while (!API.HasAnimDictLoaded(animDict))
            {
                if (API.GetGameTimer() >= end)
                    return;

                await BaseScript.Delay(0);
            }

            API.SetFacialIdleAnimOverride(this.Handle, animName, animDict);
        }
    }

    public enum Gender
    {
        Male,
        Female
    }

    public enum PedCore
    {
        Health = 0,
        Stamina,
        DeadEye
    }

}
