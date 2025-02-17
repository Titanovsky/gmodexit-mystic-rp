local C, SQL = Ambi.General.Global.Colors, Ambi.SQL
local DB = SQL.CreateTable( 'privileges', 'SteamID, Privilege, Date' )
local PLAYER = FindMetaTable( 'Player' )

function PLAYER:SetPrivilege( sPrivilege, nDays )
    local date = os.time() + 60 * 60 * 24 * ( nDays or 1 )

    SQL.Delete( DB, 'SteamID', self:SteamID() )
    SQL.Insert( DB, 'SteamID, Privilege, Date', '%s, %s, %i', self:SteamID(), sPrivilege, date )

    self.nw_Privilege = sPrivilege

    hook.Call( '[Ambi.Privilege.Set]', nil, self, sPrivilege, nDays )

    print( '[Privilege] Активирован '..sPrivilege..' для '..self:Nick()..'('..self:SteamID()..') на '..nDays..' дней' )
end

function PLAYER:RemovePrivilege()
    SQL.Delete( DB, 'SteamID', self:SteamID() )

    self.nw_Privilege = nil

    hook.Call( '[Ambi.Privilege.Remove]', nil, self )
end


-- ---------------------------------------------------------------------------------------------------------------------------------------------
hook.Add( 'PlayerInitialSpawn', 'Ambi.Privilege.Init', function( ePly )
    timer.Simple( 0, function()
        if not IsValid( ePly ) then return end

        local sid = ePly:SteamID()

        SQL.Get( DB, 'SteamID', 'SteamID', sid, function()
            local privilege = SQL.Select( DB, 'Privilege', 'SteamID', sid )
            if not privilege then return end

            local date = tonumber( SQL.Select( DB, 'Date', 'SteamID', sid ) )

            if ( os.time() >= date ) then
                ePly:RemovePrivilege()
                ePly:ChatPrint( 'Срок вашей привилегий истёк!' )
            else
                ePly.nw_Privilege = privilege
            end
        end, function() end )
    end )
end )