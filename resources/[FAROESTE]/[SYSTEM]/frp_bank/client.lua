local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

cAPI = Proxy.getInterface("API")
API = Tunnel.getInterface("API")

local displayBankBlips = true
local enableBankingGui = true -- Enables the banking GUI (Default: true) // MAY HAVE SOME ISSUES

-- Banks

Banks = {
  vector3(-308.430,776.006,118.702), -- BANK VALENTINE
  --vector3(-304.904,775.167,118.703), -- BANK VALENTINE
  vector3(-813.216,-1277.524,43.638), -- BANK BLACKWATER
  --vector3(-810.629,-1277.514,43.638), -- BANK BLACKWATER
  --vector3(1289.908,-1300.885,77.036), -- BANK RHODES
  vector3(1292.454,-1301.678,77.040), -- BANK RHODES
  vector3(2644.046,-1292.640,52.245), -- BANK SAINTDENNIS
  vector3(-3666.139,-2626.632,-13.579) -- BANK ARMADILLO
}

keys = {
  ["G"] = 0x760A9C6F,
  ["S"] = 0xD27782E3,
  ["W"] = 0x8FD015D8,
  ["H"] = 0x24978A28,
  ["G"] = 0x5415BE48,
  ["E"] = 0xDFF812F9,
  ["ALT"] = 0xE8342FF2
}

Citizen.CreateThread(
  function()
    while true do
      Citizen.Wait(0)
      local playerPed = PlayerPedId()
      local coords = GetEntityCoords(playerPed)
      for k, v in pairs(Banks) do
        if Vdist(coords, v) < 1 then
          -- local hashUnarmed = GetHashKey("WEAPON_UNARMED")

          -- local retval, weaponHash = GetCurrentPedWeapon(PlayerPedId(), 1)

          -- print(weaponHash, hashUnarmed)
          if weaponHash == hashUnarmed then
            DrawTxt("Aperte (ALT) para acessar seu cofre", 0.85, 0.95, 0.4, 0.4, true, 255, 255, 255, 255, true, 10000)
            if IsControlJustPressed(0, 0xE8342FF2) then
              if not cAPI.IsWanted() then
                inMenu = true
                SetNuiFocus(true, true)
                SendNUIMessage({type = "openGeneral"})
                TriggerServerEvent("FRP:BANKING:balance2")
              else
                TriggerEvent('FRP:NOTIFY:Simple', 'Você ainda está como procurado, não pode acessar seu banco. ', 10000)
              end
            end
          end
        end
      end
    end
  end
)

function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
  local str = CreateVarString(10, "LITERAL_STRING", str, Citizen.ResultAsLong())
  SetTextScale(w, h)
  SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
  SetTextCentre(centre)
  if enableShadow then
    SetTextDropshadow(1, 0, 0, 0, 255)
  end
  Citizen.InvokeNative(0xADA9255D, 10)
  DisplayText(str, x, y)
end

-- RegisterCommand('bank', function(source)
-- 			inMenu = true
-- 			SetNuiFocus(true, true)
-- 			SendNUIMessage({type = 'openGeneral'})
-- 			TriggerServerEvent('FRP:BANKING:balance2')
-- end)

RegisterNetEvent("FRP:BANKING:sendmoney")
AddEventHandler(
  "FRP:BANKING:sendmoney",
  function(player, amount, nome)
    local playeri = player
    local _amount = amount
    local player, distance = GetClosestPlayer()
    local jogadornome = nome

    if distance ~= -1 and distance <= 3.0 then
      TriggerServerEvent("FRP:BANKING:recmoney", GetPlayerServerId(player), amount, jogadornome)
    else
      TriggerEvent("chatMessage", "^1SISTEMA", {255, 255, 255}, "Ninguem por perto")
    end
  end
)

-- Open Gui and Focus NUI
function openGui()
  inMenu = true
  SetNuiFocus(true, true)
  SendNUIMessage({type = "openGeneral"})
  TriggerServerEvent("FRP:BANKING:balance2")
  bankOpen = true
end

-- Close Gui and disable NUI
function closeGui()
  inMenu = false
  SetNuiFocus(false, false)
  bankOpen = false
  SendNUIMessage({type = "closeAll"})
end

-- Process give cash if conditions met
RegisterNetEvent("bank:givecash")
AddEventHandler(
  "bank:givecash",
  function(toPlayer, amount)
    if (IsNearPlayer(toPlayer) == true or giveCashAnywhere == true) then
      local player2 = GetPlayerFromServerId(toPlayer)
      local playing = IsPlayerPlaying(player2)
      if (playing ~= false) then
        TriggerServerEvent("bank:givecash", toPlayer, tonumber(amount))
      else
        TriggerEvent("chatMessage", "", {255, 0, 0}, "^1~Jogador não encontrado.")
      end
    else
      TriggerEvent("chatMessage", "", {255, 0, 0}, "^1Você não está perto dessa pessoa!")
    end
  end
)

--=================Deposit Event===================
local l_
local f_
RegisterNetEvent("currentbalance1")
AddEventHandler(
  "currentbalance1",
  function(balance, name)
    if name ~= nil then
      local playerName = name
    end
    SendNUIMessage(
      {
        type = "balanceHUD",
        balance = balance,
        player = playerName
      }
    )
  end
)

--=================Deposit Event======================

RegisterNUICallback(
  "deposit",
  function(data)
    local amount = tonumber(data.amount)
    if amount ~= nil then
      TriggerServerEvent("FRP:BANKING:deposit", amount)
    end
  end
)

--==================Withdraw Event====================

RegisterNUICallback(
  "withdrawl",
  function(data)
    local amountw = tonumber(data.amountw)
    if amountw ~= nil then
      TriggerServerEvent("FRP:BANKING:withdraw", amountw)
    end
  end
)

--======================Balance Event======================

RegisterNUICallback(
  "balance",
  function()
    TriggerServerEvent("FRP:BANKING:balance")
  end
)

--======================NUIFocusoff======================

RegisterNUICallback(
  "NUIFocusOff",
  function()
    inMenu = false
    SetNuiFocus(false, false)
    SendNUIMessage({type = "closeAll"})
  end
)
