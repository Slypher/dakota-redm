using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CitizenFX.Core;
using CitizenFX.Core.Native;
using RedM.External;
using SaltyShared;

namespace SaltyClient
{
    internal class VoiceManager : BaseScript
    {
        #region Properties / Fields
        public bool IsEnabled { get; private set; }
        public bool IsConnected { get; private set; }
        public bool IsIngame { get; private set; }
        public bool IsNuiReady { get; private set; }

        public string TeamSpeakName { get; private set; }
        public string ServerUniqueIdentifier { get; private set; }
        public string SoundPack { get; private set; }
        public ulong IngameChannel { get; private set; }
        public string IngameChannelPassword { get; private set; }
        public ulong[] SwissChannelIds { get; private set; } = new ulong[0];

        public static float TestVolume = 0.9f;
        public VoiceClient[] VoiceClients => this._voiceClients.Values.ToArray();
        private Dictionary<int, VoiceClient> _voiceClients = new Dictionary<int, VoiceClient>();

        public Vector3[] RadioTowers { get; private set; }

        public string WebSocketAddress { get; private set; } = "lh.saltmine.de:38088";
        public float VoiceRange { get; private set; } = SharedData.VoiceRanges[1];

        public PlayerList PlayerList { get; } = new PlayerList();

        public bool IsTalking { get; private set; }
        public bool IsMicrophoneMuted { get; private set; }
        public bool IsMicrophoneEnabled { get; private set; }
        public bool IsSoundMuted { get; private set; }
        public bool IsSoundEnabled { get; private set; }
        #endregion

        #region CTOR
        public VoiceManager()
        {
            API.RegisterNuiCallbackType(NuiEvent.SaltyChat_OnConnected);
            API.RegisterNuiCallbackType(NuiEvent.SaltyChat_OnDisconnected);
            API.RegisterNuiCallbackType(NuiEvent.SaltyChat_OnError);
            API.RegisterNuiCallbackType(NuiEvent.SaltyChat_OnMessage);
            API.RegisterNuiCallbackType(NuiEvent.SaltyChat_OnNuiReady);
        }
        #endregion

        #region Events
        [EventHandler("onClientResourceStop")]
        private void OnResourceStop(string resourceName)
        {
            if (resourceName != API.GetCurrentResourceName())
                return;

            this.IsEnabled = false;
            this.IsConnected = false;

            lock (this._voiceClients)
            {
                this._voiceClients.Clear();
            }

        }
        #endregion

        #region Remote Events (Handling)
        [EventHandler(Event.SaltyChat_Initialize)]
        private void OnInitialize(string teamSpeakName, dynamic towers)
        {
            this.TeamSpeakName = teamSpeakName;

            this.IsEnabled = true;

            if (this.IsConnected)
                this.InitializePlugin();
            else if (this.IsNuiReady)
                this.ExecuteCommand("connect", this.WebSocketAddress);
            else
                Debug.WriteLine("[Salty Chat] Got server response, but NUI wasn't ready");

            //VoiceManager.DisplayDebug(true);
        }

        [EventHandler(Event.SaltyChat_UpdateClient)]
        private void OnClientUpdate(string handle, string teamSpeakName, float voiceRange)
        {
            if (!Int32.TryParse(handle, out int serverId))
                return;

            if (Game.Player.ServerId == serverId)
                return;

            lock (this._voiceClients)
            {
                if (this._voiceClients.TryGetValue(serverId, out VoiceClient client))
                {
                    client.TeamSpeakName = teamSpeakName;
                    client.VoiceRange = voiceRange;
                }
                else
                {
                    this._voiceClients.Add(serverId, new VoiceClient(serverId, this.PlayerList[serverId], teamSpeakName, voiceRange));
                }
            }
        }

        [EventHandler(Event.SaltyChat_RemoveClient)]
        private void OnClientRemove(string handle)
        {
            if (!Int32.TryParse(handle, out int serverId))
                return;

            lock (this._voiceClients)
            {
                if (this._voiceClients.TryGetValue(serverId, out VoiceClient client))
                {
                    this.ExecuteCommand(new PluginCommand(Command.RemovePlayer, this.ServerUniqueIdentifier, new PlayerState(client.TeamSpeakName)));

                    this._voiceClients.Remove(serverId);
                }
            }
        }
        #endregion

