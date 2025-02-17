include("shared.lua")

SWEP.PrintName        = "Blink SWEP"
SWEP.Slot             = 0
SWEP.SlotPos          = 5
SWEP.DrawAmmo         = false
SWEP.DrawCrosshair    = false

CreateConVar("blinkswep_length", "300", {FCVAR_REPLICATED, FCVAR_ARCHIVE});