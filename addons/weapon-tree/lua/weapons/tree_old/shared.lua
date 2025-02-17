AddCSLuaFile()
SWEP.VElements = {
	["tree"] = { type = "Model", model = "models/props_foliage/tree_poplar_01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-1.073, 0.889, 4.329), angle = Angle(-3.945, 180, 179.341), size = Vector(0.25, 0.25, 0.25), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 1, bodygroup = {} }
}
SWEP.WElements = {
	["circle"] = { type = "Model", model = "models/props_phx/construct/metal_angle360.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5.15, -2.221, 12.671), angle = Angle(0, -2.757, 0), size = Vector(0.146, 0.146, 0.146), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_foliage/tree_deciduous_01a_trunk", skin = 0, bodygroup = {} },
	["tree"] = { type = "Model", model = "models/props_foliage/tree_poplar_01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(10.088, -9.084, 12.814), angle = Angle(1.531, 74.946, 180), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 1, bodygroup = {} }
}
SWEP.PrintName			= "Tree(OLD)"			
SWEP.Author			    = "VAFLEG"
SWEP.Instructions		= "LMB to smash"
SWEP.Purpose            = "Use the Tree to remove your enemies from existence"
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.Base         = "weapon_base"
SWEP.Category      = "Tree Weapon"
SWEP.Primary.Damage = 1500
SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo	= "none"
SWEP.Secondary.ClipSize= -1
SWEP.Secondary.DefaultClip= -1
SWEP.Secondary.Automatic= false
SWEP.Secondary.Ammo= "none"	
SWEP.Weight			    = 25
SWEP.IsMelee = true
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false
SWEP.Slot			    = 0
SWEP.SlotPos			= 1
SWEP.DrawAmmo			= true
SWEP.DrawCrosshair		= true
SWEP.HoldType = "melee2"
SWEP.ViewModelFOV = 60
SWEP.ViewModelFlip = false
SWEP.UseHands = false
SWEP.ViewModel = "models/weapons/v_crowbar.mdl"
SWEP.WorldModel = "models/weapons/w_crowbar.mdl"
SWEP.ShowViewModel = false
SWEP.ShowWorldModel = true
SWEP.ViewModelBoneMods = {}
SWEP.IronSightsPos = Vector(-0.601, 0, 0.639)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.Base = "base_cm"



SWEP.Primary.Delay  = 0.5


function SWEP:SecondaryAttack()	
end
function SWEP:PrimaryAttack()
				



	self.Owner:EmitSound("ambient/wind/wind_gust_10.wav", 35, math.random(100, 110))
	
	self.Weapon:SendWeaponAnim(ACT_VM_MISSCENTER)
	self.Weapon:SetPlaybackRate(1)
	self.Owner:SetAnimation(PLAYER_ATTACK1)
	
	self:SetNextPrimaryFire(CurTime() + 1.5)
	self.Owner:ViewPunch(Angle(0, 2, -2))
	
	local slash = {}
	slash.start = self.Owner:GetShootPos()
	slash.endpos = self.Owner:GetShootPos() + (self.Owner:GetAimVector() * 800)
	slash.filter = self.Owner
	slash.mins = Vector(-15, -15, 0)
	slash.maxs = Vector(45, 45, 0)
	local tr = util.TraceHull(slash)
	util.Decal("Scorch", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal)
	if tr.Hit then	

		if IsValid(tr.Entity) then
			local dmg = DamageInfo()
			dmg:SetDamage(self.Primary.Damage)
			dmg:SetDamageType(DMG_BLAST)
			dmg:SetAttacker(self.Owner)
			dmg:SetInflictor(self.Weapon)
			dmg:SetDamageForce(self.Owner:GetForward() * 1500 + self.Owner:GetAimVector() * 800)
			
			
			if SERVER then tr.Entity:TakeDamageInfo(dmg) end
		end
		
		local trs = self.Owner:GetEyeTrace()
	
		if tr.Entity:IsPlayer() or tr.Entity:IsNPC() then
		self.Primary.Damage = self.Primary.Damage
		self.Weapon:EmitSound("physics/flesh/flesh_strider_impact_bullet3.wav", 100, math.random(80, 70))
		self.Owner:EmitSound("physics/concrete/boulder_impact_hard4.wav", 100, math.random(80, 70))

		else
			self.Weapon:SendWeaponAnim(ACT_VM_HITCENTER)
			
			self.Weapon:EmitSound("physics/concrete/boulder_impact_hard4.wav", 80, math.random(80, 70))
			
		end
	else	
		self.Weapon:EmitSound("weapons/iceaxe/iceaxe_swing1.wav", 80, math.random(70, 50))
	end
	util.Decal("Scorch", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal )	
	self.Owner:SetVelocity(300 * self.Owner:GetAimVector() * -1)
end
function SWEP:Reload()

end
function SWEP:Holster()		
	self:SetHoldType("normal")
	self.Owner:SetJumpPower(200)
	self.Owner:SetWalkSpeed(200)
	self.Owner:SetRunSpeed(400)
	return true
end

function SWEP:Deploy()
	self:SetHoldType(self.HoldType)
	self.Owner:SetJumpPower(150)
	self.Owner:SetWalkSpeed(200)
	self.Owner:SetRunSpeed(300)
	self:SetNextPrimaryFire( CurTime() + self.Primary.Delay + 0.5)
	self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
	return true
end


--Hi =)
--Made by VAFLEG by the way
