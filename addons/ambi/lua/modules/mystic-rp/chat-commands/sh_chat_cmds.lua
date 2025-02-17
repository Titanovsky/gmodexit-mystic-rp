if not Ambi.ChatCommands.AddCommand then return end

local Add = Ambi.ChatCommands.AddCommand

Add( 'promocode', 'MysticRP', 'Показать меню ввода промокода', 1, function( ePly, tArgs ) 
    ePly:SendLua( 'Ambi.Business.Promocode.Show()' )
    
    return true
end )

Add( 'setpromocode', 'MysticRP', 'Создать промокод', 1, function( ePly, tArgs ) 
    if ( ePly:GetLevel() < 4 ) then ePly:ChatSend( '~R~ • ~W~ Промокод создать можно с 4 уровня' ) return end

    local promocode = tArgs[ 2 ]
    if not string.IsValid( promocode ) then ePly:ChatSend( '~R~ • ~W~ Введите свободный промокод!' ) return end

    promocode = string.ForceLower( promocode )
    if ( utf8.len( promocode ) > 10 ) then ePly:ChatSend( '~R~ • ~W~ Промокод нельзя больше 10 символов и желательно на английском!' ) return end

    for k, v in ipairs( Ambi.Business.Promocode.promocodes ) do
        if ( v.code == promocode ) then ePly:ChatSend( '~R~ • ~W~ Промокод '..v.code..' уже создан!' ) return end
        if ( v.steamid == ePly:SteamID() ) then ePly:ChatSend( '~R~ • ~W~ У вас уже есть промокод: '..v.code ) return end
    end

    Ambi.Business.Promocode.Add( promocode, ePly:SteamID() )

    ePly:ChatSend( '~AMBI~ • ~W~ Вы создали свой промокод: ~AMBI~ '..promocode )
    ePly:ChatSend( '~AMBI~ • ~W~ Награда за введёного человека: Повышение уровня, Донат Валюта и +2 дня привилегий' )

    return true
end )

Add( 'orgs2', 'MysticRP', 'Открыть меню организации', 1, function( ePly, tArgs ) 
    ePly:RunCommand( 'ambi_org2_menu' )
    
    return true
end )