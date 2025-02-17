-- Полная информация по созданию работ --> https://titanovskyteam.gitbook.io/darkrp/getting-started/create-jobs

if not Ambi.DarkRP then return end

local C = Ambi.Packages.Out( 'colors' )
local Add = Ambi.DarkRP.AddJob
local SimpleAddJob = Ambi.DarkRP.SimpleAddJob

local MODELS_GANGSTERS = {
    'models/player/Group03/male_07.mdl',
    'models/player/Group03/male_02.mdl',
    'models/player/Group03/male_01.mdl', 
    'models/player/Group03/male_03.mdl', 
    'models/player/Group03/male_04.mdl', 
    'models/player/Group03/male_05.mdl', 
    'models/player/Group03/male_06.mdl', 
    'models/player/Group03/male_08.mdl',
    'models/player/Group03/male_09.mdl',

    'models/player/Group03/female_01.mdl',
    'models/player/Group03/female_02.mdl',
    'models/player/Group03/female_03.mdl',
    'models/player/Group03/female_04.mdl',
    'models/player/Group03/female_05.mdl',
    'models/player/Group03/female_06.mdl'
}

-- ----------------------------------------------------------------------------------------------------------------------------
local CATEGORY = 'Криминал'

Add( 'TEAM_GANGSTER', { 
    name = 'Мародёр', 
    command = 'gangster', 
    category = CATEGORY, 
    description = 'Самый низкоранговый бандит. Нарушает закон в одиночку, либо с группой', 
    color = C.FLAT_GRAY, 
    max = 5,
    demote = true,
    weapons = { 'lockpick' },
    models = MODELS_GANGSTERS,
} )

Add( 'TEAM_ELIT_GANG', { 
    name = 'Опытный Мародёр', 
    is_vip = true,
    command = 'mafia1', 
    category = CATEGORY, 
    description = '', 
    color = C.FLAT_GRAY, 
    max = 3,
    demote = true,
    from = 'TEAM_GANGSTER',
    weapons = { 'lockpick', 'arccw_makarov', 'arccw_melee_knife' },
    models = MODELS_GANGSTERS,
    level = 3,
} )

Add( 'TEAM_MAFIA', { 
    name = 'Мафиози', 
    is_premium = true,
    command = 'mafia2', 
    category = CATEGORY, 
    description = '', 
    color = C.AMBI_PURPLE, 
    max = 2,
    demote = true, 
    weapons = { 'lockpick', 'arccw_ragingbull', 'chainsaw', 'arccw_bizon', 'weapon_shotgun' },
    models = { 'models/hellinspector/the_toad/the_toad_pm.mdl' },
    level = 3,
} )