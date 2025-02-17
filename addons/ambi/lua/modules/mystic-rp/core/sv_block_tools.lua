local high_admins = {
    [ 'superadmin' ] = true,
    [ 'high_admin' ] = true,
}

local blocks = {
    [ '' ] = true,
}

local for_superadmins = {
    [ 'hoverboard' ] = true,
    [ 'paint' ] = true,
    [ 'trails' ] = true,
    [ 'bw3_mech_spawner' ] = true,
    [ 'permaprops' ] = true,
    [ 'balloon' ] = true,
    [ 'wire_explosive' ] = true,
    [ 'wire_expression2' ] = true,
    [ 'wire_cpu' ] = true,
    [ 'wire_gpu' ] = true,
    [ 'wire_spu' ] = true,
    [ 'wire_gates' ] = true,
}

local sf_access = {
    [ 'STEAM_0:1:95303327' ] = 'titanovsky',
    [ 'STEAM_0:1:547540838' ] = 'viktus',
}

hook.Add( 'CanTool', 'Ambi.MysticRP.BlockTools', function( ePly, _, sTool ) 
    if ( ( sTool == 'starfall_component' ) or ( sTool == 'starfall_processor' ) ) and not sf_access[ ePly:SteamID() ] then return false end
    if blocks[ sTool ] and ePly:IsUserGroup( 'user' ) then return false end
    if for_superadmins[ sTool ] and not high_admins[ ePly:GetUserGroup() ] then ePly:ChatSend( '~R~ • ~W~ Доступно лишь избранным!' ) return false end
    if string.StartsWith( sTool, 'wire' ) and not ( high_admins[ ePly:GetUserGroup() ] or ePly:IsPremium() ) then ePly:ChatSend( '~R~ • ~W~ Доступно лишь избранным!' ) return false end
end )