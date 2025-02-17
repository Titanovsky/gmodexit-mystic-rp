local C, GUI, Draw, UI, CL = Ambi.Packages.Out( '@d, ContentLoader' )
local W, H = ScrW(), ScrH()
local MultiHUD = Ambi.MultiHUD
local COLOR_PANEL = Color( 20, 20, 20, 250 )

hook.Add( 'PostDrawTranslucentRenderables', 'Ambi.MysticRP.ShowOrgHUD', function()
    if not Ambi.DarkRP.Config.hud_3d_enable then return end

    for i, ePly in ipairs( player.GetAll() ) do
        if ( LocalPlayer():GetPos():Distance( ePly:GetPos() ) > 500 ) then continue end
        if ( ePly == LocalPlayer() ) then continue end
        if not ePly:Alive() then continue end
        if not ePly.nw_amb_players_orgs then continue end

        local color = C.AMBI

        local _,max = ePly:GetRotatedAABB( ePly:OBBMins(), ePly:OBBMaxs() )
        local rot = ( ePly:GetPos() - EyePos() ):Angle().yaw - 90
        local head_bone = ePly:LookupBone( 'ValveBiped.Bip01_Head1' ) or 1
        local head = (ePly:GetBonePosition( head_bone ) and ePly:GetBonePosition( head_bone ) + Vector( 0, 0, 14 ) or nil ) or ePly:LocalToWorld( ePly:OBBCenter() ) + Vector( 0, 0, 24 )
        
        cam.Start3D2D( head, Angle( 0, rot, 90 ), 0.1 )
            Draw.SimpleText( 4, -46, ePly.nw_amb_players_orgs_name, UI.SafeFont( '44 Nexa Script Light' ), color, 'center', 1, C.ABS_BLACK )
        cam.End3D2D()
    end
end )