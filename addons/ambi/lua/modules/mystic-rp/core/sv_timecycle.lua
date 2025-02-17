local SetTime = Ambi.Date.SetTimeEnvironment

hook.Add( '[Ambi.Date.AddedHours]', 'Ambi.MysticRP.TimeCycle', function( nM, nH, nD )
    if ( nH == 4 ) then SetTime( 'SunDown' )
    elseif ( nH == 6 ) then SetTime( 'Day' )
    elseif ( nH == 16 ) then SetTime( 'SunDown' )
    elseif ( nH == 20 ) then SetTime( 'Night' )
    end
end )