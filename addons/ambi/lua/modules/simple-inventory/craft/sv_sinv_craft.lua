local Player = FindMetaTable( 'Player' )

function Player:CraftItem( sCraft, nCount )
    if Ambi.SimpleInventory.Config.craft_equal_process and self:IsProcess() then return end

    sCraft = tostring( sCraft )

    local craft = Ambi.SimpleInventory.crafting[ sCraft ]
    if not craft then return end

    local can = self:CanCraft( sCraft, nCount )
    if not can then return end

    nCount = nCount or 1
    nCount = math.floor( nCount )

    local function Callback( ePly )
        if not ePly:CanCraft( sCraft, nCount ) then ePly:ChatPrint( 'Крафт не удался!' ) return end

        for class, count in pairs( craft.items ) do
            for slot, item in ipairs( ePly:GetItems() ) do
                if ( class == item.class ) and ( item.count >= count * nCount ) then
                    ePly:SetItem( slot, item.class, ePly:GetItem( item.class ).count - count * nCount, true )
                end
            end
        end

        for class, count in pairs( craft.rewards ) do
            ePly:AddItem( class, count * nCount, true )
            ePly:PlaySound( 'player/suit_sprint.wav' )
        end
    end

    if Ambi.SimpleInventory.Config.craft_equal_process and craft.delay then
        self:RunProcess( 'Crafting', craft.name, craft.delay * nCount, 0, Callback )
    else
        Callback( self )
    end
end

local net_string = net.AddString( 'ambi_sinv_set_crafts_of_player' )
function Player:SetCrafts( tCrafts )
    net.Start( 'ambi_sinv_set_crafts_of_player' )
        net.WriteTable( tCrafts or {} )
    net.Send( self )
end

local net_string = net.AddString( Ambi.SimpleInventory.Config.net_craft )
net.Receive( net_string, function( nLen, ePly )
    if not IsValid( ePly ) then return end
    if not ePly:Alive() then return end

    local name, amount = tostring( net.ReadString() ), net.ReadUInt( 16 )
    if not ePly:CanCraft( name, amount ) then return end

    ePly:CraftItem( name, amount )
end )