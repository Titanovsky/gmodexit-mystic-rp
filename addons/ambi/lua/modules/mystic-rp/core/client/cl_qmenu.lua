local C, GUI, Draw, UI = Ambi.Packages.Out( '@d' )
local DrawTextOutline, DrawBox = draw.SimpleTextOutlined, draw.RoundedBox
local W, H = ScrW(), ScrH()

local COLOR_PANEL = Color( 0, 0, 0, 200 )

local tab_props = {
    'models/props_c17/fence01a.mdl',
    'models/props_c17/fence03a.mdl',
    'models/props_wasteland/interior_fence002d.mdl',
    'models/props_interiors/Furniture_Couch02a.mdl',
    'models/props_junk/cardboard_box001a.mdl',
    'models/props_c17/FurnitureCouch001a.mdl',
    'models/props_c17/gravestone_coffinpiece001a.mdl',
    'models/props_lab/blastdoor001c.mdl',
    'models/props_interiors/VendingMachineSoda01a.mdl',
    'models/props_lab/blastdoor001b.mdl',
    'models/props_wasteland/laundry_dryer001.mdl',
    'models/props_combine/breendesk.mdl',
    'models/props_c17/gate_door01a.mdl',
    'models/props_c17/gate_door02a.mdl',
    'models/props_junk/wood_crate001a_damaged.mdl',
    'models/props_junk/wood_crate002a.mdl',
    'models/props_junk/TrashDumpster01a.mdl',
    'models/props_doors/door03_slotted_left.mdl',
    'models/props_interiors/refrigerator01a.mdl',
    'models/props_phx/construct/wood/wood_panel2x2.mdl',
    'models/props_borealis/borealis_door001a.mdl',
    'models/props_lab/huladoll.mdl',
    'models/hunter/blocks/cube025x025x025.mdl',
    'models/hunter/blocks/cube6x6x025.mdl',
    'models/hunter/blocks/cube4x6x1.mdl',
    'models/hunter/blocks/cube8x8x025.mdl',
    'models/hunter/blocks/cube6x6x025.mdl',
    'models/hunter/plates/plate4x8.mdl',
    'models/hunter/plates/plate8x32.mdl',
    'models/hunter/plates/plate05x1.mdl',
    'models/hunter/plates/plate05x05.mdl',
    'models/hunter/plates/plate2x2.mdl',
    'models/hunter/plates/plate2x6.mdl',

    'models/props_lab/blastdoor001b.mdl', 
    'models/props_lab/blastdoor001c.mdl', 
    'models/props_c17/fence01a.mdl', 
    'models/props_c17/fence01b.mdl', 
    'models/hunter/blocks/cube025x025x025.mdl', 
    'models/hunter/blocks/cube025x2x025.mdl', 
    'models/hunter/blocks/cube05x05x05.mdl', 
    'models/hunter/blocks/cube05x2x05.mdl',  
    'models/hunter/plates/plate075x075.mdl', 
    'models/hunter/plates/plate05x05.mdl', 
    'models/props_phx/construct/metal_plate1.mdl', 
    'models/props_phx/construct/metal_plate1x2.mdl', 
    'models/props_phx/construct/metal_plate2x2.mdl', 
    'models/props_phx/construct/metal_plate2x4.mdl', 
    'models/props_phx/construct/metal_plate4x4.mdl', 
    'models/props_phx/construct/metal_tube.mdl', 
    'models/props_phx/construct/glass/glass_plate2x2.mdl', 
    'models/props_interiors/Furniture_Couch01a.mdl', 
    'models/props_interiors/Furniture_Couch02a.mdl', 
    'models/props_combine/breenchair.mdl', 
    'models/props_interiors/Furniture_Desk01a.mdl', 
    'models/props_combine/breendesk.mdl', 
    'models/props_interiors/Furniture_shelf01a.mdl', 
    'models/props_c17/FurnitureCouch001a.mdl',
}

function Ambi.DarkRP.ShowPropsMenu( vguiParent )
    local frame = GUI.DrawPanel( vguiParent, vguiParent and vguiParent:GetWide() or 800, vguiParent and vguiParent:GetTall() or 800, 0, 0, function( self, w, h ) 
        Draw.Box( w, h, 0, 0, C.AMBI_WHITE )
    end )

    local props = GUI.DrawScrollPanel( frame, frame:GetWide() - 20, frame:GetTall() - 16, 10, 8, function( self, w, h ) end )
    local grid = GUI.DrawGrid( props, 80, 76, 0, 0, 9 )

    local count = 0
    for i, mdl in ipairs( tab_props ) do
        local tooltip = mdl

        local panel = GUI.DrawPanel( grid, 72, 72, 0, 0, function( self, w, h ) 
            local color = C.AMBI_GREEN 

            Draw.Box( w, 2, 0, h - 2, color ) 
            Draw.Box( w, 2, 0, 0, color )
            Draw.Box( 2, h, 0, 0, color )
            Draw.Box( 2, h, w - 2, 0, color )

            Draw.Text( 4, 2, i, UI.SafeFont( '12 Arimo' ), C.AMBI_BLACK, 'top-left' )
        end )
        panel:SetTooltip( tooltip)

        local model = vgui.Create( 'ModelImage', panel )
        model:SetSize( 64, 64 )
        model:SetPos( panel:GetWide() / 2 - 32, panel:GetTall() / 2 - 32 )
        model:SetModel( mdl )

        grid:AddItem( panel )

        local craft = GUI.DrawButton( panel, panel:GetWide(), panel:GetTall(), 0, 0, nil, nil, nil, function()
            RunConsoleCommand( 'gm_spawn', mdl )
            surface.PlaySound( 'buttons/button14.wav' )
        end, function( self, w, h ) end )-- workaround
    end

    return frame
end
concommand.Add( 'ambi_mystic_props', function()
    local background = GUI.DrawFrame( nil, W / 1.4, H / 1.4, 0, 0, '', true, true, true, function( self, w, h ) Draw.Box( w, h, 0, 0, COLOR_PANEL ) end )
    background:Center()
    background.OnKeyCodePressed = function( self, nKey )
        if ( nKey == KEY_I ) then background:Remove() end
    end

    Ambi.Survival.ShowPropsMenu( background )
end )

local function SetMenuTab()
    g_SpawnMenu.CreateMenu.Items[ 2 ].Panel:GetChildren()[ 1 ] = Ambi.DarkRP.ShowPropsMenu( g_SpawnMenu.CreateMenu.Items[ 2 ].Panel:GetChildren()[ 1 ] )
end
concommand.Add( 'ambi_mystic_refresh_menu', SetMenuTab )
-- hook.Add( 'InitPostEntity', 'Ambi.MysticRP.SetSpawnMenuTab', SetMenuTab )

spawnmenu.AddCreationTab( 'Props', function() return Ambi.DarkRP.ShowPropsMenu() end, 'icon16/package.png', -499 )