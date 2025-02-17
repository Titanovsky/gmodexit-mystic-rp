AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.Spawnable = true
ENT.PrintName = "Is it broom?"
ENT.Category = "Harry Potter"

function ENT:SpawnFunction(ply, tr, name)
	if not tr.Hit then return end

	local pos = tr.HitPos + tr.HitNormal * 32
	
	local ent = ents.Create("kekc_broom_ent")
	ent:SetPos(pos)
	ent:SetAngles(Angle(0, 0, 180))
	ent:Spawn()
	ent:Activate()
	
	// set up variables
	ent.NextAttack = 0
	ent.Speed = 3000
	ent.Class = self.PrintName
	
	if IsValid(ent:GetPhysicsObject()) then ent:GetPhysicsObject():Wake() else return NULL end
	
	return ent
end

hook.Add("KeyPress", "broomis_KeyPress", function(ply, key)
	if CLIENT then return end

	local ent = ply:GetNWEntity("broom_active")
	if not ent:IsValid() or ent.Class != "Is it broom?" then return end //only for is it broom

	if key == IN_ATTACK and CurTime() > ent.NextAttack then
		ent:EmitSound("ambient/explosions/explode_2.wav")
		
		ent.NextAttack = CurTime() + 0.1
	end
end)