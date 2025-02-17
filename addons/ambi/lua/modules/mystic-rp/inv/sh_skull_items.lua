--Ambi.Inv.AddItem( sClass, sName, nStack, sCategory, sDescription, sIcon, fUse, fDrop, tActivity )

local AddItem = Ambi.Inv.AddItem

-- ======================================================================================================
local CATEGORY = 'Skull'
local SPEC_STACK = 10
AddItem( 'skull1', 'Череп', SPEC_STACK, CATEGORY, 'Открыть череп', 'https://icons.iconarchive.com/icons/icons-land/medical/256/Body-Skull-icon.png', function( ePly )
    ePly:OpenSkull( 1 )
    timer.Simple( 0.11, function()
        if not IsValid( ePly ) then return end

        ePly:SendLua( 'if ValidPanel( ambi_mysticrp_f4 ) then ambi_mysticrp_f4:Remove() end' )
    end )

    return false
end )

-- ======================================================================================================
local CATEGORY = 'Skull Items'

AddItem( 'skull_money1', 'Пачка Денег', nil, CATEGORY, 'Можно надеть', 'https://i.ibb.co/QD0sw9s/money-bag1.png', function( ePly )
    ePly:AddMoney( 800 )
    return true
end )

AddItem( 'skull_money2', 'Средняя пачка Денег', nil, CATEGORY, 'Можно надеть', 'https://i.ibb.co/25JQSP3/money-bag2.png', function( ePly )
    ePly:AddMoney( 2500 )
    return true
end )

AddItem( 'skull_money3', 'Большая пачка Денег', nil, CATEGORY, 'Можно надеть', 'https://i.ibb.co/mCh2pbJ/money-bag3.png', function( ePly )
    ePly:AddMoney( 6000 )
    return true
end )

AddItem( 'skull_xp1', '+200 XP', nil, CATEGORY, 'Можно надеть', 'https://i.ibb.co/88K4mpF/xp1.png', function( ePly )
    ePly:AddXP( 200 )
    return true
end )

AddItem( 'skull_xp2', '+800 XP', nil, CATEGORY, 'Можно надеть', 'https://i.ibb.co/FH6vZJz/xp2.png', function( ePly )
    ePly:AddXP( 800 )
    return true
end )

AddItem( 'skull_xp3', '+1500 XP', nil, CATEGORY, 'Можно надеть', 'https://i.ibb.co/CvN0Pjd/xp3.png', function( ePly )
    ePly:AddXP( 1500 )
    return true
end )