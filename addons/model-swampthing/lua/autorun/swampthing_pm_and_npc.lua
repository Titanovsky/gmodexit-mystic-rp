player_manager.AddValidModel( "Swamp Thing",   "models/reverse/swampthing/swampthing.mdl" );
list.Set( "PlayerOptionsModel", "Swamp Thing", "models/reverse/swampthing/swampthing.mdl" );
player_manager.AddValidHands( "Swamp Thing", "models/weapons/c_swampthing_arms.mdl", 0, "00000000" )


local NPC = {	Name = "Swamp Thing - Good",
				Class = "npc_citizen",
				Model = 
"models/reverse/swampthing/swampthing_npc_good.mdl",
				Health = "250",
				KeyValues = { citizentype = 4 },
				Category = "Swamp Thing" }

list.Set( "NPC", "npc_swampthinggood", NPC )

local NPC = {	Name = "Swamp Thing - Bad",
				Class = "npc_combine_s",
				Model = 
"models/reverse/swampthing/swampthing_npc_bad.mdl",
				Health = "250",
				Category = "Swamp Thing"  }

list.Set( "NPC", "npc_swampthingbad", NPC )
