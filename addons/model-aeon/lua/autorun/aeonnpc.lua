local Category = "Dinosaur humanoids"
local NPC = {
		 		Name = "Aeon", 
				Class = "npc_citizen",
				KeyValues = { citizentype = 4 },
				Model = "models/aeonpm/aeon.mdl",
				Health = "350",
				Category = Category	
		}
list.Set( "NPC", "npc_aeonp_p", NPC )
local NPC = {
		Name = "Aeon hostile",
		Class = "npc_combine_s",
		Category = Category,
		Model = "models/aeonpm/aeon.mdl",
		Weapons = { "weapon_crowbar" },
		KeyValues = { SquadName = "overwatch"}
}
list.Set( "NPC", "npc_aeonp_ph", NPC )
local NPC = {
		 		Name = "Aeon 2", 
				Class = "npc_citizen",
				KeyValues = { citizentype = 4 },
				Model = "models/aeonpm/aeon2.mdl",
				Health = "350",
				Category = Category	
		}
list.Set( "NPC", "npc_aeonp2_p", NPC )
local NPC = {
		Name = "Aeon 2 hostile",
		Class = "npc_combine_s",
		Category = Category,
		Model = "models/aeonpm/aeon2.mdl",
		Weapons = { "weapon_crowbar" },
		KeyValues = { SquadName = "overwatch"}
}
list.Set( "NPC", "npc_aeonp2_ph", NPC )