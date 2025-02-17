Ambi.General.CreateModule( 'ChatCommands' )

-- ---------------------------------------------------------------------------------------------------------------------------------------
Ambi.ChatCommands.Config.prefix = '/' -- Префикс для чатовых команд
Ambi.ChatCommands.Config.show_commands = false -- Показывать команды в чате после их ввода? (Исключение, если их функция вернёт true, то они в любом случае не покажутся)

-- ---------------------------------------------------------------------------------------------------------------------------------------
Ambi.ChatCommands.Config.url_content    = 'https://steamcommunity.com/sharedfiles/filedetails/?id=2993970091' -- Ссылка после команды /content
Ambi.ChatCommands.Config.url_discord    = 'https://discord.gg/hRquqwPtMp' -- Ссылка после команды /discord
Ambi.ChatCommands.Config.url_steam      = 'https://steamcommunity.com/id/titanovsky/' -- Ссылка после команды /steam
Ambi.ChatCommands.Config.url_vk         = 'https://vk.com/mysticgm' -- Ссылка после команды /vk