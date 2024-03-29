﻿using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using CitizenFX.Core.Native;

namespace RedM.External
{
	public class PlayerList : IEnumerable<Player>
	{
		public const int MaxPlayers = 256;

		public IEnumerator<Player> GetEnumerator()
		{
			var list = (IList<object>)(object)API.GetActivePlayers();

			foreach (var p in list)
			{
				yield return new Player(Convert.ToInt32(p));
			}
		}

		IEnumerator IEnumerable.GetEnumerator()
		{
			return this.GetEnumerator();
		}

		public Player this[int netId] => this.FirstOrDefault(player => player.ServerId == netId);

		public Player this[string name] => this.FirstOrDefault(player => player.Name.Equals(name, StringComparison.InvariantCultureIgnoreCase));
	}
}
