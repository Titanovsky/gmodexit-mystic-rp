
local NPC = { 	Name = "Cultist Hostile",
				Class = "npc_combine_s",
				Model = "models/WHdow2/cultist_npc.mdl",
				Health = "200",
				Category = "Black_Legion"	}

list.Set( "NPC", "npc_enemycultist", NPC )

local NPC = { 	Name = "Cultist Ally",
				Class = "npc_citizen",
				Model = "models/WHdow2/cultist_npc.mdl",
				Health = "200",
				KeyValues = { citizentype = 4 },
				Category = "Black_Legion" }

list.Set( "NPC", "npc_allycultist", NPC )