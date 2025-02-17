local PLAYER = FindMetaTable( 'Player' )

function PLAYER:GetLevel()
    return self.nw_Level or 0
end

function PLAYER:Level()
    return self:GetLevel()
end

function PLAYER:GetXP()
    return self.nw_XP
end

function PLAYER:XP()
    return self:GetXP()
end

function PLAYER:GetMaxXP()
    return Ambi.Level.Config.max_xp * self:GetLevel()
end

function PLAYER:MaxXP()
    return self:GetMaxXP()
end
