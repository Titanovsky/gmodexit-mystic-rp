hook.Add( '[Ambi.Level.AddXP]', 'Ambi.MysticRP.Notify', function( ePly, nXP ) 
    ePly:NotifySend( 1, { text = '+XP '..nXP, type = 31, color_icon_panel = Color(215,70,164), time = 2.5 } )
end )

hook.Add( '[Ambi.Level.SetLevel]', 'Ambi.MysticRP.Notify', function( ePly, nLevel ) 
    ePly:NotifySend( 1, { text = nLevel..' Level', type = 31, color_icon_panel = Color(237,191,53), time = 2.5 } )
end )