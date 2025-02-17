if not Ambi.DarkRP then return end
if not Ambi.SmallMoneyPrinters.Config.create_shop_item then return end

-- ----------------------------------------------------------------------------------------------------------------------------
local AddItem = Ambi.DarkRP.AddShopItem

-- ----------------------------------------------------------------------------------------------------------------------------
AddItem( 'smp_upgrader', { 
    name = 'Улучшитель Принтера', 
    ent = Ambi.SmallMoneyPrinters.Config.upgrader_class,
    model = 'models/props_c17/consolebox01a.mdl',
    category = 'Small Money Printers',
    price = 2999,
    max = 1
} )

AddItem( 'smp1', { 
    name = 'Принтер: Zero', 
    ent = 'smp_zero',
    model = 'models/props_c17/consolebox01a.mdl',
    category = 'Small Money Printers',
    price = 1999,
    max = 2
} )

AddItem( 'smp2', { 
    name = 'Принтер: Colourful', 
    ent = 'smp_colourful',
    model = 'models/props_c17/consolebox01a.mdl',
    category = 'Small Money Printers',
    price = 3499,
    max = 2
} )

AddItem( 'smp3', { 
    name = 'Принтер: Quantum', 
    ent = 'smp_quantum',
    model = 'models/props_c17/consolebox01a.mdl',
    category = 'Small Money Printers',
    price = 8699,
    max = 2
} )

AddItem( 'smp4', { 
    name = 'Принтер: VIP', 
    ent = 'smp_vip',
    model = 'models/props_c17/consolebox01a.mdl',
    category = 'Small Money Printers',
    price = 2499,
    max = 1,
    CustomCheck = function( ePly ) return ePly:IsUserGroup( 'vip' ) or ePly:IsSuperAdmin() or ePly:IsUserGroup( 'premium' ) end,
    CustomCheckFailMsg = function( ePly ) return 'Вы не VIP!' end,
} )

AddItem( 'smp5', { 
    name = 'Принтер: Premium', 
    ent = 'smp_premium',
    model = 'models/props_c17/consolebox01a.mdl',
    category = 'Small Money Printers',
    price = 14999,
    max = 1,
    CustomCheck = function( ePly ) return ePly:IsUserGroup( 'premium' ) or ePly:IsSuperAdmin() end,
    CustomCheckFailMsg = function( ePly ) return 'Вы не Premium!' end,
} )