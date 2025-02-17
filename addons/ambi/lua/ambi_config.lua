--[[
    Ambi Eco — платформа (экосистема) для создания проектов в игре Garry's Mod

    Github: https://github.com/Titanovsky/ambi-eco
    Documentation: https://titanovskyteam.gitbook.io/ambi-eco
--]]

-- --------------------------------------------------------------------------------------------------------------------------------------
Ambi.Config.dev = true -- Включить режим разработки?
Ambi.Config.language = 'ru' -- Язык сервера

-- --------------------------------------------------------------------------------------------------------------------------------------
--* Важные
Ambi.ConnectModule( 'net', 'Инструмент разработчика: Заменяет функций' )
Ambi.ConnectModule( 'content-loader', 'Интерфейс по работе с контентом из интернета для клинета' )
Ambi.ConnectModule( 'configurator', 'Простая система изменения конфигов' )
Ambi.ConnectModule( 'base-fonts', 'Регистрация шрифтов из Ambi Fonts и Ambi Fonts Extended' )
Ambi.ConnectModule( 'base-notify', 'Регистрация уведомлений' )
Ambi.ConnectModule( 'base-sounds', 'Регистрация звуков из Ambi Sounds и Ambi Sounds Extended' )
Ambi.ConnectModule( 'dev-panels', 'Инструмент разработчика: Важные менюшки' )

-- --------------------------------------------------------------------------------------------------------------------------------------
--* Желательные
Ambi.ConnectModule( 'chatcommands', 'Система чатовых команд' )
Ambi.ConnectModule( 'multihud', 'Систему подключения/отключения разных худов' )
Ambi.ConnectModule( 'infohud', 'Худ для показа информаций о энтити' )
Ambi.ConnectModule( 'player-freeze', 'Специфичная заморозка игрока' )
Ambi.ConnectModule( 'process', 'Система однопоточных процессов для игроков' )
Ambi.ConnectModule( 'autospawn', 'Система спавна энтитей после загрузки сервера' )
Ambi.ConnectModule( 'disable-render-unfocus', 'Отключения рендера, когда игра свёрнута' )

-- --------------------------------------------------------------------------------------------------------------------------------------
Ambi.ConnectModule( 'darkrp', 'Режим' )
Ambi.ConnectModule( 'darkrp-small-money-printers', 'Денежные принтеры' )
Ambi.ConnectModule( 'image', 'Для показа пикч' )
Ambi.ConnectModule( 'metz', 'Система варки метза' )
Ambi.ConnectModule( 'quest', 'Система квестов' )
Ambi.ConnectModule( 'esp', 'ESP показ 2D меток в 3D пространстве' )
Ambi.ConnectModule( 'kit', 'Система наборов' )
Ambi.ConnectModule( 'date', 'Дата' )
Ambi.ConnectModule( 'level', 'Система уровней' )
Ambi.ConnectModule( 'simple-tab', 'TAB' )
Ambi.ConnectModule( 'whitelist' )
Ambi.ConnectModule( 'inv' )
Ambi.ConnectModule( 'spy' )
Ambi.ConnectModule( 'authorization' )
Ambi.ConnectModule( 'statistic' )
Ambi.ConnectModule( 'business' )
Ambi.ConnectModule( 'quest' )
Ambi.ConnectModule( 'time' )
Ambi.ConnectModule( 'privilege' )
Ambi.ConnectModule( 'skills' )
Ambi.ConnectModule( 'daily' )
Ambi.ConnectModule( 'my-pets' )
Ambi.ConnectModule( 'old-orgs2', 'From PhonexRP (2020)' )
Ambi.ConnectModule( 'rob-obj', 'From PhonexRP (2020)' )
Ambi.ConnectModule( 'duel', 'From PhonexRP (2020)' )
Ambi.ConnectModule( 'crack-door-multigame', 'From PhonexRP (2020)' )

Ambi.ConnectModule( 'mystic-rp', 'Сборка' )