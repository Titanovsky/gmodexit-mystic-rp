function Ambi.SimpleInventory.AddCraft( sCraft, sName, sCategory, sDescription, nDelay, tItems, tRewardItems, fPostAction )
    Ambi.SimpleInventory.crafting[ tostring( sCraft ) ] = {
        name = sName or '',
        category = sCategory or '',
        desc = sDescription or '',
        delay = nDelay or 0.1,
        items = tItems or {},
        rewards = tRewardItems or {},
        action = fPostAction
    }
end

function Ambi.SimpleInventory.GetCraft( sCraft )
    return Ambi.SimpleInventory.crafting[ tostring( sCraft ) ]
end

function Ambi.SimpleInventory.GetCrafts()
    return Ambi.SimpleInventory.crafting
end
-- --------------------------------------------------
local Player = FindMetaTable( 'Player' )

function Player:CanCraft( sCraft, nCount )
    if not IsValid( self ) or not self:Alive() then return false end

    local craft = Ambi.SimpleInventory.crafting[ tostring( sCraft ) ]
    if not craft then return false end

    nCount = math.floor( nCount or 1 )
    
    for class, need_count in pairs( craft.rewards ) do
        local item = self:GetItem( class )
        if item then
            local now_count = item.count
            if ( now_count + need_count * nCount > Ambi.SimpleInventory.Config.max_count_item ) then return false end
        else
            if not self:GetLastFreeSlot() then return false end
        end
    end

    local max_craft_items = 0
    for class, count in pairs( craft.items ) do
        max_craft_items = max_craft_items + 1
    end

    local i = 0
    for class, count in pairs( craft.items ) do
        local count = count * nCount

        for slot, item in ipairs( self:GetItems() ) do
            if ( class == item.class ) and ( item.count >= count ) then i = i + 1 end
        end
    end

    if ( i ~= max_craft_items ) then return false end

    return true
end

function Player:GetCrafts()
    if not self.crafts then self.crafts = {} end

    return self.crafts
end