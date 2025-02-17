-- Полная информация по созданию работ --> https://titanovskyteam.gitbook.io/darkrp/getting-started/create-jobs

if not Ambi.DarkRP then return end

local C = Ambi.Packages.Out( 'colors' )
local Add = Ambi.DarkRP.AddJob
local SimpleAddJob = Ambi.DarkRP.SimpleAddJob

-- ----------------------------------------------------------------------------------------------------------------------------
local CATEGORY = 'Инквизиторы'

local SPAWNS = {
    { pos = Vector( -380, 1157, -136 ), ang = Angle( 0, 0, 0 ) },
    { pos = Vector( -440, 1165, -140 ), ang = Angle( 0, 0, 0 ) },
    { pos = Vector( -515, 1170, -144 ), ang = Angle( 0, 0, 0 ) },
    { pos = Vector( -596, 1191, -141 ), ang = Angle( 0, 0, 0 ) },
    { pos = Vector( -615, 1130, -138 ), ang = Angle( 0, 0, 0 ) },
    { pos = Vector( -591, 1245, -142 ), ang = Angle( 0, 0, 0 ) },
}

Add( 'TEAM_INQUISITOR', { 
    name = 'Инквизитор-Рекрут', 
    command = 'inquisitor', 
    category = CATEGORY, 
    description = '[ДАННЫЕ УДАЛЕНЫ]', 
    color = C.AMBI_WHITE, 
    max = 4,
    hp = 200,
    salary = 0,
    multiply_damage = 10,
    weapons = { 'weapon_fists', 'weapon_crowbar' },
    models = { 'models/player/doktor_haus/plague_doctor.mdl' },
    level = 3,
    spawns = SPAWNS,
} )

Add( 'TEAM_INQUISITOR2', { 
    name = 'Инквизитор-Воин', 
    command = 'inquisitor2', 
    category = CATEGORY, 
    description = '[ДАННЫЕ УДАЛЕНЫ]', 
    color = C.AMBI_WHITE, 
    max = 2,
    hp = 200,
    salary = 0,
    multiply_damage = 10,
    weapons = { 'weapon_fists', 'weapon_crowbar' },
    models = { 'models/player/doktor_haus/plague_doctor.mdl' },
    level = 4,
    spawns = SPAWNS,
} )

Add( 'TEAM_INQUISITOR_LEADER', { 
    name = 'Кардинал Инквизиций', 
    command = 'inquisitor_leader', 
    category = CATEGORY, 
    description = '[ДАННЫЕ УДАЛЕНЫ]', 
    color = C.AMBI_WHITE, 
    max = 1,
    hp = 200,
    salary = 0,
    multiply_damage = 10,
    weapons = { 'weapon_fists',  'weapon_crowbar' },
    models = { 'models/player/doktor_haus/plague_doctor.mdl' },
    level = 5,
    spawns = SPAWNS,
} )


-- VIP
Add( 'TEAM_INQUISITOR_VIP', { 
    is_vip = true,
    name = 'Спец. Инквизитор', 
    command = 'inquisitor_vip', 
    category = CATEGORY, 
    description = '[ДАННЫЕ УДАЛЕНЫ]', 
    color = C.AMBI_WHITE, 
    max = 4,
    hp = 450,
    salary = 0,
    multiply_damage = 15,
    block_user = true,
    weapons = { 'weapon_fists', 'arccw_gauss_rifle' },
    models = { 'models/player/quake4pm/quake4pm.mdl' },
    spawns = SPAWNS,
} )

-- Premium
Add( 'TEAM_INQUISITOR_PREMIUM', { 
    is_premium = true,
    name = 'Опытный Инквизитор', 
    command = 'inquisitor_prem', 
    category = CATEGORY, 
    description = '[ДАННЫЕ УДАЛЕНЫ]', 
    color = C.AMBI_WHITE, 
    max = 2,
    hp = 450,
    salary = 0,
    multiply_damage = 15,
    block_user = true,
    weapons = { 'weapon_fists', 'arccw_gauss_rifle' },
    models = { 'models/player/zsecurity/zsecurity.mdl' },
    spawns = SPAWNS,
} )