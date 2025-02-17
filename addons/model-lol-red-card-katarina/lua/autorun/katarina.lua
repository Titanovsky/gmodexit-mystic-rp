local NPC = { 	Name = "Katarina", 
				Class = "npc_Citizen",
				Model = "models/katarina/katarina.mdl",
				Health = "600",
				KeyValues = { citizentype = 4 },
				Category = "League Of Legends"	}


list.Set( "NPC", "npc_katarina", NPC )

player_manager.AddValidModel( "Katarina", 		"models/katarina/katarina.mdl"); 
list.Set( "PlayerOptionsModel", "Katarina", 	"models/katarina/katarina.mdl" );