--[[ 
Copyright 2014 Phoenix. I can be contacted @ http://steamcommunity.com/profiles/76561197990696007

This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License.
To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
--]]

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
 
include("shared.lua")
 
SWEP.Weight			 = 5
SWEP.AutoSwitchTo	 = false
SWEP.AutoSwitchFrom	 = false

function SWEP:Deploy()
	self.Owner:DrawWorldModel(false)
end