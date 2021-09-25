using System;
using System.Collections.Generic;
using System.Linq;
using SaltyShared;
using CitizenFX.Core;
using CitizenFX.Core.Native;

namespace SaltyServer
{
    public class VoiceManager : BaseScript
    {
        #region Properties / Fields
        public static VoiceManager Instance { get; private set; }

        public bool Enabled { get; private set; }
        public string MinimumPluginVersion { get; private set; }

        public Vector3[] RadioTowers { get; private set; } = new Vector3[0];

        public VoiceClient[] VoiceClients => this._voiceClients.Values.ToArray();
        private Dictionary<Player, VoiceClient> _voiceClients = new Dictionary<Player, VoiceClient>();

        #endregion


        #region Server Events
        [EventHandler("onResourceStart")]
        private void OnResourceStart(string resourceName)
        {
            if (resourceName != API.GetCurrentResourceName())
                return;

            this.Enabled = API.GetResourceMetadata(resourceName, "VoiceEnabled", 0).Equals("true", StringComparison.OrdinalIgnoreCase);

            if (this.Enabled)
            {
                this.MinimumPluginVersion = API.GetResourceMetadata(resourceName, "MinimumPluginVersion", 0);
            }
        }

        [EventHandler("onResourceStop")]
        private void OnResourceStop(string resourceName)
        {
            if (resourceName != API.GetCurrentResourceName())
                return;

            this.Enabled = false;

            lock (this._voiceClients)
            {
                this._voiceClients.Clear();
            }

        }

        [EventHandler("playerDropped")]
        private void OnPlayerDisconnected([FromSource] Player player, string reason)
        {
            if (!this._voiceClients.TryGetValue(player, out VoiceClient client))
                return;

            lock (this._voiceClients)
            {
                this._voiceClients.Remove(player);
            }

            BaseScript.TriggerClientEvent(Event.SaltyChat_RemoveClient, player.Handle);
        }
        #endregion

        #region RemoteEvents (Proximity)

        [EventHandler(Event.SaltyChat_SetVoiceRange)]
        private void OnSetVoiceRange([FromSource] Player player, float voiceRange)
        {
            if (!this._voiceClients.TryGetValue(player, out VoiceClient client))
                return;

            if (Array.IndexOf(SharedData.VoiceRanges, voiceRange) >= 0)
            {
                client.VoiceRange = voiceRange;

                BaseScript.TriggerClientEvent(Event.SaltyChat_UpdateClient, player.Handle, client.TeamSpeakName, client.VoiceRange);
            }
        }
        #endregion

        #region Remote Events (Salty Chat)
        [EventHandler(Event.SaltyChat_Initialize)]
        private void OnInitialize([FromSource] Player player)
        {
            if (!this.Enabled)
                return;

            VoiceClient voiceClient;

            lock (this._voiceClients)
            {
                voiceClient = new VoiceClient(player, this.GetTeamSpeakName(), SharedData.VoiceRanges[1]);
                this._voiceClients.Add(player, voiceClient);
            }

            player.TriggerEvent(Event.SaltyChat_Initialize, voiceClient.TeamSpeakName, this.RadioTowers);

            foreach (VoiceClient client in this._voiceClients.Values.ToArray().Where(c => c.Player != player))
            {
                player.TriggerEvent(Event.SaltyChat_UpdateClient, client.Player.Handle, client.TeamSpeakName, client.VoiceRange);

                client.Player.TriggerEvent(Event.SaltyChat_UpdateClient, player.Handle, voiceClient.TeamSpeakName, voiceClient.VoiceRange);
            }
        }

        [EventHandler(Event.SaltyChat_CheckVersion)]
        private void OnCheckVersion([FromSource] Player player, string version)
        {
            if (!this._voiceClients.TryGetValue(player, out VoiceClient client))
                return;

            if (!this.IsVersionAccepted(version))
            {
                player.Drop($"[Salty Chat] Required Version: {this.MinimumPluginVersion}");
                return;
            }
        }
        #endregion

        #region Methods (Misc)
        public string GetTeamSpeakName()
        {
            string name;

            do
            {
                name = Guid.NewGuid().ToString().Replace("-", "");

                if (name.Length > 30)
                {
                    name = name.Remove(29, name.Length - 30);
                }
            }
            while (this._voiceClients.Values.Any(c => c.TeamSpeakName == name));

            return name;
        }

        public bool IsVersionAccepted(string version)
        {
            if (!String.IsNullOrWhiteSpace(this.MinimumPluginVersion))
            {
                try
                {
                    string[] minimumVersionArray = this.MinimumPluginVersion.Split('.');
                    string[] versionArray = version.Split('.');

                    int lengthCounter = 0;

                    if (versionArray.Length >= minimumVersionArray.Length)
                    {
                        lengthCounter = minimumVersionArray.Length;
                    }
                    else
                    {
                        lengthCounter = versionArray.Length;
                    }

                    for (int i = 0; i < lengthCounter; i++)
                    {
                        int min = Convert.ToInt32(minimumVersionArray[i]);
                        int cur = Convert.ToInt32(versionArray[i]);

                        if (cur > min)
                        {
                            return true;
                        }
                        else if (min > cur)
                        {
                            return false;
                        }
                    }
                }
                catch
                {
                    return false;
                }
            }

            return true;
        }
        #endregion
    }
}
