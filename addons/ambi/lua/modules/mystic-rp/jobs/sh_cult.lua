-- Полная информация по созданию работ --> https://titanovskyteam.gitbook.io/darkrp/getting-started/create-jobs

if not Ambi.DarkRP then return end

local C = Ambi.Packages.Out( 'colors' )
local Add = Ambi.DarkRP.AddJob
local SimpleAddJob = Ambi.DarkRP.SimpleAddJob

-- ----------------------------------------------------------------------------------------------------------------------------
local CATEGORY = 'Инквизиторы'
local COLOR = Color( 118, 5, 50 )
local SPAWNS = {
    { pos = Vector( -1709, -4107, -902 ), ang = Angle( 0, 0, 0 ) },
    { pos = Vector( -1710, -3605, -896 ), ang = Angle( 0, 0, 0 ) },
    { pos = Vector( -2084, -4179, -884 ), ang = Angle( 0, 0, 0 ) },
    { pos = Vector( -2075, -3735, -886 ), ang = Angle( 0, 0, 0 ) },
}

Add( 'TEAM_CULT1', { 
    name = 'Культист', 
    command = 'cult1', 
    category = CATEGORY, 
    description = '[ДАННЫЕ УДАЛЕНЫ]', 
    color = COLOR, 
    max = 4,
    hp = 75,
    salary = 0,
    multiply_damage = 10,
    weapons = { 'weapon_cuff_rope', 'weapon_fists', 'arccw_melee_knife', 'arccw_makarov' },
    models = { 'models/WHdow2/cultist_plr.mdl' },
    level = 2,
    spawns = SPAWNS,
} )

Add( 'TEAM_CULT2', { 
    name = 'Культист - Высший', 
    command = 'cult2', 
    category = CATEGORY, 
    description = '[ДАННЫЕ УДАЛЕНЫ]', 
    color = COLOR, 
    max = 2,
    hp = 100,
    salary = 0,
    multiply_damage = 10,
    weapons = { 'weapon_cuff_shackles', 'weapon_fists', 'arccw_melee_knife', 'arccw_makarov', 'arccw_shorty' },
    models = { 'models/player/kogg/traitor_marine.mdl' },
    level = 3,
    spawns = SPAWNS,
} )

Add( 'TEAM_CULT_LEADER', { 
    name = 'Лидер Культистов', 
    command = 'cult_leader', 
    category = CATEGORY, 
    description = '[ДАННЫЕ УДАЛЕНЫ]', 
    color = COLOR, 
    max = 1,
    hp = 125,
    salary = 0,
    multiply_damage = 10,
    weapons = { 'weapon_cuff_shackles', 'weapon_fists', 'arccw_deagle357', 'arccw_melee_knife', 'arccw_shorty' },
    models = { 'models/player/kogg/chaos_lord.mdl' },
    level = 5,
    spawns = SPAWNS,
} )

-- VIP
Add( 'TEAM_CULT_VIP', { 
    is_vip = true,
    name = 'Культист-Воин', 
    command = 'cult_vip', 
    category = CATEGORY, 
    description = '[ДАННЫЕ УДАЛЕНЫ]', 
    color = COLOR, 
    max = 4,
    hp = 200,
    salary = 0,
    multiply_damage = 15,
    block_user = true,
    weapons = { 'weapon_cuff_shackles', 'disguise_swep', 'weapon_crossbow', 'arccw_deagle357', 'arccw_melee_knife', 'arccw_nade_incendiary' },
    models = { 'models/player/kogg/traitor_marine.mdl' },
    spawns = SPAWNS,
} )

-- Premium
Add( 'TEAM_CULT_PREMIUM', { 
    is_premium = true,
    name = 'Культис-Маг', 
    command = 'cult_prem', 
    category = CATEGORY, 
    description = '[ДАННЫЕ УДАЛЕНЫ]', 
    color = COLOR, 
    max = 2,
    hp = 350,
    salary = 0,
    multiply_damage = 15,
    block_user = true,
    weapons = { 'weapon_cuff_standard', 'disguise_swep', 'weapon_crossbow', 'arccw_ragingbull', 'arccw_melee_knife', 'arccw_nade_incendiary' },
    models = { 'models/player/kogg/sorcerer_marine.mdl' },
    spawns = SPAWNS,
} )