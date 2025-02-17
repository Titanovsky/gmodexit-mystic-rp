--Ambi.Inv.AddItem( sClass, sName, nStack, sCategory, sDescription, sIcon, fUse, fDrop, tActivity )

local AddItem = Ambi.Inv.AddItem

local function GiveWeapon( ePly, sClass )
    --if ePly:HasWeapon( sClass ) then return false end

    ePly:Give( sClass, true )
    ePly:ChatSend( '~G~ [Inv] ~W~ Вы взяли ~G~ '..sClass )

    return true
end

local STACK = 128


local CATEGORY = 'Ресурсы'
local SPEC_STACK = 1000
AddItem( 'wood', 'Дерево', SPEC_STACK, CATEGORY, 'Обычный ресурс', 'https://i.ibb.co/py1vKgw/wood.png' )
AddItem( 'stone', 'Камень', SPEC_STACK, CATEGORY, 'Обычный ресурс такой же', 'models/props_junk/rock001a.mdl' )

-- ======================================================================================================
local CATEGORY = 'Одежда'
local SPEC_STACK = 1
AddItem( 'skin_male2', 'Скин: Male 2', SPEC_STACK, CATEGORY, 'Можно надеть', 'https://i.ibb.co/k36jfb2/male2.png', function( ePly )
    ePly:ChatPrint( 'Вы надели на себя чекушку!' )
    return false
end )