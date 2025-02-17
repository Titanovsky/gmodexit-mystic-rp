local C, SQL = Ambi.General.Global.Colors, Ambi.SQL
local DB = SQL.CreateTable( 'levels', 'SteamID, Level, XP' )
local PLAYER = FindMetaTable( 'Player' )

function PLAYER:SetLevel( nLevel )
    if not self.nw_Level then return end

    nLevel = nLevel or 1

    if ( nLevel > Ambi.Level.Config.max_level ) then return end

    self.nw_Level = nLevel
    SQL.Update( DB, 'Level', nLevel, 'SteamID', self:SteamID() )

    self:SetXP( 0 )

    hook.Call( '[Ambi.Level.SetLevel]', nil, self, nLevel )
end

function PLAYER:AddLevel( nLevel )
    nLevel = nLevel or 0

    self:SetLevel( self:GetLevel() + nLevel )

    hook.Call( '[Ambi.Level.AddLevel]', nil, self, nLevel )
end

function PLAYER:SetXP( nXP )
    if not self.nw_XP then return end

    nXP = nXP or 0
    if ( nXP < 0 ) then return end

    self.nw_XP = nXP
    SQL.Update( DB, 'XP', nXP, 'SteamID', self:SteamID() )

    if ( self:GetXP() >= self:GetMaxXP() ) then
        local remains = self:GetXP() - self:GetMaxXP()

        self:AddLevel( 1 )
        self:AddXP( remains )
    end

    hook.Call( '[Ambi.Level.SetXP]', nil, self, nXP )
end

function PLAYER:AddXP( nXP )
    if not self.nw_XP then return end
    nXP = nXP or 0

    self:SetXP( self:GetXP() + nXP )

    hook.Call( '[Ambi.Level.AddXP]', nil, self, nXP )
end

-- ---------------------------------------------------------------------------------------------------------------------------------------------
hook.Add( 'PlayerInitialSpawn', 'Ambi.Level.SetTable', function( ePly )
    timer.Simple( 0, function()
        if not IsValid( ePly ) then return end

        local sid = ePly:SteamID()

        SQL.Get( DB, 'SteamID', 'SteamID', sid, function()
            local level = SQL.Select( DB, 'Level', 'SteamID', sid )
            local xp = SQL.Select( DB, 'XP', 'SteamID', sid )

            ePly.nw_Level = tonumber( level )
            ePly.nw_XP = tonumber( xp )
        end, function()
            ePly.nw_Level = Ambi.Level.Config.start_level
            ePly.nw_XP = Ambi.Level.Config.start_xp

            SQL.Insert( DB, 'SteamID, Level, XP', '%s, %i, %i', sid, ePly.nw_Level, ePly.nw_XP )
        end )
    end )
end )