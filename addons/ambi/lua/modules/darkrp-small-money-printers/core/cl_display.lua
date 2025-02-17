local C, GUI, Draw, UI = Ambi.Packages.Out( '@d' )

function Ambi.SmallMoneyPrinters.ShowDisplay( eObj )
    local pos = eObj:GetPos()
    local ang = eObj:GetAngles()
    local class = eObj:GetClass()

    local upgrade = eObj:GetUpgrade()
    if not upgrade then return end

    if ( class == 'smp_zero') then 
        ang:RotateAroundAxis( ang:Up(), 90 )

        cam.Start3D2D( pos + ang:Up() * 3.40, ang, 0.1 )
            Draw.Box( 142, 50, -70, -42, C.ABS_BLACK )

            local color = upgrade == 4 and C.ABS_WHITE or C.FLAT_GREEN
            Draw.SimpleText( 2, -18, tostring( eObj:GetMoney() ), UI.SafeFont( '42 Thintel' ), color, 'center', 1, C.ABS_BLACK )
            if ( eObj.max_upgrade > upgrade ) then Draw.SimpleText( 2, 32, upgrade..'/'..eObj.max_upgrade, UI.SafeFont( '20 Arial' ), color, 'center', 1, C.ABS_BLACK ) end

            Draw.Box( 133, 2, -66, -38, color )
            Draw.Box( 133, 2, -66, 2, color )

            local color = ( upgrade == 1 or upgrade == 2 or upgrade == 0 ) and C.ABS_BLACK or C.AMBI_WHITE
            
            Draw.Box( 4, 130, -84, -71, color ) -- left
            Draw.Box( 4, 130, 80, -71, color ) -- right
            Draw.Box( 160, 4, -80, -71, color ) -- top
            Draw.Box( 160, 4, -80, 53, color ) -- bottom
        cam.End3D2D()
    elseif ( class == 'smp_colourful' ) then
        if ( upgrade == 3 ) then
            eObj:SetColor( HSVToColor( ( CurTime() * 64 ) % 360, 0.6, 1 )  )
        end

        ang:RotateAroundAxis( ang:Up(), 90 )

        cam.Start3D2D( pos + ang:Up() * 3.40, ang, 0.1 )
            Draw.Box( 142, 50, -70, -42, C.ABS_BLACK )

            local color = C.ABS_WHITE
            Draw.SimpleText( 2, -16, tostring( eObj:GetMoney() )..'$', UI.SafeFont( '32 Nexa Script Light' ), color, 'center', 1, C.ABS_BLACK )
            if ( eObj.max_upgrade > upgrade ) then Draw.SimpleText( 2, 32, upgrade..'/'..eObj.max_upgrade, UI.SafeFont( '20 Arial' ), color, 'center', 1, C.ABS_BLACK ) end
        cam.End3D2D()
    elseif ( class == 'smp_quantum' ) then
        ang:RotateAroundAxis( ang:Up(), 90 )

        cam.Start3D2D( pos + ang:Up() * 3.40, ang, 0.1 )
            Draw.Box( 142, 50, -70, -42, C.ABS_BLACK )

            local color = C.ABS_WHITE
            Draw.SimpleText( 2, -16, tostring( eObj:GetMoney() )..'$', UI.SafeFont( '32 Open Sans Condensed' ), eObj:GetColor(), 'center', 1, C.ABS_BLACK )
            if ( eObj.max_upgrade > upgrade ) then Draw.SimpleText( 2, 32, upgrade..'/'..eObj.max_upgrade, UI.SafeFont( '20 Arial' ), color, 'center', 1, C.ABS_BLACK ) end
        cam.End3D2D()
    elseif ( class == 'smp_vip' ) then
        ang:RotateAroundAxis( ang:Up(), 90 )

        cam.Start3D2D( pos + ang:Up() * 3.40, ang, 0.1 )
            Draw.Box( 142, 50, -70, -42, C.ABS_BLACK )

            local color = C.ABS_WHITE
            Draw.SimpleText( 2, -16, tostring( eObj:GetMoney() )..'$', UI.SafeFont( '24 Arial' ), eObj:GetColor(), 'center', 1, C.ABS_BLACK )
            Draw.SimpleText( 2, 32, '• VIP •', UI.SafeFont( '32 Arial Bold' ), C.ABS_WHITE, 'center', 1, C.ABS_BLACK )
        cam.End3D2D()
    elseif ( class == 'smp_premium' ) then
        ang:RotateAroundAxis( ang:Up(), 90 )

        cam.Start3D2D( pos + ang:Up() * 3.40, ang, 0.1 )
            Draw.Box( 142, 50, -70, -42, C.ABS_BLACK )

            local color = C.ABS_WHITE
            Draw.SimpleText( 2, -16, tostring( eObj:GetMoney() )..'$', UI.SafeFont( '24 Arial' ), eObj:GetColor(), 'center', 1, C.ABS_BLACK )
            Draw.SimpleText( 2, 32, '• PREMIUM •', UI.SafeFont( '26 Arial Bold' ), C.ABS_WHITE, 'center', 1, C.ABS_BLACK )
        cam.End3D2D()
    end
end