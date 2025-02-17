local C = Ambi.Packages.Out( 'colors' )
local Add = Ambi.DarkRP.AddShopItem
local SimpleAddItem = Ambi.DarkRP.SimpleAddShopItem

-- ----------------------------------------------------------------------------------------------------------------------------
local CATEGORY = 'Weapons'

Add( 'lockpick', {
    name = 'Отмычка',
    ent = 'lockpick',
    weapon = true,
    model = 'models/weapons/w_crowbar.mdl',
    price = 800,
    max = 1,
    allowed = { 'TEAM_GANGSTER', 'TEAM_GANG1', 'TEAM_GANG2', 'TEAM_GANG3', 'TEAM_MAFIA1', 'TEAM_MAFIA2', 'TEAM_MAFIA3' },
    
    category = CATEGORY
} )

Add( 'gunbox', {
    name = 'Знания Бокса',
    weapon = true,
    ent = 'arccw_melee_fists',
    model = 'models/Gibs/HGIBS.mdl',
    price = 500,
    max = 4,
    
    category = CATEGORY
} )

Add( 'knife', {
    name = 'Нож',
    weapon = true,
    ent = 'arccw_melee_knife',
    model = 'models/weapons/w_knife_t.mdl',
    price = 800,
    max = 2,
    allowed = { 'TEAM_GUNDEALER', 'TEAM_GUNDEALER_VIP' },
    
    category = CATEGORY
} )

-- ----------------------------------------------------------------------------------------------------------------------------
local CATEGORY = 'Weapons: Pistols'

Add( 'makarov', 
    {
        name = 'Макаров',
        weapon = true,
        ent = 'arccw_makarov',
        model = 'models/weapons/arccw/w_pmt.mdl',
        price = 2700,
        max = 2,
        allowed = { 'TEAM_GUNDEALER', 'TEAM_GUNDEALER_VIP' },
        
        category = CATEGORY
    }  
)

Add( 'g18', 
    {
        name = 'Glock 18',
        weapon = true,
        ent = 'arccw_g18',
        model = 'models/weapons/w_pist_glock18.mdl',
        price = 3800,
        max = 2,
        allowed = { 'TEAM_GUNDEALER', 'TEAM_GUNDEALER_VIP' }, { 'TEAM_GUNDEALER', 'TEAM_GUNDEALER_VIP' },
        
        category = CATEGORY
    }  
)

Add( 'python', 
    {
        name = 'Python',
        weapon = true,
        ent = 'arccw_ragingbull',
        model = 'models/weapons/arccw/w_ragingbull.mdl',
        price = 12000,
        max = 2,
        allowed = { 'TEAM_GUNDEALER', 'TEAM_GUNDEALER_VIP' },
        
        category = CATEGORY
    }  
)

Add( 'usp', 
    {
        name = 'USP',
        weapon = true,
        ent = 'arccw_usp',
        model = 'models/weapons/w_pist_usp.mdl',
        price = 4500,
        max = 2,
        allowed = { 'TEAM_GUNDEALER', 'TEAM_GUNDEALER_VIP' },
        
        category = CATEGORY
    }  
)

-- ----------------------------------------------------------------------------------------------------------------------------
local CATEGORY = 'Weapons: Shotguns'

Add( 'shorty', 
    {
        name = 'Shorty',
        weapon = true,
        ent = 'arccw_shorty',
        model = 'models/weapons/arccw/w_defender.mdl',
        price = 7000,
        max = 2,
        allowed = { 'TEAM_GUNDEALER', 'TEAM_GUNDEALER_VIP' },
        
        category = CATEGORY
    }  
)

Add( 'sawn-off', 
    {
        name = 'Sawn-Off',
        weapon = true,
        ent = 'arccw_db_sawnoff',
        model = 'models/weapons/arccw/w_sawnoff.mdl',
        price = 6400,
        max = 2,
        allowed = { 'TEAM_GUNDEALER', 'TEAM_GUNDEALER_VIP' },
        
        category = CATEGORY
    }  
)

Add( 'm1014', 
    {
        name = 'M1014',
        weapon = true,
        ent = 'arccw_m1014',
        model = 'models/weapons/arccw/w_as1217.mdl',
        price = 16000,
        max = 2,
        allowed = { 'TEAM_GUNDEALER', 'TEAM_GUNDEALER_VIP' },
        
        category = CATEGORY
    }  
)

-- ----------------------------------------------------------------------------------------------------------------------------
local CATEGORY = 'Weapons: SMGs'

Add( 'tmp', 
    {
        name = 'TMP',
        weapon = true,
        ent = 'arccw_tmp',
        model = 'models/weapons/arccw/w_tmp.mdl',
        price = 6000,
        max = 2,
        allowed = { 'TEAM_GUNDEALER', 'TEAM_GUNDEALER_VIP' },
        
        category = CATEGORY
    }  
)

Add( 'mp5', 
    {
        name = 'MP5',
        weapon = true,
        ent = 'arccw_mp5',
        model = 'models/weapons/arccw/w_mp5.mdl',
        price = 8000,
        max = 2,
        allowed = { 'TEAM_GUNDEALER', 'TEAM_GUNDEALER_VIP' },
        
        category = CATEGORY
    }  
)

Add( 'scount', 
    {
        name = 'Scout',
        weapon = true,
        ent = 'arccw_scout',
        model = 'models/weapons/arccw/w_psrs.mdl',
        price = 15000,
        max = 2,
        allowed = { 'TEAM_GUNDEALER', 'TEAM_GUNDEALER_VIP' },
        
        category = CATEGORY
    }  
)

