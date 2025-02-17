local C = Ambi.Packages.Out( 'C' )

local abilities = {}

abilities[ 'TEAM_DEMON' ] = function( ePly )
    local ply = ePly:GetEyeTrace().Entity
    if IsValid( ply ) and ply:IsPlayer() and ePly:CheckDistance( ply, 800 ) then
        ply:Ignite( 10 )
        ePly:ChatSend( C.AMBI_BLOOD, 'Вы подожгли противника!' )
        ePly:EmitSound( 'ambi/csz/zombie/attack.ogg' )
    else
        ePly:ChatSend( C.ERROR, '•  ', C.ABS_WHITE, 'Впереди никого нет или вы слишком далеко' )
    end

    ePly:SetDelay( 'AbilityMystic', 15 )
end

abilities[ 'TEAM_ORACLE' ] = function( ePly )
    local pos = ePly:GetEyeTrace().HitPos

    ePly:SetPos( pos )
    ePly:SetDelay( 'AbilityMystic', 3 )
end

abilities[ 'TEAM_VAMPIRE' ] = function( ePly )
    local ply = ePly:GetEyeTrace().Entity
    if IsValid( ply ) and ply:IsPlayer() and ePly:CheckDistance( ply, 200 ) then
        if ( ply:GetJobTable().category == 'Dark' ) or ( ply:GetJobTable().category == 'Light' ) or ( ply:GetJobTable().category == 'Specialist' ) then return end

        ePly:ChatSend( C.AMBI_BLOOD, 'Вы выпили всю кровь у противника!' )
        ply:ChatSend( C.AMBI_BLOOD, 'У вас выпил кровь '..ePly:Nick() )
        ply:Kill()
        ePly:EmitSound( 'ambi/csz/humans/eating.ogg' )
        ePly:SetModel( ply:GetModel() )
    else
        ePly:ChatSend( C.ERROR, '•  ', C.ABS_WHITE, 'Впереди никого нет или вы слишком далеко' )
    end

    ePly:SetDelay( 'AbilityMystic', 10 )
end

net.AddString( 'ambi_mysticrp_ability_active' )
net.Receive( 'ambi_mysticrp_ability_active', function( _, ePly ) 
    local id = net.ReadUInt( 3 )

    local job = ePly:GetJob()
    if not Ambi.MysticRP.abilities[ job ] then ePly:Kick( '[MysticRP.Ability] Подозрения в читерстве!' ) return end

    local ability = Ambi.MysticRP.abilities[ job ][ id ]
    if not ability then ePly:Kick( '[MysticRP.Ability] Подозрения в читерстве!' ) return end

    if timer.Exists( 'MysticRPAbility:'..ePly:SteamID()..':'..job..id ) then ePly:ChatSend( '~R~ Ждите '..tostring( math.floor( timer.TimeLeft( 'MysticRPAbility:'..ePly:SteamID()..':'..job..id ) ) )..' секунд' ) return end
    timer.Create( 'MysticRPAbility:'..ePly:SteamID()..':'..job..id, ability.delay, 1, function() end )

    ability.Callback( ePly )
end )