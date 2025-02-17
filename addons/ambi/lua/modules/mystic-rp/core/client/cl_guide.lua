local C, GUI, Draw, UI, CL = Ambi.Packages.Out( '@d, ContentLoader' )

CL.CreateDir( 'mystic-rp' )

CL.DownloadMaterial( 'guide_1', 'mystic-rp/guide_1.png', 'https://i.ibb.co/qNXh5G8/1.png' )
CL.DownloadMaterial( 'guide_2', 'mystic-rp/guide_2.png', 'https://i.ibb.co/GRcfMbT/2.png' )

AmbGuide = AmbGuide or {}

AmbGuide.guidePerson = 'Вася'

local w = ScrW()
local h = ScrH()
local COLOR_BLOCK = Color( 0, 0, 0, 150 )
local delay = 0

local _snd


AmbGuide.main = {
    {
        pos = Vector( -4168, -6485, 135 ),
        angle = Angle( 17, 52, 0 ),
        picture = CL.Material( 'guide_1' ),
        name = AmbGuide.guidePerson,
        sound = 'sound/mystic_rp/1str.mp3',
        text = 
        [[Оу, привет, ты попал на Мистик РП. Это такой же простой и любимый ДаркРП,
где копы, бандиты и маники, но с разными мистиками,
вампирами, демонами и прочей нечистью..]],
        delay = 4
    },

    {
        pos = Vector( 2640, -5309, -28 ),
        angle = Angle( 4, 104, 0 ),
        picture = CL.Material( 'guide_1' ),
        name = AmbGuide.guidePerson,
        sound = 'sound/mystic_rp/2str.mp3',
        text = 
        [[Ты в самом странном городе, где помимо человека обитают 
Тёмные и Светлые мистики, и вы сможете ими стать с помощью F4]],
        delay = 2
    },

    {
        pos = Vector( 2757, 826, -82 ),
        angle = Angle( 9, -167, 0 ),
        picture = CL.Material( 'guide_1' ),
        name = AmbGuide.guidePerson,
        sound = 'sound/mystic_rp/3str.mp3',
        text = 
        [[У нас очень мало правил, нет глупых НЛР и Fear RP,
просто играй) Зарабатывай уровень и деньги.]],
        delay = 3
    },

    {
        pos = Vector( -86, 1910, -35 ),
        angle = Angle( 25, -132, 0 ),
        picture = CL.Material( 'guide_1' ),
        name = AmbGuide.guidePerson,
        sound = 'sound/mystic_rp/4str.mp3',
        text = 
        [[Защищают от мистиков - инквизиция, 
а сотрудничают с этими тварями - культисты и сектанты. 
За кого будете играть вы?]],
        delay = 2
    },

    {
        pos = Vector( 880, -9968, 114 ),
        angle = Angle( 25, 70, 0 ),
        picture = CL.Material( 'guide_1' ),
        name = AmbGuide.guidePerson,
        sound = 'sound/mystic_rp/5str.mp3',
        text = 
        [[Ну что? понравилось? Пора играть,
вы начнёте квест и он вас познакомит с игрой]],
        delay = 2
    },
}

function AmbGuide.startGuide()
    AmbGuide.setFrame( 1, true )
end

