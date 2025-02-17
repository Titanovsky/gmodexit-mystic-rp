local net_get_items = net.AddString( 'ambi_sinv_loot_get_items' )
local net_open = net.AddString( 'ambi_sinv_loot_open' )

function Ambi.SimpleInventory.SetLoot( ePly, eObj )
    if not eObj.items then return end
    if ( #eObj.items == 0 ) then return end

    ePly.loot_items = eObj.items

    net.Start( net_get_items )
        net.WriteTable( eObj.items )
        net.WriteEntity( eObj )
    net.Send( ePly )
end

local net_take = net.AddString( 'ambi_sinv_loot_take' )
net.Receive( net_take, function( nLen, ePly )
    local count = net.ReadUInt( 20 )
    local slot = net.ReadUInt( 20 )
    local ent = net.ReadEntity()

    if not IsValid( ent ) or not ent.items then return end
    if ( ent.items ~= ePly.loot_items ) then return end
    -- todo: check distance between ePly and ent

    local item = ent.items[ slot ]
    if not item then return end
    if ( count > item.count ) then return end
    
    if ePly:GetItem( item.class ) then
        local player_count = ePly:GetItem( item.class ).count -- 9999
        local result = count + player_count -- 2 + 9999 = 10001
        
        if ( result >= Ambi.SimpleInventory.Config.max_count_item ) then
            local remains = result - Ambi.SimpleInventory.Config.max_count_item

            ent.items[ slot ].count = remains
        else
            local result = ent.items[ slot ].count - count
            if ( result <= 0 ) then 
                ent.items[ slot ] = {}
            else
                ent.items[ slot ].count = result
            end
        end
        
        ePly:AddItem( item.class, count, true )
    else
        if not ePly:GetLastFreeSlot() then return end

        ePly:AddItem( item.class, count, true )

        if ( count == item.count ) then
            ent.items[ slot ] = {}
        else
            ent.items[ slot ].count = item.count - count
        end
    end

    Ambi.SimpleInventory.SetLoot( ePly, ent )

    -- if all items are empty
    for slot, item in ipairs( ent.items ) do
        if item.class then return end
    end

    ent:Remove()
end )

local net_close = net.AddString( 'ambi_sinv_loot_close' )
net.Receive( net_close, function( nLen, ePly )
    local loot = net.ReadEntity()
    if not IsValid( loot ) then return end
    if not loot.player or ( ePly ~= loot.player ) then return end

    loot.player = nil
    ePly.loot_items = nil

    -- if all items are empty
    for slot, item in ipairs( loot.items ) do
        if item.class then return end
    end

    loot:Remove()
end )