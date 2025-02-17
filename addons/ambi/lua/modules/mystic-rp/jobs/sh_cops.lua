-- Полная информация по созданию работ --> https://titanovskyteam.gitbook.io/darkrp/getting-started/create-jobs

if not Ambi.DarkRP then return end

local C = Ambi.Packages.Out( 'colors' )
local Add = Ambi.DarkRP.AddJob
local SimpleAddJob = Ambi.DarkRP.SimpleAddJob

local MODELS_POLICE = {
    'models/player/police.mdl', 
}

local WEAPONS_POLICE = {
    'cross_arms_swep',
    'salute_swep',
    'arrest_stick',
    'unarrest_stick',
    'stunstick',
    'weapon_pistol',
    'weapon_cuff_police',
    'arccw_g18',
}

local WEAPONS_SWAT = {
    'cross_arms_swep',
    'salute_swep',
    'arrest_stick',
    'unarrest_stick',
    'stunstick',
    'door_ram',
    'arccw_fiveseven',
    'arccw_mp5',
    'arccw_shorty',
    'weapon_cuff_police',
}

local WEAPONS_SHERIFF = {
    'cross_arms_swep',
    'salute_swep',
    'arrest_stick',
    'unarrest_stick',
    'stunstick',
    'door_ram',
    'arccw_deagle357',
    'arccw_aug',
    'arccw_shorty',
    'weapon_cuff_police',
}

local SPAWNS = {
    { pos = Vector( -2779, 233, -115 ), ang = Angle( 0, 0, 0 ) },
    { pos = Vector( -2776, 317, -108 ), ang = Angle( 0, 0, 0 ) },
    { pos = Vector( -2682, 222, -117 ), ang = Angle( 0, 0, 0 ) },
    { pos = Vector( -2667, 305, -116 ), ang = Angle( 0, 0, 0 ) },
    { pos = Vector( -2536, 239, -111 ), ang = Angle( 0, 0, 0 ) },
    { pos = Vector( -1922, 229, -116 ), ang = Angle( 0, 0, 0 ) },
    { pos = Vector( -1863, 234, -117 ), ang = Angle( 0, 0, 0 ) },
}

-- ----------------------------------------------------------------------------------------------------------------------------
local CATEGORY = 'МВД'

Add( 'TEAM_POLICE1', { 
    name = 'Рядовой Полиции', 
    command = 'police1', 
    category = CATEGORY, 
    description = 'Сотрудник правопорядка', 
    color = C.AMBI_BLUE, 
    police = true,
    weapons = WEAPONS_POLICE, 
    demote = true,
    max = 4,
    models = MODELS_POLICE, 
    level = 3,
    spawns = SPAWNS,
} )

Add( 'TEAM_POLICE2', { 
    name = 'Офицер Полиции', 
    command = 'police3', 
    category = CATEGORY, 
    description = 'Сотрудник правопорядка', 
    color = C.AMBI_BLUE, 
    police = true,
    weapons = WEAPONS_POLICE, 
    demote = true,
    max = 2,
    models = MODELS_POLICE,
    level = 4,
    spawns = SPAWNS,
} )

Add( 'TEAM_SWAT', { 
    name = 'Спецназ', 
    command = 'swat', 
    category = CATEGORY, 
    description = 'Отряд Специального Назначения, подчиняется Шерифу', 
    vote = true,
    color = C.AMBI_BLUE, 
    police = true,
    weapons = WEAPONS_SWAT, 
    max = 2,
    demote = true,
    models = { 'models/player/riot.mdl', 'models/player/urban.mdl', 'models/player/gasmask.mdl' },
    level = 5,
    spawns = SPAWNS,
} )

Add( 'TEAM_SHERIFF', { 
    name = 'Шериф', 
    command = 'sheriff', 
    category = CATEGORY, 
    description = 'Шериф города. Полностью руководит Полицейским Участком', 
    color = C.AMBI_HARD_BLUE, 
    police = true,
    weapons = WEAPONS_SHERIFF, 
    max = 1,
    vote = true,
    demote = true,
    models = { 'models/player/barney.mdl' },
    level = 6,
    spawns = SPAWNS,
} )

-- ----------------------------------------------------------------------------------------------------------------------------
local CATEGORY = 'Мэрия'

Add( 'TEAM_MAYOR', { 
    name = 'Мэр', 
    category = CATEGORY, 
    command = 'mayror', 
    description = 'Управляющий города\nИменно он назначает, что да как', 
    color = C.ABS_RED, 
    demote_after_death = true, 
    mayor = true,
    weapons = { 'stunstick', 'arccw_fiveseven', 'unarrest_stick' }, 
    demote = true,
    max = 1,
    vote = true,
    salary = 500,
    models = { 'models/player/breen.mdl', 'models/player/mossman_arctic.mdl' },
    level = 5,
    spawns = {
        { pos = Vector( -1718, -77, -1 ), ang = Angle( 0, 105, 0 ) },
    },
} )