player_manager.AddValidModel( "Space Kook", 		"models/player/space_kook_v6.mdl" );
player_manager.AddValidHands( "Space Kook", "models/player/space_kook_hands_v4.mdl", 0, "00000000" )
list.Set( "PlayerOptionsModel", "Space Kook", 	"models/player/space_kook_v6.mdl" );

--Add NPC
local Category = "Space Kook"
// Friendly
local NPC = {	Name = "Space Kook - Friendly",
				Class = "npc_citizen",
				Model = "models/player/space_kook_npc.mdl",
				Health = "100",
				Weapons = { "weapon_shotgun", "weapon_pistol" },
				KeyValues = { citizentype = 4 },
				Category = Category }
list.Set( "NPC", "spacekook_friendly", NPC )

--Add NPC
local Category = "Space Kook"
// Enemy
local NPC = {	Name = "Space Kook - Enemy",
				Class = "npc_combine_s",
				Model = "models/player/space_kook_npc.mdl",
				Health = "100",
				Weapons = { "weapon_pistol", "weapon_ar2" },
				Category = Category }
list.Set( "NPC", "spacekook_enemy", NPC )