-- Полная информация по созданию работ --> https://titanovskyteam.gitbook.io/darkrp/getting-started/create-jobs

if not Ambi.DarkRP then return end

local C = Ambi.Packages.Out( 'colors' )
local Add = Ambi.DarkRP.AddJob
local SimpleAddJob = Ambi.DarkRP.SimpleAddJob

local SPAWN_FOREST = {
    { pos = Vector( 1436, -13860, -151 ), ang = Angle( 0, 90, 0 ) },
    { pos = Vector( 2933, -13533, -139 ), ang = Angle( 0, 90, 0 ) },
    { pos = Vector( 4843, -14139, 22 ), ang = Angle( 0, 90, 0 ) },
    { pos = Vector( 5862, -13030, -61 ), ang = Angle( 0, 90, 0 ) },
    { pos = Vector( 5929, -11442, -151 ), ang = Angle( 0, 90, 0 ) },
    { pos = Vector( 1642, -11785, -117 ), ang = Angle( 0, 90, 0 ) },
    { pos = Vector( -1422, -10248, -191 ), ang = Angle( 0, 90, 0 ) },
}

local SPAWN_UNDERGROUND = {
    { pos = Vector( -2073, 849, -900 ), ang = Angle( 0, 90, 0 ) },
    { pos = Vector( -2056, 530, -896 ), ang = Angle( 0, 90, 0 ) },
    { pos = Vector( -2075, 20, -896 ), ang = Angle( 0, 90, 0 ) },
    { pos = Vector( -2067, -561, -896 ), ang = Angle( 0, 90, 0 ) },
    { pos = Vector( -2063, -1211, -889 ), ang = Angle( 0, 90, 0 ) },
    { pos = Vector( -1566, -1783, -426 ), ang = Angle( 0, 0, 0 ) },
    { pos = Vector( -1899, -1787, -428 ), ang = Angle( 0, 0, 0 ) },
    { pos = Vector( -2149, -1787, -434 ), ang = Angle( 0, 0, 0 ) },
    { pos = Vector( -2182, -1973, -422 ), ang = Angle( 0, 0, 0 ) },
}

local SPAWN_FOREST_AND_UNDERGROUND = {
    { pos = Vector( 1436, -13860, -151 ), ang = Angle( 0, 90, 0 ) },
    { pos = Vector( 2933, -13533, -139 ), ang = Angle( 0, 90, 0 ) },
    { pos = Vector( 4843, -14139, 22 ), ang = Angle( 0, 90, 0 ) },
    { pos = Vector( 5862, -13030, -61 ), ang = Angle( 0, 90, 0 ) },
    { pos = Vector( 5929, -11442, -151 ), ang = Angle( 0, 90, 0 ) },
    { pos = Vector( 1642, -11785, -117 ), ang = Angle( 0, 90, 0 ) },
    { pos = Vector( -1422, -10248, -191 ), ang = Angle( 0, 90, 0 ) },

    { pos = Vector( -2073, 849, -900 ), ang = Angle( 0, 90, 0 ) },
    { pos = Vector( -2056, 530, -896 ), ang = Angle( 0, 90, 0 ) },
    { pos = Vector( -2075, 20, -896 ), ang = Angle( 0, 90, 0 ) },
    { pos = Vector( -2067, -561, -896 ), ang = Angle( 0, 90, 0 ) },
    { pos = Vector( -2063, -1211, -889 ), ang = Angle( 0, 90, 0 ) },
    { pos = Vector( -1566, -1783, -426 ), ang = Angle( 0, 0, 0 ) },
    { pos = Vector( -1899, -1787, -428 ), ang = Angle( 0, 0, 0 ) },
    { pos = Vector( -2149, -1787, -434 ), ang = Angle( 0, 0, 0 ) },
    { pos = Vector( -2182, -1973, -422 ), ang = Angle( 0, 0, 0 ) },
}

-- ----------------------------------------------------------------------------------------------------------------------------
local CATEGORY = 'M | Light'

Add( 'TEAM_HOMIE', { 
    light_mystic = true,
    name = 'Домовой', 
    command = 'homie', 
    category = CATEGORY, 
    description = 'Мистик на Светлой Стороне: Сторожит дома со своей двухстволкой', 
    color = C.AMBI_YELLOW, 
    max = 4,
    demote = false,
    --can_join_command = false,
    can_arrest = false,
    can_wanted = false,
    can_warrant = false,
    can_buy_door = false,
    can_pickup_weapons = false,
    hp = 2800,
    salary = 0,
    weapons = { 'weapon_fists', 'arccw_db' },
    models = { 'models/CJDucky/RillaRooFake/RillaRooFakePM.mdl' },
    spawns = SPAWN_FOREST,
    level = 2,
} )

Add( 'TEAM_YAGA', { 
    light_mystic = true,
    name = 'Баба Яга', 
    command = 'witch', 
    category = CATEGORY, 
    description = 'Нейтральный. Загадывает загадки людям', 
    color = C.AMBI_YELLOW, 
    max = 2,
    demote = false,
    --can_join_command = false,
    can_arrest = false,
    can_wanted = false,
    can_warrant = false,
    can_buy_door = false,
    can_pickup_weapons = false,
    hp = 1000,
    salary = 0,
    weapons = { 'weapon_fists' },
    models = { 'models/player/monstermash/mm_witch.mdl' },
    spawns = SPAWN_FOREST,
    level = 2,
} )

Add( 'TEAM_CRACKER', {
    light_mystic = true,
    name = 'Сухарик', 
    command = 'cracker', 
    category = CATEGORY, 
    description = 'Мирный. Варит "весёлые" вещества', 
    color = C.AMBI_YELLOW, 
    max = 4,
    demote = false,
    --can_join_command = false,
    can_arrest = false,
    can_wanted = false,
    can_warrant = false,
    walkspeed = 350,
    runspeed = 520,
    model_scale = 0.7,
    hp = 350,
    salary = 0,
    models = { 'models/player/charple.mdl' },
    spawns = SPAWN_UNDERGROUND,
    level = 5,
} )

Add( 'TEAM_JESUS', { 
    light_mystic = true,
    name = 'Иисус', 
    is_premium = true,
    command = 'jesus', 
    category = CATEGORY, 
    description = 'Вы всемогущее существо', 
    color = C.AMBI_YELLOW, 
    max = 1,
    demote = false,
    --can_join_command = false,
    can_arrest = false,
    can_wanted = false,
    can_warrant = false,
    walkspeed = 400,
    runspeed = 700,
    hp = 9696,
    salary = 0,
    weapons = { 'arccw_jesusword' },
    models = { 'models/gtav/jesus christ.mdl' },
} )