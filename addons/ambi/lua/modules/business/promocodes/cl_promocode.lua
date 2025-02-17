Ambi.Business.Promocode = Ambi.Business.Promocode or {}
Ambi.Business.Promocode.promocodes = Ambi.Business.Promocode.promocodes or {}

local C, GUI, Draw, UI = Ambi.Packages.Out( '@d' )
local W, H = ScrW(), ScrH()

-- --------------------------------------------------------------------------------------------------------------------------------------
function Ambi.Business.Promocode.Show()
    local frame = GUI.DrawFrame( nil, 600, 400, W / 2 - 600 / 2, H / 2 - 400 / 2, '', true, true, true, function( self, w, h )
        Draw.Box( w, h, 0, 0, C.AMBI_BLACK )
        Draw.Text( w / 2, 4, 'Система Промокодов', UI.SafeFont( '22 Arial' ), C.ABS_WHITE, 'top-center' )

        Draw.Text( 4, 84, '• Введите промокод в окне, чтобы получить бонус!', UI.SafeFont( '22 Arial' ), C.ABS_WHITE, 'top-left' )

        Draw.Text( 4, 84 * 2, '1. Промокод можно вводить, как маленькими, так большими буквами', UI.SafeFont( '22 Arial' ), C.ABS_WHITE, 'top-left' )
        Draw.Text( 4, 84 * 2 + 24, '2. Неверный промокод будет считаться как неведённый', UI.SafeFont( '22 Arial' ), C.ABS_WHITE, 'top-left' )
    end )

    local code = GUI.DrawTextEntry( frame, 150, 34, frame:GetWide() / 2 - 150 / 2, 32, UI.SafeFont( '32 Arial' ), C.AMBI_BLACK, nil, nil, '', false, false )

    local drop = GUI.DrawButton( frame, 100, 25, frame:GetWide() / 2 - 100 / 2 - 100, frame:GetTall() - 25 - 4, nil, nil, nil, function( self )
        local code = code:GetValue()

        frame:Remove()

        if not string.IsValid( code ) then return end
        if ( utf8.len( code ) > 10 ) then return end

        code = string.ForceLower( code )

        net.Start( 'ambi_business_promocode' )
            net.WriteString( code )
        net.SendToServer()
    end, function( self, w, h )
        Draw.Box( w, h, 0, 0, C.AMBI_PANEL )
        Draw.Text( w / 2, h / 2, 'Ввести', UI.SafeFont( '22 Arial' ), C.FLAT_BLUE, 'center' )
    end )

    local cancel = GUI.DrawButton( frame, 100, 25, frame:GetWide() / 2 - 100 / 2 + 40, frame:GetTall() - 25 - 4, nil, nil, nil, function( self )
        frame:Remove()
    end, function( self, w, h )
        Draw.Box( w, h, 0, 0, C.AMBI_PANEL )
        Draw.Text( w / 2, h / 2, 'Отказаться', UI.SafeFont( '22 Arial' ), C.FLAT_RED, 'center' )
    end )
end
concommand.Add( 'ambi_promocode', Ambi.Business.Promocode.Show )