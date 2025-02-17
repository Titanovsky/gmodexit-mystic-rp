Ambi.Duel.duelist1 = Entity( 0 )
Ambi.Duel.duelist2 = Entity( 0 )

local duelist1 = Entity( 0 )
local duelist2 = Entity( 0 )
local award = 0
local health = 0
local armor = 0
local gun = 'gmod_tool'
local winner = Entity( 0 )
local loser = Entity( 0 )

function Ambi.Duel.PreparingStart( eDuelist1, eDuelist2, nAward, nHealth, nArmor, sGun )
    if timer.Exists( 'Ambi.DuelTime' ) then return end
    if timer.Exists( 'Ambi.DuelDelay' ) then eDuelist1:ChatSend( '~R~ Подождите: '..math.Round( timer.TimeLeft( 'Ambi.DuelDelay' ) )..' секунд' ) return end
    if timer.Exists( 'Ambi.DuelAccept' ) then return end

    nAward = math.Round( nAward )
    if ( nAward < Ambi.Duel.Config.min_award or nAward > Ambi.Duel.Config.max_award ) then return end

    if ( Ambi.Duel.ValidationProperties( nHealth, nArmor ) == false ) then eDuelist1:ChatSend( '~R~ Неправильные Health или Armor' ) return end
    if ( Ambi.Duel.ValidationPlayersData( eDuelist1, eDuelist2, nAward ) == false ) then eDuelist1:ChatSend( '~R~ Неправильные данные о Первом или Втором Дуэлянте' ) return end
    if ( Ambi.Duel.ValidationGun( sGun ) == false ) then eDuelist1:ChatSend( '~R~ Неправильное Оружие') return end

    timer.Create( 'Ambi.DuelAccept', Ambi.Duel.Config.time_accept, 1, function() end )

    duelist1 = eDuelist1
    duelist2 = eDuelist2
    award = nAward
    health = nHealth
    armor = nArmor
    gun = sGun

    Ambi.Duel.duelist1 = eDuelist1
    Ambi.Duel.duelist2 = eDuelist2

    eDuelist1:ChatSend( '~G~ Вы вызвали игрока на дуэль, ожидайте его ответ' )
    eDuelist2:ChatSend( '~G~ Вас вызвали на дуэль, принять его можно через NPC' )
end

function Ambi.Duel.AcceptDuel( ePly )
    if ( ePly == duelist2 ) and timer.Exists( 'Ambi.DuelAccept' ) then
        Ambi.Duel.Start( duelist1, duelist2, award, health, armor, gun )
        timer.Remove( 'Ambi.DuelAccept' )
    end
end

function Ambi.Duel.Start( eDuelist1, eDuelist2, nAward, nHealth, nArmor, sGun )
    timer.Create( 'Ambi.DuelTime', Ambi.Duel.Config.time_duel, 1, function() 
        Ambi.Duel.End( 1 )
    end )

    Ambi.Duel.SetDuelist( eDuelist1, true )
    eDuelist1:AddMoney( -award )

    eDuelist1:Spawn()
    eDuelist1:SetPos( Ambi.Duel.Config.places[1].pos )
    eDuelist1:SetEyeAngles( Ambi.Duel.Config.places[1].ang )
    eDuelist1:SetHealth( nHealth )
    eDuelist1:SetArmor( nArmor )
    eDuelist1:StripWeapons()
    eDuelist1:Freeze( true )

    eDuelist1:ChatSend( '~G~ Дуэль начнется через: '..Ambi.Duel.Config.delay_start..' секунд!' )

    Ambi.Duel.SetDuelist( eDuelist2, true )
    eDuelist2:AddMoney( -award )
    
    eDuelist2:Spawn()
    eDuelist2:SetPos( Ambi.Duel.Config.places[2].pos )
    eDuelist2:SetEyeAngles( Ambi.Duel.Config.places[2].ang )
    eDuelist2:SetHealth( nHealth )
    eDuelist2:SetArmor( nArmor )
    eDuelist2:StripWeapons()
    eDuelist2:Freeze( true )

    eDuelist2:ChatSend( '~G~ Дуэль начнется через: '..Ambi.Duel.Config.delay_start..' секунд!' )

    timer.Create( 'Ambi.DuelFreezeStart', Ambi.Duel.Config.delay_start, 1, function()
        eDuelist1:Freeze( false )
        eDuelist1:Give( sGun )
        eDuelist1:GiveAmmo( 255, eDuelist1:GetWeapon( sGun ):GetPrimaryAmmoType() )

        eDuelist2:Freeze( false )
        eDuelist2:Give( sGun )
        eDuelist2:GiveAmmo( 255, eDuelist2:GetWeapon( sGun ):GetPrimaryAmmoType() )
    end )

    if Ambi.Duel.Config.bet then
        Ambi.Duel.max_bet = math.Round( award / 2 )
        Ambi.Duel.SendAllPlayersMaxBet( Ambi.Duel.max_bet )
    end
end

