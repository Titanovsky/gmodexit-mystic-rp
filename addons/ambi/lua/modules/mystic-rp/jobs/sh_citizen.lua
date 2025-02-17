-- Полная информация по созданию работ --> https://titanovskyteam.gitbook.io/darkrp/getting-started/create-jobs

if not Ambi.DarkRP then return end

local C = Ambi.Packages.Out( 'colors' )
local Add = Ambi.DarkRP.AddJob
local SimpleAddJob = Ambi.DarkRP.SimpleAddJob

local MODELS_CITIZEN = {
    'models/player/Group01/male_07.mdl',
    'models/player/Group01/male_02.mdl',
    'models/player/Group01/male_01.mdl', 
    'models/player/Group01/male_03.mdl', 
    'models/player/Group01/male_04.mdl', 
    'models/player/Group01/male_05.mdl', 
    'models/player/Group01/male_06.mdl', 
    'models/player/Group01/male_08.mdl',
    'models/player/Group01/male_09.mdl',

    'models/player/Group01/female_01.mdl',
    'models/player/Group01/female_02.mdl',
    'models/player/Group01/female_03.mdl',
    'models/player/Group01/female_04.mdl',
    'models/player/Group01/female_05.mdl',
    'models/player/Group01/female_06.mdl'
}

local MODELS_MEDICS = {
    'models/player/Group03m/male_07.mdl',
    'models/player/Group03m/male_02.mdl', 
    'models/player/Group03m/male_01.mdl',
    'models/player/Group03m/male_03.mdl', 
    'models/player/Group03m/male_04.mdl', 
    'models/player/Group03m/male_05.mdl', 
    'models/player/Group03m/male_06.mdl', 
    'models/player/Group03m/male_08.mdl', 
    'models/player/Group03m/male_09.mdl', 

    'models/player/Group03m/female_01.mdl', 
    'models/player/Group03m/female_02.mdl', 
    'models/player/Group03m/female_03.mdl', 
    'models/player/Group03m/female_04.mdl', 
    'models/player/Group03m/female_05.mdl',
    'models/player/Group03m/female_06.mdl', 
}


local WEAPONS_MEDIC = {
    'med_kit'
}

-- ----------------------------------------------------------------------------------------------------------------------------
local CATEGORY = 'Гражданские'

Add( 'TEAM_CITIZEN', { 
    name = 'Житель', 
    command = 'citizen', 
    models = MODELS_CITIZEN,
    max = 0,
    category = CATEGORY, 
    demote = false,
    color = C.AMBI_GREEN,
} )

Add( 'TEAM_MEDIC', { 
    name = 'Медик', 
    command = 'medic', 
    max = 4,
    category = 'Жители', 
    models = MODELS_MEDICS,
    weapons = WEAPONS_MEDIC,
    demote = true,
    color = C.RU_PINK,
} )

Add( 'TEAM_BUSINESSMAN', { 
    name = 'Предприниматель', 
    command = 'businessman', 
    category = CATEGORY, 
    description = 'Житель города, способный покупать больше дверей', 
    color = C.AMBI_SALAT, 
    max = 4,
    doors_max = 12,
    models = { 'models/player/magnusson.mdl' },
} )