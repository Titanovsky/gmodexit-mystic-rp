SWEP.Author					= "Cheesus.Crust#5482"
SWEP.Purpose				= "German Salute!"
SWEP.Instructions 			= "Left click to use"

SWEP.Category 				= "Animation"
SWEP.PrintName				= "Sieg Heil"
SWEP.Spawnable				= true
SWEP.deactivateOnMove		= 200

SWEP.Base = "animation_swep_base"

if CLIENT then
	function SWEP:GetGesture()
		return {
	        ["ValveBiped.Bip01_R_UpperArm"] = Angle(45, -135, -45),
	        ["ValveBiped.Bip01_R_Forearm"] = Angle(0, 0, -45),
	    }
	end
end
