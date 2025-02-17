hook.Add( '[Ambi.DarkRP.CanDropWeapon]', 'Ambi.MysticRP.WeaponsToItems', function( ePly, sClass, eWeapon )
    ePly:ChatPrint( 'Временно нельзя!' )
    return false
end )