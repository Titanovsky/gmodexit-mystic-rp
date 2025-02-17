local Category = "Left 4 Dead"
local NPC = {
		 		Name = "L4D2 Witch (Friendly)", 
				Class = "npc_citizen",
				KeyValues = { citizentype = 4 },
				Model = "models/player/errol/left4dead/witch.mdl",
				Health = "100",
				Category = Category	
		}
list.Set( "NPC", "npc_witchf", NPC )

local NPC = {
		 		Name = "L4D2 Witch (Hostile)", 
				Class = "npc_combine_s",
				KeyValues = { citizentype = 4 },
				Model = "models/player/errol/left4dead/witch.mdl",
				Health = "100",
				Category = Category	
		}
list.Set( "NPC", "npc_witchh", NPC )