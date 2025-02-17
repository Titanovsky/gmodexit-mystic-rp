local Add = Ambi.Daily.AddPattern

local jobs = {
    'TEAM_DEMON',
    'TEAM_POLICE1',
    'TEAM_POLICE2',
    'TEAM_SWAT',
    'TEAM_MEDIC',
    'TEAM_BUSINESSMAN',
    'TEAM_GANGSTER',
    'TEAM_CULT1',
    'TEAM_CULT2',
    'TEAM_INQUISITOR',
    'TEAM_INQUISITOR2',
    'TEAM_VAMPIRE',
    'TEAM_NECROMANCER',
    'TEAM_LYCAN',
    'TEAM_MURDER',
    'TEAM_HOMIE'
}
Add( 'setjob', {
    Description = function( tDaily )
        local job = tDaily.features.job_name

        return 'Вступить на работу '..job
    end,

    Reward = function( ePly, tDaily )
        ePly:ChatSend( 'Вы победили в дейлике: '..tDaily.features.job_name )
    end,

    Make = function( tDaily, nID )
        local job_class = table.Random( jobs )
        local job = Ambi.DarkRP.GetJob( job_class )
        if not job then return end

        tDaily.features.job = job_class
        tDaily.features.job_name = job.name

        Ambi.Daily.HookAdd( tDaily, '[Ambi.DarkRP.SetJob]', 'Ambi.MysticRP.DailySetJob', function( ePly, sClass )
            if ( sClass ~= job_class ) then return end

            Ambi.Daily.AddCount( ePly, nID, 1 )
        end )
    end
} )

Add( 'addmoney', {
    Description = function( tDaily )
        return 'Заработать денег'
    end,

    Reward = function( ePly, tDaily )
        ePly:ChatSend( '~B~ • ~W~ За выполнение дейлика вы получаете: ~AMBI~ 500 XP'  )
        ePly:AddXP( 500 )
    end,

    Make = function( tDaily, nID )
        tDaily.count = math.random( 2000, 11000 )

        Ambi.Daily.HookAdd( tDaily, '[Ambi.DarkRP.AddMoney]', 'Ambi.MysticRP.DailyAddMoney', function( ePly, nMoney )
            if ( nMoney <= 0 ) then return end
            
            Ambi.Daily.AddCount( ePly, nID, nMoney )
        end )
    end
} )

Add( 'earn_factory_videocard1', {
    Description = function( tDaily )
        return 'Заработать денег на заводе DNS'
    end,

    Reward = function( ePly, tDaily )
        ePly:ChatSend( '~B~ • ~W~ За выполнение дейлика вы получаете: ~AMBI~ 500 XP'  )
        ePly:AddXP( 500 )
    end,

    Make = function( tDaily, nID )
        tDaily.count = math.random( 800, 4000 )

        Ambi.Daily.HookAdd( tDaily, '[Ambi.MysticRP.PutVideocard]', 'Ambi.MysticRP.DailyAddMoneyDNS', function( ePly, _, nMoney )
            Ambi.Daily.AddCount( ePly, nID, nMoney )
        end )
    end
} )

Add( 'playcasino', {
    Description = function( tDaily )
        return 'Сыграть в Казино'
    end,

    Reward = function( ePly, tDaily )
        ePly:ChatSend( '~B~ • ~W~ За выполнение дейлика вы получаете: ~AMBI~ 250 XP ~W~ и ~G~ 1000$'  )
        ePly:AddXP( 250 )
        ePly:AddMoney( 1000 )
    end,

    Make = function( tDaily, nID )
        tDaily.count = math.random( 1, 6 )

        Ambi.Daily.HookAdd( tDaily, '[Ambi.MysticRP.UsedCasino]', 'Ambi.MysticRP.DailyCasinoPlay', function( ePly )
            Ambi.Daily.AddCount( ePly, nID, 1 )
        end )
    end
} )

Add( 'call_pet', {
    Description = function( tDaily )
        return 'Вызвать Питомца'
    end,

    Reward = function( ePly, tDaily )
        ePly:ChatSend( '~B~ • ~W~ За выполнение дейлика вы получаете: ~AMBI~ 100 XP'  )
        ePly:AddXP( 100 )
    end,

    Make = function( tDaily, nID )
        tDaily.count = 1

        Ambi.Daily.HookAdd( tDaily, '[Ambi.MysticRP.CallPet]', 'Ambi.MysticRP.DailyCallPet', function( ePly )
            Ambi.Daily.AddCount( ePly, nID, 1 )
        end )
    end
} )

Add( 'take_xp', {
    Description = function( tDaily )
        return 'Получить XP'
    end,

    Reward = function( ePly, tDaily )
        ePly:ChatSend( '~B~ • ~W~ За выполнение дейлика вы получаете: ~G~ 1800$'  )
        ePly:AddMoney( 1800 )
    end,

    Make = function( tDaily, nID )
        tDaily.count = math.random( 10, 250 )

        Ambi.Daily.HookAdd( tDaily, '[Ambi.MysticRP.AddXP]', 'Ambi.MysticRP.DailyAddXP', function( ePly, nCount )
            Ambi.Daily.AddCount( ePly, nID, nCount )
        end )
    end
} )

Add( 'buy_weapon', {
    Description = function( tDaily )
        return 'Купить Оружие'
    end,

    Reward = function( ePly, tDaily )
        ePly:ChatSend( '~B~ • ~W~ Награда: ~G~ 1000$'  )
        ePly:AddMoney( 1000 )
    end,

    Make = function( tDaily, nID )
        tDaily.count = 1

        Ambi.Daily.HookAdd( tDaily, '[Ambi.MysticRP.BuyedShopWeapons]', 'Ambi.MysticRP.DailyBuyWeapon', function( ePly )
            Ambi.Daily.AddCount( ePly, nID, 1 )
        end )
    end
} )

Add( 'open_skull', {
    Description = function( tDaily )
        return 'Открыть Череп'
    end,

    Reward = function( ePly, tDaily )
        ePly:ChatSend( '~B~ • ~W~ Награда: ~AMBI~ 500 XP'  )
        ePly:AddXP( 500 )
    end,

    Make = function( tDaily, nID )
        tDaily.count = math.random( 1, 10 )

        Ambi.Daily.HookAdd( tDaily, '[Ambi.MysticRP.OpenSkull]', 'Ambi.MysticRP.DailyOpenSkull', function( ePly )
            Ambi.Daily.AddCount( ePly, nID, 1 )
        end )
    end
} )

Add( 'buy_shop_item', {
    Description = function( tDaily )
        return 'Купить что-то в магазине'
    end,

    Reward = function( ePly, tDaily )
        ePly:ChatSend( '~B~ • ~W~ Награда: ~G~ 2500$'  )
        ePly:AddMoney( 2500 )
    end,

    Make = function( tDaily, nID )
        tDaily.count = math.random( 1, 3 )

        Ambi.Daily.HookAdd( tDaily, '[Ambi.DarkRP.BuyShopItem]', 'Ambi.MysticRP.DailyOpenSkull', function( ePly )
            Ambi.Daily.AddCount( ePly, nID, 1 )
        end )
    end
} )