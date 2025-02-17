local C, GUI, Draw, UI = Ambi.Packages.Out( '@d' )
local Cache = Ambi.Cache
local W, H = ScrW(), ScrH()

AMB.SimpleInventory.loot_items = {} or AMB.SimpleInventory.loot_items
AMB.SimpleInventory.loot = nil or AMB.SimpleInventory.loot

local function Action( nSlot, nCount )
    if not nCount then return end
    if not IsValid( Ambi.SimpleInventory.loot ) then return end
    if not Ambi.SimpleInventory.loot_items[ nSlot ] then return end
    if not Ambi.SimpleInventory.loot_items[ nSlot ].count then return end
    if ( Ambi.SimpleInventory.loot_items[ nSlot ].count < nCount ) then return end

    net.Start( 'ambi_sinv_loot_take' )
        net.WriteUInt( nCount, 20 )
        net.WriteUInt( nSlot, 20 )
        net.WriteEntity( Ambi.SimpleInventory.loot )
    net.SendToServer()
end

local function ParsItems( vguiScrollPanel )
    if not ValidPanel( vguiScrollPanel ) then return end
    
    vguiScrollPanel:Clear()

    local take_all = GUI.DrawButton( vguiScrollPanel:GetParent(), 100, 24, vguiScrollPanel:GetParent():GetWide() - 100 - 100, 0, nil, nil, nil, function( self )
        for slot, item in ipairs( Ambi.SimpleInventory.loot_items ) do
            if not item.class then continue end
            if not Ambi.SimpleInventory.GetClass( item.class ) then continue end

            Action( slot, item.count )
        end
        
        timer.Simple( 0.1, function() ParsItems( vguiScrollPanel ) end )
    end, function( self, w, h )
        Draw.Box( w, h, 0, 0, C.AMBI_PANEL )
        Draw.Text( w / 2, h / 2, 'Взять всё', UI.SafeFont( '22 Arial' ), C.AMBI_BLUE, 'center', 1, C.ABS_BLACK )
    end )

    for slot, item in ipairs( Ambi.SimpleInventory.loot_items ) do
        local shell = GUI.DrawPanel( vguiScrollPanel, vguiScrollPanel:GetWide(), 68, 0, ( 68 + 4 ) * ( slot - 1 ), function( self, w, h )
            Draw.Box( w, h, 0, 0, C.PANEL )
        end )

        --print( slot, item.class ) -- debug
        if not item.class then continue end
        if not Ambi.SimpleInventory.GetClass( item.class ) then continue end

        local name = Ambi.SimpleInventory.GetClass( item.class ).name
        
        Ambi.SimpleInventory.DownloadIcon( item.class )
        local icon = Material( '../data/ambi/cache/simpleinventory/icons/'..Ambi.SimpleInventory.Config.directory_icons..'/'..item.class..'.png' )

        local panel = GUI.DrawPanel( vguiScrollPanel, vguiScrollPanel:GetWide(), 68, 0, ( 68 + 4 ) * ( slot - 1 ), function( self, w, h )
            Draw.Text( 72, h / 2, name..' x'..tostring( item.count ), UI.SafeFont( '24 Arial' ), C.ABS_WHITE, 'center-left' )
            if not icon:IsError() then 
                Draw.Material( 64, 64, 4, 4, icon ) 
            else
                Draw.Text( 16, 32, 'NO ICON', UI.SafeFont( '12 Arial' ), C.ABS_WHITE )
            end
        end )

        local take = GUI.DrawButton( panel, 70, 25, panel:GetWide() - 70 - 26, panel:GetTall() / 2 - 25 / 2, nil, nil, nil, function( self )
            Action( slot, item.count )

            timer.Simple( 0.1, function() ParsItems( vguiScrollPanel ) end )
        end, function( self, w, h )
            --Draw.Box( w, h, 0, 0, C.AMB_PANEL )
            Draw.Text( w / 2, h / 2, '+', UI.SafeFont( '46 Arial' ), C.FLAT_GREEN, 'center', 1, C.ABS_BLACK )
        end )
    end
end

function Ambi.SimpleInventory.ShowLoot( vguiParent )
    if not LocalPlayer():Alive() then return end

    local loot = GUI.DrawScrollPanel( vguiParent, vguiParent:GetWide(), vguiParent:GetTall() - 22, 0, 22, function( self, w, h )
        --Draw.Box( w, h, 0, 0, C.AMB_PANEL )
    end )
    ParsItems( loot )

    return loot
end

net.Receive( 'ambi_sinv_loot_get_items', function()
    Ambi.SimpleInventory.loot_items = net.ReadTable() or {}
    Ambi.SimpleInventory.loot = net.ReadEntity()
end )

net.Receive( 'ambi_sinv_loot_open', function()
    local window = GUI.DrawFrame( nil, W / 2, H / 2, 0, 0, '', true, true, true, function( self, w, h ) 
        Draw.Box( w, h, 0, 0, C.PANEL )
        Draw.Text( 2, -4, Ambi.SimpleInventory.loot:GetNWString( 'Header' ), UI.SafeFont( '26 Oswald Light' ), Ambi.SimpleInventory.loot:GetColor(), nil, 1, C.ABS_BLACK )
    end )
    window:Center()

    window.OnRemove = function()
        net.Start( 'ambi_sinv_loot_close')
            net.WriteEntity( Ambi.SimpleInventory.loot )
        net.SendToServer()
    end

    window.Think = function( self )
        if not LocalPlayer():Alive() then self:Remove() return end
        if not IsValid( Ambi.SimpleInventory.loot ) then self:Remove() return end
    end

    Ambi.SimpleInventory.ShowLoot( window )
end )