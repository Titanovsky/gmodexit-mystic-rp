ENT.Type 			= "anim"
ENT.Base 			= "base_anim"
ENT.PrintName		= "Sniper Rounds"
ENT.Category		= "Half-Life 2"

ENT.Spawnable		= true
ENT.AdminOnly = false

if SERVER then

AddCSLuaFile()

function ENT:SpawnFunction(ply, tr)

	if (!tr.Hit) then return end
	
	local SpawnPos = tr.HitPos + tr.HitNormal * 16
	
	local ent = ents.Create("item_sniperround")
	
	ent:SetPos(SpawnPos)
	ent:Spawn()
	ent:Activate()
	
	return ent
end

function ENT:Initialize()

	local model = ("models/weapons/sniperround.mdl")
	
	self.Entity:SetModel(model)
	
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	self.Entity:DrawShadow(false)
	
	self.Entity:SetCollisionGroup(COLLISION_GROUP_WEAPON)
	
	local phys = self.Entity:GetPhysicsObject()
	
	if (phys:IsValid()) then
		phys:Wake()
	end

	self.Entity:SetUseType(SIMPLE_USE)
end

function ENT:PhysicsCollide(data, phys)
	if data.DeltaTime > 0.2 then
		self:EmitSound("physics/metal/metal_box_impact_hard" .. math.random(1, 3) .. ".wav")
	end
end

function ENT:OnTakeDamage()
end

function ENT:Use(activator, caller)

	if activator:IsPlayer()then
		activator:GiveAmmo(20, "SniperRound")
		self.Entity:Remove()
	end
	
end

end

if CLIENT then

function ENT:Initialize()
end

function ENT:Draw()
	
	self.Entity:DrawModel()
	
	local ledcolor = Color(230, 45, 45, 255)

  	local TargetPos = self.Entity:GetPos() + (self.Entity:GetUp() * 4) + (self.Entity:GetRight() * -2.5) + (self.Entity:GetForward() * -3.3)//-1.2

	local FixAngles = self.Entity:GetAngles()
	local FixRotation = Vector(48, -90, 0)
	
	FixAngles:RotateAroundAxis(FixAngles:Right(), FixRotation.x)
	FixAngles:RotateAroundAxis(FixAngles:Up(), FixRotation.y)
	FixAngles:RotateAroundAxis(FixAngles:Forward(), FixRotation.z)

	self.Text = "Sniper Rounds"
	
	cam.Start3D2D(TargetPos, FixAngles, .07)
		draw.SimpleText(self.Text, "DermaLarge", 31, -22, ledcolor, 1, 1)
	cam.End3D2D()
end
end