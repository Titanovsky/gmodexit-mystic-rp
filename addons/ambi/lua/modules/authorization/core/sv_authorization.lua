local PLAYER = FindMetaTable( 'Player' )
local SQL = Ambi.Packages.Out( 'sql' )
local DB = SQL.CreateTable( 'auth', 'SteamID, Name, LastName, Age, Gender, Nationality, RegDate, RegIP, RegNick, LastDate, LastIP, LastNick' )

-- ---------------------------------------------------------------------------------------------------------------------------------------
function PLAYER:AuthKick( sReason )
    if Ambi.Authorization.Config.can_kick then 
        local text = '[Authorization] '..sReason

        if self:IsSuperAdmin() then self:ChatPrint( text ) self:PlaySound( 'Error4' ) return end

        self:Kick( text )

        hook.Call( '[Ambi.Authorization.Kicked]', nil, self, sReason )
    end 
end

-- ---------------------------------------------------------------------------------------------------------------------------------------
function Ambi.Authorization.Set( ePly, bIsAuth, bIsFirstTime )
    local sid = ePly:SteamID()

    ePly.nw_IsAuth = bIsAuth

    if not bIsAuth then ePly:SendLua( 'Ambi.Authorization.OpenMenu()' ) end

    ePly.nw_AuthName = bIsAuth and SQL.Select( DB, 'Name', 'SteamID', sid ) or nil
    ePly.nw_AuthLastName = bIsAuth and SQL.Select( DB, 'LastName', 'SteamID', sid ) or nil
    ePly.nw_AuthAge = bIsAuth and tonumber( SQL.Select( DB, 'Age', 'SteamID', sid ) ) or nil
    ePly.nw_AuthGender = bIsAuth and SQL.Select( DB, 'Gender', 'SteamID', sid ) or nil
    ePly.nw_AuthNationality = bIsAuth and SQL.Select( DB, 'Nationality', 'SteamID', sid ) or nil

    if bIsAuth and Ambi.DarkRP and Ambi.DarkRP.Config.rpname_enable then
        ePly.nw_RPName = ePly.nw_AuthName..' '..ePly.nw_AuthLastName
    end

    ePly:Freeze( false )
    
    if bIsAuth then
        local txt = bIsFirstTime and ' ~W~ впервые!' or ''
        for _, ply in ipairs( player.GetAll() ) do
            ply:ChatSend( '~R~ [Мистик] ~W~ В город прибыл ~R~ '..ePly.nw_RPName..txt )
        end
    end

    hook.Call( '[Ambi.Authorization.Set]', nil, ePly, bIsAuth, bIsFirstTime ) 
end

function Ambi.Authorization.Register( ePly, sName, sLastName, nAge, sGender, sNationality )
    local sid = ePly:SteamID()
    sName = sName or Ambi.Authorization.Config.default_name
    sLastName = sLastName or Ambi.Authorization.Config.default_last_name
    nAge = nAge or Ambi.Authorization.Config.default_age
    sGender = sGender or Ambi.Authorization.Config.default_gender
    sNationality = sNationality or Ambi.Authorization.Config.default_nationality

    SQL.Delete( DB, 'SteamID', sid )
    SQL.Insert( DB, 'SteamID, Name, LastName, Age, Gender, Nationality, RegDate, RegIP, RegNick, LastDate, LastIP, LastNick', '%s, %s, %s, %i, %s, %s, %i, %s, %s, %i, %s, %s', sid, sName, sLastName, nAge, sGender, sNationality, os.time(), ePly:IPAddress(), ePly:Nick(), os.time(), ePly:IPAddress(), ePly:Nick() ) 

    ePly.nw_AuthName = sName
    ePly.nw_AuthLastName = sLastName
    ePly.nw_AuthAge = nAge
    ePly.nw_AuthGender = sGender
    ePly.nw_AuthNationality = sNationality

    if Ambi.DarkRP and Ambi.DarkRP.Config.rpname_enable then
        ePly:SetRPName( ePly.nw_AuthName..' '..ePly.nw_AuthLastName )
    end

    hook.Call( '[Ambi.Authorization.Registered]', nil, ePly, sName, sLastName, nAge, sGender, sNationality, os.time(), ePly:IPAddress(), ePly:Nick() ) 
end

-- ---------------------------------------------------------------------------------------------------------------------------------------
net.Receive( 'ambi_authorization_play', function( _, ePly ) 
    if ePly:IsAuth() then ePly:AuthKick( 'Игрок уже авторизован' ) return end

    local sid = ePly:SteamID()
    local is_reg = SQL.Select( DB, 'SteamID', 'SteamID', sid ) 

    if is_reg then 
        Ambi.Authorization.Set( ePly, true )

        SQL.Update( DB, 'LastDate', os.time(), 'SteamID', sid )
        SQL.Update( DB, 'LastIP', ePly:IPAddress(), 'SteamID', sid )
        SQL.Update( DB, 'LastNick', ePly:Nick(), 'SteamID', sid )
    else
        net.Start( 'ambi_authorization_register_start' )
        net.Send( ePly )
    end
end )

net.Receive( 'ambi_authorization_register_end', function( _, ePly ) 
    if ePly:IsAuth() then ePly:AuthKick( 'Игрок уже авторизован' ) return end

    local name, last_name, age, gender, nationality = net.ReadString(), net.ReadString(), net.ReadUInt( 12 ), net.ReadString(), net.ReadString()
    if not Ambi.Authorization.CheckNationality( nationality ) then ePly:AuthKick( 'Неправильная национальность' ) return end
    if not Ambi.Authorization.CheckGender( gender ) then ePly:AuthKick( 'Неправильный гендер' ) return end
    if not Ambi.Authorization.CheckAge( age ) then ePly:AuthKick( 'Неправильный возраст' ) return end
    if not Ambi.Authorization.CheckName( last_name ) then ePly:AuthKick( 'Неправильная фамилия' ) return end
    if not Ambi.Authorization.CheckName( name ) then ePly:AuthKick( 'Неправильное имя' ) return end

    Ambi.Authorization.Register( ePly, name, last_name, age, gender, nationality )
    Ambi.Authorization.Set( ePly, true, true )
end )

hook.Add( '[Ambi.DarkRP.SetRPName]', 'Ambi.Authorization.SetRPName', function( ePly, sName ) 
    if not ePly.nw_IsAuth then return end

    local tab = string.Explode( ' ', sName )
    local name = tab[ 1 ]
    local last_name = tab[ 2 ]

    if not name or not last_name then ePly:ChatSend( '~R~ [Auth] ~W~ Вы поменяли ник, но он не сохранится!' ) return end

    local sid = ePly:SteamID()

    SQL.Update( DB, 'Name', name, 'SteamID', sid )
    SQL.Update( DB, 'LastName', last_name, 'SteamID', sid )

    ePly:ChatSend( '~G~ [Auth] ~W~ Имя и фамилия сохранятся!' )
end )