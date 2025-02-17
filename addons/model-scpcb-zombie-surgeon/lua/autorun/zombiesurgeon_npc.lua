local Category = "SCP Employee"
local NPC = {
		 		Name = "Friendly Zombie Surgeon", 
				Class = "npc_citizen",
				KeyValues = { citizentype = 4 },
				Model = "models/scp/zombiesurgeon/zombiesurgeon.mdl",
				Health = "100",
				Category = Category	
		}
list.Set( "NPC", "npc_friendly_zombie_surgeon", NPC )
local Category = "SCP Employee"
local NPC = {
		 		Name = "Hositle Zombie Surgeon", 
				Class = "npc_combine_s",
				KeyValues = { citizentype = 4 },
				Model = "models/scp/zombiesurgeon/zombiesurgeon.mdl",
				Health = "100",
				Category = Category	
		}
list.Set( "NPC", "npc_hostile_zombie_surgeon", NPC )