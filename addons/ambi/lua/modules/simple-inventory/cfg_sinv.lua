Ambi.General.CreateModule( 'SimpleInventory' )

-- -------------------------------------------------------------------
Ambi.SimpleInventory.Config.notify = 4
Ambi.SimpleInventory.Config.model_item = 'models/props_junk/cardboard_box001a.mdl'
Ambi.SimpleInventory.Config.model_loot = 'models/props_junk/cardboard_box001a.mdl'

-- -------------------------------------------------------------------
Ambi.SimpleInventory.Config.max_count_item = 5000
Ambi.SimpleInventory.Config.start_slots = 30
Ambi.SimpleInventory.Config.save_inventory = true
Ambi.SimpleInventory.Config.directory_icons = 'nmp'

-- Nets --------------------------------------------------------------
Ambi.SimpleInventory.Config.net_send_client = 'ambi_simpleinventory_send_client'
Ambi.SimpleInventory.Config.net_drop_item = 'ambi_simpleinventory_drop_item'
Ambi.SimpleInventory.Config.net_use_item = 'ambi_simpleinventory_use_item'
Ambi.SimpleInventory.Config.net_craft = 'ambi_simpleinventory_craft'

-- Crafts------------------------------------------------------------
Ambi.SimpleInventory.Config.craft_enable = true
Ambi.SimpleInventory.Config.craft_equal_process = true -- нужен модуль Process

Ambi.SimpleInventory.classes = Ambi.SimpleInventory.classes or {}
Ambi.SimpleInventory.crafting = Ambi.SimpleInventory.crafting or {}