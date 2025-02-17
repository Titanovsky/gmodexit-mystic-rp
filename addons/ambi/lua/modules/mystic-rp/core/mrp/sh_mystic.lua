local PLAYER = FindMetaTable( 'Player' )

function PLAYER:IsMystic()
    local job = self:GetJobTable()

    return job.dark_mystic or job.light_mystic
end

function PLAYER:IsDarkMystic()
    local job = self:GetJobTable()

    return job.dark_mystic
end

function PLAYER:IsLightMystic()
    local job = self:GetJobTable()

    return job.light_mystic
end

function PLAYER:IsVIP()
    local priv = self:GetPrivilege()
    if not priv then return end

    return ( priv == 'vip' ) or ( priv == 'premium' ) or ( prinv == 'titanium' )
end

function PLAYER:IsPremium()
    local priv = self:GetPrivilege()
    if not priv then return end

    return ( priv == 'premium' ) or ( prinv == 'titanium' )
end

function PLAYER:IsTitanium()
    local priv = self:GetPrivilege()
    if not priv then return end

    return ( prinv == 'titanium' )
end