player_manager.AddValidModel( "The Toad (Flushed Away)", "models/hellinspector/the_toad/the_toad_pm.mdl" );

list.Set( "PlayerOptionsModel", "The Toad (Flushed Away)", "models/hellinspector/the_toad/the_toad_pm.mdl" );


local Category = "The Toad (Flushed Away)"

local NPC = {   
        Name = "The Toad Enemy", 
        Class = "npc_combine_s", 
        Model = "models/hellinspector/the_toad/the_toad_pm.mdl",                 
        Health = "100",                 
        KeyValues = { citizentype = 4 },                 
        Category = Category,
        Squadname = "The Toad Enemy"
}

list.Set( "NPC", "npc_TheToadenemy", NPC ) 

local NPC = {   
        Name = "The Toad Friend", 
        Class = "npc_citizen", 
        Model = "models/hellinspector/the_toad/the_toad_pm.mdl",                 
        Health = "100",                 
        KeyValues = { citizentype = 4 },                 
        Category = Category,
        Squadname = "The Toad Friend"
}

list.Set( "NPC", "npc_TheToadFriend", NPC ) 


