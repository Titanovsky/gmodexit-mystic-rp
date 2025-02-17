local C, GUI, Draw, UI, CL = Ambi.Packages.Out( '@d, ContentLoader' )
local W, H = ScrW(), ScrH()

local sound_track

-- --------------------------------------------------------------------------------------------------------------------------------------
function Ambi.Authorization.OpenMenu()
    local frame = GUI.DrawFrame( nil, W, H, 0, 0, '', true, false, false, function( self, w, h ) 
        Draw.Box( w, h, 0, 0, Ambi.Authorization.Config.background.color )
    end )
    frame:Center()

    sound.PlayURL( Ambi.Authorization.Config.background.sound_url, 'mono', function( audioSound )
        if not IsValid( audioSound ) then return end

        audioSound:Play()
        audioSound:SetVolume( Ambi.Authorization.Config.background.sound_volume )

        sound_track = audioSound
    end )

    local main_menu = GUI.DrawPanel( frame, frame:GetWide(), frame:GetTall() - 32, 0, 32, function( self, w, h ) 
        -- Draw.Box( w, h, 0, 0, Ambi.Authorization.Config.background.color ) -- debug
    end )

    local header = GUI.DrawPanel( main_menu, main_menu:GetWide(), main_menu:GetTall() / 2.4, 0, 0, function( self, w, h ) 
        Draw.Material( 128, 128, w / 2 - 128 / 2, 16, CL.Material( Ambi.Authorization.Config.logo.name ), Ambi.Authorization.Config.logo.color )
        Draw.SimpleText( w / 2, 160, Ambi.Authorization.Config.header.text, UI.SafeFont( Ambi.Authorization.Config.header.font ), Ambi.Authorization.Config.header.color, 'top-center', 1, C.ABS_BLACK )
        Draw.SimpleText( w / 2, 160 + 60, Ambi.Authorization.Config.subheader.text, UI.SafeFont( Ambi.Authorization.Config.subheader.font ), Ambi.Authorization.Config.subheader.color, 'top-center', 1, C.ABS_BLACK )
    end )

    local play = GUI.DrawButton( main_menu, 240, 56, main_menu:GetWide() / 2 - 240 / 2, main_menu:GetTall() - 56 - 32, nil, nil, nil, function( self )
        self:Remove()

        net.Start( 'ambi_authorization_play' )
        net.SendToServer()
 
        local need_register = false
        net.Receive( 'ambi_authorization_register_start', function() 
            need_register = true
        end )
        
        timer.Simple( 1, function()
            if need_register then
                input.SetCursorPos( W / 2, H / 2 )
                surface.PlaySound( 'ambi/painkiller/choice4.ogg' )

                Ambi.Authorization.ShowRegisterMenu( main_menu )

                self:Remove()
                header:Remove()
            else
                surface.PlaySound( 'ambi/painkiller/voice.ogg' )
        
                frame:SetKeyboardInputEnabled( false )
                frame:SetMouseInputEnabled( false )
                frame:AlphaTo( 0, 4, 1, function() 
                    frame:Remove()
                end )

                gui.EnableScreenClicker( false )

                if IsValid( sound_track ) then
                    sound_track:Stop()
                    sound_track = nil
                end
            end
        end )
    end, function( self, w, h ) 
        Draw.Box( w, 2, 0, h - 2, self.color, 8 )

        Draw.SimpleText( w / 2, h / 2 - 2, self.text, self.font, C.ABS_WHITE, 'center', 1, C.ABS_BLACK )
    end )
    play.color = C.ABS_WHITE
    play.text = 'ИГРАТЬ'
    play.font = UI.SafeFont( '64 Bookerly Light' )

    GUI.OnCursor( play, function()
        play.color = C.AMBI_BLOOD
        play.font = UI.SafeFont( '60 Bookerly Light' )
        
        surface.PlaySound( 'Hover3' )
    end, function() 
        play.color = C.ABS_WHITE
        play.font = UI.SafeFont( '64 Bookerly Light' )
    end )
end
concommand.Add( 'ambi_authorization_open', function()
    if not LocalPlayer():IsSuperAdmin() then return end

    Ambi.Authorization.OpenMenu()
end )

