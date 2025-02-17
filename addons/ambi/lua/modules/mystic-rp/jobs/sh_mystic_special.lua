-- Полная информация по созданию работ --> https://titanovskyteam.gitbook.io/darkrp/getting-started/create-jobs

if not Ambi.DarkRP then return end

local C = Ambi.Packages.Out( 'colors' )
local Add = Ambi.DarkRP.AddJob
local SimpleAddJob = Ambi.DarkRP.SimpleAddJob

-- ----------------------------------------------------------------------------------------------------------------------------
local CATEGORY = 'M | Specialist'

-- Premium
Add( 'TEAM_SCIENTIST', { 
    name = 'Сумасшедший Учёный', 
    is_premium = true,
    command = 'scientist', 
    category = CATEGORY, 
    description = 'Учёный, который создаёт Зомби, но во благо или во вред?', 
    color = C.AMBI_WHITE, 
    max = 4,
    models = { 'models/player/kleiner.mdl', 'models/player/magnusson.mdl', 'models/player/hostage/hostage_04.mdl' },
    level = 5,
} )