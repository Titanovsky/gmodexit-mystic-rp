local CATEGORY = '[Perma Model]'

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
local command = 'setpermamodel'
local function Action( eCaller, ePly, sModel )
    if not util.IsValidModel( sModel ) then return end

    ePly:SetPermaModel( sModel )

	ulx.fancyLogAdmin( eCaller, '#A выдал перма модель #s игроку #T', sModel, ePly )
end
local method = ulx.command( CATEGORY, 'ulx '..command, Action, '!'..command )
method:addParam{ type=ULib.cmds.PlayerArg }
method:addParam{ type=ULib.cmds.StringArg, hint = 'Perma Model' }
method:defaultAccess( ULib.ACCESS_SUPERADMIN )
method:help( 'Изменить Perma Model игроку' )
