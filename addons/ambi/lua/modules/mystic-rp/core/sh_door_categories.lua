-- Полная информация по созданию категорий для дверей --> https://titanovskyteam.gitbook.io/darkrp/getting-started/create-door-category

if not Ambi.DarkRP then return end

local AddCategory = Ambi.DarkRP.AddDoorCategory

-- ----------------------------------------------------------------------------------------------------------------------------
AddCategory( 'Полицейский Участок', { 'TEAM_POLICE1', 'TEAM_SHERIFF', 'TEAM_SWAT', 'TEAM_POLICE2', 'TEAM_MAYOR', 'TEAM_BL_LEADER', 'TEAM_BL3' } )
AddCategory( 'Тюрьма', { 'TEAM_SHERIFF', 'TEAM_POLICE2', 'TEAM_MAYOR', 'TEAM_BL_LEADER', 'TEAM_BL3' } )

AddCategory( 'Церковь', { 'TEAM_INQUISITOR', 'TEAM_INQUISITOR2', 'TEAM_INQUISITOR_LEADER', 'TEAM_INQUISITOR_VIP', 'TEAM_INQUISITOR_PREMIUM', 'TEAM_INQUISITOR_TITANIUM' } )

AddCategory( 'Schwartz Legion', { 'TEAM_BL_LEADER', 'TEAM_BL4', 'TEAM_BL3', 'TEAM_BL2', 'TEAM_BL1' } )
AddCategory( 'Black Sun', { 'TEAM_BS1', 'TEAM_BS2', 'TEAM_BS3', 'TEAM_BS4' } )