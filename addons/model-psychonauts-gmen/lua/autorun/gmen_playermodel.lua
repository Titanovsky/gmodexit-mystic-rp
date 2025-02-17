if SERVER then
	AddCSLuaFile()
	resource.AddFile("models/player/gmen.mdl")
	resource.AddFile("materials/models/player/gmen.vmt")
end

local function AddPlayerModel( name, model )

	list.Set( "PlayerOptionsModel", name, model )
	player_manager.AddValidModel( name, model )
	
end

AddPlayerModel( "gmen", "models/player/gmen.mdl" )