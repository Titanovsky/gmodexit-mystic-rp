local C, GUI, Draw, UI = Ambi.Packages.Out( '@d' )
local SND, Cache = Ambi.General.Global.Sounds, Ambi.Cache

local COLOR_PANEL = Color( 255, 255, 255, 10 )
local COLOR_PANEL2 = Color( 0, 0, 0, 100 )

function Ambi.SimpleInventory.ShowCrafting( vguiParent, tItems )
    if not LocalPlayer():Alive() then return end

    local crafting = GUI.DrawPanel( vguiParent, vguiParent:GetWide(), vguiParent:GetTall(), 0, 0, function( self, w, h )
        Draw.Box( w, h, 0, 0, COLOR_PANEL2 )
    end )

    local info = GUI.DrawPanel( crafting, crafting:GetWide() - 8, 100 - 8, 4, 4, function( self, w, h )
        if not self.item then return end

        Draw.Text( w - 72, 0, self.item.name, UI.SafeFont( '32 Arial' ), C.ABS_WHITE, 'top-right', 1, C.AMBI_BLACK )
        if not self.item.icon:IsError() then Draw.Material( 64, 64, w - 64 - 4, 4, self.item.icon ) end
    end )
    info.item = nil

    local list = GUI.DrawScrollPanel( crafting, crafting:GetWide() - 8, crafting:GetTall() - 100 - 4, 4, 100 )
    local len = #tItems
    local x_offset = ( len > 5 ) and 16 or 0
    for i, _craft in ipairs( tItems or {} ) do
        local craft = Ambi.SimpleInventory.GetCraft( _craft )
        if not craft then continue end 
        
        --craft.name = _craft

        local rewards = {}
        for class, count in SortedPairs( craft.rewards ) do
            rewards[ #rewards + 1 ] = class
        end

        Ambi.SimpleInventory.DownloadIcon( rewards[ 1 ] )
        
        local icon = Material( '../data/ambi/cache/simpleinventory/icons/'..Ambi.SimpleInventory.Config.directory_icons..'/'..rewards[ 1 ]..'.png' )
        
        local panel = GUI.DrawButton( list, list:GetWide() - x_offset, 36, 0, ( 36 + 4 ) * ( i - 1 ), nil, nil, nil, function()
            info:Clear()
            info.item = craft
            info.item.icon = icon

            local amount = 0
            local number = GUI.DrawTextEntry( info, 64, 26, 4, 4, UI.SafeFont( '24 Arial' ), C.AMB_BLACK, nil, nil, '1', false, true )
            number:SetValue( 1 )
            number.Think = function( self )
                amount = string.IsValid( self:GetValue() ) and self:GetValue() or 0
                amount = tonumber( amount )
            end

            local crafting = GUI.DrawButton( info, 100, 24, 4, info:GetTall() - 24 - 4, nil, nil, nil, function()
                if not amount or ( amount <= 0 ) then return end
                if not LocalPlayer():CanCraft( _craft, amount ) then return end

                net.Start( Ambi.SimpleInventory.Config.net_craft )
                    net.WriteString( _craft )
                    net.WriteUInt( amount, 16 )
                net.SendToServer()
            end, function( self, w, h )
                if not info.item then return end

                Draw.Box( w, h, 0, 0, COLOR_PANEL2 )

                local color = LocalPlayer():CanCraft( _craft, amount ) and C.AMBI_GREEN or C.AMBI_RED
                Draw.Text( w / 2, h / 2, 'Craft', UI.SafeFont( '22 Arial' ), color, 'center' )
            end )

            local ingredients = GUI.DrawScrollPanel( info, 120, 50, 100 + 12, 36 )
            local j = 0
            
            for class, count in SortedPairs( craft.items ) do
                j = j + 1
                local name = Ambi.SimpleInventory.GetClass( class ).name

                local panel = GUI.DrawButton( ingredients, ingredients:GetWide(), 36, 0, ( 36 + 4 ) * ( j - 1 ), nil, nil, nil, function( self )
                end, function( self, w, h )
                    Draw.Box( w, h, 0, 0, COLOR_PANEL2, 4, 'all' )

                    local color = ( LocalPlayer():GetItem( class ) and LocalPlayer():GetItem( class ).count >= count * amount ) and C.AMBI_GREEN or C.AMBI_RED
                    Draw.Text( w / 2, h / 2 - 8, name, UI.SafeFont( '22 Arial' ), color, 'center' )
                    Draw.Text( w / 2, h / 2 + 10, 'x'..tostring( count * amount ), UI.SafeFont( '18 Arial' ), color, 'center' )
                end )
                panel:SetCursor( 'arrow' )
                panel:SetTooltip( name.. ' x'..count )
            end
        end, function( self, w, h )
            Draw.Box( w, h, 0, 0, COLOR_PANEL, 4, 'all' )

            Draw.Text( 44, 6, craft.name, UI.SafeFont( '20 Arial' ), C.ABS_WHITE, 'top-left' )
            
            if not icon:IsError() then Draw.Material( 32, 32, 4, 4, icon ) end
        end )
    end
end

net.Receive( 'ambi_sinv_set_crafts_of_player', function()
    LocalPlayer().crafts = net.ReadTable()
end )