-- ----------------------------------------------------------------------------------------------------------------------------
local CATEGORY = 'Weapons: Hard Rifle'

Add( 'ak47', 
    {
        name = 'AK-47',
        weapon = true,
        ent = 'arccw_ak47',
        model = 'models/weapons/arccw/w_type2.mdl',
        price = 20000,
        max = 1,
        allowed = { 'TEAM_GUNDEALER', 'TEAM_GUNDEALER_VIP' },
        
        category = CATEGORY
    }  
)

Add( 'm4a1', 
    {
        name = 'M4A1',
        weapon = true,
        ent = 'arccw_m4a1',
        model = 'models/weapons/arccw/mk4.mdl',
        price = 18000,
        max = 1,
        allowed = { 'TEAM_GUNDEALER', 'TEAM_GUNDEALER_VIP' },
        
        category = CATEGORY
    }  
)

Add( 'aug', 
    {
        name = 'AUG',
        weapon = true,
        ent = 'arccw_aug',
        model = 'models/weapons/arccw/w_para.mdl',
        price = 18000,
        max = 1,
        allowed = { 'TEAM_GUNDEALER', 'TEAM_GUNDEALER_VIP' },
        
        category = CATEGORY
    }  
)

Add( 'p90', 
    {
        name = 'P90',
        weapon = true,
        ent = 'arccw_p90',
        model = 'models/weapons/arccw/w_pdw57.mdl',
        price = 18000,
        max = 1,
        allowed = { 'TEAM_GUNDEALER', 'TEAM_GUNDEALER_VIP' },
        
        category = CATEGORY
    }  
)

Add( 'm14', 
    {
        name = 'Абакан',
        weapon = true,
        ent = 'arccw_m14',
        model = 'models/weapons/arccw/w_m14.mdl',
        price = 22000,
        max = 1,
        allowed = { 'TEAM_GUNDEALER', 'TEAM_GUNDEALER_VIP' },
        
        category = CATEGORY
    }  
)

Add( 'ragingbull', 
    {
        name = 'Raging Bull',
        weapon = true,
        ent = 'arccw_ragingbull',
        model = 'models/weapons/arccw/w_ragingbull.mdl',
        price = 15000,
        max = 1,
        allowed = { 'TEAM_GUNDEALER', 'TEAM_GUNDEALER_VIP' },
        
        category = CATEGORY
    }  
)

Add( 'gdeagle', 
    {
        name = 'Gold Desert Eagle',
        weapon = true,
        ent = 'arccw_deagle50',
        model = 'models/weapons/arccw/w_gce.mdl',
        price = 27000,
        max = 1,
        allowed = { 'TEAM_GUNDEALER_VIP' },
        
        category = CATEGORY
    }  
)

Add( 'deagle', 
    {
        name = 'Desert Eagle',
        weapon = true,
        ent = 'arccw_deagle357',
        model = 'models/weapons/w_pist_deagle.mdl',
        price = 10^4,
        max = 1,
        allowed = { 'TEAM_GUNDEALER', 'TEAM_GUNDEALER_VIP' },
        
        category = CATEGORY
    }  
)

Add( 'sg552', 
    {
        name = 'SG_552',
        weapon = true,
        ent = 'arccw_sg552',
        model = 'models/weapons/arccw/w_roland.mdl',
        price = 22000,
        max = 1,
        allowed = { 'TEAM_GUNDEALER', 'TEAM_GUNDEALER_VIP' },
        
        category = CATEGORY
    }  
)

Add( 'awp', 
    {
        name = 'AWP',
        weapon = true,
        ent = 'arccw_awm',
        model = 'models/weapons/arccw/w_hs338.mdl',
        price = 32000,
        max = 1,
        allowed = { 'TEAM_GUNDEALER', 'TEAM_GUNDEALER_VIP' },
        
        category = CATEGORY
    }  
)

Add( 'barretm107', 
    {
        name = 'Barret M107',
        weapon = true,
        ent = 'arccw_m107',
        model = 'models/weapons/arccw/w_bfg.mdl',
        price = 64000,
        max = 1,
        allowed = {  'TEAM_GUNDEALER_VIP' },
        
        category = CATEGORY
    }  
)

Add( 'm60', 
    {
        name = 'M-60',
        weapon = true,
        ent = 'arccw_m60',
        model = 'models/weapons/arccw/w_m60.mdl',
        price = 64000,
        max = 1,
        allowed = { 'TEAM_GUNDEALER_VIP' },
        
        category = CATEGORY
    }  
)

Add( 'rpg7', 
    {
        name = 'RPG-7',
        weapon = true,
        ent = 'arccw_rpg7',
        model = 'models/weapons/arccw/w_rpg7.mdl',
        price = 19999,
        max = 1,
        allowed = { 'TEAM_GUNDEALER_VIP' },
        
        category = CATEGORY
    }  
)

Add( 'gauss', {
    name = 'Gauss Rifle',
    weapon = true,
    ent = 'arccw_gauss_rifle',
    model = 'models/weapons/arccw/w_gauss_rifle.mdl',
    price = 99999,
    max = 1,
    allowed = { 'TEAM_GUNDEALER_VIP' },
    
    category = CATEGORY
} )

-- Ambi.DarkRP.AddShipmentFromShopWeapon( 'gauss', 'Gauss [Коробка]', CATEGORY, 'dsa', 16, 2, {
--     allowed = { 'TEAM_GUNDEALER_VIP' },
-- } )