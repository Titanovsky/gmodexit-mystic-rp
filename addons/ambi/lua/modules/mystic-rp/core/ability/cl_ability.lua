local C, GUI, Draw, UI, CL = Ambi.Packages.Out( '@d, ContentLoader' )
local W, H = ScrW(), ScrH()

local COLOR_PANEL = Color( 0, 0, 0, 210 )
local ID = {
    [ KEY_PAD_1 ] = 1,
    [ KEY_PAD_2 ] = 2,
    [ KEY_PAD_3 ] = 3,
}

-- --------------------------------------------------------------------------------------------------------------------------------------
function Ambi.MysticRP.OpenAbilities()
    if not Ambi.MysticRP.abilities[ LocalPlayer():GetJob() ] then return end

    if ValidPanel( Ambi.MysticRP.ability_menu ) then Ambi.MysticRP.ability_menu:Remove() return end

    local wide = 3 * ( 128 + 2 ) + 2
    local frame = GUI.DrawFrame( nil, wide, 132, W / 2 - wide / 2, H - 132 - 12, '', false, false, false, function( self, w, h ) 
        Draw.Box( w, h, 0, 0, COLOR_PANEL )

        Draw.Box( 2, h, 0, 0, C.AMBI_BLOOD )
        Draw.Box( 2, h, w - 2, 0, C.AMBI_BLOOD )
        Draw.Box( w, 2, 0, 0, C.AMBI_BLOOD )
        Draw.Box( w, 2, 0, h - 2, C.AMBI_BLOOD )

        --Draw.SimpleText( 10 + self.pages:GetWide() + 20, 22, self.header, UI.SafeFont( '54 Ambi Bold' ), C.ABS_WHITE, 'top-left', 1, C.ABS_BLACK )
    end )
    frame.Think = function( self )
        if input.IsKeyDown( KEY_1 ) then 
            net.Start( 'ambi_mysticrp_ability_active' )
                net.WriteUInt( 1, 3 )
            net.SendToServer()

            frame:Remove()

            return 
        elseif input.IsKeyDown( KEY_2 ) then
            net.Start( 'ambi_mysticrp_ability_active' )
                net.WriteUInt( 2, 3 )
            net.SendToServer()

            frame:Remove()

            return 
        elseif input.IsKeyDown( KEY_3 ) then 
            net.Start( 'ambi_mysticrp_ability_active' )
                net.WriteUInt( 3, 3 )
            net.SendToServer()

            frame:Remove()

            return 
        end
    end

    Ambi.MysticRP.ability_menu = frame

    for i = 1, 3 do
        local ability = Ambi.MysticRP.abilities[ LocalPlayer():GetJob() ][ i ]

        local panel = GUI.DrawPanel( frame, 128, 128, ( i - 1 ) * ( 128 + 2 ) + 2, 2, function( self, w, h ) 
            Draw.Box( w, h, 0, 0, COLOR_PANEL )
    
            Draw.Material( w, h, 0, 0, CL.Material( 'mrp_ability_'..ability.header..'_'..i ), C.AMBI_BLOOD )
            Draw.SimpleText( 4, 4, i, UI.SafeFont( '24 Ambi' ), C.ABS_WHITE, 'top-left', 1, C.ABS_BLACK )
        end )
    end
end

hook.Add( 'Think', 'Ambi.MysticRP.OpenAbils', function() 
    if not input.IsKeyDown( KEY_M ) then return end
    if gui.IsConsoleVisible() then return end
    if LocalPlayer():IsTyping() then return end
    if timer.Exists( 'MysticRP.Abilities.Delay' ) then return end
    timer.Create( 'MysticRP.Abilities.Delay', 0.25, 1, function() end )

    Ambi.MysticRP.OpenAbilities()
end )