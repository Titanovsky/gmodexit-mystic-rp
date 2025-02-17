if CLIENT then
SWEP.DrawWeaponInfoBox = true
end

SWEP.Author       = "-CRY-minal-"
SWEP.Purpose      = "Stylish neon..."
SWEP.Instructions = "You know what to do..."

SWEP.PrintName = "Neon axe"
SWEP.Category = "Gluk Melee"
SWEP.Spawnable= true

SWEP.ViewModelFOV = 70
SWEP.ViewModel = "models/weapons/cstrike/c_knife_t.mdl"
SWEP.WorldModel = "models/weapons/w_knife_t.mdl"
SWEP.ViewModelFlip = false
SWEP.BobScale = 1
SWEP.SwayScale = 0

SWEP.HoldType = "melee"

SWEP.ShowWorldModel = false

SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = false
SWEP.Weight = 0
SWEP.Slot = 0
SWEP.SlotPos = 0

SWEP.UseHands = true
SWEP.HoldType = "melee"
SWEP.DrawAmmo = false
SWEP.Base = "weapon_base"

SWEP.Idle = 0
SWEP.IdleTimer = CurTime()

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"
SWEP.Primary.Damage = 99
SWEP.Primary.DelayMiss = 0.8
SWEP.Primary.DelayHit = 1.2
SWEP.Primary.Force = 140

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "none"

