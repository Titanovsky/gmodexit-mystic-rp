AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

SWEP.Weight            = 5
SWEP.AutoSwitchTo      = false

SWEP.AutoSwitchFrom    = false

CreateConVar("blinkswep_length", "300", {FCVAR_REPLICATED, FCVAR_ARCHIVE});