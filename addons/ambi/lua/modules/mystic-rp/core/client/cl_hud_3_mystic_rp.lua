local C, GUI, Draw, UI, CL = Ambi.Packages.Out( '@d, ContentLoader' )
local W, H = ScrW(), ScrH()
local MultiHUD = Ambi.MultiHUD
local COLOR_PANEL = Color( 20, 20, 20, 250 )

local BLOCK_GUNS = {
    [ 'weapon_physcannon' ] = true,
    [ 'weapon_bugbait' ] = true,
    [ 'weapon_crowbar' ] = true,
    [ 'weapon_stunstick' ] = true,
    [ 'gmod_camera' ] = true,
    [ 'weapon_fists' ] = true,
    [ 'weapon_physgun' ] = true,
    [ 'gmod_tool' ] = true,
    [ 'keys' ] = true,
    [ 'lockpick' ] = true,
    [ 'stunstick' ] = true,
    [ 'arrest_stick' ] = true,
    [ 'unarrest_stick' ] = true,
    [ 'weaponchecker' ] = true,
    [ 'keypadchecker' ] = true,
}

-- --------------------------------------------------------------------------------------------------------------------------------------
local function DrawBox( nW, nH, nX, nY, bFlag )
    Draw.Box( nW, nH, nX, nY, COLOR_PANEL )
    Draw.Box( 2, nH, nX, nY, C.AMBI_BLOOD )

    if bFlag then
        Draw.Box( 2, nH, nX + nW - 2, nY, C.AMBI_BLOOD )
        Draw.Box( nW, 2, nX, nY, C.AMBI_BLOOD )
        Draw.Box( nW, 2, nX, nY + nH - 2, C.AMBI_BLOOD )
    end
end

-- --------------------------------------------------------------------------------------------------------------------------------------
MultiHUD.Add( 3, 'Mystic RP', 'Ambi', function()
    Draw.SimpleText( W - 10, 2, 'Мистик РП', UI.SafeFont( '40 Ambi' ), C.AMBI_BLOOD, 'top-right', 1, C.ABS_BLACK )

    local job = LocalPlayer():GetJobName() or ''
    local w = Draw.GetTextSizeX( UI.SafeFont( '32 Ambi' ), job ) + 10

    DrawBox( w, 32, 6, H - 114, false )
    Draw.SimpleText( 14, H - 80, job, UI.SafeFont( '32 Ambi' ), C.ABS_WHITE, 'bottom-left', 1, C.ABS_BLACK )

    local money = LocalPlayer():GetMoney() or ''
    local w = Draw.GetTextSizeX( UI.SafeFont( '28 Ambi' ), money ) + 42

    DrawBox( w, 38, 6, H - 156, true )
    Draw.Material( 24, 24, 12, H - 150, CL.Material( 'mrp_hud_wallet' ), C.ABS_WHITE )
    Draw.SimpleText( 40, H - 124, money, UI.SafeFont( '28 Ambi' ), C.ABS_WHITE, 'bottom-left', 1, C.ABS_BLACK )

    local level = tostring( LocalPlayer():GetLevel() )..' LVL ('..tostring( LocalPlayer():GetXP() )..'/'..tostring( LocalPlayer():GetMaxXP() )..')'
    local w = Draw.GetTextSizeX( UI.SafeFont( '28 Ambi' ), level ) + 12

    DrawBox( w, 38, 6, H - 198, true )
    Draw.SimpleText( 12, H - 166, level, UI.SafeFont( '28 Ambi' ), C.AMBI, 'bottom-left', 1, C.ABS_BLACK )

    local hp = LocalPlayer():Health()
    local w = Draw.GetTextSizeX( UI.SafeFont( '54 Slimamif Medium' ), hp ) + 32
    local hp_w = w

    Draw.Box( w + 8 + 32, 58, 8, H - 58 - 20, COLOR_PANEL )
    Draw.Box( 2, 58, 8, H - 58 - 20, C.AMBI_BLOOD )
    Draw.Box( 2, 58, 8 + w + 32 + 6, H - 58 - 20, C.AMBI_BLOOD )
    Draw.Box( w + 8 + 32, 2, 8, H - 58 - 20, C.AMBI_BLOOD )
    Draw.Box( w + 8 + 32, 2, 8, H - 22, C.AMBI_BLOOD )

    Draw.Material( 48, 38, 16, H - 38 - 29, CL.Material( 'mrp_hud_health' ), C.AMBI_GRAY )
    Draw.SimpleText( 72, H - 26, hp, UI.SafeFont( '54 Slimamif Medium' ), C.ABS_WHITE, 'bottom-left', 1, C.ABS_BLACK )

    local armor = LocalPlayer():Armor() or ''
    local w = Draw.GetTextSizeX( UI.SafeFont( '44 Slimamif Medium' ), armor ) + 50

    if ( armor > 0 ) then
        DrawBox( w, 40, 8 + hp_w + 38 + 4, H - 60, true )
        Draw.Material( 30, 30, 16 + hp_w + 38, H - 56, CL.Material( 'mrp_hud_armor' ), C.AMBI_GRAY )
        Draw.SimpleText( 8 + hp_w + 80, H - 20, armor, UI.SafeFont( '44 Slimamif Medium' ), C.ABS_WHITE, 'bottom-left', 1, C.ABS_BLACK )
    end

    if GetConVar( 'ambi_darkrp_lockdown' ):GetBool() then
        Draw.SimpleText( 4, 84, '• Комендантский Час!', UI.SafeFont( '28 Ambi' ), C.AMBI_RED, 'top-left', 1, C.ABS_BLACK )
    end

    local wep = LocalPlayer():GetActiveWeapon()
    if not IsValid( wep ) then return end
    if BLOCK_GUNS[ wep:GetClass() ] then return end

    local clip1, ammo1, ammo2 = wep:Clip1(), LocalPlayer():GetAmmoCount( wep:GetPrimaryAmmoType() ), LocalPlayer():GetAmmoCount( wep:GetSecondaryAmmoType() )
    local ammo = clip1..' / '..ammo1
    local x = Draw.GetTextSizeX( UI.SafeFont( '56 Slimamif Medium' ), ammo ) + 14
    if ammo2 and ( ammo2 > 0 ) then 
        ammo = '('..ammo2..') '..clip1..' / '..ammo1
        x = Draw.GetTextSizeX( UI.SafeFont( '56 Slimamif Medium' ), ammo ) + 10
    end

    DrawBox( x - 4, 44, W - x - 4, H - 42 - 20, true )
    draw.SimpleTextOutlined( ammo, UI.SafeFont( '56 Slimamif Medium' ), W - 12, H - 50 - 20, C.AMBI_WHITE, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, C.ABS_BLACK )
end )