        #region NUI Events
        [EventHandler("__cfx_nui:" + NuiEvent.SaltyChat_OnNuiReady)]
        private void OnNuiReady(dynamic dummy, dynamic cb)
        {
            this.IsNuiReady = true;

            if (this.IsEnabled && this.TeamSpeakName != null && !this.IsConnected)
            {
                Debug.WriteLine("[Salty Chat] NUI is now ready, connecting...");

                this.ExecuteCommand("connect", this.WebSocketAddress);
            }

            cb("");
        }

        [EventHandler("__cfx_nui:" + NuiEvent.SaltyChat_OnConnected)]
        private void OnConnected(dynamic dummy, dynamic cb)
        {
            this.IsConnected = true;

            if (this.IsEnabled)
                this.InitializePlugin();

            cb("");
        }

        [EventHandler("__cfx_nui:" + NuiEvent.SaltyChat_OnDisconnected)]
        private void OnDisconnected(dynamic dummy, dynamic cb)
        {
            this.IsConnected = false;

            cb("");
        }

        [EventHandler("__cfx_nui:" + NuiEvent.SaltyChat_OnMessage)]
        private void OnMessage(dynamic message, dynamic cb)
        {
            cb("");

            PluginCommand pluginCommand = PluginCommand.Deserialize(message);

            if (pluginCommand.ServerUniqueIdentifier != this.ServerUniqueIdentifier)
                return;

            switch (pluginCommand.Command)
            {
                case Command.PluginState:
                    {
                        if (pluginCommand.TryGetPayload(out PluginState pluginState))
                        {
                            BaseScript.TriggerServerEvent(Event.SaltyChat_CheckVersion, pluginState.Version);

                            this.ExecuteCommand(
                                new PluginCommand(
                                    Command.RadioTowerUpdate,
                                    this.ServerUniqueIdentifier,
                                    new RadioTower(this.RadioTowers)
                                )
                            );
                        }

                        break;
                    }
                case Command.Reset:
                    {
                        this.IsIngame = false;

                        this.InitializePlugin();

                        break;
                    }
                case Command.Ping:
                    {
                        this.ExecuteCommand(new PluginCommand(this.ServerUniqueIdentifier));

                        break;
                    }
                case Command.InstanceState:
                    {
                        if (pluginCommand.TryGetPayload(out InstanceState instanceState))
                        {
                            this.IsIngame = instanceState.IsReady;
                        }

                        break;
                    }
                case Command.SoundState:
                    {
                        if (pluginCommand.TryGetPayload(out SoundState soundState))
                        {
                            if (soundState.IsMicrophoneMuted != this.IsMicrophoneMuted)
                            {
                                this.IsMicrophoneMuted = soundState.IsMicrophoneMuted;

                                BaseScript.TriggerEvent(Event.SaltyChat_MicStateChanged, this.IsMicrophoneMuted);
                            }

                            if (soundState.IsMicrophoneEnabled != this.IsMicrophoneEnabled)
                            {
                                this.IsMicrophoneEnabled = soundState.IsMicrophoneEnabled;

                                BaseScript.TriggerEvent(Event.SaltyChat_MicEnabledChanged, this.IsMicrophoneEnabled);
                            }

                            if (soundState.IsSoundMuted != this.IsSoundMuted)
                            {
                                this.IsSoundMuted = soundState.IsSoundMuted;

                                BaseScript.TriggerEvent(Event.SaltyChat_SoundStateChanged, this.IsSoundMuted);
                            }

                            if (soundState.IsSoundEnabled != this.IsSoundEnabled)
                            {
                                this.IsSoundEnabled = soundState.IsSoundEnabled;

                                BaseScript.TriggerEvent(Event.SaltyChat_SoundEnabledChanged, this.IsSoundEnabled);
                            }
                        }

                        break;
                    }
                case Command.TalkState:
                    {
                        if (pluginCommand.TryGetPayload(out TalkState talkState))
                            this.SetPlayerTalking(talkState.Name, talkState.IsTalking);

                        break;
                    }
            }
        }

        [EventHandler("__cfx_nui:" + NuiEvent.SaltyChat_OnError)]
        private void OnError(dynamic message, dynamic cb)
        {
            try
            {
                PluginError pluginError = PluginError.Deserialize(message);

                switch (pluginError.Error)
                {
                    case Error.AlreadyInGame:
                        {
                            Debug.WriteLine($"[Salty Chat] Error: Seems like we are already in an instance, retry...");

                            this.InitializePlugin();

                            break;
                        }
                    default:
                        {
                            Debug.WriteLine($"[Salty Chat] Error: {pluginError.Error} - Message: {pluginError.Message}");

                            break;
                        }
                }
            }
            catch (Exception e)
            {
                Debug.WriteLine($"[Salty Chat] Error: We received an error, but couldn't deserialize it:{Environment.NewLine}{e.ToString()}");
            }

            cb("");
        }
        #endregion

