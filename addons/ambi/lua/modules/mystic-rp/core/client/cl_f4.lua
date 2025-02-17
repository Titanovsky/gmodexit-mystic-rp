local C, GUI, Draw, UI, CL = Ambi.Packages.Out( '@d, ContentLoader' )
local CacheURL = Ambi.Cache.CacheURL
local W, H = ScrW(), ScrH()

local COLOR_LINE, COLOR_BLUE = ColorAlpha( C.AMBI_BLOOD, 255 ), Color( 0, 145, 255 )
local COLOR_PANEL = Color( 0, 0, 0, 210 )
local COLOR_MYSTIC = Color(194,35,35)
local BUTTONS = 10

local FONT_HEADER = UI.SafeFont( '28 Diablo' )
local URL_SOUND = 'https://github.com/Titanovsky/ambition_sites/raw/main/Blurred%20-%20Shadows.mp3'
local COLOR_BACKGROUND_MAT = 'mrp_f4_background1'

local save_page
local snd

-- --------------------------------------------------------------------------------------------------------------------------------------
local function GetJobs()
    local jobs = SortedPairsByMemberValue( Ambi.DarkRP.GetJobs(), 'category' )
    jobs = SortedPairsByMemberValue( jobs, 'order' )

    return jobs
end

-- --------------------------------------------------------------------------------------------------------------------------------------
function Ambi.DarkRP.MysticRPOpenF4Menu()
    if not snd then
        sound.PlayURL( URL_SOUND, 'mono noblock', function( audioChannel ) 
            audioChannel:Play()
            audioChannel:SetVolume( 0.5 )
            audioChannel:EnableLooping( true )

            snd = audioChannel
        end )
    else
        snd:Play()
    end

    local ambi_market_banner = Material( Ambi.Cache.GetCacheFile( 'ambi_market_banner.png' ) )
    if ambi_market_banner:IsError() then Ambi.Cache.CacheURL( 'ambi_market_banner.png', 'https://i.ibb.co/Q8h58p2/ambi-market-banner1.png', 12 ) end

    local w, h = W, H
    local frame = GUI.DrawFrame( nil, w, h, W / 2 - w / 2, H / 2 - h / 2, '', true, false, false, function( self, w, h ) 
        Draw.Material( w, h, 0, 0, CL.Material( COLOR_BACKGROUND_MAT ) )
        Draw.Blur( self, 1 )

        Draw.SimpleText( 10 + self.pages:GetWide() + 20, 22, self.header, UI.SafeFont( '54 Ambi Bold' ), C.ABS_WHITE, 'top-left', 1, C.ABS_BLACK )
    end )
    frame.OnKeyCodePressed = function( self, nKey )
        if ( nKey == KEY_F4 ) then self:AlphaTo( 0, 0.3, 0, function() self:Remove() end ) end
    end
    frame.OnRemove = function( self )
        if snd then snd:Pause() end
        timer.Create( 'AmbiDarkRPF4Menu1', 0.25, 1, function() end )
    end
    frame:Center()
    frame:SetAlpha( 0 )
    frame:AlphaTo( 255, 0.3, 0, function() end )
    frame.header = ''

    ambi_mysticrp_f4 = frame

    local btn_close = GUI.DrawButton( frame, 146, 36, frame:GetWide() - 146 - 8, 32, nil, nil, nil, function()
        LocalPlayer():EmitSound( 'buttons/button15.wav', nil, 135, .1 )

        frame:AlphaTo( 0, 0.3, 0, function() frame:Remove() end )
    end, function( self, w, h ) 
        Draw.Box( w, h, 0, 0, C.ABS_BLACK )
        Draw.Box( 32, h, 0, 0, C.ABS_WHITE )
        Draw.SimpleText( w - 4, h / 2, 'Закрыть', UI.SafeFont( '24 Diablo' ), C.ABS_WHITE, 'center-right', 1, C.ABS_BLACK )
        Draw.SimpleText( 5, h / 2, '✖', UI.SafeFont( '24 Ambi' ), C.ABS_BLACK, 'center-left' )
    end )

    local pages = GUI.DrawScrollPanel( frame, frame:GetWide() / 5, frame:GetTall() - 20, 10, 10, function( self, w, h ) 
        Draw.Box( w, h, 0, 0, COLOR_PANEL )
    end )
    frame.pages = pages

    local main = GUI.DrawScrollPanel( frame, frame:GetWide() - pages:GetWide() - 20 - 24, frame:GetTall() - 80 - 10, 10 + pages:GetWide() + 24, 80, function( self, w, h ) 
        Draw.Box( w, h, 0, 0, COLOR_PANEL )
    end )

    local buttons = {}
    for i = 1, BUTTONS do
        local page = GUI.DrawButton( pages, pages:GetWide(), 56, 0, ( i - 1 ) * 56, nil, nil, nil, function( self ) 
            if not self.Action then return end

            main:Clear()
            LocalPlayer():EmitSound( 'buttons/button15.wav', nil, 135, .1 )
            save_page = i
            self.Action( self )

            frame.header = buttons[ i ].text
        end, function( self, w, h ) 
            Draw.Box( w, h, 0, 0, self.color )
            Draw.SimpleText( w / 2, h / 2, '♦ '..self.text, FONT_HEADER, self.color_text, 'center', 1, C.ABS_BLACK )
        end )
        page.text = 'Page'
        page.color = Color( 0, 0, 0, 0 )
        page.color_text = C.AMBI_WHITE
        GUI.OnCursor( page, function()
            LocalPlayer():EmitSound( 'buttons/button15.wav', nil, 75, .1 ) 
            page.color = C.ABS_BLACK
        end, function() 
            page.color = Color( 0, 0, 0, 0 )
        end )

        buttons[ i ] = page
    end

    local home = buttons[ 1 ]
    if Ambi.DarkRP.Config.f4menu_show_home then
        home.text = 'Основное'
        home.Action = function()
            local panel = GUI.DrawPanel( main, main:GetWide(), main:GetTall(), 0, 0, function( self, w, h ) 
                Draw.SimpleText( 136, 4, LocalPlayer():Nick(), UI.SafeFont( '26 Ambi' ), C.ABS_WHITE, 'top-left', 1, C.ABS_BLACK )
                Draw.SimpleText( 136, 28 * 1, LocalPlayer():JobName(), UI.SafeFont( '26 Ambi' ), LocalPlayer():TeamColor(), 'top-left', 1, C.ABS_BLACK )
                Draw.SimpleText( 136, 28 * 2, LocalPlayer():GetMoney()..Ambi.DarkRP.Config.money_currency_symbol, UI.SafeFont( '26 Nexa Script Light' ), C.AMBI_GREEN, 'top-left', 1, C.ABS_BLACK )

                Draw.Box( w, 2, 0, 128, C.AMBI_BLACK )
                Draw.Box( 2, 128, 128, 0, C.AMBI_BLACK )
            end )

            GUI.DrawAvatar( panel, 128, 128, 0, 0, 128 )

            local banner = GUI.DrawButton( panel, 144, 94, panel:GetWide() - 144 - 4, panel:GetTall() - 94 - 4, nil, nil, nil, function()
                gui.OpenURL( 'https://vk.com/ambi_market' )
            end, function( self, w, h ) 
                Draw.Box( w, h, 0, 0, C.AMBI_BLACK, 8 )
                Draw.Box( w - 4, h - 4, 2, 2, self.color, 8 )
                Draw.Material( w, h, 0, 0, ambi_market_banner )
            end )
            banner.color = C.AMBI_WHITE
            banner:SetTooltip( 'Ambi Market — место, где можно Создать DarkRP и Заказать Отличные Скрипты :)' )

            GUI.OnCursor( banner, function()
                banner.color = COLOR_BLUE

                LocalPlayer():EmitSound( 'buttons/button15.wav', nil, 25, .1 ) 
            end, function() 
                banner.color = C.AMBI_WHITE
            end )
        end
    end

    local jobs = buttons[ 2 ]
    if Ambi.DarkRP.Config.f4menu_show_jobs then
        jobs.text = 'Работы'
        jobs.Action = function()
            local panel = GUI.DrawScrollPanel( main, main:GetWide(), main:GetTall(), 0, 0, function( self, w, h )
            end )

            local jobs = GUI.DrawScrollPanel( panel, panel:GetWide() / 3, main:GetTall(), 0, 0, function( self, w, h )
            end )

            local job_info = GUI.DrawScrollPanel( panel, panel:GetWide() - jobs:GetWide(), main:GetTall(), jobs:GetWide(), 0, function( self, w, h )
                -- Draw.Box( w, h, 0, 0, C.AMBI_BLACK, 8 ) -- debug

                Draw.SimpleText( 8, 4, self.header, '38 Ambi', C.ABS_WHITE, 'top-left', 1, C.ABS_BLACK )
                --Draw.Text( 8, 64, self.desc, '22 Ambi', C.ABS_WHITE, 'top-left', 1, C.ABS_BLACK )
            end )
            job_info.header = ''
            job_info.desc = ''

            local i = -1
            for class, job in SortedPairsByMemberValue( Ambi.DarkRP.GetJobs(), 'category' ) do
                if not job then continue end
                if ( job.can_join_command == false ) then continue end
                if not Ambi.DarkRP.Config.f4menu_show_restrict_items_and_jobs then
                    local class = job.from 
                    if class then
                        if isstring( class ) then
                            if ( LocalPlayer():Job() != class ) then continue end
                        elseif isnumber( class ) then
                            if ( LocalPlayer():Team() != class ) then continue end
                        end
                    end
                end

                i = i + 1

                local count_workers = #team.GetPlayers( job.index )

                local job_panel = GUI.DrawButton( jobs, jobs:GetWide(), 64, 0, 64 * i, nil, nil, nil, function()
                    job_info:Clear()

                    job_info.header = job.name
                    job_info.desc = job.description

                    local join = GUI.DrawButton( job_info, 140, 52, 8, job_info:GetTall() - 52 - 4, nil, nil, nil, function()
                        LocalPlayer():EmitSound( 'buttons/button15.wav', nil, 135, .1 )
    
                        if ( LocalPlayer():Job() == class ) then chat.AddText( C.ERROR, '•  ', C.ABS_WHITE, 'Нельзя поменять работу на свою же работу!' ) return frame:Remove() end
                        
                        if ( #job.models == 1 ) then
                            if timer.Exists( 'BlockF4MenuSetJob' ) then return end
                            timer.Create( 'BlockF4MenuSetJob', 1.25, 1, function() end )
    
                            LocalPlayer():EmitSound( 'buttons/button15.wav', nil, 135, .1 )
    
                            net.Start( 'ambi_darkrp_f4menu_set_job' )
                                net.WriteString( class )
                                net.WriteUInt( 1, 10 )
                            net.SendToServer()
    
                            frame:Remove()
                        else
                            job_info:Clear()
                            job_info.header = ''
                            job_info.desc = ''
    
                            local i = -1
                            for index, model in ipairs( job.models ) do
                                local name = string.Explode( '/', model )
                                name = name[ #name ]
    
                                name = string.Explode( '.', name )
                                name = name[ 1 ]
    
                                i = i + 1
                                local job_model = GUI.DrawButton( job_info, job_info:GetWide(), 64, 0, 64 * i, nil, nil, nil, function()
                                    if timer.Exists( 'BlockF4MenuSetJob' ) then return end
                                    timer.Create( 'BlockF4MenuSetJob', 1.25, 1, function() end )
    
                                    LocalPlayer():EmitSound( 'buttons/button15.wav', nil, 135, .1 )
    
                                    net.Start( 'ambi_darkrp_f4menu_set_job' )
                                        net.WriteString( class )
                                        net.WriteUInt( index, 10 )
                                    net.SendToServer()
    
                                    frame:Remove()
                                end, function( self, w, h ) 
                                    --Draw.Box( w, h, 0, 0, self.col )
                                    Draw.SimpleText( 68, h / 2, name, UI.SafeFont( '24 Ambi' ), C.ABS_WHITE, 'top-left', 1, C.ABS_BLACK )
                                end )
                                job_model.col = C.AMBI_WHITE
    
                                GUI.OnCursor( job_model, function()
                                    job_model.col = ColorAlpha( C.ABS_BLACK, 100 )
    
                                    LocalPlayer():EmitSound( 'buttons/button15.wav', nil, 25, .1 ) 
                                end, function() 
                                    job_model.col = C.AMBI_WHITE
                                end )
    
                                GUI.DrawModel( job_model, 64, 64, 0, 0, model )
                            end
                        end
                    end, function( self, w, h ) 
                        Draw.Box( w, h, 0, 0, self.col )
                        Draw.SimpleText( w / 2, h / 2, 'ВСТУПИТЬ', UI.SafeFont( '32 Ambi' ), C.ABS_WHITE, 'center', 1, C.ABS_BLACK )
                    end )
                    join.col = COLOR_PANEL

                    local avatar = GUI.DrawModel3D( job_info, job_info:GetWide(), job_info:GetTall(), 84, -40, job.models[ 1 ] )

                    local job_desc = GUI.DrawScrollPanel( job_info, 330, job_info:GetTall() - 160, 6, 46, function( self, w, h )
                        --Draw.Box( w, h, 0, 0, COLOR_PANEL ) -- debug
        
                        --Draw.Text( 4, 4, job.description, UI.SafeFont( '18 Ambi' ), C.ABS_WHITE, 'top-left', 1, C.ABS_BLACK )
                    end )
                    job_desc:SetTooltip( job.description )

                    local text = vgui.Create( 'RichText', job_desc )
                    text:SetPos( 0, 0 )
                    text:SetSize( job_desc:GetWide(), job_desc:GetTall() )
                    text:AppendText( job.description )
                    text.PerformLayout = function( self )
                        self:SetFontInternal( UI.SafeFont( '26 Eirik Raude' ) )
                        self:SetFGColor( C.ABS_WHITE )
                    end
                end, function( self, w, h ) 
                    --Draw.Box( w, h, 0, 0, self.col ) -- debug

                    Draw.SimpleText( 68, 4, job.name, UI.SafeFont( '28 Ambi' ), C.ABS_WHITE, 'top-left', 1, C.ABS_BLACK )
                    if job.money then Draw.SimpleText( 68, 32, job.money..'$', UI.SafeFont( '22 Ambi' ), LocalPlayer():GetMoney() >= job.money and C.AMBI_GREEN or C.AMBI_RED, 'top-left', 1, C.ABS_BLACK ) end
                    if job.level then Draw.SimpleText( 68, 32, job.level..' LVL', UI.SafeFont( '22 Ambi' ), LocalPlayer():GetLevel() >= job.level and C.AMBI_GREEN or C.AMBI_RED, 'top-left', 1, C.ABS_BLACK ) end
                    Draw.Box( w, 4, 0, h - 4, C.AMBI_RED )

                    if job.max and ( job.max >= 1 ) then 
                        Draw.SimpleText( w - 18, h / 2, count_workers..'/'..job.max, UI.SafeFont( '18 Ambi' ), count_workers >= job.max and C.AMBI_RED or C.ABS_WHITE, 'center-right' ) 
                    end
                end )
                job_panel.col = C.AMBI_WHITE
                --job_panel:SetTooltip( job.description )

                GUI.OnCursor( job_panel, function()
                    job_panel.col = ColorAlpha( job.color, 100 )

                    LocalPlayer():EmitSound( 'buttons/button15.wav', nil, 25, .1 ) 
                end, function() 
                    job_panel.col = C.AMBI_WHITE
                end )
                
                GUI.DrawModel( job_panel, 64, 64, 0, 0, job.models[ 1 ] )

                local line = GUI.DrawPanel( job_panel, job_panel:GetWide(), 8, 0, job_panel:GetTall() - 8, function( self, w, h ) 
                    Draw.Box( w, h, 0, 0, job.color )
                end )
            end
        end
    end

    local shop = buttons[ 3 ]
    if Ambi.DarkRP.Config.f4menu_show_shop then
        shop.text = 'Магазин'
        shop.Action = function()
            local panel = GUI.DrawScrollPanel( main, main:GetWide(), main:GetTall(), 0, 0, function( self, w, h )
            end )

            local i = -1
            for class, item in SortedPairsByMemberValue( Ambi.DarkRP.GetShop(), 'category' ) do
                if not item then continue end
                if not Ambi.DarkRP.Config.f4menu_show_restrict_items_and_jobs then
                    if item.allowed then
                        local can

                        for _, job in ipairs( item.allowed ) do
                            if isnumber( job ) and ( LocalPlayer():Team() == job ) then can = true break 
                            elseif isstring( job ) and ( LocalPlayer():GetJob() == job ) then can = true break 
                            end
                        end

                        if not can then continue end
                    end
                end

                i = i + 1

                local price = item.GetPrice and item.GetPrice( LocalPlayer(), item ) or item.price

                local item_panel = GUI.DrawButton( panel, panel:GetWide(), 64, 0, 64 * i, nil, nil, nil, function()
                    LocalPlayer():EmitSound( 'buttons/button15.wav', nil, 135, .1 )
                    
                    if timer.Exists( 'BlockF4MenuBuyItem' ) then return end
                    timer.Create( 'BlockF4MenuBuyItem', 1, 1, function() end )

                    LocalPlayer():ConCommand( 'say /'..Ambi.DarkRP.Config.shop_buy_command..' '..class )
                end, function( self, w, h ) 
                    --Draw.Box( w, h, 0, 0, self.col ) -- debug

                    Draw.SimpleText( 68, 4, item.name, UI.SafeFont( '28 Ambi' ), C.ABS_WHITE, 'top-left', 1, C.ABS_BLACK )
                    Draw.SimpleText( 68, 4 + 28, price..Ambi.DarkRP.Config.money_currency_symbol, UI.SafeFont( '24 Nexa Script Light' ), LocalPlayer():GetMoney() >= price and C.AMBI_GREEN or C.AMBI_RED, 'top-left', 1, C.ABS_BLACK )
                    Draw.Box( w, 2, 0, h - 2, C.AMBI_BLACK )
                end )
                item_panel.col = C.AMBI_WHITE
                item_panel:SetTooltip( item.description )

                GUI.OnCursor( item_panel, function()
                    item_panel.col = ColorAlpha( C.ABS_WHITE, 50 )

                    LocalPlayer():EmitSound( 'buttons/button15.wav', nil, 25, .1 ) 
                end, function() 
                    item_panel.col = C.AMBI_WHITE
                end )
                
                GUI.DrawModel( item_panel, 64, 64, 0, 0, item.model )

                local line = GUI.DrawPanel( item_panel, item_panel:GetWide(), 8, 0, item_panel:GetTall() - 8, function( self, w, h ) 
                    --Draw.Box( w, h, 0, 0, item.color )
                end )
            end
        end
    end

    local settings = buttons[ 4 ]
    if Ambi.DarkRP.Config.f4menu_show_settings then
        settings.text = 'Настройка'
        settings.Action = function()
            local panel = GUI.DrawScrollPanel( main, main:GetWide(), main:GetTall(), 0, 0, function( self, w, h )
                Draw.Text( w / 2 - 84, h / 2, 'Скачайте модуль ', UI.SafeFont( '36 Ambi' ), C.ABS_WHITE, 'center', 1, C.ABS_BLACK ) 
                Draw.Text( w / 2 + 104, h / 2 + 2, 'Ambi Opti', UI.SafeFont( '36 Ambi' ), C.AMBI_BLUE, 'center', 1, C.ABS_BLACK ) 
            end )

            local button = GUI.DrawButton( panel, panel:GetWide(), panel:GetTall(), 0, 0, nil, nil, nil, function()
                gui.OpenURL( 'https://github.com/Titanovsky/AE-Opti' )
            end, function( self, w, h ) 
            end )
        end
    end

    local cmd_list = {}
    cmd_list[ 'Продать Все Двери' ] = Ambi.DarkRP.Config.doors_sell_all_command
    cmd_list[ 'Купить Патроны' ] = Ambi.DarkRP.Config.buy_auto_ammo_command
    cmd_list[ 'Выкинуть Оружие' ] = Ambi.DarkRP.Config.weapon_drop_command
    cmd_list[ 'Вкл/Выкл Комендантский Час' ] = Ambi.DarkRP.Config.goverment_lockdown_command

    local commands = buttons[ 5 ]
    if Ambi.DarkRP.Config.f4menu_show_commands then
        commands.text = 'Команды'
        commands.Action = function()
            local panel = GUI.DrawScrollPanel( main, main:GetWide(), main:GetTall(), 0, 0, function( self, w, h ) 
            end )

            local i = -1
            for name, command in pairs( cmd_list ) do
                if not command then continue end
                if ( command == Ambi.DarkRP.Config.goverment_lockdown_command ) and not LocalPlayer():IsMayor() then continue end

                local command = '/'..command

                i = i + 1
                
                local tw = Draw.GetTextSizeX( UI.SafeFont( '22 Ambi' ), name ) + 24
                local panel = GUI.DrawButton( panel, panel:GetWide(), 34, 0, 34 * i, nil, nil, nil, function()
                    LocalPlayer():EmitSound( 'buttons/button15.wav', nil, 135, .1 )
                    
                    LocalPlayer():ConCommand( 'say '..command )
                end, function( self, w, h ) 
                    Draw.Box( w, h, 0, 0, self.col )
                    Draw.SimpleText( w / 2, h / 2, name, UI.SafeFont( '22 Ambi' ), C.ABS_WHITE, 'center', 1, C.ABS_BLACK )
                    Draw.Box( tw, 2, w / 2 - tw / 2, h - 2, C.AMBI_BLACK )
                end )
                panel.col = Color( 0, 0, 0, 0 )
                panel:SetTooltip( command )

                GUI.OnCursor( panel, function()
                    panel.col = ColorAlpha( C.ABS_BLACK, 100 )

                    LocalPlayer():EmitSound( 'buttons/button15.wav', nil, 25, .1 ) 
                end, function() 
                    panel.col = Color( 0, 0, 0, 0 )
                end )
            end
        end
    end

    local inv = buttons[ 6 ]
    inv.text = 'Инвентарь'
    inv.Action = function()
        local panel = GUI.DrawScrollPanel( main, main:GetWide(), main:GetTall(), 0, 0, function( self, w, h )
        end )

        Ambi.Inv.Show( panel )
    end

    local skills = buttons[ 7 ]
    skills.text = 'Навыки'
    skills.Action = function()
        local panel = GUI.DrawScrollPanel( main, main:GetWide(), main:GetTall(), 0, 0, function( self, w, h )
        end )

        local w, h = panel:GetWide(), panel:GetTall()

        local i = 0
        for skill, tab in pairs( Ambi.Skills.GetSkills() ) do
            i = i + 1

            local skill_player = LocalPlayer():GetSkill( skill )
            local skill_next = math.min( #tab.nodes, skill_player + 1 )

            local panel = GUI.DrawPanel( panel, panel:GetWide(), 74, 4, ( 74 + 1 ) * ( i - 1 ), function( self, w, h )
                --Draw.Box( w, h, 0, 0, C.AMB_GRAY, 4, 'all' )
                Draw.SimpleText( w / 2, 0, tab.name, UI.SafeFont( '24 Ambi' ), C.ABS_WHITE, 'top-center' )
            end )

            if ( skill_player ~= #tab.nodes ) then
                local buy = GUI.DrawButton( panel, 400, 28, panel:GetWide() * .5 - 400 * .5, 24, nil, nil, nil, function()
                    if LocalPlayer():GetSkillPoints() < tab.nodes[ skill_next ].cost then return end

                    LocalPlayer():EmitSound( 'buttons/button15.wav', nil, 135, .1 )

                    frame:Remove()

                    net.Start( 'ambi_mystic_buy_skill' )
                        net.WriteString( skill )
                    net.SendToServer()
                end, function( self, w, h ) 
                    local color = LocalPlayer():GetSkillPoints() >= tab.nodes[ skill_next ].cost and C.GREEN or C.RED
                    Draw.Box( w, h, 0, 0, C.PANEL )
                    Draw.SimpleText( w / 2, h / 2, 'Улучшить', UI.SafeFont( '26 Ambi' ), color, 'center', 1, C.ABS_BLACK )
                end )
                panel.col = Color( 0, 0, 0, 0 )
            end

            local panel_max_w = math.floor( panel:GetWide() / 1.4 )
            local panel_max = GUI.DrawPanel( panel, panel_max_w, 20, panel:GetWide() / 2 - panel_max_w / 2, panel:GetTall() - 20 - 4, function( self, w, h ) 
                Draw.Box( w, h, 0, 0, ( skill_player >= #tab.nodes ) and C.FLAT_BLUE or C.ABS_WHITE )

                Draw.Box( w, 2, 0, 0, C.ABS_BLACK ) -- top
                Draw.Box( w, 2, 0, h - 2, C.ABS_BLACK ) -- bottom
                Draw.Box( 2, h - 2, 0, 2, C.ABS_BLACK ) -- left
                Draw.Box( 2, h - 2, w - 2, 2, C.ABS_BLACK ) -- right
            end )

            local text_max = GUI.DrawPanel( panel, 100, 22, panel:GetWide() / 2 - panel_max_w / 2 + panel_max_w + 2, panel:GetTall() - 20 - 4, function( self, w, h )
                Draw.SimpleText( 0, 0, #tab.nodes, UI.SafeFont( '22 Ambi' ), C.ABS_WHITE, 'top-left' )
            end )

            if ( skill_player >= #tab.nodes ) then continue end
            
            local text_xp = GUI.DrawPanel( panel, 100, 22, panel:GetWide() / 2 - panel_max_w / 2 - 100 - 4, panel:GetTall() - 20 - 4, function( self, w, h )
                Draw.SimpleText( w - 1, 0, skill_player, UI.SafeFont( '22 Ambi' ), C.ABS_WHITE, 'top-right' )
            end )

            -- w = 200
            -- xp = 300
            -- max = 600
            -- 1: max / xp = 600 / 300 = 2
            -- 2: w 
            local panel_xp_w = panel_max_w / ( #tab.nodes / skill_player )
            local panel_xp = GUI.DrawPanel( panel_max, panel_xp_w, 16, 2, 2, function( self, w, h ) 
                Draw.Box( w, h, 0, 0, C.AMBI_GREEN )
            end )
        end
    end

    local quests = buttons[ 8 ]
    quests.text = 'Квесты'
    quests.Action = function()
        local panel = GUI.DrawScrollPanel( main, main:GetWide(), main:GetTall(), 0, 0, function( self, w, h )
        end )

        local panel_daily = GUI.DrawScrollPanel( panel, panel:GetWide(), 240, 0, 0, function( self, w, h )
            Draw.Box( w, h, 0, 0, COLOR_PANEL )

            Draw.SimpleText( w / 2, 8, 'Ежедневные Задания', UI.SafeFont( '32 Ambi' ), C.ABS_WHITE, 'top-center' )
        end )

        for id, daily in ipairs( Ambi.Daily.dailies ) do
            local desc = daily.players[ LocalPlayer():SteamID() ] 
            and daily.Description( daily ) 
            or ( daily.count > 1 and daily.Description( daily )..' ['..LocalPlayer()[ 'nw_DailyCount'..id ]..'/'..daily.count..']' or daily.Description( daily )  ) -- такая хуебина честно

            local color = daily.players[ LocalPlayer():SteamID() ] and C.AMBI_GREEN or C.AMBI_RED
            
            local panel_daily = GUI.DrawPanel( panel_daily, panel:GetWide(), 32, 0, 40 + ( id - 1 ) * ( 28 + 2 ), function( self, w, h )
                Draw.SimpleText( 0, 0, '•', UI.SafeFont( '32 Ambi' ), color, 'top-left' )
                Draw.SimpleText( 24, 4, desc, UI.SafeFont( '28 Ambi' ), C.ABS_WHITE, 'top-left' )
            end )
        end
    end

    local rules = buttons[ 9 ]
    rules.text = 'Правила'
    rules.Action = function()
        frame:Remove()
        save_page = 1

        gui.OpenURL( 'https://docs.google.com/document/d/1K41QYZrnlcZDql39tHLCU4beyu3_YMVZb-MhYCN5oi8/edit?usp=sharing' )
    end

    local donate = buttons[ 10 ]
    donate.text = 'Донат'
    donate.color_text = Color(226,99,222)
    donate.Action = function()
        frame:Remove()
        save_page = 1
        IGS.UI()
    end

    --! only funcion's end
    if Ambi.DarkRP.Config.f4menu_show_home and not save_page then 
        home.Action() 
        frame.header = buttons[ 1 ].text
    else 
        if buttons[ save_page ] then
            if buttons[ save_page ].Action then buttons[ save_page ].Action() end
            frame.header = buttons[ save_page ].text
        end
    end
end
concommand.Add( 'ambi_mysticrp_f4menu_open', Ambi.DarkRP.OpenF4Menu )

-- --------------------------------------------------------------------------------------------------------------------------------------
hook.Add( 'PlayerButtonDown', 'Ambi.DarkRP.MysticRPOpenF4Menu', function( _, nButton ) 
    if Ambi.DarkRP.Config.f4menu_enable then return end
    if not input.IsKeyDown( KEY_F4 ) then return end
    if timer.Exists( 'AmbiDarkRPF4Menu1' ) then return end

    Ambi.DarkRP.MysticRPOpenF4Menu()
    timer.Create( 'AmbiDarkRPF4Menu1', 0.25, 1, function() end )
end )

-- --------------------------------------------------------------------------------------------------------------------------------------
net.Receive( 'ambi_mysticrp_sync_jobs', function() 
    local can_join_command = net.ReadBool()

    for class, _ in pairs( net.ReadTable() ) do
        local job = Ambi.DarkRP.GetJobs()[ class ]
        if not job then continue end

        job.can_join_command = can_join_command
    end
end )