function AmbGuide.setFrame( frame, bContinue )
    -- print('da') -- debug

    if ValidPanel( amb_guide_frame ) then amb_guide_frame:Remove() end

    AmbGuide.camPos( true, frame )
    
    amb_guide_frame = vgui.Create( 'DPanel' )
    amb_guide_frame:MakePopup()
    amb_guide_frame:SetSize( 640, 180 )
    amb_guide_frame:SetPos( w/2 - amb_guide_frame:GetWide()/2, h - amb_guide_frame:GetTall() )
    amb_guide_frame.Paint = function( self, w, h )
        draw.RoundedBox( 4, 0, 0, w, h, C.AMBI_BLOOD )
        draw.RoundedBox( 4, 4, 4, w-8, h-8, C.AMBI_BLACK )

        surface.SetFont( UI.SafeFont( '32 Ambi' ) )
        local x, _ = surface.GetTextSize(  AmbGuide.main[frame].name )
        draw.RoundedBox( 4, self:GetWide()/2, 18, x + 12, 28, COLOR_BLOCK )
        draw.SimpleText( AmbGuide.main[frame].name, UI.SafeFont( '32 Ambi' ), self:GetWide()/2 + 6, 30, C.AMBI_WHITE, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )

        surface.SetDrawColor( 255, 255, 255, 255 )
        surface.SetMaterial( CL.Material( 'guide_1' ) )
	    surface.DrawTexturedRect( 24, self:GetTall()/2-64, 128, 128 )
    end

    if IsValid( _snd ) then 
        _snd:Stop()
    end

    sound.PlayFile( AmbGuide.main[frame].sound, 'mono', function( audio ) 
        audio:Play()
        _snd = audio
    end )

    amb_guide_text = vgui.Create( "DLabel", amb_guide_frame )
    amb_guide_text:SetPos( 160, 52 )
    amb_guide_text:SetFont( 'HudHintTextLarge' )
    amb_guide_text:SetTextColor( C.AMBI_WHITE )
    amb_guide_text:SetText(AmbGuide.main[frame].text )
    amb_guide_text:SizeToContents()


    timer.Simple( AmbGuide.main[frame].delay, function()
        amb_guide_button = vgui.Create( 'DButton', amb_guide_frame )
        amb_guide_button:SetSize( 60, 32 )
        amb_guide_button:SetPos( amb_guide_frame:GetWide()/2-amb_guide_button:GetWide()/2, amb_guide_frame:GetTall() - amb_guide_button:GetTall() - 16 )
        amb_guide_button:SetFont( UI.SafeFont( '32 Ambi' ) )
        amb_guide_button:SetTextColor( C.AMBI_WHITE )
        amb_guide_button:SetText( '>>' )
        amb_guide_button.Paint = function( self, w, h )
            draw.RoundedBox( 2, 0, 0, w, h, C.AMBI_BLOOD )
            draw.RoundedBox( 2, 2, 2, w-4, h-4, C.AMBI_BLACK )
        end
        amb_guide_button.DoClick = function( self )
            amb_guide_frame:Remove()
            AmbGuide.camPos( false )
            if ( bContinue ) then
                if ( frame >= #AmbGuide.main ) then return AmbGuide.endGuide( true ) end
                AmbGuide.setFrame( frame+1, bContinue )
            end
        end
    end )
end

function AmbGuide.endGuide( flag )
    if ( flag ) then
        AmbGuide.camPos( true, #AmbGuide.main )
        
        local snd
        sound.PlayURL( 'https://github.com/Titanovsky/ambition_sites/raw/main/Pharmacist-North%20Memphis.mp3', 'mono', function( audioChannel ) 
            audioChannel:Play()

            snd = audioChannel
        end )

        amb_guide_end = vgui.Create( 'DPanel' )
        amb_guide_end:MakePopup()
        amb_guide_end:SetSize( 640, 180 )
        amb_guide_end:SetPos( w/2 - amb_guide_end:GetWide()/2, h - amb_guide_end:GetTall() )
        amb_guide_end.Paint = function( self, w, h )
            draw.RoundedBox( 4, 0, 0, w, h, C.AMBI_BLOOD )
            draw.RoundedBox( 4, 4, 4, w-8, h-8, C.AMBI_BLACK )

            surface.SetFont( UI.SafeFont( '32 Ambi' ) )
            local x, _ = surface.GetTextSize(  AmbGuide.main[#AmbGuide.main].name )
            draw.RoundedBox( 4, self:GetWide()/2, 18, x + 12, 28, COLOR_BLOCK )
            draw.SimpleText( AmbGuide.main[#AmbGuide.main].name, UI.SafeFont( '32 Ambi' ), self:GetWide()/2 + 6, 30, C.AMBI_WHITE, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )

            surface.SetDrawColor( 255, 255, 255, 255 )
            surface.SetMaterial( CL.Material( 'guide_1' ) )
            surface.DrawTexturedRect( 24, self:GetTall()/2-64, 128, 128 )
        end

        amb_guide_text = vgui.Create( "DLabel", amb_guide_end )
        amb_guide_text:SetPos( 160, 52 )
        amb_guide_text:SetFont( 'HudHintTextLarge' )
        amb_guide_text:SetTextColor( C.AMBI_WHITE )
        amb_guide_text:SetText( 'Эм.. Что?' )
        amb_guide_text:SizeToContents()

        if IsValid( _snd ) then
            _snd:Stop()
            _snd = nil
        end

        surface.PlaySound( 'mystic_rp/6str.mp3' )

        local bandit = vgui.Create( 'DPanel' )
        bandit:SetSize( 128, 128 )
        bandit:SetPos( w, h - amb_guide_end:GetTall() - 142 )
        bandit.Paint = function( self, w, h )
            draw.RoundedBox( 0, 0, 0, w, h, Color(0,0,0,0) )

            surface.SetDrawColor( 255, 255, 255, 255 )
            surface.SetMaterial( CL.Material( 'guide_2' ) )
            surface.DrawTexturedRect( 0, 0, 128, 128 )
        end

        bandit:MoveTo( w/2, h - amb_guide_end:GetTall() - 142, 14, 0, -1, function() end )

        timer.Simple( 15.6, function()
                AmbGuide.endGuide( false )
                bandit:Remove()

                amb_guide_end = vgui.Create( 'DPanel' )
                amb_guide_end:MakePopup()
                amb_guide_end:SetSize( 640, 180 )
                amb_guide_end:SetPos( w/2 - amb_guide_end:GetWide()/2, h - amb_guide_end:GetTall() )
                amb_guide_end.Paint = function( self, w, h )
                    draw.RoundedBox( 4, 0, 0, w, h, C.AMBI_BLOOD )
                    draw.RoundedBox( 4, 4, 4, w-8, h-8, C.AMBI_BLACK )

                    surface.SetDrawColor( 255, 255, 255, 255 )
                    surface.SetMaterial( CL.Material( 'guide_2' ) )
                    surface.DrawTexturedRect( 24, self:GetTall()/2-64, 128, 128 )
                end

                amb_guide_text = vgui.Create( "DLabel", amb_guide_end )
                amb_guide_text:SetPos( 160, 52 )
                amb_guide_text:SetFont( UI.SafeFont( '32 Ambi' ) )
                amb_guide_text:SetTextColor( C.AMBI_WHITE )
                amb_guide_text:SetText( 'Хватит Болтавни Погнали Играть!' )
                amb_guide_text:SizeToContents()

                amb_guide_button = vgui.Create( 'DButton', amb_guide_end )
                amb_guide_button:SetSize( 128, 42 )
                amb_guide_button:SetPos( amb_guide_end:GetWide()/2-amb_guide_button:GetWide()/2, amb_guide_end:GetTall() - amb_guide_button:GetTall() - 16 )
                amb_guide_button:SetFont( UI.SafeFont( '32 Ambi' ) )
                amb_guide_button:SetText( 'Играть' )
                amb_guide_button.Think = function()
                    amb_guide_button:SetTextColor( HSVToColor(  ( CurTime() * 64 ) % 360, 1, 1 ) )
                end
                amb_guide_button.Paint = function( self, w, h )
                    draw.RoundedBox( 2, 0, 0, w, h, C.AMBI_BLOOD )
                    draw.RoundedBox( 2, 2, 2, w-4, h-4, C.AMBI_BLACK )
                end
                amb_guide_button.DoClick = function( self )
                    amb_guide_end:Remove()
                    AmbGuide.camPos( false )
                    LocalPlayer():ConCommand('ambi_hud 1')

                    if IsValid( snd ) then 
                        snd:Stop() 
                        snd = nil 
                    end
                end
            end )
    else
        if ValidPanel( amb_guide_end ) then amb_guide_end:Remove() end
    end
end
concommand.Add( 'ambi_guide', function() AmbGuide.startGuide() end )

function AmbGuide.camPos( start, frame )
    if ( start ) then
        hook.Add( 'CalcView', 'amb_0x8', function( ply, vector_pos, angle_angle, fov )
            local view = {
                origin = AmbGuide.main[frame].pos,
                angles = AmbGuide.main[frame].angle,
                fov = fov,
                drawviewer = true
            }

            return view
        end )
    else
        hook.Remove( 'CalcView', 'amb_0x8' )
    end
end