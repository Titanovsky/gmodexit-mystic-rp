local C, GUI, Draw, UI, CL = Ambi.Packages.Out( '@d, ContentLoader' )
local W, H = ScrW(), ScrH()
local COLOR_PANEL = Color( 0, 0, 0, 150 )
local COLOR_LINE = Color( 20, 20, 20, 240 )
local COLOR_ROULETTE = Color( 0, 0, 0, 160 )

-- ====================================================================================================================================================== --
function Ambi.MysticRP.OpenCase( nType )
    local items = Ambi.MysticRP.cases[ nType ]
    if not items then return end
    
    local frame = GUI.DrawFrame( nil, 800, 260, 0, 0, '', true, false, true, function( self, w, h ) 
        Draw.Box( w, h, 0, 0, C.AMBI_BLACK )
    end )
    frame.OnRemove = function()
        net.Start( 'ambi_mysticrp_case_cancel' )
        net.SendToServer()
    end 
    frame:Center()
    
    local div = GUI.DrawPanel( frame, frame:GetWide() - 16, 100, 8, 35, function( self, w, h )
        Draw.Box( 10, h, w / 2 - 10 / 2, 0, COLOR_PANEL )
    end )

    local roulette = GUI.DrawPanel( div, frame:GetWide() + 6500, div:GetTall(), 0, 0, function( self, w, h )
        draw.RoundedBox( 0, 0, 0, w, h, COLOR_ROULETTE )
    end )
    roulette.slots = {}

    local random = {}
    for class, tab in pairs( items ) do
        if ( class == 'item' ) then continue end

        for i = 1, 100 do
            random[ i ] = ( math.random( 0, 100 ) <= tab.chance ) and class or random[ i ]
            if not random[ i ] then random[ i ] = 'Ничего' end
        end
    end

    for i = 1, 100 do
        local slot = GUI.DrawPanel( roulette, 100, 100 - 8, 4 + ( 100 + 8 ) * ( i - 1 ), 4, function( self, w, h )
            draw.RoundedBox( 4, 0, 0, w, h, COLOR_ROULETTE )
            --draw.SimpleText( name, '14 Ambi', w / 2, 4, C.ABS_WHITE, TEXT_ALIGN_TOP, TEXT_ALIGN_CENTER )

            if not self.dont_show and self.icon and string.StartsWith( self.icon, 'http' ) then
                Draw.Material( 100, 100, 0, 0, CL.Material( 'inv_'..random[ i ] ) )
            end
        end )

        slot.item = Ambi.Inv.GetItem( random[ i ] )
        slot.name = slot.item and slot.item.name or ''
        slot.icon = slot.item and slot.item.icon or ''

        local name = GUI.DrawPanel( slot, slot:GetWide(), 20, 0, 0, function( self, w, h )
            draw.RoundedBox( 0, 0, 0, w, h, COLOR_PANEL )
            draw.SimpleText( slot.name, UI.SafeFont( '16 Ambi' ), w / 2, h / 2, C.ABS_WHITE, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
        end )

        if slot.item and string.StartsWith( slot.icon, 'model' ) then
            local mdl = GUI.DrawModel( slot, 128, 128, 0, 0, slot.icon )
            mdl:Center()

            slot.model = mdl
        end

        roulette.slots[ i ] = slot
    end

    local start = GUI.DrawButton( frame, 130, 50, frame:GetWide() / 2 - 100 / 2, frame:GetTall() - 40 - 32, nil, nil, nil, function( self )
        if timer.Exists( 'MysticRPCaseDelay' ) then return end

        local size = math.random( -6080, -6010 )

        self:Remove()

        timer.Create( 'MysticRPCaseDelay', 33, 1, function() end )

        roulette:MoveTo( size, 0, 30, 0, 0.2, function() 
            frame:Remove()
        end )

        net.Start( 'ambi_mysticrp_case_start' )
            net.WriteUInt( nType, 6 )
        net.SendToServer()

        net.Receive( 'ambi_mysticrp_case_give_reward', function() 
            local reward = net.ReadString()

            local slot = roulette.slots[ 60 ]

            local real_slot = GUI.DrawPanel( slot, slot:GetWide(), slot:GetTall(), 0, 0, function( self, w, h )
                draw.RoundedBox( 4, 0, 0, w, h, COLOR_ROULETTE )
                --draw.SimpleText( name, '14 Ambi', w / 2, 4, C.ABS_WHITE, TEXT_ALIGN_TOP, TEXT_ALIGN_CENTER )
    
                if self.icon and string.StartsWith( self.icon, 'http' ) then
                    Draw.Material( 100, 100, 0, 0, CL.Material( 'inv_'..reward ) )
                end
            end )

            real_slot.item = Ambi.Inv.GetItem( reward )
            real_slot.name = slot.item and slot.item.name or ''
            real_slot.icon = slot.item and slot.item.icon or ''

            if slot.model then slot.model:Remove() end

            if slot.item and string.StartsWith( slot.icon, 'model' ) then
                local mdl = GUI.DrawModel( real_slot, 128, 128, 0, 0, slot.icon )
                mdl:Center()
            end

            slot.dont_show = true
        end )
    end, function( self, w, h ) 
        Draw.Box( w, h, 0, 0, C.AMBI_WHITE, 4 )
        Draw.SimpleText( w / 2, h / 2, 'START', UI.SafeFont( '36 Ambi' ), HSVToColor( ( CurTime() * 32 ) % 360, 1, 1 ), 'center', 1, C.ABS_BLACK )
    end )
end
concommand.Add( 'ambi_mystic_rp_case', Ambi.MysticRP.OpenCase )