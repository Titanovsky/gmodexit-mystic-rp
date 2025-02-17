AddCSLuaFile()

-- Ugly way to get around some engine limitations
ENT.PrintName = "Ricochet"
ENT.Spawnable = false
ENT.Type = "anim"


if CLIENT then
    function ENT:Draw()

    end
    return
end

function ENT:Initialize()
    self:SetModel("models/Combine_Helicopter/helicopter_bomb01.mdl")
    self:DrawShadow(false)
    self:SetNoDraw(true)
end

function ENT:Think()
    if self.FireTime < CurTime() then
        local ricsleft = self.RicsLeft or 20
        self:FireBullets({
            Attacker = self.Owner,
            Damage = self.Damage,
            Force = 0,
            Distance = 5000,
            Num = 1,
            Tracer = 1,
            TracerName = "ToolTracer",
            Dir = self.Direction,
            Spread = Vector(0.05,0.05,0),
            Src = self:GetPos(),
            --IgnoreEntity = self.Owner,
            Callback = function(attacker, tr, dmginfo)
                if IsValid(self.Inflictor) then dmginfo:SetInflictor(self.Inflictor) end
                if ricsleft > 0 then
                    local r = ents.Create("arccw_ricochet_gauss")
                    r.FireTime = CurTime() + 0.1
                    r.Owner = self.Owner
                    r.Damage = math.ceil(self.Damage * (tr.HitNonWorld and 0.75 or 0.95))
                    r.Direction = tr.Normal - 2 * (tr.Normal:Dot(tr.HitNormal)) * tr.HitNormal
                    r.Inflictor = self.Inflictor
                    r.RicsLeft = ricsleft - 1
                    r:SetPos(tr.HitPos)
                    r:Spawn()
                end
            end
        })
        self:EmitSound("weapons/fx/rics/ric" .. math.random(1,5) .. ".wav", 70, 100)
        self:Remove()
    end
end