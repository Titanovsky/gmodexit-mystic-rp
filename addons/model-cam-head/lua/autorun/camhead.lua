player_manager.AddValidModel( "Cam Head", "models/bala/cam_head_pm.mdl" )
list.Set( "PlayerOptionsModel",  "Cam Head", "models/bala/cam_head_pm.mdl" )
player_manager.AddValidHands( "Cam Head", "models/bala/cam_head_arms.mdl", 0, "00000000" )
--Add NPC
local Category = "Criminal"

local NPC = { 	Name = "Cam Head (Apyr.)", 
				Class = "npc_citizen",
				Model = "models/bala/cam_head.mdl",
				Health = "100",
				KeyValues = { citizentype = 4 },
                                Category = Category    }

list.Set( "NPC", "cam_head", NPC )

local NPC = { 	Name = "Cam Head (Hostile)", 
				Class = "npc_combine_s",
				Model = "models/bala/cam_head.mdl",
				Health = "100",
				KeyValues = { citizentype = 4 },
                                Category = Category    }

list.Set( "NPC", "cam_head_hostile", NPC )
