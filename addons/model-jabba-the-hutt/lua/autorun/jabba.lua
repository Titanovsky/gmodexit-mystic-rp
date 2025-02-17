local function AddPlayerModel( name, model )

	list.Set( "PlayerOptionsModel", name, model )
	player_manager.AddValidModel( name, model )
	
end


AddPlayerModel( "Hutt", 		                      "models/hgn/swrp/swrp/hutt_01.mdl" )
