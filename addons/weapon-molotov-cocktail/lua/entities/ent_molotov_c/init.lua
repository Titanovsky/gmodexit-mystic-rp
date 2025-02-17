--[[ 
Copyright 2014 Phoenix. I can be contacted @ http://steamcommunity.com/profiles/76561197990696007

This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License.
To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
--]]

if (SERVER) then
	AddCSLuaFile("cl_init.lua")
	AddCSLuaFile("shared.lua")
end

include("shared.lua")

function ENT:Initialize()
	self.Entity:SetModel("models/props_junk/garbage_glassbottle003a.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	self.Entity:SetMaterial("models/debug/debugwhite")
	self.Entity:SetColor( Color(189, 69, 24) )
	self.Entity:Ignite(10, 0)
	self.Entity:GetPhysicsObject():AddAngleVelocity(Vector(0, 500, 0))
	timer.Simple(10, function()
		if self:IsValid() then self:Remove() end
	end )
end

function ENT:Think()
	if self.Entity:WaterLevel() > 0 then self.Entity:Extinguish() end
end

function ENT:OnRemove()
	
	local expl = ents.Create("env_explosion")
	expl:SetPos(self.Entity:GetPos())
	expl:SetKeyValue("iMagnitude", "100")
	expl:EmitSound("BaseGrenade.Explode", 300, 300)
	expl:Spawn()
	expl:Fire("Explode", 0, 0)
	expl:SetOwner(self.Owner)
	
	if self.Entity:WaterLevel() > 0 then return end
		
	for i=1,10 do
		
		local pos = self.Entity:GetPos() + Vector(math.random(-100, 100), math.random(-100, 100), 0)
		
		for _, c in pairs(ents.FindInSphere(pos, 5)) do
			if c:GetClass() == "env_fire" then return end
		end
		
		local explfire = ents.Create("env_fire")
		explfire:SetPos(pos)
		explfire:SetKeyValue("health", "20")
		explfire:SetKeyValue("firesize", "100")
		explfire:SetKeyValue("damagescale", "10")
		explfire:SetKeyValue("spawnflags", "2")
		explfire:Spawn()
		explfire:Fire("StartFire", "", 0)
		
		timer.Simple(60, function()
			if explfire:IsValid() then explfire:Remove() end
		end )
		
	end	
	
	for _, v in pairs(ents.FindInSphere(self.Entity:GetPos(), 100)) do
		if v:IsPlayer() or v:IsWorld() or v:IsWeapon() or not v:IsValid() then return end
		
		if string.find(v:GetClass(), "prop_") then
			local phys = v:GetPhysicsObject()
			if string.find(phys:GetMaterial(), "metal") then
				return
			end
		end
		
		v:Ignite(60, 100)
	end
	
end

function ENT:PhysicsCollide()
	self.Entity:EmitSound("physics/glass/glass_largesheet_break" ..math.random(1,3).. ".wav", 500, math.random(90,110))
	if self.Entity:IsValid() then self.Entity:Remove() end
end