function Ambi.Authorization.ShowRegisterMenu( vguiFrame )
    local main_menu, frame = vguiFrame, vguiFrame:GetParent()
    local reason_failed = ''
    local success = false
    local margin_y = 0

    local forma = GUI.DrawScrollPanel( main_menu, main_menu:GetWide() / 2, main_menu:GetTall() / 1.4, main_menu:GetWide() / 2 - ( main_menu:GetWide() / 2 ) / 2, 0, function( self, w, h ) 
        Draw.Box( 2, h, 0, 0, C.WHITE )
        Draw.Box( 2, h, w - 2, 0, C.WHITE )
        Draw.Box( w, 2, 0, 0, C.WHITE )
        Draw.Box( w, 2, 0, h - 2, C.WHITE )
    end )
    forma:SetAlpha( 0 )
    forma:AlphaTo( 255, 2, 0, function() end )

    local count_panels = 4

    -- ================================================================= --
    local panel_name = GUI.DrawPanel( forma, forma:GetWide() - 8, forma:GetTall() / count_panels, 4, 4, function( self, w, h ) 
        -- Draw.Box( w, h, 0, 0, C.RED ) -- debug

        Draw.SimpleText( w / 2, h / 2 - 32, '1. Имя', UI.SafeFont( '40 Bookerly Light' ), C.ABS_WHITE, 'center', 1, C.ABS_BLACK )
    end )
    panel_name:SetAlpha( 0 )
    panel_name:AlphaTo( 255, 2, 0, function() end )

    local te_name = GUI.DrawTextEntry( panel_name, panel_name:GetWide() - 12 * 2, 46, 12, panel_name:GetTall() / 2 - 46 / 2 + 16, UI.SafeFont( '45 Ambi' ), C.BLACK, '', C.AMBI_GRAY, 'Press here' )

    margin_y = margin_y + panel_name:GetTall()

    -- ================================================================= --
    local panel_last_name = GUI.DrawPanel( forma, forma:GetWide() - 8, forma:GetTall() / count_panels, 4, 4 + margin_y, function( self, w, h ) 
        -- Draw.Box( w, h, 0, 0, C.GREEN ) -- debug

        Draw.SimpleText( w / 2, h / 2 - 32, '2. Фамилия', UI.SafeFont( '40 Bookerly Light' ), C.ABS_WHITE, 'center', 1, C.ABS_BLACK )
    end )
    panel_last_name:SetAlpha( 0 )
    panel_last_name:AlphaTo( 255, 2, 0, function() end )

    local te_last_name = GUI.DrawTextEntry( panel_last_name, panel_last_name:GetWide() - 12 * 2, 46, 12, panel_last_name:GetTall() / 2 - 46 / 2 + 16, UI.SafeFont( '45 Ambi' ), C.BLACK, '', C.AMBI_GRAY, 'Press here' )

    margin_y = margin_y + panel_last_name:GetTall()

    -- ================================================================= --
    local panel_age = GUI.DrawPanel( forma, forma:GetWide() - 8, forma:GetTall() / count_panels, 4, 4 + margin_y, function( self, w, h ) 
        -- Draw.Box( w, h, 0, 0, C.BLUE ) -- debug

        Draw.SimpleText( w / 2, h / 2 - 32, '3. Возраст', UI.SafeFont( '40 Bookerly Light' ), C.ABS_WHITE, 'center', 1, C.ABS_BLACK )
    end )
    panel_age:SetAlpha( 0 )
    panel_age:AlphaTo( 255, 2, 0, function() end )

    local te_age = GUI.DrawTextEntry( panel_age, panel_age:GetWide() / 3, 46, panel_age:GetWide() / 2 - ( panel_age:GetWide() / 3 ) / 2, panel_age:GetTall() / 2 - 46 / 2 + 16, UI.SafeFont( '45 Ambi' ), C.BLACK, '', C.AMBI_GRAY, 'Press here', false, true )

    margin_y = margin_y + panel_age:GetTall()

    -- ================================================================= --
    local panel_gender_and_nation = GUI.DrawPanel( forma, forma:GetWide() - 8, forma:GetTall() / count_panels - 4, 4, 4 + margin_y, function( self, w, h ) 
        -- Draw.Box( w, h, 0, 0, C.PURPLE ) -- debug

        Draw.SimpleText( 100, h / 2 - 32, '4. Гендер', UI.SafeFont( '40 Bookerly Light' ), C.ABS_WHITE, 'center', 1, C.ABS_BLACK )
        Draw.SimpleText( w - 120, h / 2 - 32, '5. Национальность', UI.SafeFont( '30 Bookerly Light' ), C.ABS_WHITE, 'center', 1, C.ABS_BLACK )
    end )
    panel_gender_and_nation:SetAlpha( 0 )
    panel_gender_and_nation:AlphaTo( 255, 2, 0, function() end )

    local cbox_gender = GUI.DrawComboBox( panel_gender_and_nation, panel_gender_and_nation:GetWide() / 4, 40, 24, 50, UI.SafeFont( '28 Ambi' ), '', function( self, nIndex, sValue ) 
    end )

    for _, gender in ipairs( Ambi.Authorization.Config.genders ) do
        cbox_gender:AddChoice( gender )
    end

    local cbox_nationality = GUI.DrawComboBox( panel_gender_and_nation, panel_gender_and_nation:GetWide() / 4, 40, panel_gender_and_nation:GetWide() - ( panel_gender_and_nation:GetWide() / 4 ) - 24, 50, UI.SafeFont( '22 Ambi' ), '', function( self, nIndex, sValue ) 
    end )

    for _, nationality in ipairs( Ambi.Authorization.Config.nationalities ) do
        cbox_nationality:AddChoice( nationality )
    end

    margin_y = margin_y + panel_gender_and_nation:GetTall()

    local register = GUI.DrawButton( main_menu, 420, 45, main_menu:GetWide() / 2 - 420 / 2, main_menu:GetTall() - 45 - 32, nil, nil, nil, function( self )
        if not Ambi.Authorization.CheckNationality( cbox_nationality:GetValue() ) then surface.PlaySound( 'Error4' ) reason_failed = '• Не выбрана национальность' return end
        if not Ambi.Authorization.CheckGender( cbox_gender:GetValue() ) then surface.PlaySound( 'Error4' ) reason_failed = '• Не выбран гендер' return end
        if not Ambi.Authorization.CheckAge( tonumber( te_age:GetValue() ) ) then surface.PlaySound( 'Error4' ) reason_failed = '• Неправильный возраст, от '..Ambi.Authorization.Config.check_age_min..' до '..Ambi.Authorization.Config.check_age_max return end
        if not Ambi.Authorization.CheckName( te_last_name:GetValue() ) then surface.PlaySound( 'Error4' ) reason_failed = '• Некорректная фамилия (Без запретных символов, минимум '..Ambi.Authorization.Config.check_name_min_len..' символа и макс '..Ambi.Authorization.Config.check_name_max_len..')' return end
        if not Ambi.Authorization.CheckName( te_name:GetValue() ) then surface.PlaySound( 'Error4' ) reason_failed = '• Некорректное имя (Без запретных символов, минимум '..Ambi.Authorization.Config.check_name_min_len..' символа и макс '..Ambi.Authorization.Config.check_name_max_len..')' return end
        
        -- surface.PlaySound( 'ambi/painkiller/pact.ogg' ) --! мешает для cl_guide
        
        self:Remove()
        main_menu:Remove()

        if IsValid( sound_track ) then
            sound_track:Stop()
            sound_track = nil
        end

        net.Start( 'ambi_authorization_register_end' )
            net.WriteString( te_name:GetValue() )
            net.WriteString( te_last_name:GetValue() )
            net.WriteUInt( tonumber( te_age:GetValue() ), 12 )
            net.WriteString( cbox_gender:GetValue() )
            net.WriteString( cbox_nationality:GetValue() )
        net.SendToServer()

        local header = GUI.DrawPanel( frame, frame:GetWide(), frame:GetTall(), 0, 0, function( self, w, h )
            Draw.SimpleText( w / 2, 150, table.Random( Ambi.Authorization.Config.headers_post_authorization ), UI.SafeFont( '64 Bookerly Light' ), C.AMBI_BLOOD, 'top-center', 1, C.ABS_BLACK )
        end )
        header:SetAlpha( 0, 0 )
        header:AlphaTo( 255, 2, 0, function() end )

        frame:SetKeyboardInputEnabled( false )
        frame:SetMouseInputEnabled( false )

        frame:AlphaTo( 0, 10, 1, function() 
            frame:Remove()
            header:Remove()
        end )
        gui.EnableScreenClicker( false )

        AmbGuide.startGuide()
    end, function( self, w, h ) 
        ------------------------------------------------------------------------------
        Draw.Box( w, 2, 0, h - 2, self.color, 8 )

        Draw.SimpleText( w / 2, h / 2 - 2, self.text, UI.SafeFont( '45 Bookerly Light' ), C.ABS_WHITE, 'center', 1, C.ABS_BLACK )
    end )
    register:SetAlpha( 0 )
    register:AlphaTo( 255, 6, 0, function() end )
    register.color = C.ABS_WHITE
    register.text = 'ЗАРЕГИСТРИРОВАТЬСЯ'
    register.font = UI.SafeFont( '45 Bookerly Light' )

    GUI.OnCursor( register, function()
        register.color = C.AMBI_BLOOD
        register.font = UI.SafeFont( '43 Bookerly Light' )
        
        surface.PlaySound( 'Hover3' )
    end, function() 
        register.color = C.ABS_WHITE
        register.font = UI.SafeFont( '45 Bookerly Light' )
    end )

    local reason = GUI.DrawPanel( main_menu, main_menu:GetWide(), 40, 0, main_menu:GetTall() - 40 - register:GetTall() - 32 - 40, function( self, w, h ) 
        Draw.SimpleText( w / 2, h / 2, reason_failed, UI.SafeFont( '40 Bookerly Light' ), C.AMBI_RED, 'center', 1, C.ABS_BLACK )
    end )
end

-- --------------------------------------------------------------------------------------------------------------------------------------
hook.Add( 'InitPostEntity', 'Ambi.Authorization.OpenMenu', Ambi.Authorization.OpenMenu )

local TYPES = {
    [ 'joinleave' ] = true,
    [ 'namechange' ] = true,
    [ 'teamchange' ] = true,
}
hook.Add( 'ChatText', 'Ambi.Authorization.RemoveTypes', function( index, name, text, type )
	if TYPES[ type ] then return true end
end )