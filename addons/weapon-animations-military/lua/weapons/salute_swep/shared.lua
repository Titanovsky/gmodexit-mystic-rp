SWEP.Author					= "Cheesus.Crust#5482"
SWEP.Purpose				= "Salute"
SWEP.Instructions 			= "Left click to do the Animation"

SWEP.Category 				= "Animation"
SWEP.PrintName				= "Salute"
SWEP.Spawnable				= true
SWEP.deactivateOnMove		= 200

SWEP.Base = "animation_swep_base"

if CLIENT then
	function SWEP:GetGesture()
		return {
	        ["ValveBiped.Bip01_R_UpperArm"] = Angle(80, -95, -77.5),
	        ["ValveBiped.Bip01_R_Forearm"] = Angle(35, -125, -5),
	    }
	end
end
