local C, GUI, Draw, UI = Ambi.Packages.Out( '@d' )
local W, H = ScrW(), ScrH()
local COLOR_PANEL = Color( 0, 0, 0, 150)

-- --------------------------------------------------------------------------------------------------------------------------------------------
function Ambi.MysticRP.ShowHelp()
    local background = GUI.DrawFrame( nil, W, H, 0, 0, '', true, false, false, function( self, w, h ) 
        Draw.Box( w, h, 0, 0, COLOR_PANEL )
        Draw.Blur( self, 1 )
    end )
    background.OnKeyCodePressed = function( self, nKey )
        if ( nKey == KEY_F4 ) or ( nKey == KEY_SPACE ) then self:Remove() end
    end

    local cancel = GUI.DrawButton( background, 128, 128, background:GetWide() - 128 - 4, 16, nil, nil, nil, function( self )
        background:Remove()
    end, function( self, w, h )
        Draw.Box( w, h, 0, 0, COLOR_PANEL, 6 )

        Draw.Text( w / 2, h / 2, '❌', UI.SafeFont( '128 Eirik Raude' ), C.RED, 'center' )
    end )

    local panel = GUI.DrawScrollPanel( background, 760, 260, background:GetWide() / 2 - 760 / 2, background:GetTall() - 260 - 16, function( self, w, h ) 
        Draw.Box( w, h, 0, 0, COLOR_PANEL )
    end )

    local top = GUI.DrawPanel( background, 400, 260, background:GetWide() / 2 - 400 / 2, panel:GetY() - 260 - 4, function( self, w, h ) 
        Draw.Box( w, h, 0, 0, COLOR_PANEL )

        -- Draw.SimpleText( w / 2, 32, 'doktor mabuza', UI.SafeFont( '36 Eirik Raude' ), C.RU_PINK, 'top-center' )
    end )

    local pages = GUI.DrawScrollPanel( top, top:GetWide(), top:GetTall() - 24, 0, 24, function( self, w, h ) 
    end )

    local i = 0
    for header, phrase in SortedPairs( Ambi.MysticRP.Config.help_text ) do
        local page = GUI.DrawButton( pages, pages:GetWide(), 36, 0, i * 36, nil, nil, nil, function( self )
            panel:Clear()

            local text = vgui.Create( 'RichText', panel )
            text:SetPos( 0, 0 )
            text:SetSize( panel:GetWide(), panel:GetTall() )
            text:AppendText( phrase )
            text.PerformLayout = function( self )
                self:SetFontInternal( UI.SafeFont( '40 Eirik Raude' ) )
                self:SetFGColor( C.ABS_WHITE )
            end
        end, function( self, w, h )
            -- Draw.Box( w, h, 0, 0, COLOR_GREEN, 6 )
    
            Draw.Text( w / 2, h / 2, header, UI.SafeFont( '32 Ambi' ), C.ABS_WHITE, 'center', 1, C.BLACK )
        end )

        i = i + 1
    end
end