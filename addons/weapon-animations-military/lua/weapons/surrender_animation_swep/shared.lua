SWEP.Author					= "Cheesus.Crust#5482"
SWEP.Purpose				= "surrender"
SWEP.Instructions 			= "Left click to do the Animation"

SWEP.Category 				= "Animation"
SWEP.PrintName				= "Surrender"
SWEP.Spawnable				= true
SWEP.deactivateOnMove		= 1100

SWEP.Base = "animation_swep_base"

if CLIENT then
	function SWEP:GetGesture()
		return {
	        ["ValveBiped.Bip01_L_Forearm"] = Angle(25,-65,25),
	        ["ValveBiped.Bip01_R_Forearm"] = Angle(-25,-65,-25),
	        ["ValveBiped.Bip01_L_UpperArm"] = Angle(-70,-180,70),
	        ["ValveBiped.Bip01_R_UpperArm"] = Angle(70,-180,-70),
	    }
	end
end
