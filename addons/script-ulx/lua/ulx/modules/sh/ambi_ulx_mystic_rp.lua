local CATEGORY = '[Mystic RP]'

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
local command = 'wipe'
local function Action( eCaller, ePly, sItem, nCount )
    --todo
end
local method = ulx.command( CATEGORY, 'ulx '..command, Action, '!'..command )
method:addParam{ type=ULib.cmds.PlayerArg }
method:defaultAccess( ULib.ACCESS_SUPERADMIN )
method:help( 'Выдать полный вайп (Инвентарь, Квесты, Аккаунт)' )