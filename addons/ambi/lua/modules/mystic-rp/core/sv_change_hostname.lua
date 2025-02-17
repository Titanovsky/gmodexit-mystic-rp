hook.Add( 'PostGamemodeLoaded', 'Ambi.MysticRP.RemoveHostnameThink', function() 
    timer.Remove( 'HostnameThink' )
end )

local RANDOM_EMOJI = {
    '🎅🏻', '🎄', '☃️', '❄️'
}

local RANDOM_PHRASES = {
    'VIP, /kit bonus, Набор',
    'Набор',
    'Демоны, Мутанты, Зомби',
    'Демоны, Инквизиция, Культисты',
    'Побеждаем Мунлорда!',
    'Набор, Бесплатный Донат',
}

timer.Create( 'ChangeHostname', 120, 0, function() 
    --local hostname = '🩸 Мистик РП • '..table.Random( RANDOM_PHRASES )

    --RunConsoleCommand( 'hostname', hostname )
    --SetGlobalString( 'ServerName', hostname )
end )