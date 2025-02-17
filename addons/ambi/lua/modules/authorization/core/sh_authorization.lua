local PLAYER = FindMetaTable( 'Player' )
local SUCCESS, FAIL = true, false

-- --------------------------------------------------------------------------------------------------------------------------------------
function PLAYER:IsAuth()
    return self.nw_IsAuth
end

-- --------------------------------------------------------------------------------------------------------------------------------------
function Ambi.Authorization.CheckName( sName )
    if not string.IsValid( sName ) then return FAIL end

    local len = utf8.len( sName )
    if ( len < Ambi.Authorization.Config.check_name_min_len ) then return FAIL end
    if ( len > Ambi.Authorization.Config.check_name_max_len ) then return FAIL end

    if Ambi.Authorization.Config.check_name_bad_symbols then
        for i = 1, len do
            local char = utf8.GetChar( sName, i )
            if Ambi.General.Global.Keys.BLACKLIST[ char ] or Ambi.General.Global.Keys.NUMERIC[ char ] or Ambi.General.Global.Keys.SYMBOLS[ char ] then return FAIL end 
        end
    end

    return SUCCESS
end

function Ambi.Authorization.CheckAge( nAge )
    if not nAge or not isnumber( nAge ) then return FAIL end

    if ( nAge % 1 ~= 0 ) then return FAIL end
    if ( nAge > Ambi.Authorization.Config.check_age_max ) then return FAIL end
    if ( nAge < Ambi.Authorization.Config.check_age_min ) then return FAIL end

    return SUCCESS
end

function Ambi.Authorization.CheckGender( sGender )
    if not string.IsValid( sGender ) then return FAIL end

    for _, v in ipairs( Ambi.Authorization.Config.genders ) do
        if ( sGender == v ) then return SUCCESS end
    end

    return FAIL
end

function Ambi.Authorization.CheckNationality( sNationality )
    if not string.IsValid( sNationality ) then return FAIL end

    for _, v in ipairs( Ambi.Authorization.Config.nationalities ) do
        if ( sNationality == v ) then return SUCCESS end
    end

    return FAIL
end