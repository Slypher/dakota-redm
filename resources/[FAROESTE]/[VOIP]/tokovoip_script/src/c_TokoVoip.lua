------------------------------------------------------------
------------------------------------------------------------
---- Author: Dylan 'Itokoyamato' Thuillier              ----
----                                                    ----
---- Email: itokoyamato@hotmail.fr                      ----
----                                                    ----
---- Resource: tokovoip_script                          ----
----                                                    ----
---- File: c_TokoVoip.lua                               ----\
------------------------------------------------------------
------------------------------------------------------------

--------------------------------------------------------------------------------
--	Client: TokoVoip functions
--------------------------------------------------------------------------------

TokoVoip = {};
TokoVoip.__index = TokoVoip;
local lastTalkState = false

function TokoVoip.init(self, config)
	local self = setmetatable(config, TokoVoip);
	self.config = json.decode(json.encode(config));
	self.lastNetworkUpdate = 0;
	self.lastPlayerListUpdate = self.playerListRefreshRate;
	self.playerList = {};
	return (self);
end

function TokoVoip.loop(self)
	Citizen.CreateThread(function()
		while (true) do
			Citizen.Wait(self.refreshRate);
			self:processFunction();
			self:sendDataToTS3();

			self.lastNetworkUpdate = self.lastNetworkUpdate + self.refreshRate;
			self.lastPlayerListUpdate = self.lastPlayerListUpdate + self.refreshRate;
			if (self.lastNetworkUpdate >= self.networkRefreshRate) then
				self.lastNetworkUpdate = 0;
				self:updateTokoVoipInfo();
			end
			if (self.lastPlayerListUpdate >= self.playerListRefreshRate) then
				self.playerList = GetActivePlayers();
				self.lastPlayerListUpdate = 0;
			end
		end
	end);
end

function TokoVoip.sendDataToTS3(self) -- Send usersdata to the Javascript Websocket
	self:updatePlugin("updateTokoVoip", self.plugin_data);
end

function TokoVoip.updateTokoVoipInfo(self, forceUpdate) -- Update the top-left info
	local info = "";
	if (self.mode == 1) then
		info = "Normal";
	elseif (self.mode == 2) then
		info = "Sussurro";
	elseif (self.mode == 3) then
		info = "Gritando";
	end

	if (self.plugin_data.radioTalking) then
		info = info .. " No radio ";
	end
	if (self.talking == 1 or self.plugin_data.radioTalking) then
		info = "<font class='talking'>" .. info .. "</font>";
	end
	
	if (info == self.screenInfo and not forceUpdate) then return end
	self.screenInfo = info;
	self:updatePlugin("updateTokovoipInfo", "" .. info);
end

function TokoVoip.updatePlugin(self, event, payload)
	exports.tokovoip_script:doSendNuiMessage(event, payload);
end

function TokoVoip.updateConfig(self)
	local data = self.config;
	data.plugin_data = self.plugin_data;
	data.pluginVersion = self.pluginVersion;
	data.pluginStatus = self.pluginStatus;
	data.pluginUUID = self.pluginUUID;
	self:updatePlugin("updateConfig", data);
end

function TokoVoip.initialize(self)
	self:updateConfig();
	self:updatePlugin("initializeSocket", nil);
	Citizen.CreateThread(function()
		while (true) do
			Citizen.Wait(5);

			if (IsControlJustPressed(0, self.keyProximity)) then -- Switch proximity modes (normal / whisper / shout)
				if (not self.mode) then
					self.mode = 1;
				end
				self.mode = self.mode + 1;
				if (self.mode > 3) then
					self.mode = 1;
				end
				setPlayerData(self.serverId, "voip:mode", self.mode, true);
				self:updateTokoVoipInfo();
			end



			if (IsControlPressed(0, self.radioKey) and self.plugin_data.radioChannel ~= -1) then -- Talk on radio
				self.plugin_data.radioTalking = true;
				self.plugin_data.localRadioClicks = true;
				if (self.plugin_data.radioChannel > 1035) then
					self.plugin_data.localRadioClicks = false;
				end
				if (not getPlayerData(self.serverId, "radio:talking")) then
					setPlayerData(self.serverId, "radio:talking", true, true);
				end
				self:updateTokoVoipInfo();
				if (lastTalkState == false and self.myChannels[self.plugin_data.radioChannel] and self.config.radioAnim) then
                    if (not string.match(self.myChannels[self.plugin_data.radioChannel].name, "Call") and not IsPedSittingInAnyVehicle(PlayerPedId())) then
                        RequestAnimDict("random@arrests");
                        while not HasAnimDictLoaded("random@arrests") do
                            Wait(5);
                        end
                        TaskPlayAnim(PlayerPedId(),"random@arrests","generic_radio_chatter", 8.0, 0.0, -1, 49, 0, 0, 0, 0);
                        local coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(),0.0,0.0,-5.0)
                        object = CreateObject(GetHashKey('prop_cs_hand_radio'),coords.x,coords.y,coords.z,true,true,true)
                        SetEntityCollision(object,false,false)
                        AttachEntityToEntity(object,PlayerPedId(),GetPedBoneIndex(PlayerPedId(),60309),0.06,0.05,0.03,-90.0,30.0,0.0,false,false,false,false,2,true)
                    end
                    lastTalkState = true
                end
            else
                self.plugin_data.radioTalking = false;
                if (getPlayerData(self.serverId, "radio:talking")) then
                    setPlayerData(self.serverId, "radio:talking", false, true);
                end
                self:updateTokoVoipInfo();
                
                if lastTalkState == true and self.config.radioAnim then
                    lastTalkState = false
                    StopAnimTask(PlayerPedId(), "random@arrests","generic_radio_chatter", -4.0);
                    if DoesEntityExist(object) then
                        TriggerServerEvent("trydeleteobj",ObjToNet(object))
                        object = nil
                    end
                end
            end
        end
    end);
end

function TokoVoip.disconnect(self)
	self:updatePlugin("disconnect");
end


