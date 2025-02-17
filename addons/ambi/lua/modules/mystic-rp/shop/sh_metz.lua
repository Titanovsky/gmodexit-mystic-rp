local C = Ambi.Packages.Out( 'colors' )
local Add = Ambi.DarkRP.AddShopItem
local SimpleAddItem = Ambi.DarkRP.SimpleAddShopItem

-- ----------------------------------------------------------------------------------------------------------------------------
local CATEGORY = 'Metz'

Add( 'stove', 
    {
        name = 'Плита',
        ent = 'metz_stove',
        model = 'models/props_c17/furniturestove001a.mdl',
        price = 4200,
        max = 2,
        allowed = { 'TEAM_CRACKER' },
        
        category = CATEGORY
    }  
)

Add( 'gas', 
    {
        name = 'Газ',
        ent = 'metz_gas_cylinder',
        model = 'models/props_c17/canister01a.mdl',
        price = 1499,
        max = 2,
        allowed = { 'TEAM_CRACKER' },
        
        category = CATEGORY
    }  
)

Add( 'jar', 
    {
        name = 'Банка',
        ent = 'metz_iodine_jar',
        model = 'models/props_lab/jar01a.mdl',
        price = 500,
        max = 2,
        allowed = { 'TEAM_CRACKER' },
        
        category = CATEGORY
    }  
)

Add( 'finalpot', 
    {
        name = 'Кастрюля Metz',
        ent = 'metz_final_pot',
        model = 'models/props_c17/metalpot001a.mdl',
        price = 500,
        max = 2,
        allowed = { 'TEAM_CRACKER' },
        
        category = CATEGORY
    }  
)

Add( 'phosphorpot', 
    {
        name = 'Кастрюля для Фосфора',
        ent = 'metz_phosphor_pot',
        model = 'models/props_c17/metalpot001a.mdl',
        price = 500,
        max = 4,
        allowed = { 'TEAM_CRACKER' },
        
        category = CATEGORY
    }  
)

Add( 'muraticacid', 
    {
        name = 'Соляная Кислота',
        ent = 'metz_muratic_acid',
        model = 'models/props_junk/garbage_plasticbottle001a.mdl',
        price = 200,
        max = 5,
        allowed = { 'TEAM_CRACKER' },
        
        category = CATEGORY
    }  
)

Add( 'water', 
    {
        name = 'Водичка',
        ent = 'metz_water',
        model = 'models/props_junk/garbage_plasticbottle003a.mdl',
        price = 200,
        max = 5,
        allowed = { 'TEAM_CRACKER' },
        
        category = CATEGORY
    }  
)

Add( 'liquidsulfur', 
    {
        name = 'Жидкая Сера',
        ent = 'metz_sulfur',
        model = 'models/props_lab/jar01b.mdl',
        price = 100,
        max = 5,
        allowed = { 'TEAM_CRACKER' },
        
        category = CATEGORY
    }  
)

Add( 'liquidiodine', 
    {
        name = 'Жидкий Йод',
        ent = 'metz_liquid_iodine',
        model = 'models/props_lab/jar01b.mdl',
        price = 100,
        max = 5,
        allowed = { 'TEAM_CRACKER' },
        
        category = CATEGORY
    }  
)