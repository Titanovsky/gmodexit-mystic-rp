Ambi.General.CreateModule( 'RobObj' )

-- ---------------------\------------------------------------------------------------------------------------------------------------------------
Ambi.RobObj.Config.min_online = 3 -- Сколько нужно онлайна

Ambi.RobObj.Config.rewards = { -- Награды
    -- Если груз спасут никто не украдёт. Рандомно от min до max
    min_money_save = 250,
    max_money_save = 600,

    -- Если груз украдут. Рандомно от min до max
    min_money_rob = 4000,
    max_money_rob = 5000
}

Ambi.RobObj.Config.delays = {
    -- Задержка рандомно от min и до max между приездом груза в город
    min_delay = 700,
    max_delay = 1600,

    time_rob = 600, -- Время сколько будет идти ивент

    time_rob_object = 120 -- Сколько будет грабить игрок объект?
}

Ambi.RobObj.Config.object = {
    class = 'rob_object',
    name = 'Золото',
    hp = 800, -- Здоровье
    places = { -- Количество, а также место
        { pos = Vector( 3838, 2858, -175 ), ang = Angle( 0, 180, 0 ) },
        { pos = Vector( 3878, 3199, -176 ), ang = Angle( 0, 180, 0 ) },
        { pos = Vector( 3856, 3571, -176 ), ang = Angle( 0, 180, 0 ) }
    }
}

Ambi.RobObj.Config.security = {
    turn_on = true,
    repeat_spawn = false, -- нужно им ещё раз появится? (время time_rob / 2)
    guns = {
        'weapon_ar2',
    },
    models = {
        'models/Combine_Super_Soldier.mdl'
    },
    dmg = 2.32, -- На сколько умножится дамаг на игрока от NPC
    min_hp = 200,
    max_hp = 400,
    places = {
        { pos = Vector( 3586, 3003, -196), ang = Angle( 0, 80, 0 ) },
        { pos = Vector( 3295, 2853, -196 ), ang = Angle( 0, 80, 0 ) },
        { pos = Vector( 3334, 3391, -68 ), ang = Angle( 0, 0, 0 ) },
    }
}

Ambi.RobObj.Config.can_rob_jobs = {
    [ 'TEAM_GANGSTER' ] = true,
    [ 'TEAM_ELIT_GANG' ] = true,
    [ 'TEAM_MAFIA' ] = true,
    [ 'TEAM_BL_LEADER' ] = true,
    [ 'TEAM_BL4' ] = true,
    [ 'TEAM_BL3' ] = true,
    [ 'TEAM_BL2' ] = true,
    [ 'TEAM_BL1' ] = true,
    [ 'TEAM_BS1' ] = true,
    [ 'TEAM_BS2' ] = true,
    [ 'TEAM_BS3' ] = true,
    [ 'TEAM_BS4' ] = true,
}