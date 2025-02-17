local exception_promos = {}
local temp_makers = {}

-- exception_promos[ 'tawich' ] = function( ePly, sCode, tPromocode, eMaker )

-- end

exception_promos[ 'vkgroup' ] = function( ePly, sCode )
    ePly:ChatSend( '~AMBI~ • ~W~ Через 10 минут вы получите награду' )

    timer.Create( 'MysticRPPromoPlayer:'..ePly:SteamID(), 60 * 10, 1, function()
        if not IsValid( ePly ) then return end

        ePly:ChatSend( '~AMBI~ • ~W~ Награда: 1000 XP, 1 уровень, 4k $, ak-47 и 10 черепов!' )
        ePly:AddXP( 1000 )
        ePly:AddLevel( 1 )
        ePly:AddMoney( 4000 )
        ePly:AddInvItem( 'wep_arccw_ak47', 1 )
        ePly:AddInvItem( 'skull1', 10 )
        ePly:ActivatePromocode()
    end )
end

hook.Add( '[Ambi.Business.Promocode.Set]', 'Ambi.MysticRP.ActivatePromo', function( ePly, sCode, tPromocode, eMaker ) 
    if exception_promos[ sCode ] then
        return exception_promos[ sCode ]( ePly, sCode, tPromocode, eMaker )
    end

    local name = IsValid( eMaker ) and eMaker:Nick() or '('..tPromocode.steamid..')'

    ePly:ChatSend( '~AMBI~ • ~W~ Вы ввели промокод '..sCode..' от игрока '..name )
    ePly:ChatSend( '~AMBI~ • ~W~ Через 10 минут вы получите награду' )
    ePly:ChatSend( '~AMBI~ • ~W~ Через 20 минут создатель промокода получит награду, если его нет, пусть зайдёт ' )
    ePly:ChatSend( '~AMBI~ • ~W~ Чтобы он получил награду, не выходите с сервера 20 минут' )

    timer.Create( 'MysticRPPromoPlayer:'..ePly:SteamID(), 60 * 10, 1, function()
        if not IsValid( ePly ) then return end

        ePly:ChatSend( '~AMBI~ • ~W~ Награда: 1000 XP, 1 уровень, 4k $, ak-47 и 10 черепов!' )
        ePly:AddXP( 1000 )
        ePly:AddLevel( 1 )
        ePly:AddMoney( 4000 )
        ePly:AddInvItem( 'wep_arccw_ak47', 1 )
        ePly:AddInvItem( 'skull1', 10 )
        ePly:ActivatePromocode()
    end )

    if IsValid( eMaker ) then
        eMaker:ChatSend( '~AMBI~ • ~W~ Ваш промокод ввели (всего: '..( tPromocode.players + 1 )..'), ожидайте 20 минут для награды' )
        
        local sid = eMaker:SteamID()

        timer.Create( 'MysticRPPromoPlayerTwo:'..sid, 60 * 10, 1, function()
            if not IsValid( eMaker ) then temp_makers[ sid ] = true return end
            if not IsValid( ePly ) then eMaker:ChatSend( '~R~ • ~W~ Игрок должен быть в сети! Пусть зайдёт обратно' ) return end
            if not ePly:GetActivatedPromocode() then eMaker:ChatSend( '~R~ • ~W~ У Игрока нет активированного промокода!' ) return end
            
            eMaker:ChatSend( '~AMBI~ • ~W~ Держите за награду и не забывайте ещё давать промокодов!' )
            eMaker:EmitSound( 'garrysmod/balloon_pop_cute.wav' )
            eMaker:AddLevel( 1 )
            --todo add two days privilege
            --todo add donate currency 
        end )
    else
        timer.Create( 'MysticRPPromoPlayerTwo:'..tPromocode.steamid, 60 * 10, 1, function()
            temp_makers[ tPromocode.steamid ] = true
        end )
    end
end )

hook.Add( '[Ambi.Authorization.Set]', 'Ambi.MysticRP.SetPromoRewardsForMakers', function( eMaker ) 
    if not temp_makers[ eMaker:SteamID() ] then return end

    temp_makers[ eMaker:SteamID()  ] = false

    eMaker:ChatSend( '~AMBI~ • ~W~ Держите за награду и не забывайте ещё давать промокодов!' )
    eMaker:EmitSound( 'garrysmod/balloon_pop_cute.wav' )
    eMaker:AddLevel( 1 )
    --todo add two days privilege
            --todo add donate currency 
end )