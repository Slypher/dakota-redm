DiscordWebhookSystemInfos = 'https://discord.com/api/webhooks/872569454142308353/Yf1XUXU4Dev5a_5GCKl4-QU3yHdGYlmqo7KUcuBNABtCJXJdu5mCTdiqN9E2EYH3XgHO'
DiscordWebhookKillinglogs = 'https://discord.com/api/webhooks/872569454142308353/Yf1XUXU4Dev5a_5GCKl4-QU3yHdGYlmqo7KUcuBNABtCJXJdu5mCTdiqN9E2EYH3XgHO'
DiscordWebhookChat = 'https://discord.com/api/webhooks/872569454142308353/Yf1XUXU4Dev5a_5GCKl4-QU3yHdGYlmqo7KUcuBNABtCJXJdu5mCTdiqN9E2EYH3XgHO'

SystemAvatar = 'https://i.imgur.com/4YQOBlC.png'

UserAvatar = 'https://i.imgur.com/4YQOBlC.png'

SystemName = 'LogBot'

--[[ Special Commands formatting
		 *YOUR_TEXT*			--> Make Text Italics in Discord
		**YOUR_TEXT**			--> Make Text Bold in Discord
	   ***YOUR_TEXT***			--> Make Text Italics & Bold in Discord
		__YOUR_TEXT__			--> Underline Text in Discord
	   __*YOUR_TEXT*__			--> Underline Text and make it Italics in Discord
	  __**YOUR_TEXT**__			--> Underline Text and make it Bold in Discord
	 __***YOUR_TEXT***__		--> Underline Text and make it Italics & Bold in Discord
		~~YOUR_TEXT~~			--> Strikethrough Text in Discord
]]
-- Use 'USERNAME_NEEDED_HERE' without the quotes if you need a Users Name in a special command
-- Use 'USERID_NEEDED_HERE' without the quotes if you need a Users ID in a special command


-- These special commands will be printed differently in discord, depending on what you set it to
SpecialCommands = {
				   {'/112', '**[112]:**'},
				   {'/god', '**[GOD]:**'},
				   {'/190', '**[911]: (CALLER ID: [ USERNAME_NEEDED_HERE | USERID_NEEDED_HERE ])**'},
				  }

						
-- These blacklisted commands will not be printed in discord
BlacklistedCommands = {
					   '/AnyCommand',
					   '/AnyCommand2',
					  }

-- These Commands will use their own webhook
OwnWebhookCommands = {
					  {'/190', 'https://discord.com/api/webhooks/784999621951881226/7X4riDABQDEPRkRbhDzPDPN61ptYrp_c--IxUtqWm9xUjuki6GFKtQLgcntJLxYtLdet'},
					  {'/192', 'https://discord.com/api/webhooks/784999621951881226/7X4riDABQDEPRkRbhDzPDPN61ptYrp_c--IxUtqWm9xUjuki6GFKtQLgcntJLxYtLdet'},
					  {'/god', 'https://discord.com/api/webhooks/784999621951881226/7X4riDABQDEPRkRbhDzPDPN61ptYrp_c--IxUtqWm9xUjuki6GFKtQLgcntJLxYtLdet'},
					 }

-- These Commands will be sent as TTS messages
TTSCommands = {
			   '/Whatever',
			   '/Whatever2',
			  }

