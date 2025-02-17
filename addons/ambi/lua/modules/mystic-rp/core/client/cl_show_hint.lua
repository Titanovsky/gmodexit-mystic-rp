local C, GUI, Draw, UI, CL = Ambi.Packages.Out( '@d, ContentLoader' )
local W, H = ScrW(), ScrH()
local COLOR_PANEL = Color( 20, 20, 20, 230 )

-- ---------------------------------------------------------------------------------------------------------------------------------------
CL.CreateDir( 'ambi_mystic_rp' )
CL.CreateDir( 'ambi_mystic_rp/hints' )

for name, url in pairs( Ambi.MysticRP.Config.hints ) do
    CL.DownloadMaterial( 'mrp_hint_'..name, 'ambi_mystic_rp/hints/'..name..'.png', url )
end

-- ---------------------------------------------------------------------------------------------------------------------------------------
function Ambi.MysticRP.ShowHint( sHint )
    if not sHint then return end

    local url = Ambi.MysticRP.Config.hints[ sHint ]
    if not url then return end

    local frame = GUI.DrawFrame( nil, W, H, 0, 0, '', true, false, false, function( self, w, h ) 
        Draw.Box( w, h, 0, 0, COLOR_PANEL )

        if self.ready then
            Draw.SimpleText( w / 2, h - 11, 'Нажмите что нибудь..', UI.SafeFont( '40 Ambi Bold' ), C.AMBI_YELLOW, 'bottom-center', 1, C.ABS_BLACK )
        end
    end )
    frame.OnKeyCodePressed = function( self, nKey )
        if not self.ready then return end

        self:Remove()
        timer.Remove( 'PoseSex' )
    end
    frame.OnMousePressed = frame.OnKeyCodePressed

    local panel = GUI.DrawPanel( frame, 512, 512, 0, 0,  function( self, w, h ) 
        Draw.Material( w, h, 0, 0, CL.Material( 'mrp_hint_'..sHint ) )
    end )
    panel:Center()

    timer.Simple( 4, function()
        frame.ready = true
        surface.PlaySound( 'ambi/ui/click5.mp3' )
    end )

    timer.Create( 'PoseSex', 60, 1, function() 
        frame:Remove()
    end )
end
concommand.Add( 'ambi_mysticrp_hint', function( _, _, tArgs ) 
    Ambi.MysticRP.ShowHint( tArgs[ 1 ] )
end )