SWEP.ViewModelBoneMods = {
	["v_weapon.Knife_Handle"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_R_UpperArm"] = { scale = Vector(1, 1, 1), pos = Vector(16, 4.599, 0), angle = Angle(-45, -25, 70) }
}

SWEP.VElements = {
	["handle_load"] = { type = "Model", model = "models/phxtended/tri2x1x1solid.mdl", bone = "v_weapon.Knife_Handle", rel = "handle", pos = Vector(-5, 0, 1.5), angle = Angle(180, 0, 0), size = Vector(0.05, 0.05, 0.05), color = Color(125, 125, 125, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["gear2"] = { type = "Model", model = "models/props_phx/gears/bevel90_24.mdl", bone = "v_weapon.Knife_Handle", rel = "gear", pos = Vector(0, 0, 0.8), angle = Angle(0, 0, 0), size = Vector(0.1, 0.1, 0.1), color = Color(255, 0, 0, 255), surpresslightning = true, material = "phoenix_storms/white", skin = 0, bodygroup = {} },
	["handle"] = { type = "Model", model = "models/props_junk/harpoon002a.mdl", bone = "v_weapon.Knife_Handle", rel = "", pos = Vector(0, 0, -12), angle = Angle(-90, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(50, 50, 50, 255), surpresslightning = false, material = "phoenix_storms/gear_top", skin = 0, bodygroup = {} },
	["blade_load"] = { type = "Model", model = "models/phxtended/tri2x1x1solid.mdl", bone = "v_weapon.Knife_Handle", rel = "handle", pos = Vector(-27, -0.801, -1), angle = Angle(0, 0, 0), size = Vector(0.05, 0.05, 0.05), color = Color(125, 125, 125, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["blade+"] = { type = "Model", model = "models/props_phx/construct/metal_angle90.mdl", bone = "v_weapon.Knife_Handle", rel = "handle", pos = Vector(-25, 0.1, -0.48), angle = Angle(0, 45, 0), size = Vector(0.23, 0.23, 0.189), color = Color(255, 0, 0, 255), surpresslightning = true, material = "phoenix_storms/white", skin = 0, bodygroup = {} },
	["rack"] = { type = "Model", model = "models/props_phx/gears/rack18.mdl", bone = "v_weapon.Knife_Handle", rel = "handle", pos = Vector(-20, -0.431, 0), angle = Angle(-90, 90, 0), size = Vector(0.1, 0.1, 0.1), color = Color(255, 0, 0, 255), surpresslightning = true, material = "phoenix_storms/white", skin = 0, bodygroup = {} },
	["what"] = { type = "Model", model = "models/props_combine/CombineThumper002.mdl", bone = "v_weapon.Knife_Handle", rel = "handle", pos = Vector(-26, 7.3, -0.5), angle = Angle(90, 0, -90), size = Vector(0.039, 0.039, 0.039), color = Color(255, 0, 0, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["train"] = { type = "Model", model = "models/props_combine/combine_train02a.mdl", bone = "v_weapon.Knife_Handle", rel = "handle", pos = Vector(-20, 0, 0), angle = Angle(90, 90, 0), size = Vector(0.009, 0.012, 0.009), color = Color(145, 145, 145, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["prop+"] = { type = "Model", model = "models/maxofs2d/thruster_propeller.mdl", bone = "v_weapon.Knife_Handle", rel = "handle", pos = Vector(-23.5, -0.9, 0), angle = Angle(0, -25, -90), size = Vector(0.2, 0.2, 0.05), color = Color(255, 0, 0, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["rack2"] = { type = "Model", model = "models/props_phx/gears/rack18.mdl", bone = "v_weapon.Knife_Handle", rel = "handle", pos = Vector(-21, 4.675, -0.5), angle = Angle(90, -90, -45), size = Vector(0.1, 0.1, 0.1), color = Color(255, 0, 0, 255), surpresslightning = true, material = "phoenix_storms/white", skin = 0, bodygroup = {} },
	["gyro"] = { type = "Model", model = "models/maxofs2d/hover_rings.mdl", bone = "v_weapon.Knife_Handle", rel = "gear", pos = Vector(0, 0, 1.5), angle = Angle(0, 0, 0), size = Vector(0.129, 0.129, 0.129), color = Color(255, 0, 0, 255), surpresslightning = true, material = "", skin = 0, bodygroup = {} },
	["prop"] = { type = "Model", model = "models/maxofs2d/thruster_propeller.mdl", bone = "v_weapon.Knife_Handle", rel = "handle", pos = Vector(-25.8, -2, 0), angle = Angle(0, -25, -90), size = Vector(0.2, 0.2, 0.05), color = Color(255, 0, 0, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["gear"] = { type = "Model", model = "models/Mechanics/gears2/gear_18t3.mdl", bone = "v_weapon.Knife_Handle", rel = "handle", pos = Vector(-25, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.1, 0.1, 0.119), color = Color(80, 80, 80, 255), surpresslightning = false, material = "phoenix_storms/gear_top", skin = 0, bodygroup = {} },
	["blade"] = { type = "Model", model = "models/props_phx/construct/metal_angle90.mdl", bone = "v_weapon.Knife_Handle", rel = "handle", pos = Vector(-25, 0, -0.5), angle = Angle(0, 45, 0), size = Vector(0.2, 0.2, 0.2), color = Color(60, 60, 60, 255), surpresslightning = false, material = "phoenix_storms/gear_top", skin = 0, bodygroup = {} },
	["decor"] = { type = "Model", model = "models/mechanics/roboticslarge/clawl.mdl", bone = "v_weapon.Knife_Handle", rel = "blade", pos = Vector(-1.67, 4, 0.4), angle = Angle(0, 0, 0), size = Vector(0.1, 0.1, 0.1), color = Color(100, 0, 0, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}





SWEP.WElements = {
	["handle_load"] = { type = "Model", model = "models/phxtended/tri2x1x1solid.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "handle", pos = Vector(-5, 0, 1.5), angle = Angle(180, 0, 0), size = Vector(0.05, 0.05, 0.05), color = Color(125, 125, 125, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["gear2"] = { type = "Model", model = "models/props_phx/gears/bevel90_24.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "gear", pos = Vector(0, 0, 0.8), angle = Angle(0, 0, 0), size = Vector(0.1, 0.1, 0.1), color = Color(255, 0, 0, 255), surpresslightning = true, material = "phoenix_storms/white", skin = 0, bodygroup = {} },
	["handle"] = { type = "Model", model = "models/props_junk/harpoon002a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3, 1, 12), angle = Angle(90, 0, 90), size = Vector(0.5, 0.5, 0.5), color = Color(50, 50, 50, 255), surpresslightning = false, material = "phoenix_storms/gear_top", skin = 0, bodygroup = {} },
	["train"] = { type = "Model", model = "models/props_combine/combine_train02a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "handle", pos = Vector(-20, 0, 0), angle = Angle(90, 90, 0), size = Vector(0.009, 0.012, 0.009), color = Color(145, 145, 145, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["blade+"] = { type = "Model", model = "models/props_phx/construct/metal_angle90.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "handle", pos = Vector(-25, 0.1, -0.473), angle = Angle(0, 45, 0), size = Vector(0.23, 0.23, 0.189), color = Color(255, 0, 0, 255), surpresslightning = true, material = "phoenix_storms/white", skin = 0, bodygroup = {} },
	["rack"] = { type = "Model", model = "models/props_phx/gears/rack18.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "handle", pos = Vector(-20, -0.431, 0), angle = Angle(-90, 90, 0), size = Vector(0.1, 0.1, 0.1), color = Color(255, 0, 0, 255), surpresslightning = true, material = "phoenix_storms/white", skin = 0, bodygroup = {} },
	["decor"] = { type = "Model", model = "models/mechanics/roboticslarge/clawl.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "blade", pos = Vector(-1.67, 4, 0.4), angle = Angle(0, 0, 0), size = Vector(0.1, 0.1, 0.1), color = Color(100, 0, 0, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["gyro"] = { type = "Model", model = "models/maxofs2d/hover_rings.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "gear", pos = Vector(0, 0, 1.5), angle = Angle(0, 0, 0), size = Vector(0.129, 0.129, 0.129), color = Color(255, 0, 0, 255), surpresslightning = true, material = "", skin = 0, bodygroup = {} },
	["prop+"] = { type = "Model", model = "models/maxofs2d/thruster_propeller.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "handle", pos = Vector(-23.5, -0.9, 0), angle = Angle(0, -25, -90), size = Vector(0.2, 0.2, 0.05), color = Color(255, 0, 0, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["rack2"] = { type = "Model", model = "models/props_phx/gears/rack18.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "handle", pos = Vector(-21, 4.675, -0.5), angle = Angle(90, -90, -45), size = Vector(0.1, 0.1, 0.1), color = Color(255, 0, 0, 255), surpresslightning = true, material = "phoenix_storms/white", skin = 0, bodygroup = {} },
	["gear"] = { type = "Model", model = "models/Mechanics/gears2/gear_18t3.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "handle", pos = Vector(-25, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.1, 0.1, 0.119), color = Color(80, 80, 80, 255), surpresslightning = false, material = "phoenix_storms/gear_top", skin = 0, bodygroup = {} },
	["what"] = { type = "Model", model = "models/props_combine/CombineThumper002.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "handle", pos = Vector(-26, 7.3, -0.5), angle = Angle(90, 0, -90), size = Vector(0.039, 0.039, 0.039), color = Color(255, 0, 0, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["prop"] = { type = "Model", model = "models/maxofs2d/thruster_propeller.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "handle", pos = Vector(-25.8, -2, 0), angle = Angle(0, -25, -90), size = Vector(0.2, 0.2, 0.05), color = Color(255, 0, 0, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["blade"] = { type = "Model", model = "models/props_phx/construct/metal_angle90.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "handle", pos = Vector(-25, 0, -0.5), angle = Angle(0, 45, 0), size = Vector(0.2, 0.2, 0.2), color = Color(60, 60, 60, 255), surpresslightning = false, material = "phoenix_storms/gear_top", skin = 0, bodygroup = {} },
	["blade_load"] = { type = "Model", model = "models/phxtended/tri2x1x1solid.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "handle", pos = Vector(-27, -0.801, -1), angle = Angle(0, 0, 0), size = Vector(0.05, 0.05, 0.05), color = Color(125, 125, 125, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}



function SWEP:Initialize()
self:SetWeaponHoldType( self.HoldType )
self.Idle = 0
self.IdleTimer = CurTime() + 1
end

function SWEP:Deploy()
self:SetWeaponHoldType( self.HoldType )
self.Weapon:SendWeaponAnim( ACT_VM_DRAW )
self.Idle = 0
self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
return true
end

function SWEP:Holster()
self.Idle = 0
self.IdleTimer = CurTime()
return true
end

function SWEP:PrimaryAttack()
self:SetHoldType( self.HoldType )
local tr = util.TraceLine( {
start = self.Owner:GetShootPos(),
endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * 64,
filter = self.Owner,
mask = MASK_SHOT_HULL,
} )
if !IsValid( tr.Entity ) then
tr = util.TraceHull( {
start = self.Owner:GetShootPos(),
endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * 64,
filter = self.Owner,
mins = Vector( -16, -16, 0 ),
maxs = Vector( 16, 16, 0 ),
mask = MASK_SHOT_HULL,
} )
end
if SERVER then
if IsValid( tr.Entity ) then
local dmg = DamageInfo()
local attacker = self.Owner
if !IsValid( attacker ) then
attacker = self
end
dmg:SetAttacker( attacker )
dmg:SetInflictor( self )
dmg:SetDamage( self.Primary.Damage )
dmg:SetDamageForce( self.Owner:GetForward() * self.Primary.Force )
tr.Entity:TakeDamageInfo( dmg )
end
if !tr.Hit then
self.Owner:EmitSound( "weapons/iceaxe/iceaxe_swing1.wav" )
end
if tr.Hit then
local bullet = {}
bullet.Num = 1
bullet.Src = self.Owner:GetShootPos()
bullet.Dir = self.Owner:GetAimVector()
bullet.Distance = 90
bullet.Spread = Vector( 0, 0, 0 )
bullet.Tracer = 0
bullet.Force = 9000
bullet.Damage = 0
bullet.AmmoType = "none"
self.Owner:FireBullets( bullet )
if tr.Entity:IsNPC() || tr.Entity:IsPlayer() then
self.Owner:EmitSound( "weapons/crossbow/bolt_fly4.wav" )
else
self.Owner:EmitSound( "weapons/crossbow/bolt_fly4.wav" )
end
end
end
if !tr.Hit then
self.Weapon:SendWeaponAnim( ACT_VM_MISSCENTER )
self:SetNextPrimaryFire( CurTime() + self.Primary.DelayMiss )
self:SetNextSecondaryFire( CurTime() + self.Primary.DelayMiss )
end
if tr.Hit then
self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
self:SetNextPrimaryFire( CurTime() + self.Primary.DelayHit )
self:SetNextSecondaryFire( CurTime() + self.Primary.DelayHit )
end
self:ShootEffects()
self.Idle = 0
self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
end

function SWEP:SecondaryAttack()
end

function SWEP:ShootEffects()
self.Owner:SetAnimation( PLAYER_ATTACK1 )
end

function SWEP:Reload()
end

function SWEP:Think()
if self.IdleTimer <= CurTime() then
if self.Idle == 0 then
self.Idle = 1
end
if SERVER and self.Idle == 1 then
self.Weapon:SendWeaponAnim( ACT_VM_IDLE )
end
self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
end
end






/********************************************************
	SWEP Construction Kit base code
		Created by Clavus
	Available for public use, thread at:
	   facepunch.com/threads/1032378
	   
	   
	DESCRIPTION:
		This script is meant for experienced scripters 
		that KNOW WHAT THEY ARE DOING. Don't come to me 
		with basic Lua questions.
		
		Just copy into your SWEP or SWEP base of choice
		and merge with your own code.
		
		The SWEP.VElements, SWEP.WElements and
		SWEP.ViewModelBoneMods tables are all optional
		and only have to be visible to the client.
********************************************************/

function SWEP:Initialize()

	// other initialize code goes here

	if CLIENT then
		
		self:SetWeaponHoldType( self.HoldType )	
		// Create a new table for every weapon instance
		self.VElements = table.FullCopy( self.VElements )
		self.WElements = table.FullCopy( self.WElements )
		self.ViewModelBoneMods = table.FullCopy( self.ViewModelBoneMods )

		self:CreateModels(self.VElements) // create viewmodels
		self:CreateModels(self.WElements) // create worldmodels
		
		// init view model bone build function
		if IsValid(self.Owner) then
			local vm = self.Owner:GetViewModel()
			if IsValid(vm) then
				self:ResetBonePositions(vm)
				
				--[[// Init viewmodel visibility
				if (self.ShowViewModel == nil or self.ShowViewModel) then
					vm:SetColor(Color(255,255,255,255))
				else
					// we set the alpha to 1 instead of 0 because else ViewModelDrawn stops being called
					vm:SetColor(Color(255,255,255,1))
					// ^ stopped working in GMod 13 because you have to do Entity:SetRenderMode(1) for translucency to kick in
					// however for some reason the view model resets to render mode 0 every frame so we just apply a debug material to prevent it from drawing
					vm:SetMaterial("Debug/hsv")			
				end]]--
			end
		end
		
	end

end

function SWEP:Holster()
	
	if CLIENT and IsValid(self.Owner) then
		local vm = self.Owner:GetViewModel()
		if IsValid(vm) then
			self:ResetBonePositions(vm)
		end
	end
	
	return true
end

function SWEP:OnRemove()
	self:Holster()
end

if CLIENT then

	SWEP.vRenderOrder = nil
	function SWEP:ViewModelDrawn()
		
		local vm = self.Owner:GetViewModel()
		if !IsValid(vm) then return end
		
		if (!self.VElements) then return end
		
		self:UpdateBonePositions(vm)

		if (!self.vRenderOrder) then
			
			// we build a render order because sprites need to be drawn after models
			self.vRenderOrder = {}

			for k, v in pairs( self.VElements ) do
				if (v.type == "Model") then
					table.insert(self.vRenderOrder, 1, k)
				elseif (v.type == "Sprite" or v.type == "Quad") then
					table.insert(self.vRenderOrder, k)
				end
			end
			
		end

		for k, name in ipairs( self.vRenderOrder ) do
		
			local v = self.VElements[name]
			if (!v) then self.vRenderOrder = nil break end
			if (v.hide) then continue end
			
			local model = v.modelEnt
			local sprite = v.spriteMaterial
			
			if (!v.bone) then continue end
			
			local pos, ang = self:GetBoneOrientation( self.VElements, v, vm )
			
			if (!pos) then continue end
			
			if (v.type == "Model" and IsValid(model)) then

				model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z )
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)

				model:SetAngles(ang)
				//model:SetModelScale(v.size)
				local matrix = Matrix()
				matrix:Scale(v.size)
				model:EnableMatrix( "RenderMultiply", matrix )
				
				if (v.material == "") then
					model:SetMaterial("")
				elseif (model:GetMaterial() != v.material) then
					model:SetMaterial( v.material )
				end
				
				if (v.skin and v.skin != model:GetSkin()) then
					model:SetSkin(v.skin)
				end
				
				if (v.bodygroup) then
					for k, v in pairs( v.bodygroup ) do
						if (model:GetBodygroup(k) != v) then
							model:SetBodygroup(k, v)
						end
					end
				end
				
				if (v.surpresslightning) then
					render.SuppressEngineLighting(true)
				end
				
				render.SetColorModulation(v.color.r/255, v.color.g/255, v.color.b/255)
				render.SetBlend(v.color.a/255)
				model:DrawModel()
				render.SetBlend(1)
				render.SetColorModulation(1, 1, 1)
				
				if (v.surpresslightning) then
					render.SuppressEngineLighting(false)
				end
				
			elseif (v.type == "Sprite" and sprite) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				render.SetMaterial(sprite)
				render.DrawSprite(drawpos, v.size.x, v.size.y, v.color)
				
			elseif (v.type == "Quad" and v.draw_func) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				
				cam.Start3D2D(drawpos, ang, v.size)
					v.draw_func( self )
				cam.End3D2D()

			end
			
		end
		
	end

	SWEP.wRenderOrder = nil
	function SWEP:DrawWorldModel()
		
		if (self.ShowWorldModel == nil or self.ShowWorldModel) then
			self:DrawModel()
		end
		
		if (!self.WElements) then return end
		
		if (!self.wRenderOrder) then

			self.wRenderOrder = {}

			for k, v in pairs( self.WElements ) do
				if (v.type == "Model") then
					table.insert(self.wRenderOrder, 1, k)
				elseif (v.type == "Sprite" or v.type == "Quad") then
					table.insert(self.wRenderOrder, k)
				end
			end

		end
		
		if (IsValid(self.Owner)) then
			bone_ent = self.Owner
		else
			// when the weapon is dropped
			bone_ent = self
		end
		
		for k, name in pairs( self.wRenderOrder ) do
		
			local v = self.WElements[name]
			if (!v) then self.wRenderOrder = nil break end
			if (v.hide) then continue end
			
			local pos, ang
			
			if (v.bone) then
				pos, ang = self:GetBoneOrientation( self.WElements, v, bone_ent )
			else
				pos, ang = self:GetBoneOrientation( self.WElements, v, bone_ent, "ValveBiped.Bip01_R_Hand" )
			end
			
			if (!pos) then continue end
			
			local model = v.modelEnt
			local sprite = v.spriteMaterial
			
			if (v.type == "Model" and IsValid(model)) then

				model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z )
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)

				model:SetAngles(ang)
				//model:SetModelScale(v.size)
				local matrix = Matrix()
				matrix:Scale(v.size)
				model:EnableMatrix( "RenderMultiply", matrix )
				
				if (v.material == "") then
					model:SetMaterial("")
				elseif (model:GetMaterial() != v.material) then
					model:SetMaterial( v.material )
				end
				
				if (v.skin and v.skin != model:GetSkin()) then
					model:SetSkin(v.skin)
				end
				
				if (v.bodygroup) then
					for k, v in pairs( v.bodygroup ) do
						if (model:GetBodygroup(k) != v) then
							model:SetBodygroup(k, v)
						end
					end
				end
				
				if (v.surpresslightning) then
					render.SuppressEngineLighting(true)
				end
				
				render.SetColorModulation(v.color.r/255, v.color.g/255, v.color.b/255)
				render.SetBlend(v.color.a/255)
				model:DrawModel()
				render.SetBlend(1)
				render.SetColorModulation(1, 1, 1)
				
				if (v.surpresslightning) then
					render.SuppressEngineLighting(false)
				end
				
			elseif (v.type == "Sprite" and sprite) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				render.SetMaterial(sprite)
				render.DrawSprite(drawpos, v.size.x, v.size.y, v.color)
				
			elseif (v.type == "Quad" and v.draw_func) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				
				cam.Start3D2D(drawpos, ang, v.size)
					v.draw_func( self )
				cam.End3D2D()

			end
			
		end
		
	end

	function SWEP:GetBoneOrientation( basetab, tab, ent, bone_override )
		
		local bone, pos, ang
		if (tab.rel and tab.rel != "") then
			
			local v = basetab[tab.rel]
			
			if (!v) then return end
			
			// Technically, if there exists an element with the same name as a bone
			// you can get in an infinite loop. Let's just hope nobody's that stupid.
			pos, ang = self:GetBoneOrientation( basetab, v, ent )
			
			if (!pos) then return end
			
			pos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
			ang:RotateAroundAxis(ang:Up(), v.angle.y)
			ang:RotateAroundAxis(ang:Right(), v.angle.p)
			ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				
		else
		
			bone = ent:LookupBone(bone_override or tab.bone)

			if (!bone) then return end
			
			pos, ang = Vector(0,0,0), Angle(0,0,0)
			local m = ent:GetBoneMatrix(bone)
			if (m) then
				pos, ang = m:GetTranslation(), m:GetAngles()
			end
			
			if (IsValid(self.Owner) and self.Owner:IsPlayer() and 
				ent == self.Owner:GetViewModel() and self.ViewModelFlip) then
				ang.r = -ang.r // Fixes mirrored models
			end
		
		end
		
		return pos, ang
	end

	function SWEP:CreateModels( tab )

		if (!tab) then return end

		// Create the clientside models here because Garry says we can't do it in the render hook
		for k, v in pairs( tab ) do
			if (v.type == "Model" and v.model and v.model != "" and (!IsValid(v.modelEnt) or v.createdModel != v.model) and 
					string.find(v.model, ".mdl") and file.Exists (v.model, "GAME") ) then
				
				v.modelEnt = ClientsideModel(v.model, RENDER_GROUP_VIEW_MODEL_OPAQUE)
				if (IsValid(v.modelEnt)) then
					v.modelEnt:SetPos(self:GetPos())
					v.modelEnt:SetAngles(self:GetAngles())
					v.modelEnt:SetParent(self)
					v.modelEnt:SetNoDraw(true)
					v.createdModel = v.model
				else
					v.modelEnt = nil
				end
				
			elseif (v.type == "Sprite" and v.sprite and v.sprite != "" and (!v.spriteMaterial or v.createdSprite != v.sprite) 
				and file.Exists ("materials/"..v.sprite..".vmt", "GAME")) then
				
				local name = v.sprite.."-"
				local params = { ["$basetexture"] = v.sprite }
				// make sure we create a unique name based on the selected options
				local tocheck = { "nocull", "additive", "vertexalpha", "vertexcolor", "ignorez" }
				for i, j in pairs( tocheck ) do
					if (v[j]) then
						params["$"..j] = 1
						name = name.."1"
					else
						name = name.."0"
					end
				end

				v.createdSprite = v.sprite
				v.spriteMaterial = CreateMaterial(name,"UnlitGeneric",params)
				
			end
		end
		
	end
	
	local allbones
	local hasGarryFixedBoneScalingYet = false

	function SWEP:UpdateBonePositions(vm)
		
		if self.ViewModelBoneMods then
			
			if (!vm:GetBoneCount()) then return end
			
			// !! WORKAROUND !! //
			// We need to check all model names :/
			local loopthrough = self.ViewModelBoneMods
			if (!hasGarryFixedBoneScalingYet) then
				allbones = {}
				for i=0, vm:GetBoneCount() do
					local bonename = vm:GetBoneName(i)
					if (self.ViewModelBoneMods[bonename]) then 
						allbones[bonename] = self.ViewModelBoneMods[bonename]
					else
						allbones[bonename] = { 
							scale = Vector(1,1,1),
							pos = Vector(0,0,0),
							angle = Angle(0,0,0)
						}
					end
				end
				
				loopthrough = allbones
			end
			// !! ----------- !! //
			
			for k, v in pairs( loopthrough ) do
				local bone = vm:LookupBone(k)
				if (!bone) then continue end
				
				// !! WORKAROUND !! //
				local s = Vector(v.scale.x,v.scale.y,v.scale.z)
				local p = Vector(v.pos.x,v.pos.y,v.pos.z)
				local ms = Vector(1,1,1)
				if (!hasGarryFixedBoneScalingYet) then
					local cur = vm:GetBoneParent(bone)
					while(cur >= 0) do
						local pscale = loopthrough[vm:GetBoneName(cur)].scale
						ms = ms * pscale
						cur = vm:GetBoneParent(cur)
					end
				end
				
				s = s * ms
				// !! ----------- !! //
				
				if vm:GetManipulateBoneScale(bone) != s then
					vm:ManipulateBoneScale( bone, s )
				end
				if vm:GetManipulateBoneAngles(bone) != v.angle then
					vm:ManipulateBoneAngles( bone, v.angle )
				end
				if vm:GetManipulateBonePosition(bone) != p then
					vm:ManipulateBonePosition( bone, p )
				end
			end
		else
			self:ResetBonePositions(vm)
		end
		   
	end
	 
	function SWEP:ResetBonePositions(vm)
		
		if (!vm:GetBoneCount()) then return end
		for i=0, vm:GetBoneCount() do
			vm:ManipulateBoneScale( i, Vector(1, 1, 1) )
			vm:ManipulateBoneAngles( i, Angle(0, 0, 0) )
			vm:ManipulateBonePosition( i, Vector(0, 0, 0) )
		end
		
	end

	/**************************
		Global utility code
	**************************/

	// Fully copies the table, meaning all tables inside this table are copied too and so on (normal table.Copy copies only their reference).
	// Does not copy entities of course, only copies their reference.
	// WARNING: do not use on tables that contain themselves somewhere down the line or you'll get an infinite loop
	function table.FullCopy( tab )

		if (!tab) then return nil end
		
		local res = {}
		for k, v in pairs( tab ) do
			if (type(v) == "table") then
				res[k] = table.FullCopy(v) // recursion ho!
			elseif (type(v) == "Vector") then
				res[k] = Vector(v.x, v.y, v.z)
			elseif (type(v) == "Angle") then
				res[k] = Angle(v.p, v.y, v.r)
			else
				res[k] = v
			end
		end
		
		return res
		
	end
	
end