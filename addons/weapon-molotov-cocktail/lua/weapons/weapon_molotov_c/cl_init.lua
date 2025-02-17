--[[ 
Copyright 2014 Phoenix. I can be contacted @ http://steamcommunity.com/profiles/76561197990696007

This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License.
To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
--]]

include("shared.lua")

SWEP.Author			= "Phoenix"
SWEP.Contact 		= "STEAM_0:1:15215139"
SWEP.Purpose		= "To ignite."
SWEP.Instructions	= "Aim and throw at designated enemy."
SWEP.Category		= "Other"
SWEP.PrintName		= "Molotov Cocktail"

hook.Add("OnEntityCreated", "Molotov Visibility", function(ent)
	if ent:GetClass() == "weapon_molotov_c" then
		ent:SetMaterial("models/debug/debugwhite")
		ent:SetColor( Color(189, 69, 24) )
	end
end )