        #region Tick
        [Tick]
        private async Task FirstTick()
        {
            string resourceName = API.GetCurrentResourceName();

            this.ServerUniqueIdentifier = API.GetResourceMetadata(resourceName, "ServerUniqueIdentifier", 0);
            this.SoundPack = API.GetResourceMetadata(resourceName, "SoundPack", 0);
            this.IngameChannel = UInt64.Parse(API.GetResourceMetadata(resourceName, "IngameChannelId", 0));
            this.IngameChannelPassword = API.GetResourceMetadata(resourceName, "IngameChannelPassword", 0);

            string swissChannelIds = API.GetResourceMetadata(resourceName, "SwissChannelIds", 0);

            if (!String.IsNullOrEmpty(swissChannelIds))
            {
                this.SwissChannelIds = swissChannelIds.Split(',').Select(s => UInt64.Parse(s.Trim())).ToArray();
            }

            BaseScript.TriggerServerEvent(Event.SaltyChat_Initialize);

            this.Tick -= this.FirstTick;

            await Task.FromResult(0);
        }

        [Tick]
        private async Task OnControlTick()
        {


            if (!(this.IsConnected && this.IsIngame))
            {
                Function.Call<long>((Hash)0x405224591DF02025, 0.50, 0.50, 4.0, 4.0, 0, 0, 0, 255, true, true);
                long text = Function.Call<long>((Hash)0xFA925AC00EB830B9, 10, "LITERAL_STRING", "Teamspeak / Saltychat not running!");
                long textIP = Function.Call<long>((Hash)0xFA925AC00EB830B9, 10, "LITERAL_STRING", "TS3 IP: fox.serverbb.net:9126");
                long textDescription = Function.Call<long>((Hash)0xFA925AC00EB830B9, 10, "LITERAL_STRING", "For more information, visit our Discord!\n https://discord.com/invite/vEjyZRmzX3");
                API.SetTextColor(204, 0, 0, 255);
                API.SetTextCentre(true);
                API.SetTextScale(1.5F, 1.5F);
                Function.Call((Hash)0xADA9255D, 1);
                API.DisplayText(text, 0.5F, 0.4F);
                API.SetTextColor(204, 0, 0, 255);
                API.SetTextCentre(true);
                API.SetTextScale(1.0F, 1.0F);
                Function.Call((Hash)0xADA9255D, 1);
                API.DisplayText(textIP, 0.5F, 0.5F);
                API.SetTextColor(204, 0, 0, 255);
                API.SetTextCentre(true);
                API.SetTextScale(0.7F, 0.7F);
                Function.Call((Hash)0xADA9255D, 1);
                API.DisplayText(textDescription, 0.5F, 0.6F);

            }
            if (Game.IsControlJustPressed(0, Control.InteractOption1))
            {
                this.ToggleVoiceRange();
            }

            await Task.FromResult(0);
        }

        [Tick]
        private async Task OnStateUpdateTick()
        {
            if (this.IsConnected && this.IsIngame)
            {
                List<PlayerState> playerStates = new List<PlayerState>();

                Vector3 playerPosition = Game.PlayerPed.Position;

                foreach (VoiceClient client in this.VoiceClients)
                {
                    if (client.Player == null)
                    {
                        client.Player = this.PlayerList[client.ServerId];

                        if (client.Player == null)
                            continue;
                    }

                    Ped ped = client.Player.Character;

                    if (!ped.Exists())
                        continue;

                    float Dist = API.Vdist(playerPosition.X, playerPosition.Y, playerPosition.Z, ped.Position.X, ped.Position.Y, ped.Position.Z);

                    TestVolume = 0.90f - Dist / client.VoiceRange;

                    playerStates.Add(
                        new PlayerState(
                            client.TeamSpeakName,
                            ped.Position,
                            client.VoiceRange,
                            true,
                            TestVolume
                        )
                    );
                    await BaseScript.Delay(1);
                }

                this.ExecuteCommand(
                    new PluginCommand(
                        Command.BulkUpdate,
                        this.ServerUniqueIdentifier,
                        new BulkUpdate(
                            playerStates,
                            new SelfState(
                                playerPosition,
                                API.GetGameplayCamRot(0).Z
                            )
                        )
                    )
                );
            }

            await BaseScript.Delay(70);
        }
        #endregion

