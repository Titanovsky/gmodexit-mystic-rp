local C = Ambi.Packages.Out( 'colors' )

local ZERO_COLOR1 = Color( 191, 191, 191)
local ZERO_COLOR2 = Color( 113, 112, 112)
local ZERO_COLOR3 = Color( 58, 57, 57)
local ZERO_COLOR4 = Color( 0, 0, 0)

function Ambi.SmallMoneyPrinters.Upgrade( eObj )
    local class, upgrade = eObj:GetClass(), eObj:GetUpgrade()

    if ( class == 'smp_zero' ) then
        if ( upgrade == 1 ) then
            eObj:SetColor( ZERO_COLOR1 )
        elseif ( upgrade == 2 ) then
            eObj:SetColor( ZERO_COLOR2 )
        elseif ( upgrade == 3 ) then
            eObj:SetColor( ZERO_COLOR3 )
        elseif ( upgrade == 4 ) then
            eObj:SetColor( ZERO_COLOR4 )
        end
    elseif ( class == 'smp_colourful' ) then
        if ( upgrade == 1 ) then
            eObj:SetColor( C.AMBI_GREEN )
        elseif ( upgrade == 2 ) then
            eObj:SetColor( C.AMBI_BLUE )
        end
    elseif ( class == 'smp_quantum' ) then
        if ( upgrade == 1 ) then
            eObj:SetRenderMode( RENDERMODE_TRANSCOLOR )
            eObj:SetColor( ColorAlpha( eObj:GetColor(), 200 ) )
        elseif ( upgrade == 2 ) then
            eObj:SetColor( ColorAlpha( eObj:GetColor(), 100 ) )
        end
    end
end