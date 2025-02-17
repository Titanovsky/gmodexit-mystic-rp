local Category = "Vinrax NPCS"
local NPC = {
		 		Name = "Doll", 
				Class = "npc_citizen",
				KeyValues = { citizentype = 4 },
				Model = "models/vinrax/npc/doll_npc.mdl",
				Health = "250",
				Category = Category	
		}

list.Set( "NPC", "npc_doll", NPC )