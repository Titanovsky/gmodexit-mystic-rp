Ambi.MysticRP.cases = {
    [ 1 ] = {
        item = 'skull1',
    },
}

local PLAYER = FindMetaTable( 'Player' )

-- ====================================================================================================================================================== --
function Ambi.MysticRP.AddItemInCase( sItem, nCase, nChance )
    if not sItem then return end

    if ( nChance >= 100 ) then return end

    Ambi.MysticRP.cases[ nCase ][ sItem ] = {
        chance = nChance,
    }

    print( '[MysticRP] Added Item in Case ('..nCase..'): '..sItem ) 
end

Ambi.MysticRP.AddItemInCase( 'wep_arccw_ak47', 1, 55 )
Ambi.MysticRP.AddItemInCase( 'skull_money1', 1,  75 )
Ambi.MysticRP.AddItemInCase( 'skull_money2', 1,  45 )
Ambi.MysticRP.AddItemInCase( 'skull_money3', 1,  10 )
Ambi.MysticRP.AddItemInCase( 'skull_xp1', 1,  70 )
Ambi.MysticRP.AddItemInCase( 'skull_xp2', 1,  55 )
Ambi.MysticRP.AddItemInCase( 'skull_xp3', 1,  15 )
Ambi.MysticRP.AddItemInCase( 'skull1', 1,  15 )