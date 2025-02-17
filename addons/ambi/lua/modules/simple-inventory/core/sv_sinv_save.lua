local Files, Folders, JSON = Ambi.Files, Ambi.Files.Folders, Ambi.Files.JSON
local PLAYER = FindMetaTable( 'Player' ) 

Folders.Create( 'simpleinventory', true )

function PLAYER:SaveItems()
    if not Ambi.SimpleInventory.Config.save_inventory then return end

    local ID = self:SteamID64()
    local inventory = self.simpleinventory

    for slot, item in ipairs( inventory ) do
        if item.class and not Ambi.SimpleInventory.GetClass( item.class ) then table.remove( inventory, slot ) end
    end
    local data = JSON.In( inventory )

    Files.Create( 'simpleinventory/'..ID..'.json', data, true )
end

function PLAYER:LoadItems()
    if not Ambi.SimpleInventory.Config.save_inventory then return end

    local data = Files.Read( 'simpleinventory/'..self:SteamID64()..'.json', 'DATA', true )
    if not data then return end
    
    local inventory = JSON.Out( data )

    for slot, item in pairs( inventory ) do
        if item.class and not Ambi.SimpleInventory.GetClass( item.class ) then table.remove( inventory, slot ) end
    end

    return inventory
end