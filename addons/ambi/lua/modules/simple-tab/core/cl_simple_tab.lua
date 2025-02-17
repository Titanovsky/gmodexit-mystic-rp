local C, GUI, Draw, UI = Ambi.Packages.Out( '@d' )

local W, H = ScrW(), ScrH()
local C_BACK = Color( 20, 20, 20, 235 )
local C_PANEL = Color( 0, 0, 0, 100 ) 

-- ---------------------------------------------------------------------------------------------------------------------------------------
function Ambi.SimpleTab.ShowTab()
    local all_players, max_players = #player.GetAll(), game.MaxPlayers()

    local C_ALL = Ambi.SimpleTab.Config.color_main
    local C_HEADER = Ambi.SimpleTab.Config.color_header
    
    local panel = GUI.DrawPanel( nil, W / 2, H / 1.1, 0, 0, function( self, w, h ) 
        --Draw.Box( w, h, 0, 0, C_BACK )
        Draw.SimpleText( w / 2, 6, Ambi.SimpleTab.Config.header_text, UI.SafeFont( Ambi.SimpleTab.Config.header_front ), C_HEADER, 'top-center', 1, C.ABS_BLACK )
        Draw.SimpleText( w - 2, 6 + 36, all_players..'/'..max_players, UI.SafeFont( '32 Slimamif Medium' ), Ambi.SimpleTab.Config.color_text_up, 'top-right', 1, C.ABS_BLACK )
        Draw.SimpleText( 2, 6 + 18, Ambi.Date and Ambi.Date.GetTimeNiceFormat() or os.date( '%X', os.time() - 60 * 60 * 2 ), UI.SafeFont( '54 Slimamif Medium' ), Ambi.SimpleTab.Config.color_text_up, 'top-left', 1, C.ABS_BLACK )
    end )
    panel:Center()

    local subpanel = GUI.DrawPanel( panel, panel:GetWide(), panel:GetTall() - 72, 0, 72, function( self, w, h ) 
        if Ambi.SimpleTab.Config.blur then Draw.Blur( self, 1 ) end
        
        Draw.Box( w, 2, 0, 0, C_ALL )
        Draw.Box( w, 2, 0, h - 2, C_ALL )

        Draw.Box( 2, h, 0, 0, C_ALL )
        Draw.Box( 2, h, w - 2, 0, C_ALL )
    end )

    local players = GUI.DrawScrollPanel( subpanel, subpanel:GetWide() - 4, subpanel:GetTall() - 4, 2, 2, function( self, w, h ) 
        Draw.Box( w, h, 0, 0, C_BACK )
    end )

    players:GetVBar():SetSize( 0 )

    local tab_players = player.GetAll()
    for i, ply in ipairs( tab_players ) do
        if ply == LocalPlayer() then
            tab_players[ 1 ], tab_players[ i ] = tab_players[ i ], tab_players[ 1 ]

            break
        end
    end

    local actions = {}
    for i, ply in ipairs( tab_players ) do
        local panel = GUI.DrawPanel( players, players:GetWide(), 66, 0, 66 * ( i - 1 ), function( self, w, h ) 
            if not IsValid( ply ) then self:Remove() return end

            Draw.Box( w, 2, 0, h - 2, C_ALL )
            Draw.Box( 2, h, 64, 0, C_ALL )

            if ply:IsBot() then
                Draw.Box( 64, 64, 0, 0, C.ABS_WHITE )
                Draw.SimpleText( 4, h / 2, '( ͡° ͜ʖ ͡°)', '26 Ambi', C.ABS_BLACK, 'center-left' )
            end
        end )

        local id, name, team_name, team_color = ply:EntIndex(), ply:Name(), ply:TeamName(), ply:TeamColor()
        if Ambi.SimpleTab.Config.show_entindex_with_nick then name = '['..id..'] '..name end

        local info = GUI.DrawButton( panel, panel:GetWide() - 66, panel:GetTall() - 2, 66, 0, nil, nil, nil, function( self )
        end, function( self, w, h ) 
            if not IsValid( ply ) then self:Remove() return end

            Draw.SimpleText( 2, 2, name, UI.SafeFont( '28 Ambi' ), C.ABS_WHITE, 'top-left', 1, C.ABS_BLACK )
            Draw.SimpleText( 2, 28, team_name, UI.SafeFont( '16 Ambi' ), team_color, 'top-left', 1, C.ABS_BLACK )

            Draw.SimpleText( w - 22, 4, 'Ping', UI.SafeFont( '12 Ambi' ), C.ABS_WHITE, 'top-center', 1, C.ABS_BLACK )
            Draw.SimpleText( w - 23, 20, ply:Ping(), UI.SafeFont( '15 Ambi' ), C.ABS_WHITE, 'top-center', 1, C.ABS_BLACK )

            Draw.SimpleText( w - 22 - 40, 4, 'Frags', UI.SafeFont( '12 Ambi' ), C.ABS_WHITE, 'top-center', 1, C.ABS_BLACK )
            Draw.SimpleText( w - 23 - 40, 20, ply:Frags(), UI.SafeFont( '15 Ambi' ), C.ABS_WHITE, 'top-center', 1, C.ABS_BLACK )

            Draw.SimpleText( w - 22 - 40 * 2, 4, 'Deaths', UI.SafeFont( '12 Ambi' ), C.ABS_WHITE, 'top-center', 1, C.ABS_BLACK )
            Draw.SimpleText( w - 23 - 40 * 2, 20, ply:Deaths(), UI.SafeFont( '15 Ambi' ), C.ABS_WHITE, 'top-center', 1, C.ABS_BLACK )
        end )

        GUI.OnCursor( info, function()
            info:SetCursor( 'arrow' )

            if ( #actions > 0 ) then
                for i, panel in ipairs( actions ) do panel:Remove() end
            end
            actions = {}

            local goto_btn = GUI.DrawButton( info, 54, 24, info:GetWide() - 54 - 4, info:GetTall() - 24 - 4, nil, nil, nil, function( self )
                LocalPlayer():ConCommand( 'ulx goto "'..ply:Name()..'"' )
            end, function( self, w, h ) 
                Draw.Box( w, h, 0, 0, C_PANEL, 6 )
                Draw.SimpleText( w / 2, h / 2, 'Goto', UI.SafeFont( '20 Ambi' ), C.ABS_WHITE, 'center', 1, C.ABS_BLACK )
            end )
            actions[ #actions + 1 ] = goto_btn

            local offset_x = goto_btn:GetWide() + 2
            local bring_btn = GUI.DrawButton( info, 54, 24, info:GetWide() - 54 - 4 - offset_x, info:GetTall() - 24 - 4, nil, nil, nil, function( self )
                LocalPlayer():ConCommand( 'ulx bring "'..ply:Name()..'"' )
            end, function( self, w, h ) 
                Draw.Box( w, h, 0, 0, C_PANEL, 6 )
                Draw.SimpleText( w / 2, h / 2, 'Bring', UI.SafeFont( '20 Ambi' ), C.ABS_WHITE, 'center', 1, C.ABS_BLACK )
            end )
            actions[ #actions + 1 ] = bring_btn

            local offset_x = offset_x + bring_btn:GetWide() + 2
            local return_btn = GUI.DrawButton( info, 54, 24, info:GetWide() - 54 - 4 - offset_x, info:GetTall() - 24 - 4, nil, nil, nil, function( self )
                LocalPlayer():ConCommand( 'ulx return "'..ply:Name()..'"' )
            end, function( self, w, h ) 
                Draw.Box( w, h, 0, 0, C_PANEL, 6 )
                Draw.SimpleText( w / 2, h / 2, 'Return', UI.SafeFont( '20 Ambi' ), C.ABS_WHITE, 'center', 1, C.ABS_BLACK )
            end )
            actions[ #actions + 1 ] = return_btn

            local offset_x = offset_x + return_btn:GetWide() + 2
            local kick_btn = GUI.DrawButton( info, 54, 24, info:GetWide() - 54 - 4 - offset_x, info:GetTall() - 24 - 4, nil, nil, nil, function( self )
                LocalPlayer():ConCommand( 'ulx kick "'..ply:Name()..'" "!"' )
            end, function( self, w, h ) 
                Draw.Box( w, h, 0, 0, C_PANEL, 6 )
                Draw.SimpleText( w / 2, h / 2, 'Kick', UI.SafeFont( '20 Ambi' ), C.ABS_WHITE, 'center', 1, C.ABS_BLACK )
            end )
            actions[ #actions + 1 ] = kick_btn

            if ( ply != LocalPlayer() ) then
                offset_x = offset_x + kick_btn:GetWide() + 2
                local gag = GUI.DrawButton( info, 54, 24, info:GetWide() - 54 - 4 - offset_x, info:GetTall() - 24 - 4, nil, nil, nil, function()
                    if ply:IsMuted() then
                        ply:SetMuted( false )
                    else
                        ply:SetMuted( true )
                    end
                end, function( self, w, h ) 
                    if not IsValid( ply ) then self:Remove() return end
    
                    Draw.Box( w, h, 0, 0, C_PANEL, 6 )
                    Draw.SimpleText( w / 2, h / 2, ply:IsMuted() and 'UnGag' or 'Gag', UI.SafeFont( '16 Ambi' ), C.ABS_WHITE, 'center', 1, C.ABS_BLACK )
                end )

                actions[ #actions + 1 ] = gag
            end
        end )

        -- Actions ----------------------------------------------
        ---------------------------------------------------------

        if ply:IsBot() then continue end

        local avatar = GUI.DrawAvatar( panel, 64, 64, 0, 0, 64, ply )
        local avatar_button = GUI.DrawButton( avatar, avatar:GetWide(), avatar:GetTall(), 0, 0, nil, nil, nil, function()
            ply:ShowProfile()

            chat.AddText( C.ABS_WHITE, 'https://steamcommunity.com/profiles/'..ply:SteamID64() )
        end, function( self, w, h ) 
        end )

        local sid = ply:SteamID()
        avatar_button.DoRightClick = function() 
            chat.AddText( C.ABS_WHITE, sid )
            SetClipboardText( sid ) 
        end
    end

    Ambi.SimpleTab.tab = panel
end

hook.Add( 'ScoreboardShow', 'Ambi.SimpleTab.Tab', function()
    Ambi.SimpleTab.ShowTab()
    gui.EnableScreenClicker( true ) 

	return false
end )

hook.Add( 'ScoreboardHide', 'Ambi.SimpleTab.Tab', function()
    if Ambi.SimpleTab.tab then Ambi.SimpleTab.tab:Remove() end
    gui.EnableScreenClicker( false )
    
	return false
end )