function Ambi.Duel.End( nFlag )
    if not timer.Exists( 'Ambi.DuelTime' ) then return end

    timer.Create( 'Ambi.DuelDelay', Ambi.Duel.Config.delay, 1, function() end )

    if ( nFlag == 0 ) then
        timer.Remove( 'Ambi.DuelTime' )

        winner:SetPos( Ambi.Duel.Config.places['end'].pos )
        winner:SetEyeAngles( Ambi.Duel.Config.places['end'].ang )

        winner:AddMoney( award * 2 )

        winner:ChatSend( '~G~ Вы одержали победу в дуэли!' )

        Ambi.Duel.ReturnWeapon( winner )

        loser:ChatSend( '~R~ Вы не смогли в дуэль!' )

        if Ambi.Duel.Config.bet then
            Ambi.Duel.winner = winner
            Ambi.Duel.TheEndBet()
        end

    else -- time is up
        if IsValid( duelist1 ) and duelist1:Alive() then 
            duelist1:Kill() 

            duelist1:ChatSend( '~R~ Время вышло!' )
        end

        if IsValid( duelist2 ) and duelist2:Alive() then 
            duelist2:Kill() 

            duelist2:ChatSend( '~R~ Время вышло!' )
        end
    end

    Ambi.Duel.SetDuelist( duelist1, false )
    Ambi.Duel.SetDuelist( duelist2, false )
end

function Ambi.Duel.ReturnWeapon( eWinner )
    eWinner:StripWeapons()
    eWinner:Spawn()
end

function Ambi.Duel.SetDuelist( ePly, bool )
    ePly:SetNWBool( 'Duel', bool )
end

function Ambi.Duel.IsDuelist( ePly )
    return ePly:GetNWBool( 'Duel' )
end

function Ambi.Duel.ValidationPlayersData( ePly1, ePly2, nAward )
    if ( IsValid( ePly1 ) == false ) or ( IsValid( ePly2 ) == false ) then return false end
    if ( ePly1 == ePly2 ) then return false end
    if ( ePly1:IsPlayer() == false ) or ( ePly2:IsPlayer() == false ) then return false end

    if ( ePly1:GetMoney() < nAward ) then return false end
    if ( ePly2:GetMoney() < nAward ) then return false end

    -- todo: will make check distance between ePly2 and NPC ( for DarkRP )

    return true
end

function Ambi.Duel.ValidationProperties( nHealth, nArmor )
    if ( nHealth < 1 or nHealth > Ambi.Duel.Config.max_health ) then return false end
    if ( nArmor < 0 or nHealth > 255 ) then return false end

    return true
end

function Ambi.Duel.ValidationGun( sGun )
    for _, gun in pairs( Ambi.Duel.Config.access_guns ) do
        if ( gun == sGun ) then return true end
    end

    return false
end

hook.Add( 'PlayerDeath', 'Ambi.Duel.TheEndDuel', function( eVictim, _, eAttacker )
    if ( Ambi.Duel.IsDuelist( eVictim ) == false or Ambi.Duel.IsDuelist( eAttacker ) == false ) then return end

    winner = eAttacker
    loser = eVictim
    Ambi.Duel.End( 0 )
end )

hook.Add( 'PlayerDisconnected', 'Ambi.Duel.TheEndDuel', function( ePly ) 
    if Ambi.Duel.IsDuelist( ePly ) then
        if ( ePly == duelist1 ) then
            winner = duelist2
        elseif ( ePly == duelist2 ) then
            winner = duelist1
        end

        Ambi.Duel.End( 0 )
    end
end )

hook.Add( 'CanPlayerSuicide', 'Ambi.Duel.RestrictDuelist', function( ePly )
	if Ambi.Duel.IsDuelist( ePly ) then return false end
end )

hook.Add( 'PlayerGiveSWEP', 'Ambi.Duel.RestrictDuelist', function( ePly )
    if Ambi.Duel.IsDuelist( ePly ) then return false end
end )

hook.Add( 'PlayerSpawnSWEP', 'Ambi.Duel.RestrictDuelist', function( ePly )
    if Ambi.Duel.IsDuelist( ePly ) then return false end
end )

hook.Add( 'PlayerSpawnSENT', 'Ambi.Duel.RestrictDuelist', function( ePly )
    if Ambi.Duel.IsDuelist( ePly ) then return false end
end )

hook.Add( 'PlayerSpawnProp', 'Ambi.Duel.RestrictDuelist', function( ePly )
    if Ambi.Duel.IsDuelist( ePly ) then return false end
end )

hook.Add( 'InitPostEntity', 'Ambi.Duel.WorkaroundMap', function() 
    if ( game.GetMap() ~= 'rp_downtown_v4_exl' ) then return end

    Entity( 418 ):Fire( 'Close' )
    Entity( 418 ):Fire( 'Lock' )
end )

util.AddNetworkString( 'ambi_duel' )
net.Receive( 'ambi_duel', function( nLen, caller )
    if ( IsValid( caller ) == false ) then return end

    local options = {}
    options.duelist1 = caller
    options.duelist2 = net.ReadEntity()
    options.award = net.ReadUInt( 17 )
    options.health = net.ReadInt( 17 )
    options.armor = net.ReadInt( 17 )
    options.gun = net.ReadString()

    Ambi.Duel.PreparingStart( options.duelist1, options.duelist2, options.award, options.health, options.armor, options.gun )

    options = nil
end )