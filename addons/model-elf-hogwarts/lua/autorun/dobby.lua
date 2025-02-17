if SERVER then
	AddCSLuaFile()
end

player_manager.AddValidModel("Elf de maison", "models/player/elf/elf.mdl")
player_manager.AddValidHands( "Elf de maison", "models/weapons/arms/v_arms_dobby.mdl", 0, "00000000" )

local Category = "Harry Potter"

local function AddNPC( t, class )
	list.Set( "NPC", class or t.Class, t )
end
