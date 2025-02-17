local C = Ambi.Packages.Out( 'colors' )
local Add = Ambi.DarkRP.AddShopItem
local SimpleAddItem = Ambi.DarkRP.SimpleAddShopItem

-- ----------------------------------------------------------------------------------------------------------------------------
local CATEGORY = 'Заработок'

Add( 'smp_upgrader', { 
    name = 'Улучшитель Принтера', 
    ent = Ambi.SmallMoneyPrinters.Config.upgrader_class,
    model = 'models/props_c17/consolebox01a.mdl',
    category = CATEGORY,
    price = 2999,
    max = 1
} )

Add( 'smp1', { 
    name = 'Принтер: Zero', 
    ent = 'smp_zero',
    model = 'models/props_c17/consolebox01a.mdl',
    category = CATEGORY,
    price = 1999,
    max = 2
} )

Add( 'smp2', { 
    name = 'Принтер: Colourful', 
    ent = 'smp_colourful',
    model = 'models/props_c17/consolebox01a.mdl',
    category = CATEGORY,
    price = 3499,
    max = 2
} )

Add( 'smp3', { 
    name = 'Принтер: Quantum', 
    ent = 'smp_quantum',
    model = 'models/props_c17/consolebox01a.mdl',
    category = CATEGORY,
    price = 8699,
    max = 2
} )

Add( 'smp4', { 
    name = 'Принтер: VIP', 
    ent = 'smp_vip',
    model = 'models/props_c17/consolebox01a.mdl',
    category = CATEGORY,
    price = 2499,
    max = 1,
    CustomCheck = function( ePly ) return false end,
    CustomCheckFailMsg = function( ePly ) return 'Вы не VIP!' end,
} )

Add( 'smp5', { 
    name = 'Принтер: Premium', 
    ent = 'smp_premium',
    model = 'models/props_c17/consolebox01a.mdl',
    category = 'Small Money Printers',
    price = 14999,
    max = 1,
    CustomCheck = function( ePly ) return ePly:IsUserGroup( 'premium' ) or ePly:IsSuperAdmin() end,
    CustomCheckFailMsg = function( ePly ) return 'Вы не Premium!' end,
} )