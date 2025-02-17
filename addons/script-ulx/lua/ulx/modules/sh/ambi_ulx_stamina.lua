local CATEGORY = '[Stamina]'

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
local command = 'setstamina'
local function Action( eCaller, tPlayers, nCount )
    
    for _, ply in ipairs( tPlayers ) do ply:SetStamina( nCount ) end

	ulx.fancyLogAdmin( eCaller, '#A изменил #i стамину для #T', nCount, tPlayers )
end
local method = ulx.command( CATEGORY, 'ulx '..command, Action, '!'..command )
method:addParam{ type=ULib.cmds.PlayersArg }
method:addParam{ type=ULib.cmds.NumArg, min = 0, default = 0, max = 5000, hint = 'Количество', ULib.cmds.optional, ULib.cmds.round }
method:defaultAccess( ULib.ACCESS_SUPERADMIN )
method:help( 'Изменить Stamina игроку' )

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
local command = 'addstamina'
local function Action( eCaller, tPlayers, nCount )
    
    for _, ply in ipairs( tPlayers ) do ply:AddStamina( nCount ) end

	ulx.fancyLogAdmin( eCaller, '#A добавил #i стамину для #T', nCount, tPlayers )
end
local method = ulx.command( CATEGORY, 'ulx '..command, Action, '!'..command )
method:addParam{ type=ULib.cmds.PlayersArg }
method:addParam{ type=ULib.cmds.NumArg, min = -5000, default = 0, max = 5000, hint = 'Количество', ULib.cmds.optional, ULib.cmds.round }
method:defaultAccess( ULib.ACCESS_SUPERADMIN )
method:help( 'Добавить Stamina игроку' )