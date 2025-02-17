Ambi.MysticRP.statistic_player_auth = Ambi.MysticRP.statistic_player_auth or {} 
Ambi.MysticRP.statistic_player_reg = Ambi.MysticRP.statistic_player_reg or {}
Ambi.MysticRP.statistic_player_connect = Ambi.MysticRP.statistic_player_connect or {}

-- --------------------------------------------------------------------------------------------------------------------------------------
timer.Create( 'MysticRP_Log', 60 * 20, 0, function() 
    print( '\n>>' )
    print( '>> На сервере: '..#player.GetHumans()..'/'..game.MaxPlayers() )
    print( '>> '..os.date( '%X', os.time() )..' '..util.GetRussianDate( os.time() ) )
    print( Format( '>> За сессию подключились %i, авторизовались %i, зарегистрировались %i', #Ambi.MysticRP.statistic_player_connect, #Ambi.MysticRP.statistic_player_auth, #Ambi.MysticRP.statistic_player_reg ) )
    print( '>>\n' )
end )

-- --------------------------------------------------------------------------------------------------------------------------------------
hook.Add( 'PlayerConnect', 'Ambi.MysticRP.Statistic', function( _, sIP ) 
    if ( sIP == 'none' ) then return end -- it's bot
    if Ambi.MysticRP.statistic_player_connect[ sIP ] then return end

    Ambi.MysticRP.statistic_player_connect[ #Ambi.MysticRP.statistic_player_connect + 1 ] = sIP
end )

hook.Add( '[Ambi.Authorization.Set]', 'Ambi.MysticRP.Statistic', function( ePly, _, bNewPlayer ) 
    if ePly:IsBot() then return end
    
    local sid = ePly:SteamID()

    if Ambi.MysticRP.statistic_player_auth[ sid ] then return end
    Ambi.MysticRP.statistic_player_auth[ #Ambi.MysticRP.statistic_player_auth + 1 ] = sid

    if bNewPlayer then
        Ambi.MysticRP.statistic_player_reg[ #Ambi.MysticRP.statistic_player_reg + 1 ] = sid
    end
end )