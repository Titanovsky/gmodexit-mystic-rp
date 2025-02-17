local C = Ambi.Packages.Out( 'colors' )
local Add = Ambi.DarkRP.AddShopItem
local SimpleAddItem = Ambi.DarkRP.SimpleAddShopItem

-- ----------------------------------------------------------------------------------------------------------------------------
local CATEGORY = 'Other'

Add( 'heal1', {
    name = 'Аптечка +10',
    ent = 'item_healthvial',
    model = 'models/healthvial.mdl',
    price = 80,
    max = 2,
    
    category = CATEGORY,
} )

Add( 'heal2', {
    name = 'Аптечка +25',
    ent = 'item_healthkit',
    model = 'models/items/healthkit.mdl',
    price = 180,
    max = 2,
    
    category = CATEGORY,
} )

Add( 'defence1', {
    name = 'Защита +15',
    ent = 'item_battery',
    model = 'models/items/battery.mdl',
    price = 80,
    max = 2,
    
    category = CATEGORY,
} )

Add( 'photocamera', {
    name = 'Фотоаппарат',
    ent = 'gmod_camera',
    model = 'models/MaxOfS2D/camera.mdl',
    price = 500,
    max = 2,
    
    category = CATEGORY,
} )

-- Add(
--     'Раздатчик Здоровья', 
--     {
--         sortOrder = 100,
--         ent = 'health_recharger',
--         model = 'models/props_c17/consolebox03a.mdl',
--         price = 12000,
--         max = 2,
        
--         category = CATEGORY,
--     }  
-- )

-- Add(
--     'Раздатчик Здоровья (VIP)', 
--     {
--         sortOrder = 100,
--         ent = 'vip_health_recharger',
--         model = 'models/props_lab/reciever01a.mdl',
--         price = 16000,
--         max = 1,
--         cmd = 'buyrech2',
        
--         category = CATEGORY,
--     }  
-- )

-- Add(
--     'Раздатчик Брони', 
--     {
--         sortOrder = 100,
--         ent = 'armor_recharger',
--         model = 'models/props_c17/consolebox03a.mdl',
--         price = 9000,
--         max = 2,
--         cmd = 'buyrech3',
        
--         category = CATEGORY,
--     }  
-- )

-- Add(
--     'Раздатчик Брони (VIP)', 
--     {
--         sortOrder = 100,
--         ent = 'vip_armor_recharger',
--         model = 'models/props_lab/reciever01a.mdl',
--         price = 12000,
--         max = 1,
--         cmd = 'buyrech4',
        
--         category = CATEGORY,
--     }  
-- )