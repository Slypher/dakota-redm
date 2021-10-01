## Some COMBAT ATTRIBUTES Flags


## Example

```lua
	Citizen.InvokeNative(0x9F7794730795E019,ped_id,116,true)  -- SET_PED_COMBAT_ATTRIBUTES Set CA_PREFER_DUAL_WIELD enabled;
```

<h2>Some known COMBAT ATTRIBUTES Flags.</h2>

FlagId | COMBAT ATTRIBUTE Action Result
----------- | -------------------------- 
0 | CA_USE_COVER
1 | CA_USE_VEHICLE
2 | CA_DO_DRIVEBYS
3 | CA_LEAVE_VEHICLES
4 | CA_STRAFE_BASED_ON_TARGET_PROXIMITY
5 | CA_ALWAYS_FIGHT
8 | CA_ALLOW_STRAFE_BREAKUP
13 | CA_COVER_SEARCH_IN_ARC_AWAY_FROM_TARGET
14 | CA_CAN_INVESTIGATE
15 | CA_CAN_USE_RADIO
16 | CA_STRAFE_DUE_TO_BULLET_EVENTS
17 | CA_ALWAYS_FLEE
20 | CA_CAN_TAUNT_IN_VEHICLE
21 | CA_CAN_CHASE_TARGET_ON_FOOT
22 | CA_WILL_DRAG_INJURED_PEDS_TO_SAFETY
24 | CA_USE_PROXIMITY_FIRING_RATE
25 | CA_DISABLE_SECONDARY_TARGET
27 | CA_PERFECT_ACCURACY
28 | CA_CAN_USE_FRUSTRATED_ADVANCE
30 | ped can shoot without los
31 | CA_MAINTAIN_MIN_DISTANCE_TO_TARGET
34 | CA_ALLOW_PROJECTILE_SWAPS_AFTER_REPEATED_THROWS
35 | CA_DISABLE_PINNED_DOWN
38 | CA_DISABLE_BULLET_REACTIONS
39 | CA_CAN_BUST
41 | CA_CAN_COMMANDEER_VEHICLES
42 | CA_CAN_FLANK
43 | CA_SWITCH_TO_ADVANCE_IF_CANT_FIND_COVER
44 | CA_SWITCH_TO_DEFENSIVE_IF_IN_COVER
46 | CA_CAN_FIGHT_ARMED_PEDS_WHEN_NOT_ARMED
49 | CA_USE_ENEMY_ACCURACY_SCALING
50 | CA_CAN_CHARGE
52 | CA_USE_VEHICLE_ATTACK
54 | CA_ALWAYS_EQUIP_BEST_WEAPON
55 | CA_CAN_SEE_UNDERWATER_PEDS
58 | CA_DISABLE_FLEE_FROM_COMBAT
60 | CA_CAN_THROW_SMOKE_GRENADE
64 | CA_DISABLE_BLOCK_FROM_PURSUE_DURING_VEHICLE_CHASE
65 | CA_DISABLE_SPIN_OUT_DURING_VEHICLE_CHASE
66 | CA_DISABLE_CRUISE_IN_FRONT_DURING_BLOCK_DURING_VEHICLE_CHASE
68 | CA_DISABLE_REACT_TO_BUDDY_SHOT
71 | CA_PERMIT_CHARGE_BEYOND_DEFENSIVE_AREA
77 | CA_DISABLE_RESPONDED_TO_THREAT_BROADCAST
81 | CA_FORCE_STRAFE
91 | CA_USE_RANGE_BASED_WEAPON_SELECTION
93 | CA_PREFER_MELEE
113 | CA_USE_INFINITE_CLIPS
114 | CA_CAN_EXECUTE_TARGET
115 | CA_DISABLE_RETREAT_DUE_TO_TARGET_PROXIMITY
116 | CA_PREFER_DUAL_WIELD
117 | CA_WILL_CUT_FREE_HOGTIED_PEDS
118 | CA_TRY_TO_FORCE_SURRENDER
120 | if false, ped will not holster their secondary weapon
125 | CA_QUIT_WHEN_TARGET_FLEES_INTERACTION_FIGHT
131 | CA_PREVENT_UNSAFE_PROJECTILE_THROWS
133 | CA_DISABLE_BLANK_SHOTS
