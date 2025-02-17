SWEP.Base = "arccw_base_melee"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - allah stuff" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "Jesus sword"
SWEP.Trivia_Class = "cross"
SWEP.Trivia_Desc = "jesus cross sword"
SWEP.Trivia_Manufacturer = "jesus"
SWEP.Trivia_Calibre = "sword"
SWEP.Trivia_Mechanism = "jesus"
SWEP.Trivia_Country = "jesus"
SWEP.Trivia_Year = 0

SWEP.Slot = 0

SWEP.NotForNPCs = true

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/darky_m/c_jesusword.mdl"
SWEP.WorldModel = "models/weapons/darky_m/w_jesusword.mdl"
SWEP.ViewModelFOV = 60

-- SWEP.WorldModelOffset = {
    -- pos = Vector(3, 0.5, 0),
    -- ang = Angle(-150, -180, 0)
-- }

SWEP.PrimaryBash = true

SWEP.MeleeDamage = 60
SWEP.MeleeRange = 32
SWEP.MeleeDamageType = DMG_SLASH
SWEP.MeleeTime = 2
SWEP.MeleeGesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_KNIFE
SWEP.MeleeAttackTime = 0.6

SWEP.Melee2 = true
SWEP.Melee2Damage = 60
SWEP.Melee2Range = 32
SWEP.Melee2Time = 2
SWEP.Melee2Gesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE
SWEP.Melee2AttackTime = 0.6

-- SWEP.MeleeHitSound = {
    -- "weapons/arccw/bh_melee/katana/melee_katana_01.wav",
    -- "weapons/arccw/bh_melee/katana/melee_katana_02.wav",
    -- "weapons/arccw/bh_melee/katana/melee_katana_03.wav"
-- }

SWEP.NotForNPCs = true

SWEP.Firemodes = {
    {
        Mode = 1,
        PrintName = "MELEE"
    },
}

SWEP.HoldtypeHolstered = "normal"
SWEP.HoldtypeActive = "knife"

SWEP.Primary.ClipSize = -1

SWEP.Attachments = {
    {
        PrintName = "Charm",
        Slot = "charm",
        FreeSlot = true,
        Bone = "main", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector(0.2, -19.8, -2.2), -- offset that the attachment will be relative to the bone
            vang = Angle(115, 0, -90),
        },
    },
}

SWEP.Animations = {
    ["idle"] = false,
    ["draw"] = {
        Source = "draw",
        Time = 2.5
    },
    ["bash"] = {
        Source = {"slash3"},
        Time = 2,
        -- SoundTable = {{s = "weapons/arccw/bh_melee/katana/katana_swing_miss1.wav", "weapons/arccw/bh_melee/katana/katana_swing_miss2.wav", t = 0}}
    },
    ["bash2"] = {
        Source = {"slash1"},
        Time = 2,
        -- SoundTable = {{s = "weapons/arccw/bh_melee/katana/katana_swing_miss1.wav", "weapons/arccw/bh_melee/katana/katana_swing_miss2.wav", t = 0}}
    },
}

-- sound.Add({
-- 	name = 			"Katana.Deploy",
-- 	channel = 		CHAN_ITEM,
-- 	volume = 		1.0,
-- 	sound = 		"weapons/arccw/bh_melee/katana/katana_deploy_1.wav"
-- })

SWEP.IronSightStruct = false

SWEP.ActivePos = Vector(0, 0, 0)

SWEP.HolsterPos = Vector(0, -1, 2)
SWEP.HolsterAng = Angle(-15, 0, 0)

-- SWEP.CustomizePos = Vector(20, 5, 1)
-- SWEP.CustomizeAng = Angle(5, 30, 30)