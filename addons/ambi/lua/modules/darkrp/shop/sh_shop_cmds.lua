local C = Ambi.General.Global.Colors

--------------------------------------------------------------------------------------------------------
if not Ambi.ChatCommands then Ambi.General.Error( 'DarkRP', 'Before DarkRP module, need to connect ChatCommands module' ) return end

local Add = Ambi.ChatCommands.AddCommand
local TYPE = 'DarkRP | Shop'

Add( Ambi.DarkRP.Config.shop_buy_command, TYPE, Ambi.DarkRP.Config.shop_buy_description, 1, function( ePly, tArgs ) 
    local class = ''
    for i = 2, #tArgs do
        local word = tArgs[ i ]
        local breakpoint = ( i == #tArgs ) and '' or ' '
        class = class..word..breakpoint
    end

    ePly:BuyShopItem( class )

    return true
end )

Add( Ambi.DarkRP.Config.shop_sell_command, TYPE, Ambi.DarkRP.Config.shop_sell_description, 1, function( ePly, tArgs ) 
    local ent = ePly:GetEyeTrace().Entity
    if not IsValid( ent ) then return end
    if ( ePly:Distance( ent ) > Ambi.DarkRP.Config.shop_sell_distance ) then return end

    ePly:SellShopItem( ent )

    return true
end )