        #region Methods (Proximity)
        private void SetPlayerTalking(string teamSpeakName, bool isTalking)
        {
            Ped playerPed = null;
            VoiceClient voiceClient = this.VoiceClients.FirstOrDefault(v => v.TeamSpeakName == teamSpeakName);

            if (voiceClient != null)
            {
                playerPed = voiceClient.Player?.Character;
            }
            else if (teamSpeakName == this.TeamSpeakName)
            {
                playerPed = Game.PlayerPed;
                API.SendNuiMessage(
                    Newtonsoft.Json.JsonConvert.SerializeObject(new { Talking = isTalking })
                 );
                BaseScript.TriggerEvent(Event.SaltyChat_TalkStateChanged, isTalking);
            }

            if (playerPed != null)
            {
                //API.SetPlayerTalkingOverride(playerPed.Handle, isTalking);
              
                if (isTalking)
                    _ = playerPed.Tasks.PlayFacialAnimation("face_human@gen_male@base", "mood_talking_normal");
                else
                    _ = playerPed.Tasks.PlayFacialAnimation("face_human@gen_male@base", "mood_normal");
            }
        }

        /// <summary>
        /// Toggles voice range through <see cref="SharedData.VoiceRanges"/>
        /// </summary>
        public void ToggleVoiceRange()
        {
            int index = Array.IndexOf(SharedData.VoiceRanges, this.VoiceRange);

            if (index < 0)
            {
                this.VoiceRange = SharedData.VoiceRanges[1];
            }
            else if (index + 1 >= SharedData.VoiceRanges.Length)
            {
                this.VoiceRange = SharedData.VoiceRanges[0];
            }
            else
            {
                this.VoiceRange = SharedData.VoiceRanges[index + 1];
            }

            BaseScript.TriggerServerEvent(Event.SaltyChat_SetVoiceRange, this.VoiceRange);

            // ToDo
            //CitizenFX.Core.UI.Screen.ShowNotification($"New voice range is {VoiceManager._voiceRange} metres.");

            System.Drawing.Color color = System.Drawing.Color.FromArgb(255, 255, 255);

            string test = "Voice Distance" + this.VoiceRange + " meters";
            API.SendNuiMessage(
                Newtonsoft.Json.JsonConvert.SerializeObject(new { Range = test })
            );

            BaseScript.TriggerEvent("pNotify:SendNotification", new
            {
                text = new[] { "Distance changed to " + this.VoiceRange + " meters" },
                type = new[] { "success" },
                timeout = new[] { 2000 },
                layout = new[] { "centerLeft" },
                queue = new[] { "left" }

            });
        }
        #endregion

        #region Methods (Plugin)
        private void InitializePlugin()
        {
            this.ExecuteCommand(
                new PluginCommand(
                    Command.Initiate,
                    new GameInstance(
                        this.ServerUniqueIdentifier,
                        this.TeamSpeakName,
                        this.IngameChannel,
                        this.IngameChannelPassword,
                        this.SoundPack,
                        this.SwissChannelIds
                    )
                )
            );
        }

        /// <summary>
        /// Plays a file from soundpack specified in <see cref="VoiceManager._soundPack"/>
        /// </summary>
        /// <param name="fileName">filename (without .wav) of the soundfile</param>
        /// <param name="loop">use <see cref="true"/> to let the plugin loop the sound</param>
        /// <param name="handle">use your own handle instead of the filename, so you can play the sound multiple times</param>
        public void PlaySound(string fileName, bool loop = false, string handle = null)
        {
            if (String.IsNullOrWhiteSpace(handle))
                handle = fileName;

            this.ExecuteCommand(
                new PluginCommand(
                    Command.PlaySound,
                    this.ServerUniqueIdentifier,
                    new Sound(
                        fileName,
                        loop,
                        handle
                    )
                )
            );
        }

        /// <summary>
        /// Stops and dispose the sound
        /// </summary>
        /// <param name="handle">filename or handle of the sound</param>
        public void StopSound(string handle)
        {
            this.ExecuteCommand(
                new PluginCommand(
                    Command.StopSound,
                    this.ServerUniqueIdentifier,
                    new Sound(handle)
                )
            );
        }

        private void ExecuteCommand(string funtion, object parameters)
        {
            API.SendNuiMessage(
                Newtonsoft.Json.JsonConvert.SerializeObject(new { Function = funtion, Params = parameters })
            );
        }

        private void ExecuteCommand(PluginCommand pluginCommand)
        {
            this.ExecuteCommand("runCommand", Util.ToJson(pluginCommand));
        }

        private void DisplayDebug(bool show)
        {
            this.ExecuteCommand("showBody", show);
        }
        #endregion
    }
}
