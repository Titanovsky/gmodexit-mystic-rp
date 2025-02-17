if SERVER then
    AddCSLuaFile ()
    SWEP.AutoSwitchTo        = true
    SWEP.AutoSwitchFrom        = true
elseif CLIENT then
    SWEP.DrawCrosshair        = true
    SWEP.PrintName            = "Fire Magic"
    SWEP.BounceWeaponIcon   = false
	CreateClientConVar("mp_beam_length","8.95",true, true)
end

game.AddParticles( "particles/firemagic01.pcf" )
PrecacheParticleSystem( "firemagic_shield" )
PrecacheParticleSystem( "spell_fireball_small_red" )
PrecacheParticleSystem( "asplode_hoodoo" )

SWEP.Base = "weapon_base"
SWEP.Author          = "Hds46"
SWEP.Contact         = "http://steamcommunity.com/profiles/76561198065894505/"
SWEP.Purpose         = "It's time to acquire the most badass and deadly magic of the world."
SWEP.Instructions    = "Left Click - Flame Stream \nRight Click - Fireball \nReload Key - Solar Beam \nALT Key - Meteor Strike \nUse Key - Sizzling Fire \nSuit Zoom(O) - Firestorm"
SWEP.Category        = "Magic"

SWEP.Spawnable                = true
SWEP.AdminOnly           = false
SWEP.UseHands = false

SWEP.HoldType             = "normal"
SWEP.ViewModel            = "models/weapons/c_crowbar.mdl"
SWEP.WorldModel            = "models/weapons/w_crowbar.mdl"
SWEP.Slot				= 0
SWEP.SlotPos			= 3
SWEP.Primary.ClipSize        = -1
SWEP.Primary.DefaultClip    = -1
SWEP.Primary.Automatic        = true
SWEP.Primary.Ammo            = "None" 

SWEP.Secondary.ClipSize        = -1 
SWEP.Secondary.DefaultClip    = -1 
SWEP.Secondary.Automatic    = true 
SWEP.Secondary.Ammo            = "none"
SWEP.NextAttackSound = 0
SWEP.NextAttackStop = 0
SWEP.NextUseShield = 0
SWEP.NukeCooldown = 0


---Nuclear Explosion
--Originally by R3ality 
--Edits by Teta_Bonita
--Ported to Garry's Mod 13 by Hds46


yield = 10 --modifies almost every value.  default = 10 units = about 0.5 kilotons = 1 gm_construct.  Values above 150 are not tested and will only make the mushroom cloud bigger. 

yieldslowest = 0.380*yield^0.42
yieldslow = 0.2821*yield^0.55
yieldmoderate = 0.209*yield^0.68
yieldfast = 0.191*yield^0.72
yieldfastest = 0.071*yield^1.15
yielddirect = yield/10


allowfires = 1	--set to 1 to enable random fire spawning. setting this to zero will increase performance
allowigniting = 1	--set to 1 to enable radius based entity igniting. setting this to zero will also increase performance
allowcharring = 1	--set to 1 to enable corpse charring NOTE: As a temporary bugfix all humanoids caught in the char radius will always die, no matter what.
allowsmokerings = 1	--set to 1 to enable the drawing of a smoke ring in the blast
lowFX = 0	--set to 1 for a performance boost at the cost of some graphical quality

blastradius = yieldfast * 3800	--the size of the initial explosion
burnradius = yieldslow * 3000	--Anything caught in the burn radius gets buuurrrrnneeed! (except for players)  :D
charradius = yieldfast * 3000	--Corpses of humanoid NPCs in the char radius are replaced with models of charred corpses. NOTE: As a temporary bugfix all humanoids caught in the char radius will always die, no matter what.
chardelay = 2					--duration in seconds to roast corpses Note: this doesn't do anything as of this version.

allowcartossing = 1 --set to 1 to enable an extra push for phys objects.  Those giant red crates will now get tossed around like toys.
pushradius = yieldmoderate * 6000	--Phys objects in the push radius are sent flying.
pushtime = 0.7 --time in seconds to apply force to objects in the pushradius.  The higher it is, the farther they fly.  Only applies if allowcartossing is set to 1.
minmass = 2000 --the minimum mass of the objects to push.  only applies if cartossing is on.


if yieldfast*2200 < 13000 then
fireballradius = yieldfast * 2200	--NOT a visual effect- the fireball is an area near that epicenter that does massive dammage over a short period of time.
else
fireballradius = 13000 --dont change this.  This is approxamently the maximum radius a point_hurt can have- any longer and it will disappear.
end

if yieldfast*4100 < 13000 then
falloutradius = yieldfast * 4100 --Entities caught in the fall-out radius sustain moderate damage for a specific length of time.
else
falloutradius = 13000 --dont change this.  This is approxamently the maximum radius a point_hurt can have- any longer and it will disappear.
end

--------------------------------------------------------------------------------
--Modify The Third Value To Modify The Delays
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
--Mushroom Cloud Appearance Multipliers
--------------------------------------------------------------------------------
	
----------------------------Head Multipliers-------------------------------
if (lowFX==0) then
BaseSpreadHeadMultiplier=0.8*yieldmoderate
SpreadSpeedHeadMultiplier=1.1*yieldmoderate
SpeedHeadMultiplier=1.3*yieldslow
startsizeHeadMultiplier=0.8*yieldmoderate
EndSizeHeadMultiplier=1.2*yieldmoderate
RateHeadMultiplier=0.4
JetLengthHeadMultiplier=0.4*yieldslow
WindAngleHeadMultiplier=0.4
WindSpeedHeadMultiplier=0.4
renderamtHeadMultiplier=0.4
else
BaseSpreadHeadMultiplier=0.6
SpreadSpeedHeadMultiplier=0.7
SpeedHeadMultiplier=1.3
startsizeHeadMultiplier=0.6
EndSizeHeadMultiplier=0.8
RateHeadMultiplier=0.25
JetLengthHeadMultiplier=1
WindAngleHeadMultiplier=1
WindSpeedHeadMultiplier=1.2
renderamtHeadMultiplier=1
end

----------------------------Stalk  Multipliers-------------------------------
if (lowFX==0) then
BaseSpreadStalkMultiplier=1*yieldmoderate
SpreadSpeedStalkMultiplier=0.5*yieldmoderate
SpeedStalkMultiplier=1.3*yieldslow
startsizeStalkMultiplier=1.4*yieldmoderate
EndSizeStalkMultiplier=1.4*yieldmoderate
RateStalkMultiplier= 0.4
JetLengthStalkMultiplier=0.4*yieldslow
WindAngleStalkMultiplier=0.4
WindSpeedStalkMultiplier=0.4
renderamtStalkMultiplier=0.4
else
BaseSpreadStalkMultiplier=0.6
SpreadSpeedStalkMultiplier=0.5
SpeedStalkMultiplier=1.3
startsizeStalkMultiplier=1
EndSizeStalkMultiplier=1
RateStalkMultiplier=0.4
JetLengthStalkMultiplier=1
WindAngleStalkMultiplier=1
WindSpeedStalkMultiplier=1
renderamtStalkMultiplier=1.2
end

----------------------------Ring  Multipliers-------------------------------
if (lowFX==0) then
BaseSpreadRingMultiplier=1.2*yieldmoderate
SpreadSpeedRingMultiplier=1*yieldmoderate
SpeedRingMultiplier=1.56*yieldslow
startsizeRingMultiplier=1.1*yieldmoderate
EndSizeRingMultiplier=1*yieldmoderate
RateRingMultiplier=0.4
JetLengthRingMultiplier=0.4*yieldslow
WindAngleRingMultiplier=0.4
WindSpeedRingMultiplier=0.4
renderamtRingMultiplier=0.4
else
BaseSpreadRingMultiplier=0.8
SpreadSpeedRingMultiplier=0.4
SpeedRingMultiplier=1.56
startsizeRingMultiplier=0.8
EndSizeRingMultiplier=0.7
RateRingMultiplier=0.4
JetLengthRingMultiplier=1.2
WindAngleRingMultiplier=1
WindSpeedRingMultiplier=0.6
renderamtRingMultiplier=0.8
end


----------------------------Base  Multipliers-------------------------------
if (lowFX==0) then
BaseSpreadBaseMultiplier=1.2*yieldmoderate
SpreadSpeedBaseMultiplier=1.0*yieldmoderate
SpeedBaseMultiplier=1.3*yieldslow
startsizeBaseMultiplier=1.1*yieldmoderate
EndSizeBaseMultiplier=1.1*yieldmoderate
RateBaseMultiplier=0.4
JetLengthBaseMultiplier=0.4*yieldslow
WindAngleBaseMultiplier=0.4
WindSpeedBaseMultiplier=0.4
renderamtBaseMultiplier=0.4
else
BaseSpreadBaseMultiplier=1.4
SpreadSpeedBaseMultiplier=0.6
SpeedBaseMultiplier=1.3
startsizeBaseMultiplier=0.7
EndSizeBaseMultiplier=0.7
RateBaseMultiplier=0.4
JetLengthBaseMultiplier=1
WindAngleBaseMultiplier=1
WindSpeedBaseMultiplier=0.3
renderamtBaseMultiplier=1
end

function immolate(centervec, radius)
    for key,found in pairs(ents.FindInSphere( centervec, radius )) do
		if (allowigniting == 1) then 
		if vFireInstalled then
		if (found:IsNPC() or found:IsPlayer() or type(found) == "NextBot" or string.find(found:GetClass(),"prop")) and !found:IsOnFire() then
		local lotteryoffierydoom = math.random(0,4)		
		if (lotteryoffierydoom == 0) or (lotteryoffierydoom == 1) or (lotteryoffierydoom == 2) then
		found:Ignite(5)
		end
		end
		else
		if !(found:IsPlayer() or found:IsWeapon() or found:GetClass()=="predicted_viewmodel" or found:GetClass()=="gmod_hands") then 
			local lotteryoffierydoom = math.random(0,4)		
			if (lotteryoffierydoom == 0) or (lotteryoffierydoom == 1) or (lotteryoffierydoom == 2) then
			found:Ignite(math.random(14,25),100)
			end
		end
		end
		
		end	
	end	
end

function SWEP:Shield_Ignite(ent,duration)
if vFireInstalled then
if (ent:IsNPC() or ent:IsPlayer() or type(ent) == "NextBot" or string.find(ent:GetClass(),"prop")) and !ent:IsOnFire() then
ent:Ignite(5)
end
else
if !(ent:IsWeapon() or ent:GetClass()=="predicted_viewmodel" or ent:GetClass()=="gmod_hands") then 
ent:Ignite(duration,100)
end
end
end

function char_burn(centervec, radius)
    for key,found in pairs(ents.FindInSphere( centervec, radius )) do
		if (allowcharring == 1) then
				local corpsestyle = math.random(0,4)
				if found:IsNPC() and (found:GetClass()=="npc_zombie" or 
				found:GetClass()=="npc_citizen" or
				found:GetClass()=="npc_barney" or
				found:GetClass()=="npc_metropolice" or
				found:GetClass()=="npc_alyx" or
				found:GetClass()=="npc_combine_s" or
				found:GetClass()=="npc_vortigaunt" or
				found:GetClass()=="npc_stalker" or
				found:GetClass()=="npc_eli" or
				found:GetClass()=="npc_gman" or
				found:GetClass()=="npc_monk" or
				found:GetClass()=="npc_mossman" or
				found:GetClass()=="npc_fastzombie" or
				found:GetClass()=="npc_poisonzombie" or
				found:GetClass()=="npc_zombie_torso" or
				found:GetClass()=="npc_fastzombie_torso" or
				found:GetClass()=="npc_magnusson" or
				found:GetClass()=="npc_kleiner" or
				found:GetClass()=="npc_zombine" or
				found:GetClass()=="npc_breen") then
					if (corpsestyle == 0) then
					found:SetModel("models/Humans/Charple01.mdl")
					end				
					if (corpsestyle == 1) then
					found:SetModel("models/Humans/Charple01.mdl")
					end
					if (corpsestyle == 2) then
					found:SetModel("models/Humans/Charple02.mdl")
					end
					if (corpsestyle == 3) then
					found:SetModel("models/Humans/Charple03.mdl")
					end
					if (corpsestyle == 4) then
					found:SetModel("models/Humans/Charple04.mdl")
					end	
				    found:SetHealth(0)
				end
			end	
		end	
end

--------------------------------------------------------------------------------
--Don't Mess With Stuff Below This Line Unless You Know What You Are Doing
--------------------------------------------------------------------------------

function pointGrav2( centervec, zerooffset, radius, force )

local objects2 = ents.FindInSphere( centervec, radius )
    for i = 1,#objects2 do
        if (IsValid(objects2[i]:GetPhysicsObject())) then
            local entpos = objects2[i]:GetPos()
            if ( centervec.x == entpos.x and centervec.y == entpos.y and centervec.z == entpos.z ) then return end
            local gravforce = force * objects2[i]:GetPhysicsObject():GetMass() / ((centervec - entpos):Length() + ( zerooffset ) ) ^ 2
            local entvec = (centervec - entpos):GetNormalized()
			local a = entvec
            a:Mul( gravforce )
            objects2[i]:GetPhysicsObject():ApplyForceCenter(a)
        end
	end
end

hook.Add("EntityRemoved", "fixsomebugs_fm",function(ent)
if ent.IsFMNuke and IsValid(ent:GetOwner()) and ent:GetOwner().HasSpeedChanged then
local owner = ent:GetOwner()
owner:SetWalkSpeed(owner.PlyWalkSpeed)
owner:SetRunSpeed(owner.PlyRunSpeed)
owner:SetJumpPower(owner.PlyJumpPower)
end
end)

function SWEP:Think()
    if IsValid(self.nuke) then
	self.nuke:SetPos(self.Owner:EyePos() + self.Owner:GetAimVector()*100 + Vector(0,0,-20))
	self.nuke:SetAngles(self.Owner:EyeAngles())
	end
    if IsValid(self) and IsValid(self.Owner) and self.Owner:Alive() and (self.Owner:KeyReleased( IN_ATTACK ) or (self.Owner:KeyDown(IN_ATTACK) and self.Owner:KeyDown(IN_ATTACK2))) then
	if ( self.FireSound ) then 
	self.FireSound:ChangeVolume( 0, 0.1 ) 
	self.FireSound:Stop() 
	self.FireSound = nil
	end
	end
	if IsValid(self.Owner) and self.Owner:KeyDown(IN_USE) and self:GetNextPrimaryFire() < CurTime() and self.NukeCooldown < CurTime() and SERVER then
	if IsValid(self.Owner:GetEyeTrace().Entity) and self.Owner:GetEyeTrace().HitPos:Distance(self.Owner:EyePos()) <= 400 then
	return
	end
	for k,v in pairs(ents.FindByClass("firemagic_fireball_nuke")) do
	if IsValid(v) and v:GetOwner() == self.Owner then
	return
	end
	end
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self.Weapon:SetNextPrimaryFire(CurTime() + 5)
    self.Weapon:SetNextSecondaryFire(CurTime() + 5)
	local pos = self.Owner:GetEyeTrace().HitPos
	self.Owner:EmitSound("nuke_prepare2.wav",70,120)
	if !IsValid(self.nuke) then
	self.nuke = ents.Create( "firemagic_fireball_nuke" )
	self.nuke:SetPos( self.Owner:EyePos() + self.Owner:GetAimVector()*20 + Vector(0,0,-20) )
	self.nuke:SetAngles( self.Owner:EyeAngles() )
	self.nuke:Spawn()
	self.nuke.IsFMNuke = true
	self.nuke:SetOwner( self.Owner )
	self.nuke:SetMoveType(MOVETYPE_NONE)
	self.nuke:SetSolid(SOLID_NONE)
	self.nuke.wepent = self
	end
	self.Owner.HasSpeedChanged = true
	self.Owner.PlyWalkSpeed = self.Owner:GetWalkSpeed()
	self.Owner.PlyRunSpeed = self.Owner:GetRunSpeed()
	self.Owner.PlyJumpPower = self.Owner:GetJumpPower()
	self.Owner:SetWalkSpeed(self.Owner.PlyWalkSpeed/2)
	self.Owner:SetRunSpeed(self.Owner.PlyWalkSpeed/2)
	self.Owner:SetJumpPower(0)
	timer.Create("nuke_sound" .. self:EntIndex(),0.4,5,function()
	if IsValid(self) and IsValid(self.Owner) and IsValid(self.nuke) then
	self.Owner:EmitSound("nuke_prepare2.wav",70,120)
	end
	end)
	timer.Create("launch_nuke" .. self:EntIndex(),2.3,1,function()
	if IsValid(self) and IsValid(self.Owner) and IsValid(self.nuke) then
	self.Owner:EmitSound("nuke_launch.wav",90,100)
	self.Owner.HasSpeedChanged = false
	self.Owner:SetWalkSpeed(self.Owner.PlyWalkSpeed)
	self.Owner:SetRunSpeed(self.Owner.PlyRunSpeed)
	self.Owner:SetJumpPower(self.Owner.PlyJumpPower)
	self.nuke.WorldCheck = true
	self.nuke:SetMoveType(MOVETYPE_FLY)
    self.nuke:SetGravity(0.2)
	self.nuke:SetSolid(SOLID_VPHYSICS)
	self.nuke:SetVelocity( self.Owner:GetAimVector()*1000)
	if !self.nuke.FireSound then
	self.nuke.FireSound = CreateSound(self.nuke,Sound("ambient/fire/firebig.wav"))
	self.nuke.FireSound:SetSoundLevel( 80 )
	self.nuke.FireSound:PlayEx(1,220)
	end
	self.nuke = nil
	end
	end)
	end
	if IsValid(self.Owner) and self.Owner:IsOnGround() and self:WaterLevel() == 0 and self.Owner:KeyDown(IN_ZOOM) and self:GetNextPrimaryFire() < CurTime() then
	self.Weapon:SetNextPrimaryFire(CurTime() + 0.05)
    self.Weapon:SetNextSecondaryFire(CurTime() + 0.05)
	local startpos = self.Owner:GetPos() + Vector(math.Rand(-400,400),math.Rand(-400,400),0)
	local traceworld = {}
	traceworld.start = startpos
	traceworld.endpos = traceworld.start - Vector(0,0,400)
	traceworld.fliter = function(ent) if !ent:IsWorld() then return false end end
	traceworld.mask = MASK_SOLID_BRUSHONLY
	local trw = util.TraceLine(traceworld)
	if trw.HitWorld and !(self.Owner:GetPos():Distance(trw.HitPos) <= 75) then 
    ParticleEffect( "firemagic_shield", trw.HitPos,Angle(0,0,0))
	if SERVER then
	local randfire = math.random(1,2)
	if randfire == 1 then
	sound.Play( "ambient/fire/mtov_flame2.wav" , trw.HitPos, 75, 100, 1 )
	else
	sound.Play( "ambient/fire/ignite.wav" , trw.HitPos, 75, 100, 1 )
	end
	local decpos1 = trw.HitPos + trw.HitNormal
	local decpos2 = trw.HitPos - trw.HitNormal
	util.Decal("Dark", decpos1, decpos2) 	
	for k,v in pairs(ents.FindInSphere(trw.HitPos,150)) do
	if IsValid(v) and v != self.Owner then
	local dmginfo = DamageInfo()
    dmginfo:SetDamageType( DMG_GENERIC  )
	dmginfo:SetDamage( math.random(5,10) )
	dmginfo:SetDamagePosition( trw.HitPos )
	dmginfo:SetDamageForce( Vector(0,0,10*1000) )
	dmginfo:SetAttacker( self.Owner )
	dmginfo:SetInflictor( self )
	v:TakeDamageInfo(dmginfo)
	self:Shield_Ignite(v,math.random(5,8))
	end
	end
	if vFireInstalled then
	local newFireEnt = CreateVFire(IsValid(trw.HitEntity) and trw.HitEntity or game.GetWorld(), trw.HitPos, trw.HitNormal, 4)
	end
	end
	end
	end
	if IsValid(self.Owner) and self.Owner:KeyReleased(IN_RELOAD) and SERVER then
	if IsValid(self.SensorEnt) then
	self.SensorEnt:Remove()
	end
	if IsValid(self.particle) then
	if ( self.particle.SolarBeamSound ) then 
	self.particle.SolarBeamSound:ChangeVolume( 0, 0.02 ) 
	self.particle.SolarBeamSound:Stop() 
	self.particle.SolarBeamSound = nil
	self.particle:Remove()
	end
	end
	self.Weapon:SetNextPrimaryFire(CurTime() + 1)
    self.Weapon:SetNextSecondaryFire(CurTime() + 1)
	end
	if IsValid(self.Owner) and self.Owner:KeyDown(IN_RELOAD) and SERVER then
	if IsValid(self.SensorEnt) then
	local pos
	local num = 0
	local checkforlag = 0
	self.haspath = false
	while !self.haspath  do
	local tracesensor = {}
    tracesensor.start = self.Owner:GetEyeTrace().HitPos + Vector(0,0,num)
    tracesensor.endpos = tracesensor.start + Vector(0,0,4200)
    tracesensor.filter = function(ent) if !ent:IsWorld() then return false end end
    local traceworldsensor = util.TraceLine(tracesensor)
    if traceworldsensor.HitSky then
	pos = traceworldsensor.HitPos - Vector(0,0,40)
	self.haspath = true
	break
	else
	if !traceworldsensor.HitSky then
	num = num + 84
	if num >= self.SensorEnt.EntHeight then
	pos = self.Owner:GetEyeTrace().HitPos + Vector(0,0,4000)
	self.haspath = true
	break
	end
	checkforlag = checkforlag + 1
	if checkforlag >= 50 then
	break
	end
	end
	end
	end
	if IsValid(self.SensorEnt) then
	self.SensorEnt:SetPos(LerpVector( math.Clamp((1 - math.Clamp(self.SensorEnt:GetPos():Distance(pos)/1200,0,1))/20,0.005,1), self.SensorEnt:GetPos(), pos ))
	if !self.particle.SolarBeamSound then
	self.particle.SolarBeamSound = CreateSound(self.particle,Sound("ambient/levels/citadel/zapper_loop2.wav"))
	self.particle.SolarBeamSound:SetSoundLevel( 140 )
	self.particle.SolarBeamSound:PlayEx(1,120)
	end
	local tracebeam = {}
    tracebeam.start = self.SensorEnt:GetPos()
    tracebeam.endpos = tracebeam.start - Vector(0,0,90000)
    tracebeam.filter = function(ent) if !ent:IsWorld() then return false end end
    local traceworldbeam = util.TraceLine(tracebeam)
	if traceworldbeam.Hit then
	if self.NextBeamAttack == nil then
	self.NextBeamAttack = 0
	end
	if self.NextBeamAttack < CurTime() then
	self.NextBeamAttack = CurTime() + 0.1
	for k,v in pairs(ents.FindInSphere(traceworldbeam.HitPos,330)) do
	if IsValid(v) and v != self.Owner then
	v.InGround = true
	timer.Create("ent_ground" .. v:EntIndex(),0.2,1,function()
	if IsValid(v) then
	v.InGround = false
	end
	end)
	local dmginfo = DamageInfo()
    dmginfo:SetDamageType( DMG_GENERIC  )
	dmginfo:SetDamage( math.random(25,40) )
	dmginfo:SetDamagePosition( traceworldbeam.HitPos )
	dmginfo:SetDamageForce( Vector(0,0,20*1000) )
	dmginfo:SetAttacker( self.Owner )
	dmginfo:SetInflictor( self.SensorEnt )
	if v:IsNPC() or v:IsPlayer() or string.find(v:GetClass(),"prop") then
	if vFireInstalled then
	if !v:IsOnFire() then
	v:Ignite(3)
	end
	else
	if GetConVarNumber("ai_serverragdolls") > 0 then
	if !v.IsSensorEnt then
	v:Ignite(10,100)
	end
	end
	end
	end
	v:TakeDamageInfo(dmginfo)
	end
	end
	if vFireInstalled then
	if math.random(1,100) <= 80 then
	local newFireEnt = CreateVFire(IsValid(traceworldbeam.HitEntity) and traceworldbeam.HitEntity or game.GetWorld(), traceworldbeam.HitPos + traceworldbeam.HitNormal:Angle():Up()*math.Rand(-200,200) + traceworldbeam.HitNormal:Angle():Right()*math.Rand(-200,200), traceworldbeam.HitNormal, 10)
	end
	end
	local owner = self.Owner
	local tracedamagebeam = util.TraceHull( {
	start = self.SensorEnt:GetPos(),
	endpos = self.SensorEnt:GetPos() - Vector(0,0,90000),
	filter = function(ent) if (ent:IsWorld() or (ent:IsPlayer() and ent != owner ) or ent:IsNPC()) then return true end end,
	mins = Vector( -100, -100, -100 ),
	maxs = Vector( 100, 100, 100 )
    } )
	if IsValid(tracedamagebeam.Entity) and tracedamagebeam.Entity and !tracedamagebeam.Entity.InGround and tracedamagebeam.Entity != self.Owner and (tracedamagebeam.Entity:IsPlayer() or tracedamagebeam.Entity:IsNPC() or type( tracedamagebeam.Entity ) == "NextBot") then
	local dmginfo = DamageInfo()
    dmginfo:SetDamageType( DMG_GENERIC  )
	dmginfo:SetDamage( math.random(25,40) )
	dmginfo:SetDamagePosition( traceworldbeam.HitPos )
	dmginfo:SetDamageForce( Vector(0,0,20*1000) )
	dmginfo:SetAttacker( self.Owner )
	dmginfo:SetInflictor( self.SensorEnt )
	if tracedamagebeam.Entity:IsNPC() or tracedamagebeam.Entity:IsPlayer() then
	if vFireInstalled then
	if !tracedamagebeam.Entity:IsOnFire() then
	tracedamagebeam.Entity:Ignite(3)
	end
	else
	if GetConVarNumber("ai_serverragdolls") > 0 then
	tracedamagebeam.Entity:Ignite(10,100)
	end
	end
	end
	tracedamagebeam.Entity:TakeDamageInfo(dmginfo)
	end
	end
	if IsValid(self.Shake) then
	self.Shake:SetPos(traceworldbeam.HitPos)
	if self.NextShake == nil then
	self.NextShake = 0
	end
	if self.NextShake < CurTime() then
	self.NextShake = CurTime() + 0.2
	self.Shake:Fire( "StartShake", "", 0 )
	end
	end
	end
	end
	end
	end
	if IsValid(self.Owner) and self.Owner:KeyDown(IN_WALK) and self:GetNextPrimaryFire() < CurTime() and SERVER then
	self.Weapon:SetNextPrimaryFire(CurTime() + 3)
    self.Weapon:SetNextSecondaryFire(CurTime() + 3)
	local pos
	local tracesensor = {}
    tracesensor.start = self.Owner:GetEyeTrace().HitPos
    tracesensor.endpos = tracesensor.start + Vector(0,0,90000)
    tracesensor.filter = function(ent) if !ent:IsWorld() then return false end end
    local traceworldsensor = util.TraceLine(tracesensor)
    if traceworldsensor.HitSky then
	local length = tracesensor.start:Distance(traceworldsensor.HitPos)
	if length > 2000 then
	pos = self.Owner:GetEyeTrace().HitPos + Vector(0,0,1960)
	else
	pos = traceworldsensor.HitPos - Vector(0,0,40)
	end
	timer.Create("start_meteor" .. self:EntIndex(),0.4,math.random(8,14),function()
	if IsValid(self) and IsValid(self.Owner) then
	local startpos = pos + Vector(math.Rand(-700,700),math.Rand(-700,700),0)
	local fireball = ents.Create("firemagic_fireball")
	fireball:SetPos(startpos)
	fireball:SetAngles(Angle(0,0,0))
	fireball:Spawn()
	fireball:SetOwner(self.Owner)
	fireball:GetPhysicsObject():ApplyForceCenter(Vector(math.Rand(-1000,1000)*3,math.Rand(-1000,1000)*3,math.Rand(-7000,-5000)))
	SafeRemoveEntityDelayed( fireball, 30 )
	fireball:EmitSound("fireball_launch.wav",75,100)
	if !fireball:IsInWorld() then
	fireball:Remove()
	end
	end
	end)
	else
	self.Owner:SendLua("surface.PlaySound('common/wpn_denyselect.wav')")
	end
	end
end

function SWEP:Initialize()
	self:SetWeaponHoldType( self.HoldType )
end

function SWEP:Equip()
end

function SWEP:Holster()
if SERVER then
if ( self.FireSound ) then 
self.FireSound:ChangeVolume( 0, 0.02 ) 
self.FireSound:Stop() 
self.FireSound = nil
end
self.Owner:SetCanZoom( true )
self.Owner.HasSpeedChanged = false
if IsValid(self.SensorEnt) then
self.SensorEnt:Remove()
end
if IsValid(self.Shake) then
if ( self.particle.SolarBeamSound ) then 
self.particle.SolarBeamSound:ChangeVolume( 0, 0.02 ) 
self.particle.SolarBeamSound:Stop() 
self.particle.SolarBeamSound = nil
self.Shake:Remove()
end
end
if IsValid(self.nuke) then
return false
end
end
return true
end

function SWEP:OnRemove()
if SERVER then
if ( self.FireSound ) then 
self.FireSound:ChangeVolume( 0, 0.02 ) 
self.FireSound:Stop() 
self.FireSound = nil
end
self.Owner:SetCanZoom( true )
self.Owner.HasSpeedChanged = false
if IsValid(self.SensorEnt) then
self.SensorEnt:Remove()
end
if IsValid(self.Shake) then
if ( self.particle.SolarBeamSound ) then 
self.particle.SolarBeamSound:ChangeVolume( 0, 0.02 ) 
self.particle.SolarBeamSound:Stop() 
self.particle.SolarBeamSound = nil
self.Shake:Remove()
end
end
if IsValid(self.nuke) then
self.nuke:Remove()
end
self.nuke = nil
end
end

function SWEP:OnDrop()
if SERVER then
if ( self.FireSound ) then 
self.FireSound:ChangeVolume( 0, 0.02 ) 
self.FireSound:Stop() 
self.FireSound = nil
end
self.Owner:SetCanZoom( true )
self.Owner.HasSpeedChanged = false
if IsValid(self.Shake) then
if ( self.particle.SolarBeamSound ) then 
self.particle.SolarBeamSound:ChangeVolume( 0, 0.02 ) 
self.particle.SolarBeamSound:Stop() 
self.particle.SolarBeamSound = nil
self.Shake:Remove()
end
end
if IsValid(self.nuke) then
self.nuke:Remove()
end
self.nuke = nil
end
end

function SWEP:DrawWorldModel()
end

function SWEP:Deploy()
   self.Weapon:SetNextPrimaryFire(CurTime() + 0.8)
   self.Weapon:SetNextSecondaryFire(CurTime() + 0.7)
   self.Owner:DrawViewModel(false)
   if SERVER then
   self.Owner:SetCanZoom( false )
   end
end

function SWEP:Reload()
if !( self:GetNextPrimaryFire() < CurTime() ) then return end
if IsValid(self.SensorEnt) then return end
self.Owner:SetAnimation( PLAYER_ATTACK1 )
if CLIENT then return end
self.Weapon:SetNextPrimaryFire(CurTime() + 1)
self.Weapon:SetNextSecondaryFire(CurTime() + 1)
local playertrace = self.Owner:GetEyeTrace()
local trace = {}
trace.start = playertrace.HitPos
trace.endpos = trace.start + Vector(0,0,80000)
trace.filter = function(ent) if !ent:IsWorld() then return false end end
local traceworld = util.TraceLine(trace)
if traceworld.HitSky then
local Ang = self.Owner:GetAngles()
Ang.pitch = 0
Ang.roll = Ang.roll
Ang.yaw = Ang.yaw - 180
local ent
	local pos
	local tracesensor = {}
    tracesensor.start = playertrace.HitPos
    tracesensor.endpos = tracesensor.start + Vector(0,0,4200)
    tracesensor.filter = function(ent) if !ent:IsWorld() then return false end end
    local traceworldsensor = util.TraceLine(tracesensor)
    if traceworldsensor.HitSky then
	pos = traceworldsensor.HitPos - Vector(0,0,40)
	else
	pos = playertrace.HitPos + Vector(0,0,4000)
	end
	local height = 4200
	self.SensorEnt = ents.Create("prop_dynamic")
	self.SensorEnt:SetPos(pos)
	self.SensorEnt:SetAngles(Ang)
	self.SensorEnt:SetModel("models/gibs/gunship_gibs_sensorarray.mdl")
	self.SensorEnt:Spawn()
	self.SensorEnt:Activate()
	self.SensorEnt.IsSensorEnt = true
	self.SensorEnt.EntHeight = height
	self.SensorEnt:SetMaterial("models/effects/vol_light001")
	if IsValid(self) and IsValid(self.Owner) then
	self.SensorEnt.Caller = self.Owner
	else
	self.SensorEnt.Caller = game:GetWorld()
	end
	self.SensorEnt.BeamDamageCooldown = 0
	if SERVER then
	if IsValid(self.SensorEnt) then
	self.SensorEnt.BeamTurnedOn = true
	end
	local tracebeam = {}
    tracebeam.start = trace.start
    tracebeam.endpos = trace.start - Vector(0,0,90000)
    tracebeam.filter = function(ent) if !ent:IsWorld() then return false end end
    local traceworldbeam = util.TraceLine(tracebeam)
	if traceworldbeam.Hit then
	if game.SinglePlayer() then
	local LaserBeam = EffectData()
	LaserBeam:SetStart(self.SensorEnt:GetPos())
	LaserBeam:SetOrigin(traceworldbeam.HitPos)
	LaserBeam:SetEntity(self.SensorEnt)
	util.Effect("solar_beam",LaserBeam)
	local LaserParticle = EffectData()
	LaserParticle:SetStart(self.SensorEnt:GetPos())
	LaserParticle:SetOrigin(traceworldbeam.HitPos)
	LaserParticle:SetNormal(traceworldbeam.HitNormal)
	LaserParticle:SetEntity(self.SensorEnt)
	util.Effect("solar_beam_particle",LaserParticle)
	else
	timer.Simple(0.002,function()
	if IsValid(self.SensorEnt) then
	local LaserBeam = EffectData()
	LaserBeam:SetStart(self.SensorEnt:GetPos())
	LaserBeam:SetOrigin(traceworldbeam.HitPos)
	LaserBeam:SetEntity(self.SensorEnt)
	util.Effect("solar_beam",LaserBeam)
	local LaserParticle = EffectData()
	LaserParticle:SetStart(self.SensorEnt:GetPos())
	LaserParticle:SetOrigin(traceworldbeam.HitPos)
	LaserParticle:SetNormal(traceworldbeam.HitNormal)
	LaserParticle:SetEntity(self.SensorEnt)
	util.Effect("solar_beam_particle",LaserParticle)
	end
	end)
	end
	self.Target = ents.Create( "info_target" )
	self.Target:SetPos(traceworldbeam.HitPos)
	self.Target:Spawn()
	self.Shake = ents.Create( "env_shake" )
	self.Shake:SetPos( traceworldbeam.HitPos )
	self.Shake:SetKeyValue( "amplitude", "5" )
	self.Shake:SetKeyValue( "radius", "1000" )
	self.Shake:SetKeyValue( "duration", "3" )
	self.Shake:SetKeyValue( "frequency", "255" )
	self.Shake:SetKeyValue( "spawnflags", "4" )
	self.Shake:Spawn()
	self.Shake:Activate()
	self.Shake:Fire( "StartShake", "", 0 )
	self.particle = ents.Create("info_particle_system") -- This used for sound loops -_-
	self.particle:SetAngles(self.Shake:GetAngles())
	self.particle:SetKeyValue("effect_name","")
	self.particle:SetKeyValue("start_active",tostring(1))
	self.particle:Spawn()
	self.particle:Activate()
	self.particle:SetPos(self.Shake:GetPos())
	self.particle:SetParent(self.Shake)
end
end
else
if IsValid(self.SensorEnt) then
self.SensorEnt:Remove()
self.Weapon:SetNextPrimaryFire(CurTime() + 1)
self.Weapon:SetNextSecondaryFire(CurTime() + 1)
end
self.Owner:SendLua("surface.PlaySound('common/wpn_denyselect.wav')")
end
end

function SWEP:PrimaryAttack()
if CLIENT then return end
if self.Owner:WaterLevel() > 1 then return end
self.Weapon:SetNextPrimaryFire(CurTime() + 0.07)
self.Weapon:SetNextSecondaryFire(CurTime() + 0.07)
if !self.FireSound then
self.FireSound = CreateSound(self.Owner,Sound("ambient/fire/fire_big_loop1.wav"))
self.FireSound:PlayEx(1,180)
end
local fire_stream = ents.Create("fire_stream")
fire_stream:SetPos(self.Owner:GetShootPos() + Vector(0,0,-25))
fire_stream:SetAngles(self.Owner:EyeAngles())
fire_stream:Spawn()
fire_stream:SetOwner(self.Owner)
fire_stream:GetPhysicsObject():SetMass(1)
local dir = self.Owner:GetAimVector()*(10000) + VectorRand()*(20^2)
fire_stream:GetPhysicsObject():SetVelocity(dir)
local idx = "fire_stream_vel" .. fire_stream:EntIndex()
timer.Create(idx,0.01,0,function()
if IsValid(fire_stream) and !fire_stream.Hit then
fire_stream:GetPhysicsObject():SetVelocity(dir)
else
timer.Remove(idx)
end
end)
end

function SWEP:SecondaryAttack()
self.Owner:SetAnimation( PLAYER_ATTACK1 )
if CLIENT then return end
self.Weapon:SetNextPrimaryFire(CurTime() + 1)
self.Weapon:SetNextSecondaryFire(CurTime() + 1)
local fireball = ents.Create("firemagic_fireball")
fireball:SetPos(self.Owner:GetShootPos())
fireball:SetAngles(self.Owner:GetAngles())
fireball:Spawn()
fireball:SetOwner(self.Owner)
fireball:GetPhysicsObject():ApplyForceCenter(self.Owner:GetForward()*7000)
SafeRemoveEntityDelayed( fireball, 100 )
self.Owner:EmitSound("fireball_launch.wav",75,100)
end

hook.Add("EntityTakeDamage" , "StopBlastDamageShield" , function(target, dmginfo)
        if shield then return end
        shield = true
        if IsValid(target) and target.HasShield then
		if dmginfo:IsDamageType(DMG_BLAST) then
		dmginfo:SetDamage(0)
		target:TakeDamageInfo(dmginfo)
		end
        end
		shield = false
end)

hook.Add("EntityTakeDamage","SolarBeam_Disslove",function(target,dmginfo)
if IsValid(target) and (target:IsPlayer() or target:IsNPC() or type( target ) == "NextBot") and IsValid(dmginfo:GetInflictor()) and (dmginfo:GetInflictor().IsSensorEnt and string.find(dmginfo:GetInflictor():GetClass(),"prop_dynamic")) and SERVER then
local info = dmginfo:GetDamage()
if target:Health() <= info and !target.BeamAttacked then
target.BeamAttacked = true
if game.SinglePlayer() then
local effectdata = EffectData()
effectdata:SetOrigin(target:GetPos())
effectdata:SetNormal(Vector(0,0,1))
util.Effect( "solarbeam_disslove", effectdata )
else
local pos = target:GetPos()
timer.Simple(0.002,function()
local effectdata = EffectData()
effectdata:SetOrigin(pos)
effectdata:SetNormal(Vector(0,0,1))
util.Effect( "solarbeam_disslove", effectdata )
end)
end
target:SetHealth(0)
for i=1,16 do
local traceline2 = {}
traceline2.start = target:GetPos() + target:GetAngles():Forward()*-15 + Vector(math.Rand(-30,30),math.Rand(-30,30),0)
traceline2.endpos = traceline2.start - Vector(0,0,50)
traceline2.filter = {target}
local trw = util.TraceLine(traceline2)
local decpos1 = trw.HitPos + trw.HitNormal
local decpos2 = trw.HitPos - trw.HitNormal
util.Decal("Dark", decpos1, decpos2) 	
end
if target:IsPlayer() then
target:SetShouldServerRagdoll( true )
end
if target:IsNPC() and GetConVarNumber("ai_serverragdolls") == 0 then
dmginfo:SetDamageForce(Vector(0,0,0))
target:SetRenderMode( 4 )
target:SetColor( Color( 255, 255, 255, 0 ) )
target:Remove()
end
end
end
end)

local function PlyHitBySolarBeam(ply,inflictor,attacker)
if SERVER and IsValid(inflictor) and inflictor.IsSensorEnt then
if IsValid(ply:GetRagdollEntity()) then
local pos = ply:GetPos()
timer.Simple(0.002,function()
local effectdata = EffectData()
effectdata:SetOrigin(pos)
effectdata:SetNormal(Vector(0,0,1))
util.Effect( "solarbeam_disslove", effectdata )
end)
ply:GetRagdollEntity():Remove()
end
end
end
hook.Add("PlayerDeath", "PlyHitBySolarBeam",PlyHitBySolarBeam)

local function removerageffect(ent,ragdoll)
if ent.BeamAttacked and SERVER then
ragdoll:Remove()
end
end
hook.Add("CreateEntityRagdoll", "removerageffect",removerageffect)

function ProtectFireProjectiles(target,dmginfo)
        if protect_fp then return end
        protect_fp = true
        if IsValid(target) and (string.find(target:GetClass(),"fire_stream") or string.find(target:GetClass(),"firemagic_fireball") or string.find(target:GetClass(),"firemagic_fireball_nuke")) then
		dmginfo:SetDamage(0)
		dmginfo:SetDamageForce(Vector(0,0,0))
	    target:TakeDamageInfo(dmginfo)
        end
		if IsValid(target) and target:IsNPC() and !target.IsHitByNuke and dmginfo:GetInflictor().IsFMNuke then
		target.IsHitByNuke = true
		
				local corpsestyle = math.random(0,4)
				if target:IsNPC() and (target:GetClass()=="npc_zombie" or 
				target:GetClass()=="npc_citizen" or
				target:GetClass()=="npc_barney" or
				target:GetClass()=="npc_metropolice" or
				target:GetClass()=="npc_alyx" or
				target:GetClass()=="npc_combine_s" or
				target:GetClass()=="npc_vortigaunt" or
				target:GetClass()=="npc_stalker" or
				target:GetClass()=="npc_eli" or
				target:GetClass()=="npc_gman" or
				target:GetClass()=="npc_monk" or
				target:GetClass()=="npc_mossman" or
				target:GetClass()=="npc_fastzombie" or
				target:GetClass()=="npc_poisonzombie" or
				target:GetClass()=="npc_zombie_torso" or
				target:GetClass()=="npc_fastzombie_torso" or
				target:GetClass()=="npc_magnusson" or
				target:GetClass()=="npc_kleiner" or
				target:GetClass()=="npc_zombine" or
				target:GetClass()=="npc_breen") then
					if (corpsestyle == 0) then
					target:SetModel("models/Humans/Charple01.mdl")
					end				
					if (corpsestyle == 1) then
					target:SetModel("models/Humans/Charple01.mdl")
					end
					if (corpsestyle == 2) then
					target:SetModel("models/Humans/Charple02.mdl")
					end
					if (corpsestyle == 3) then
					target:SetModel("models/Humans/Charple03.mdl")
					end
					if (corpsestyle == 4) then
					target:SetModel("models/Humans/Charple04.mdl")
					end	
				    target:SetHealth(0)
			    end
		end
	    protect_fp = false
end
hook.Add("EntityTakeDamage","ProtectFireProjectiles",ProtectFireProjectiles)

local fire_stream = {}
fire_stream.Type = "anim"
fire_stream.Base = "base_anim"	
fire_stream.Rendergroup = RENDERGROUP_BOTH

function fire_stream:Initialize()	
if SERVER then
self:SetModel( "models/dav0r/hoverball.mdl" )
self.Entity:PhysicsInit( SOLID_VPHYSICS )
self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
self.Entity:SetSolid( SOLID_VPHYSICS )
self.LifeTime = CurTime() + 1
self.StartParticlesTime = 0
local idx = "fire_fix" .. self:EntIndex()
timer.Create(idx,0.04,0,function()
if IsValid(self) then
local effectdata = EffectData()
effectdata:SetOrigin(self:GetPos())
effectdata:SetScale(2)
effectdata:SetEntity(self)
util.Effect("flame_stream_effect",effectdata)
else
timer.Remove(idx)
end
end)
self.StartOnce = false
self:SetNoDraw(true)
local phys = self.Entity:GetPhysicsObject()
if ( IsValid( phys ) ) then
phys:Wake()
phys:AddGameFlag( FVPHYSICS_NO_IMPACT_DMG )
phys:AddGameFlag( FVPHYSICS_NO_NPC_IMPACT_DMG )
phys:SetMaterial("default_silent")
phys:EnableGravity(false)
end
for k,v in pairs(ents.GetAll()) do
if v:GetClass() == self:GetClass() and v != self then
constraint.NoCollide(v,self.Entity,0,0)
end
end
end
end
    
function fire_stream:PhysicsCollide( data, phys )
if self.Hit then return end
self.Hit = true
self:SetNWBool("Hit",true)
local phys = self.Entity:GetPhysicsObject()
if ( IsValid( phys ) ) then
phys:SetMass(1)
phys:SetVelocity(phys:GetVelocity()*0.00001)
end
if data.HitEntity:IsWorld() then
local trace = {}
trace.filter = {self}
data.HitNormal = data.HitNormal * -1
local start = data.HitPos + data.HitNormal
local endpos = data.HitPos - data.HitNormal
util.Decal("Dark",start,endpos)
end
for k,v in pairs(ents.FindInSphere(self:GetPos(),80)) do
if v != self:GetOwner() then
if vFireInstalled then
if (v:IsNPC() or v:IsPlayer() or type(v) == "NextBot" or string.find(v:GetClass(),"prop")) and !v:IsOnFire() then
v:Ignite(5)
end
else
if v:GetClass()=="player" then
v:Ignite( math.random(4,8), 100 )
elseif IsEntity(v) and !v:IsNPC()  and (!v:GetClass()=="player" or (!v:GetModel()=="models/Gibs/HGIBS.mdl" or !v:GetModel()=="models/Gibs/HGIBS_scapula.mdl" or !v:GetModel()=="models/Gibs/HGIBS_spine.mdl" or !v:GetModel()=="models/Gibs/HGIBS_rib.mdl" )) then
v:Ignite( math.random(4,8),100 )
elseif v:IsNPC() then
v:Ignite( math.random(4,8),100 )
elseif type( v ) == "NextBot" then
v:Ignite( math.random(4,8),100 )
elseif v:GetClass()=="prop_physics" and !v.IsChunk then
v:Ignite( math.random(4,8) + 4,100 )
elseif v:GetClass()=="prop_physics_multiplayer" then
v:Ignite( math.random(4,8),100 )
elseif v:GetClass()=="prop_physics_override" then
v:Ignite( math.random(4,8),100 )
elseif v:GetClass()=="prop_physics_respawnable" then
v:Ignite( math.random(4,8),100 )
elseif v:GetClass()=="prop_ragdoll" then
v:Ignite( math.random(4,8) + 4,100 )
elseif v:GetClass()=="prop_vehicle_jeep" then
v:Ignite( math.random(4,8),100 )
elseif v:GetClass()=="prop_vehicle_airboat" then
v:Ignite( math.random(4,8),100 )
elseif v:GetClass()=="prop_vehicle_prisoner_pod" then
v:Ignite( math.random(4,8),100 )
end
end
local dmginfo = DamageInfo()
dmginfo:SetDamage( math.random(4,8) )
dmginfo:SetDamageType( DMG_GENERIC )
dmginfo:SetAttacker( self:GetOwner() )
dmginfo:SetInflictor( self )
dmginfo:SetDamageForce( VectorRand()*10000 )
v:TakeDamageInfo(dmginfo)
end
end
if vFireInstalled then
local newFireEnt = CreateVFire(IsValid(data.HitEntity) and data.HitEntity or game.GetWorld(), data.HitPos, data.HitNormal, 4)
end
if math.random(1,2) < 2 then
self:EmitSound(Sound("ambient/fire/gascan_ignite1.wav"))
end
end

function fire_stream:Think()
if SERVER then
if self.LifeTime < CurTime() then
self:Remove()
end
if self:WaterLevel() > 0 then
SafeRemoveEntity(self)
end
if self.StartParticlesTime < CurTime() and !self.Hit then
end
self.Entity:NextThink( CurTime() )
end
return true
end

scripted_ents.Register( fire_stream, "fire_stream", true )

local fireball = {}
fireball.Type = "anim"
fireball.Base = "base_anim"	
fireball.Rendergroup = RENDERGROUP_BOTH

function fireball:Initialize()	
if SERVER then
self:SetModel( "models/dav0r/hoverball.mdl" )
self.Entity:PhysicsInit( SOLID_VPHYSICS )
self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
self.Entity:SetSolid( SOLID_VPHYSICS )
self:SetNoDraw(true)
if !self.FireSound then
self.FireSound = CreateSound(self,Sound("ambient/fire/fire_big_loop1.wav"))
self.FireSound:SetSoundLevel( 80 )
self.FireSound:PlayEx(1,220)
end
local phys = self.Entity:GetPhysicsObject()
if ( IsValid( phys ) ) then
phys:Wake()
phys:AddGameFlag( FVPHYSICS_NO_IMPACT_DMG )
phys:AddGameFlag( FVPHYSICS_NO_NPC_IMPACT_DMG )
phys:SetMaterial("default_silent")
end
for k,v in pairs(ents.GetAll()) do
if v:GetClass() == self:GetClass() and v != self then
constraint.NoCollide(v,self.Entity,0,0)
end
end
end
ParticleEffectAttach( "spell_fireball_small_red", PATTACH_ABSORIGIN_FOLLOW, self, 1 )
end
    
function fireball:PhysicsCollide( data, phys )
if self.Hit then return end
self.Hit = true
self:SetNWBool("Hit",true)
local phys = self.Entity:GetPhysicsObject()
if ( IsValid( phys ) ) then
phys:SetMass(1)
phys:SetVelocity(phys:GetVelocity()*0.00001)
end
if data.HitEntity:IsWorld() then
local trace = {}
trace.filter = {self}
data.HitNormal = data.HitNormal * -1
local start = data.HitPos + data.HitNormal
local endpos = data.HitPos - data.HitNormal
util.Decal("Scorch",start,endpos)
end
local dmginfo = DamageInfo()
dmginfo:SetDamage( 350 )
dmginfo:SetDamageType( DMG_GENERIC )
dmginfo:SetAttacker( self:GetOwner() )
dmginfo:SetInflictor( self )
util.BlastDamageInfo( dmginfo, self:GetPos(), 350 )
local pos = self:GetPos()
local shouldphys = true
for k,v in pairs(ents.FindInSphere(pos,300)) do
if v:IsNPC() then
shouldphys = false
end
end
if shouldphys then
local physExplo = ents.Create( "env_physexplosion" )
physExplo:SetPos( self:GetPos() )
physExplo:SetKeyValue( "magnitude", "1000" )	-- Power of the Physicsexplosion
physExplo:SetKeyValue( "radius", "350" )	-- Radius of the explosion
physExplo:SetKeyValue( "spawnflags", "1" )
physExplo:Spawn()
physExplo:Fire( "Explode", "", 0 )
end
if vFireInstalled then
for k,v in pairs(ents.FindInSphere(pos,300)) do
if (v:IsNPC() or v:IsPlayer() or type(v) == "NextBot" or string.find(v:GetClass(),"prop")) and !v:IsOnFire() then
v:Ignite(10)
end
end
for i=1,math.random(3,7) do
local newFireEnt = CreateVFire(IsValid(data.HitEntity) and data.HitEntity or game.GetWorld(), data.HitPos + data.HitNormal:Angle():Up()*math.Rand(-25,25) + data.HitNormal:Angle():Right()*math.Rand(-25,25), data.HitNormal, 15)
end
else
timer.Simple(0.05,function()
for k,v in pairs(ents.FindInSphere(pos,300)) do
if v:GetClass()=="player" then
v:Ignite( 15, 100 )
elseif IsEntity(v) and !v:IsNPC()  and (!v:GetClass()=="player" or (!v:GetModel()=="models/Gibs/HGIBS.mdl" or !v:GetModel()=="models/Gibs/HGIBS_scapula.mdl" or !v:GetModel()=="models/Gibs/HGIBS_spine.mdl" or !v:GetModel()=="models/Gibs/HGIBS_rib.mdl" )) then
v:Ignite( 15,100 )
elseif v:IsNPC() then
v:Ignite( 15,100 )
elseif type( v ) == "NextBot" then
v:Ignite( 15,100 )
elseif v:GetClass()=="prop_physics" and !v.IsChunk then
v:Ignite( 15,100 )
elseif v:GetClass()=="prop_physics_multiplayer" then
v:Ignite( 10,100 )
elseif v:GetClass()=="prop_physics_override" then
v:Ignite( 10,100 )
elseif v:GetClass()=="prop_physics_respawnable" then
v:Ignite( 10,100 )
elseif v:GetClass()=="prop_ragdoll" then
v:Ignite( 15,100 )
elseif v:GetClass()=="prop_vehicle_jeep" then
v:Ignite( 15,100 )
elseif v:GetClass()=="prop_vehicle_airboat" then
v:Ignite( 15,100 )
elseif v:GetClass()=="prop_vehicle_prisoner_pod" then
v:Ignite( 15,100 )
end
end
end)
end
local shake = ents.Create( "env_shake" )
shake:SetPos( self:GetPos() )
shake:SetKeyValue( "amplitude", "1000" )
shake:SetKeyValue( "radius", "500" )
shake:SetKeyValue( "duration", "3" )
shake:SetKeyValue( "frequency", "255" )
shake:SetKeyValue( "spawnflags", "4" )
shake:Spawn()
shake:Activate()
shake:Fire( "StartShake", "", 0 )
shake:Fire( "kill", 0, 10 )
ParticleEffect( "asplode_hoodoo", self:GetPos() + Vector(0,0,2),Angle(0,0,0))
self:EmitSound(Sound("fireball_explosion.wav"),90)
self:Remove()
end

function fireball:OnRemove()
if ( self.FireSound ) then 
self.FireSound:ChangeVolume( 0, 0.02 ) 
self.FireSound:Stop() 
self.FireSound = nil
end
end

function fireball:Think()
if SERVER then
if self:WaterLevel() > 0 then
SafeRemoveEntity(self)
end
self.Entity:NextThink( CurTime() )
end
return true
end

scripted_ents.Register( fireball, "firemagic_fireball", true )

local Fireball_Nuke = {}
Fireball_Nuke.Type = "anim"
Fireball_Nuke.Base = "base_anim"
Fireball_Nuke.PrintName		= "Nuke Fireball"
Fireball_Nuke.Author			= "Hds46"
Fireball_Nuke.Information		= "None"
Fireball_Nuke.Category        = "None"

Fireball_Nuke.Editable			= false
Fireball_Nuke.Spawnable			= false
Fireball_Nuke.AdminOnly			= false
Fireball_Nuke.RenderGroup 		= RENDERGROUP_TRANSCULENT

--[[---------------------------------------------------------
   Name: Initialize
-----------------------------------------------------------]]
function Fireball_Nuke:Initialize()

	if ( SERVER ) then
		self:SetModel( "models/dav0r/hoverball.mdl" )
		
		self.Entity:SetMoveType(MOVETYPE_FLY)
		self.Entity:SetGravity(0.2)
		self.Entity:SetSolid(SOLID_VPHYSICS)
		
		self.StartAngle = self:GetAngles()
		
		local phys = self:GetPhysicsObject()
		if (phys:IsValid()) then
	    phys:Wake()
        phys:AddGameFlag( FVPHYSICS_NO_IMPACT_DMG )
        phys:AddGameFlag( FVPHYSICS_NO_NPC_IMPACT_DMG )
        phys:AddGameFlag( FVPHYSICS_PENETRATING )
		end
		self.Active = false
	end
	if ( CLIENT ) then
    self.EffectSize = 10
	self.LaunchTime = CurTime()
	timer.Create("effect_resize" .. self:EntIndex(),0.05,46,function()
	if IsValid(self) then
	self.EffectSize = math.Clamp(self.EffectSize + 1.39130435,10,64)
	end
	end)
	timer.Simple(2.3,function()
	if IsValid(self) then
	self.StopParticlesCharge = true
	end
	end)
	end
end

function Fireball_Nuke:Touch( ent )
if ent:GetMoveType() == 0 and !ent:IsWorld() then return end
if ent:GetMoveType() == 7 and ent:GetClass()=="func_breakable_surf" then return end
local trace = {}
trace.start = self:GetPos() + self:GetForward()
trace.endpos = trace.start + self:GetForward()*90000
trace.filter = self
local tr = util.TraceLine(trace)
if tr.Hit and tr.HitSky then self:Remove() return end
if CLIENT or self.Active then return end
if !game.SinglePlayer() then
for k,v in pairs(player.GetAll()) do
v:SendLua("surface.PlaySound('ambient/explosions/explode_6.wav')")
end
end
self.Active = true
self:StartNuke()
if IsValid(self.wepent) and IsValid(self:GetOwner()) then
self.wepent.NukeCooldown = CurTime() + 15
end
self:Remove()
end

function Fireball_Nuke:StartNuke()
    local pos = self:GetPos()
	-- Nuke
	pointGrav2( pos, 2, pushradius, -900000000 )
	
	immolate( pos, burnradius )				--lights things on fire!  >|:D   (allowigniting has to be set to 1 for this to work)
	-- char_burn( pos, charradius )					--mmmmmmm toasty
	
	local PhysicsEnt = ents.Create("info_target")
	PhysicsEnt:SetPos(pos)
	PhysicsEnt:Spawn()
	PhysicsEnt.IsForPhysics = true
	PhysicsEnt:Fire( "Kill", "", 20 )
	timer.Create("phys_fix" .. PhysicsEnt:EntIndex(),pushtime,10,function()
	pointGrav2( pos, 2, pushradius, -900000000 )
	end)

	local explosion = ents.Create( "env_explosion" )
	explosion:SetKeyValue("spawnflags", "64" )
	explosion:SetKeyValue("iMagnitude", "800" )
	explosion:SetKeyValue("iRadiusOverride", blastradius )
	explosion:SetOwner( self:GetOwner() )
	explosion:SetPos(pos + Vector(0, 0, 8))
	explosion:Spawn()
	explosion.IsFMNuke = true
	explosion:Fire( "Explode", "", 0.6 )

	local explosion2 = ents.Create( "env_explosion" )	--the sole purpose of this explosion is to kill striders
	explosion2:SetKeyValue("spawnflags", "64" )
	explosion2:SetKeyValue("iMagnitude", "800" )
	explosion2:SetKeyValue("iRadiusOverride", blastradius )
	explosion2:SetOwner( self:GetOwner() )
	explosion2:SetPos(pos + Vector(0, 0, 320))
	explosion2:Spawn()
	explosion2.IsFMNuke = true
	explosion2:Fire( "Explode", "", 0.6 )


   local fallout = ents.Create( "point_hurt" )
   fallout:SetKeyValue("targetname", "bomb_hurt" )
   fallout:SetKeyValue("DamageRadius", falloutradius )
   fallout:SetKeyValue("Damage", "9" )
   fallout:SetKeyValue("DamageDelay", "0.3" )
   fallout:SetKeyValue("DamageType", "262144" )
   fallout:SetOwner( self:GetOwner() )
   fallout:SetPos(pos + Vector(0, 0, 96 ))
   fallout:Spawn()
   fallout.IsFMNuke = true
   fallout:Fire( "TurnOn", "", 3 )
   fallout:Fire( "Kill", "", 12 )


	local fireball = ents.Create( "point_hurt" )
	fireball:SetKeyValue("targetname", "bomb_hurt2" )
	fireball:SetKeyValue("DamageRadius", fireballradius )
	fireball:SetKeyValue("Damage", "800" )
	fireball:SetKeyValue("DamageDelay", "0.2" )
	fireball:SetKeyValue("DamageType", "64" )
	fireball:SetOwner( self:GetOwner() )
	fireball:SetPos(pos + Vector(0, 0, 300 ))
	
	fireball:Spawn()
	fireball.IsFMNuke = true
	fireball:Fire( "TurnOn", "", 1.5 )
	fireball:Fire( "Kill", "", 6 )

	local fireball2 = ents.Create( "point_hurt" )
	fireball2:SetKeyValue("targetname", "bomb_hurt3" )
	fireball2:SetKeyValue("DamageRadius", fireballradius )
	fireball2:SetKeyValue("Damage", "800" )
	fireball2:SetKeyValue("DamageDelay", "0.2" )
	fireball2:SetKeyValue("DamageType", "64" )
	fireball2:SetOwner( self:GetOwner() )
	fireball2:SetPos(pos + Vector(0, 0, 8 ))

	fireball2:Spawn()
	fireball2.IsFMNuke = true
	fireball2:Fire( "TurnOn", "", 1.5 )
	fireball2:Fire( "Kill", "", 6 )

    local abomb = ents.Create( "env_fade")
    abomb:SetKeyValue("targetname", "bomb_flash2")
    abomb:SetKeyValue("duration", "0.1" )
    abomb:SetKeyValue("holdtime", "2" )
    abomb:SetKeyValue("renderamt", "250" )
    abomb:SetKeyValue("rendercolor", "255 255 240" )
    abomb:SetKeyValue("spawnflags", "0" )
    abomb:SetPos(pos + Vector(-1.5, 0, 176))
	
	
	abomb:SetKeyValue("color", "255 255 180" )
	abomb:SetKeyValue("visgroupshown", "1" )
	abomb:SetKeyValue("visgroupautoshown", "1" )
	abomb:Spawn()

    abomb:SetKeyValue("id", "838")
	abomb:Fire( "Fade", "", 0 )
    abomb:Fire( "Kill", "", 0.5 )

   local abomb2 = ents.Create( "env_fade")
   abomb2:SetKeyValue("targetname", "bomb_flash")
   abomb2:SetKeyValue("duration", "4" )
   abomb2:SetKeyValue("holdtime", "0.6" )
   abomb2:SetKeyValue("renderamt", "240" )
   abomb2:SetKeyValue("rendercolor", "255 255 227" )
   abomb2:SetKeyValue("spawnflags", "1" )
   abomb2:SetPos(pos + Vector(-1.5, 0, 176))
	
   abomb2:SetKeyValue("color", "255 255 155" )
   abomb2:SetKeyValue("visgroupshown", "1" )
   abomb2:SetKeyValue("visgroupautoshown", "1" )
   abomb2:Spawn()
   abomb2:Fire( "Fade", "", 0.5 )
   abomb2:Fire( "Kill", "", 14 )


   abomb2:SetKeyValue("id", "837")

   local abomb3 = ents.Create( "env_shake")
   abomb3:SetKeyValue("targetname", "bomb_shake")
   abomb3:SetKeyValue("amplitude", "14" )
   abomb3:SetKeyValue("radius", "20000" )
   abomb3:SetKeyValue("duration", "7.3")
   abomb3:SetKeyValue("frequency", "100" )
   abomb3:SetKeyValue("spawnflags", "8" )
   abomb3:SetPos(pos + Vector(-1.5, 0, 352 ))

   abomb3:Spawn()
   abomb3:Fire( "StartShake", "", 1 )
   abomb3:Fire( "Kill", "", 6.5 )
   
    if (lowFX==1) then   
    self:createGlow(pos, 0, 0, 0, 255, 240, 210, 16, 37, 3000, 3000, 0, 1.8, 0, 0, 1024)
    self:createGlow(pos, 0, 0, 0, 255, 235, 205, 12, 42, 3000, 3000, 0, 1.5, 0, 0, 192)
    self:createGlow(pos, 0, 0, 0, 250, 230, 200, 800, 250, 100, 100, yieldslowest*6800, 5.0, 0, 0, 96)
	end
    if (lowFX==0) then
    self:createGlow(pos, 0, 0, 0, 230, 255, 210, 14, 35, 2800, 2800, 99999, 1.2, 0, 0, 1280)
    self:createGlow(pos, 0, 0, 0, 230, 255, 210, 14, 64, 2800, 2800, 99999, 1.0, 0, 0, 128)
    self:createGlow(pos, 0, 0, 0, 230, 230, 180, 25, 14, 2800, 2800, 99999, 0.8, 0, 0, 512)
    self:createGlow(pos, 0, 0, 0, 250, 230, 200, 800, 250, 100, 100, yieldslowest*6800, 5.0, 0, 0, 148)
    self:createGlow(pos, 0, 0, 0, 250, 30, 10, 80, 140, 2800, 2800, 99999, 0.2, 0, 0, 786)
	end
	if (allowsmokerings == 1) then
	self:CreateSmokeRing(pos, 0, 0, 0, -96, -1, 624, 200, 200, 200)
	self:CreateSmokeRing(pos, 0, 0, 0, 96, 1, 624, 200, 200, 200)
	end
	if (lowFX==0) then
	self:CreateSmokeHead(pos, 0, 600, 0, 0, 0, 0, 1072, 200, 200, 200)
	self:CreateSmokeHead(pos, -0, 600, 0, 0, 0, 0, 1072, 200, 200, 200)
	self:CreateSmokeHead(pos, 0, 850, 0, 0, 0, 0, 1136, 200, 200, 200)
	self:CreateSmokeHead(pos, -0, 850, 0, 0, 0, 0, 1136, 200, 200, 200)
	self:CreateSmokeHead(pos, 0, 600, 0, 0, 0, 0, 1200, 200, 200, 200)
	self:CreateSmokeHead(pos, -0, 600, 0, 0, 0, 0, 1200, 200, 200, 200)
	self:CreateSmokeHead(pos, 0, 180, 0, 0, 0, 0, 1272, 200, 200, 200)
	self:CreateSmokeHead(pos, -0, 180, 0, 0, 0, 0, 1272, 200, 200, 200)
	self:CreateSmokeHead(pos, 0, 30, 0, 0, 0, 0, 1372, 200, 200, 200)
	self:CreateSmokeHead(pos, -0, 30, 0, 0, 0, 0, 1372, 200, 200, 200)
	else
	self:CreateSmokeHead(pos, 0, 850, 0, 0, 0, 0, 1072, 200, 200, 200)
	self:CreateSmokeHead(pos, -0, 850, 0, 0, 0, 0, 1072, 200, 200, 200)
	self:CreateSmokeHead(pos, 0, 180, 0, 0, 0, 0, 1172, 200, 200, 200)
	self:CreateSmokeHead(pos, -0, 180, 0, 0, 0, 0, 1172, 200, 200, 200)
	self:CreateSmokeHead(pos, 0, 30, 0, 0, 0, 0, 1272, 200, 200, 200)
	self:CreateSmokeHead(pos, -0, 30, 0, 0, 0, 0, 1272, 200, 200, 200)
	end
	self:CreateSmokeStalk(pos, 0, 300, 0, 0, 0, 0, 112, 137, 130, 125)
	self:CreateSmokeStalk(pos, -0, 260, 0, 0, 0, 0, 176, 137, 130, 125)
	self:CreateSmokeStalk(pos, 0, 220, 0, 0, 0, 0, 240, 137, 130, 125)
	self:CreateSmokeStalk(pos, -0, 180, 0, 0, 0, 0, 304, 137, 130, 125)
	self:CreateSmokeStalk(pos, 0, 140, 0, 0, 0, 0, 368, 137, 130, 125)
	self:CreateSmokeStalk(pos, -0, 100, 0, 0, 0, 0, 432, 137, 130, 125)
	self:CreateSmokeStalk(pos, 0, 80, 0, 0, 0, 0, 496, 137, 130, 125)
	self:CreateSmokeStalk(pos, -0, 60, 0, 0, 0, 0, 560, 137, 130, 125)
	self:CreateSmokeStalk(pos, 0, 35, 0, 0, 0, 0, 624, 137, 130, 125)
	self:CreateSmokeStalk(pos, -0, 35, 0, 0, 0, 0, 688, 137, 130, 125)
	self:CreateSmokeStalk(pos, 0, 60, 0, 0, 0, 0, 752, 137, 130, 125)
	self:CreateSmokeStalk(pos, -0, 0, 0, 0, 0, 0, 816, 137, 130, 125)
	self:CreateSmokeStalk(pos, 0, 120, 0, 0, 0, 0, 880, 137, 130, 125)
	self:CreateSmokeStalk(pos, -0, 160, 0, 0, 0, 0, 944, 137, 130, 125)
	self:CreateSmokeStalk(pos, 0, 200, 0, 0, 0, 0, 1008, 137, 130, 125)
	self:CreateSmokeStalk(pos, -0, 240, 0, 0, 0, 0, 1072, 137, 130, 125)
	if (lowFX==0) then	
	self:CreateSmokeBase(pos, 0, 700, 0, 0, 0, 0, 0, 137, 130, 125)
	self:CreateSmokeBase(pos, -0, 700, 0, 0, 0, 0, 0, 137, 130, 125)
	self:CreateSmokeBase(pos, 0, 600, 0, 0, 0, 0, 32, 137, 130, 125)
	self:CreateSmokeBase(pos, -0, 600, 0, 0, 0, 0, 32, 137, 130, 125)
	self:CreateSmokeBase(pos, 0, 500, 0, 0, 0, 0, 64, 137, 130, 125)
	self:CreateSmokeBase(pos, -0, 500, 0, 0, 0, 0, 64, 137, 130, 125)
	self:CreateSmokeBase(pos, 0, 450, 0, 0, 0, 0, 96, 137, 130, 125)
	self:CreateSmokeBase(pos, -0, 450, 0, 0, 0, 0, 96, 137, 130, 125)
	self:CreateSmokeBase(pos, 0, 250, 0, 0, 0, 0, 128, 137, 130, 125)
	self:CreateSmokeBase(pos, -0, 250, 0, 0, 0, 0, 128, 137, 130, 125)
	else
	self:CreateSmokeBase(pos, 0, 600, 0, 0, 0, 0, 0, 137, 130, 125)
	self:CreateSmokeBase(pos, -0, 600, 0, 0, 0, 0, 0, 137, 130, 125)
	self:CreateSmokeBase(pos, 0, 500, 0, 0, 0, 0, 38, 137, 130, 125)
	self:CreateSmokeBase(pos, -0, 500, 0, 0, 0, 0, 38, 137, 130, 125)
	self:CreateSmokeBase(pos, 0, 400, 0, 0, 0, 0, 70, 137, 130, 125)
	self:CreateSmokeBase(pos, -0, 400, 0, 0, 0, 0, 70, 137, 130, 125)
	self:CreateSmokeBase(pos, 0, 350, 0, 0, 0, 0, 112, 137, 130, 125)
	self:CreateSmokeBase(pos, -0, 350, 0, 0, 0, 0, 112, 137, 130, 125)
	end

	if (allowfires == 1) then	
	for i=1,3 do
	self:createFire(pos)
	self:createFire(pos)
	self:createFire(pos)
	self:createFire(pos)
	self:createFire(pos)
	self:createFire(pos)
	self:createFire(pos)
	self:createFire(pos)
	self:createFire(pos)
	end
	end
	sound.Play( "ambient/explosions/explode_6.wav" , self:GetPos(), 140, 100, 1 )
end

if CLIENT then
local FireRate = 0.03
function Fireball_Nuke:Draw()
self.NextSmoke = self.NextSmoke or CurTime() + FireRate
if self.NextSmoke < CurTime() then
local Pos = self.Entity:GetPos()
local emitter = ParticleEmitter(Pos)	
local particle = emitter:Add("sprites/flamelet"..math.random(1,5),Pos + self:OBBCenter())
particle:SetVelocity(VectorRand()*10)
particle:SetDieTime(1)
particle:SetStartSize(self.EffectSize)
particle:SetEndSize(0)
particle:SetStartAlpha(255)
particle:SetEndAlpha(0)
particle:SetRoll(math.Rand(-2,2))
particle:SetRollDelta(math.Rand(-2,2))
emitter:Finish()
local pos = self.Entity:GetPos() + self:OBBCenter()
local particle_time = ( CurTime() - self.LaunchTime ) / 13.37
local dir = VectorRand():GetNormalized()
local speed = 50 + 300 * particle_time * particle_time
local dist = math.Rand( 56, 78 )
local emitter = ParticleEmitter(Pos)
if !self.StopParticlesCharge then
local particle = emitter:Add( "sprites/flamelet"..math.random(1,5), pos + dir * dist )
particle:SetVelocity( dir * -speed + self:GetVelocity() + Vector(0,0,-10) )
particle:SetDieTime( dist / speed )
particle:SetStartAlpha( 0 )
particle:SetEndAlpha( 100 + 155 * particle_time * particle_time )
particle:SetStartSize( math.Rand( 10, 20 ) )
particle:SetEndSize( 1 )
particle:SetRoll( math.Rand( -180, 180 ) )
particle:SetRollDelta( math.Rand(-1,1) )
emitter:Finish()
end
self.NextSmoke = CurTime() + FireRate
end
end
end

function Fireball_Nuke:Use( activator, caller )
end

function Fireball_Nuke:OnRemove()
if ( self.FireSound ) then 
self.FireSound:ChangeVolume( 0, 0.02 ) 
self.FireSound:Stop() 
self.FireSound = nil
end
end

function Fireball_Nuke:Think()
if CLIENT then return end
if self.WorldCheck and !self:IsInWorld() then
self:Remove()
return
end
self.Entity:NextThink( CurTime() + 0.2 )
return true
end

function Fireball_Nuke:CreateSmoke(start, angX, angY, angZ, BaseSpread, SpreadSpeed, Speed, startsize, EndSize, Rate, JetLength, WindAngle, WindSpeed, twist, Red, Green, Blue, renderamt, posX, posY, posZ)
	local abomb_smoke = ents.Create( "env_smokestack") --name of entity being spawned
	abomb_smoke:SetAngles( Angle(angX, angY, angZ)) --angles smoke is rotated by (smoke naturally forms in semicircles)
	
	abomb_smoke:SetKeyValue("InitialState", "0" )
	abomb_smoke:SetKeyValue("BaseSpread", BaseSpread ) --starting "puffiness" of the smoke
	abomb_smoke:SetKeyValue("SpreadSpeed", SpreadSpeed ) --how fast smoke puffs outwards
	abomb_smoke:SetKeyValue("Speed", Speed ) --how fast smoke moves upwards; divide JetLength by this value to get how long it takes for the smoke to dissapear (in seconds).  If the smoke is not killed, it will keep reapearing and dissapearing indefinately.
	abomb_smoke:SetKeyValue("startsize", startsize ) --starting size of each individual smoke particle
	abomb_smoke:SetKeyValue("EndSize", EndSize ) --ending size of each individual smoke particle
	abomb_smoke:SetKeyValue("Rate", Rate ) --rate at which individual smoke particles are spawned
	abomb_smoke:SetKeyValue("JetLength", JetLength ) --how high the smoke has to climb before it dissapears
	abomb_smoke:SetKeyValue("WindAngle", WindAngle ) --self explanitory
	abomb_smoke:SetKeyValue("WindSpeed", WindSpeed ) --self explanitory;  best to keep this at a low value 
	abomb_smoke:SetKeyValue("SmokeMaterial", "particle/SmokeStack.vmt" ) --smoke texture.  I haven't tried anything else, but different textures might work.
	abomb_smoke:SetKeyValue("twist", twist ) --speed at which the smoke turns horizontally
	abomb_smoke:SetKeyValue("roll", "0" ) --doesn't seem to do anything
	abomb_smoke:SetKeyValue("rendercolor", ""..Red.." "..Green.." "..Blue.."") --self explanitory
	abomb_smoke:SetKeyValue("renderamt", renderamt ) --transparency of the smoke
    abomb_smoke:SetKeyValue("targetname", "abomb_smoke") --name this entity is referred to
	abomb_smoke:SetPos(start + Vector(yieldmoderate*posX, yieldmoderate*posY, yieldmoderate*posZ)) --position of this particular smoke band in the blast
	
	abomb_smoke:SetKeyValue("color", "255 255 255" ) --probably not needed

  abomb_smoke:Spawn()
  abomb_smoke:Fire( "TurnOn", "", 0 )
  abomb_smoke:Fire( "Kill", "", 21.5 )
end
--Chuck Norris makes porn of himself watching himself make porn of himself and then watches it
function Fireball_Nuke:CreateSmokeRing(start, angX, angY, angZ, posX, posY, posZ, Red, Green, Blue)
    local abomb_smoke2 =	ents.Create( "env_smokestack")
	abomb_smoke2:SetAngles( Angle(angX, angY, angZ))

   abomb_smoke2:SetKeyValue("InitialState", "0" )
   abomb_smoke2:SetKeyValue("BaseSpread", BaseSpreadRingMultiplier*"500" )
   abomb_smoke2:SetKeyValue("SpreadSpeed", SpreadSpeedRingMultiplier*"13" )
   abomb_smoke2:SetKeyValue("Speed", SpeedRingMultiplier*"22.8" )
   abomb_smoke2:SetKeyValue("startsize", startsizeRingMultiplier*"112" )
   abomb_smoke2:SetKeyValue("EndSize", EndSizeRingMultiplier*"121" )
   abomb_smoke2:SetKeyValue("Rate", RateRingMultiplier*"70" )
   abomb_smoke2:SetKeyValue("JetLength", JetLengthRingMultiplier*"594" )
   abomb_smoke2:SetKeyValue("WindAngle", WindAngleRingMultiplier*"-195" )
   abomb_smoke2:SetKeyValue("WindSpeed", WindSpeedRingMultiplier*"0.7" )
   abomb_smoke2:SetKeyValue("SmokeMaterial", "particle/SmokeStack.vmt" )
   abomb_smoke2:SetKeyValue("twist", "0" )
   abomb_smoke2:SetKeyValue("roll", "0" )
   abomb_smoke2:SetKeyValue("rendercolor", ""..Red.." "..Green.." "..Blue.."")
   abomb_smoke2:SetKeyValue("renderamt", renderamtRingMultiplier*"210" )
   abomb_smoke2:SetKeyValue("targetname", "abomb_smoke")
   abomb_smoke2:SetPos(start + Vector(yieldmoderate*posX, yieldmoderate*posY, yieldmoderate*posZ))
	
   abomb_smoke2:SetKeyValue("color", "220 220 220" )

   abomb_smoke2:Spawn()
   abomb_smoke2:Fire( "TurnOn", "", 0 )
   abomb_smoke2:Fire( "TurnOff", "", 15 )
   abomb_smoke2:Fire( "Kill", "", 21.5 )
end

function Fireball_Nuke:CreateSmokeHead(start, angX, BaseSpread, angY, angZ, posX, posY, posZ, Red, Green, Blue)
	local abomb_smoke3 =	ents.Create( "env_smokestack")
	abomb_smoke3:SetAngles(Angle(angX, angY, angZ))
	
	local bSpread = BaseSpreadHeadMultiplier*BaseSpread
	
   abomb_smoke3:SetKeyValue("InitialState", "0" )
   abomb_smoke3:SetKeyValue("BaseSpread", bSpread )
   abomb_smoke3:SetKeyValue("SpreadSpeed", SpreadSpeedHeadMultiplier*"36" )
   abomb_smoke3:SetKeyValue("Speed", SpeedHeadMultiplier*"22" )
   abomb_smoke3:SetKeyValue("startsize", startsizeHeadMultiplier*"75" )
   abomb_smoke3:SetKeyValue("EndSize", EndSizeHeadMultiplier*"111" )
   abomb_smoke3:SetKeyValue("Rate", RateHeadMultiplier*"60" )
   abomb_smoke3:SetKeyValue("JetLength", JetLengthHeadMultiplier*"581" )
   abomb_smoke3:SetKeyValue("WindAngle", WindAngleHeadMultiplier*math.random(-180,180))
   abomb_smoke3:SetKeyValue("WindSpeed", WindSpeedHeadMultiplier*"0.7" )
   abomb_smoke3:SetKeyValue("SmokeMaterial", "particle/SmokeStack.vmt" )
   abomb_smoke3:SetKeyValue("twist", "0" )
   abomb_smoke3:SetKeyValue("roll", "0" )
   abomb_smoke3:SetKeyValue("rendercolor", ""..Red.." "..Green.." "..Blue.."")
   abomb_smoke3:SetKeyValue("renderamt", renderamtHeadMultiplier*"200" )
   abomb_smoke3:SetKeyValue("targetname", "abomb_smoke")
   abomb_smoke3:SetPos(start + Vector(yieldmoderate*posX, yieldmoderate*posY, yieldmoderate*posZ ))
	
   abomb_smoke3:SetKeyValue("color", "255 255 255" )

   abomb_smoke3:Spawn()
   abomb_smoke3:Fire( "TurnOn", "", 0 )
   abomb_smoke3:Fire( "TurnOff", "", 15 )
   abomb_smoke3:Fire( "Kill", "", 21.5 )
end
 
function Fireball_Nuke:CreateSmokeStalk(start, angX, BaseSpread, angY, angZ, posX, posY, posZ, Red, Green, Blue)
 	local abomb_smoke4 =	ents.Create( "env_smokestack")
	abomb_smoke4:SetAngles( Angle(angX, angY, angZ))
	
	local bSpread = BaseSpreadStalkMultiplier*BaseSpread
	
   abomb_smoke4:SetKeyValue("InitialState", "0" )
   abomb_smoke4:SetKeyValue("BaseSpread", bSpread )
   abomb_smoke4:SetKeyValue("SpreadSpeed", SpreadSpeedStalkMultiplier*"18" )
   abomb_smoke4:SetKeyValue("Speed", SpeedStalkMultiplier*"12.67" )
   abomb_smoke4:SetKeyValue("startsize", startsizeStalkMultiplier*"75" )
   abomb_smoke4:SetKeyValue("EndSize", EndSizeStalkMultiplier*"80" )
   abomb_smoke4:SetKeyValue("Rate", RateStalkMultiplier*"40" )
   abomb_smoke4:SetKeyValue("JetLength", JetLengthStalkMultiplier*"330" )
   abomb_smoke4:SetKeyValue("WindAngle", WindAngleStalkMultiplier*math.random(-180,180))
   abomb_smoke4:SetKeyValue("WindSpeed", WindSpeedStalkMultiplier*"0.7" )
   abomb_smoke4:SetKeyValue("SmokeMaterial", "particle/SmokeStack.vmt" )
   abomb_smoke4:SetKeyValue("twist", "0" )
   abomb_smoke4:SetKeyValue("roll", "0" )
   abomb_smoke4:SetKeyValue("rendercolor", ""..Red.." "..Green.." "..Blue.."")
   abomb_smoke4:SetKeyValue("renderamt", renderamtStalkMultiplier*"200" )
   abomb_smoke4:SetKeyValue("targetname", "abomb_smoke")
   abomb_smoke4:SetPos(start + Vector(yieldmoderate*posX, yieldmoderate*posY, yieldmoderate*posZ))
	
  abomb_smoke4:SetKeyValue("color", "255 255 255" )

  abomb_smoke4:Spawn()
  abomb_smoke4:Fire( "TurnOn", "", 0 )
  abomb_smoke4:Fire( "TurnOff", "", 15 )
  abomb_smoke4:Fire( "Kill", "", 21.5 )
end	

function Fireball_Nuke:CreateSmokeBase(start, angX, BaseSpread, angY, angZ, posX, posY, posZ, Red, Green, Blue)
	local abomb_smoke5 =	ents.Create( "env_smokestack")
	abomb_smoke5:SetAngles(Angle(angX, angY, angZ))
	
	local bSpread = BaseSpreadBaseMultiplier*BaseSpread
	
   abomb_smoke5:SetKeyValue("InitialState", "0" )
   abomb_smoke5:SetKeyValue("BaseSpread", bSpread )
   abomb_smoke5:SetKeyValue("SpreadSpeed", SpreadSpeedBaseMultiplier*"36" )
   abomb_smoke5:SetKeyValue("Speed", SpeedBaseMultiplier*"6.67" )
   abomb_smoke5:SetKeyValue("startsize", startsizeBaseMultiplier*"120" )
   abomb_smoke5:SetKeyValue("EndSize", EndSizeBaseMultiplier*"180" )
   abomb_smoke5:SetKeyValue("Rate", RateBaseMultiplier*"40" )
   abomb_smoke5:SetKeyValue("JetLength", JetLengthBaseMultiplier*"170.5" )
   abomb_smoke5:SetKeyValue("WindAngle", WindAngleBaseMultiplier*math.random(-180,180))
   abomb_smoke5:SetKeyValue("WindSpeed", WindSpeedBaseMultiplier*"0.7" )
   abomb_smoke5:SetKeyValue("SmokeMaterial", "particle/SmokeStack.vmt" )
   abomb_smoke5:SetKeyValue("twist", "0" )
   abomb_smoke5:SetKeyValue("roll", "0" )
   abomb_smoke5:SetKeyValue("rendercolor", ""..Red.." "..Green.." "..Blue.."")
   abomb_smoke5:SetKeyValue("renderamt", renderamtBaseMultiplier*"200" )
   abomb_smoke5:SetKeyValue("targetname", "abomb_smoke")
   abomb_smoke5:SetPos(start + Vector(yieldmoderate*posX, yieldmoderate*posY, yieldmoderate*posZ))
	
   abomb_smoke5:SetKeyValue("color", "255 255 255" )

   abomb_smoke5:Spawn()
   abomb_smoke5:Fire( "TurnOn", "", 0 )
   abomb_smoke5:Fire( "TurnOff", "", 15 )
   abomb_smoke5:Fire( "Kill", "", 21.5 )
end


function Fireball_Nuke:createSmokeTrail( start, angX, angY, angZ, spawnradius, startsize, endsize, lifetime, spawnrate, opacity, minspeed, maxspeed, posX, posY, posZ, startR, startG, startB, endR, endB, endG )
local trail_parent =	ents.Create( "env_smokestack")
trail_parent:SetAngles(Angle(0, 0, 0))
	

trail_parent:SetKeyValue("InitialState", "0" )
trail_parent:SetKeyValue("BaseSpread", "10" )
trail_parent:SetKeyValue("SpreadSpeed", "1" )
trail_parent:SetKeyValue("Speed", SpeedHeadMultiplier*"33" )
trail_parent:SetKeyValue("startsize", "10" )
trail_parent:SetKeyValue("EndSize", "10" )
trail_parent:SetKeyValue("Rate", "30" )
trail_parent:SetKeyValue("JetLength", JetLengthHeadMultiplier*"528" )
trail_parent:SetKeyValue("WindAngle", WindAngleHeadMultiplier*math.random(-180,180))
trail_parent:SetKeyValue("WindSpeed", WindSpeedHeadMultiplier*"0.7" )
trail_parent:SetKeyValue("SmokeMaterial", "particle/SmokeStack.vmt" )
trail_parent:SetKeyValue("twist", "0" )
trail_parent:SetKeyValue("roll", "0" )
trail_parent:SetKeyValue("rendercolor", "255, 255, 255")
trail_parent:SetKeyValue("renderamt", "0" )
trail_parent:SetKeyValue("targetname", "trail_parent")
trail_parent:SetPos(start + Vector(yieldmoderate*posX, yieldmoderate*posY, yieldmoderate*posZ ))
	
trail_parent:SetKeyValue("color", "255 255 255" )

trail_parent:Spawn()



local smoketrail = ents.Create( "env_smoketrail" )
smoketrail:SetAngles(  Angle(angX, angY, angZ))
smoketrail:SetKeyValue( "smokesprite", "sprites/whitepuff.spr")
smoketrail:SetKeyValue( "firesprite","sprites/firetrail.spr" )
smoketrail:SetKeyValue( "spawnradius", spawnradius )
smoketrail:SetKeyValue( "startsize", startsize )
smoketrail:SetKeyValue( "endsize", endsize )
smoketrail:SetKeyValue( "startcolor",""..startR.." "..startG.." "..startB.."" )
smoketrail:SetKeyValue( "endcolor",""..endR.." "..endG.." "..endB.."" )
smoketrail:SetKeyValue( "lifetime", lifetime )
smoketrail:SetKeyValue( "spawnrate", spawnrate )
smoketrail:SetKeyValue( "opacity", opacity )
smoketrail:SetKeyValue( "minspeed", minspeed )
smoketrail:SetKeyValue( "maxspeed", maxspeed )
smoketrail:SetKeyValue(  "targetname", "smoketrail")
smoketrail:SetPos(start + Vector(yieldmoderate*posX, yieldmoderate*posY, yieldmoderate*posZ ))

smoketrail:SetKeyValue("color", "255 255 255" )

smoketrail:SetParent(trail_parent)
smoketrail:Spawn()
end

function Fireball_Nuke:createGlow(start, angX, angY, angZ, Red, Green, Blue, Vsize, Hsize, MinDist, MaxDist, Omaxdist, GlowSize, posX, posY, posZ)
		local RadioactiveGlow = ents.Create("env_lightglow")
		RadioactiveGlow:SetKeyValue("angles" , ""..angX.." "..angY.." "..angZ.."")
		RadioactiveGlow:SetKeyValue("rendercolor" , ""..Red.." "..Green.." "..Blue.."")
		local Vize = yieldslowest*Vsize
		local Hize = yieldslowest*Hsize
		RadioactiveGlow:SetKeyValue("VerticalGlowSize" , Vize)			
		RadioactiveGlow:SetKeyValue("HorizontalGlowSize" , Hize)
		RadioactiveGlow:SetKeyValue("MinDist" , MinDist)
		RadioactiveGlow:SetKeyValue("MaxDist" , MaxDist)
		RadioactiveGlow:SetKeyValue("OuterMaxDist" , Omaxdist)
		local Gsize = yieldslow*GlowSize
		RadioactiveGlow:SetKeyValue("HDRColorScale", "3")
		RadioactiveGlow:SetKeyValue("GlowProxySize" , Gsize)
		RadioactiveGlow:SetKeyValue("targetname" , "RadioactiveGlow")
		RadioactiveGlow:SetPos(start + Vector(yieldmoderate*posX, yieldmoderate*posY, yieldmoderate*posZ ))
		RadioactiveGlow:Spawn()
		RadioactiveGlow:Fire( "Kill", "", 15 )
end

function Fireball_Nuke:createFire(start)
	local startpos = start + Vector(math.random(-2000,2000), math.random(-2000,2000), 50 )
	local traceworld = {}
	traceworld.start = startpos
	traceworld.endpos = traceworld.start - Vector(0,0,400)
	traceworld.fliter = function(ent) if !ent:IsWorld() then return false end end
	traceworld.mask = MASK_SOLID_BRUSHONLY
	local trw = util.TraceLine(traceworld)
	if !trw.HitWorld  then 
	return
	end
	if vFireInstalled then
	for i=1,5 do
	local newFireEnt = CreateVFire(IsValid(trw.HitEntity) and trw.HitEntity or game.GetWorld(), trw.HitPos, trw.HitNormal, 30)
	end
	else
    local fireent = ents.Create( "env_fire" )
    fireent:SetKeyValue("StartDisabled", "0" )
    fireent:SetKeyValue("health", math.random(11,15))
    fireent:SetKeyValue("firesize", math.random(102,192))
    fireent:SetKeyValue("fireattack", "2.5" )
    fireent:SetKeyValue("firetype", "Normal" )
    fireent:SetKeyValue("ignitionpoint", "999" )  -- set this value low to allow fire spreading! :D
    fireent:SetKeyValue("damagescale", "15" )
    fireent:SetKeyValue("spawnflags", 2 + 128 )
    fireent:SetPos(trw.HitPos)
    fireent:SetKeyValue("targetname", "fire")
    fireent:Spawn()
	fireent:Fire( "StartFire", "", 2.6 )
	fireent:Fire( "Kill", "", 19 )
	end
end

scripted_ents.Register( Fireball_Nuke, "firemagic_fireball_nuke", true )

/*---------------------------------------------------------
	Flame Stream effect
---------------------------------------------------------*/
if CLIENT then
local EFFECT={}
    
function EFFECT:Init( data )
self.Origin = data:GetOrigin()
self.Scale = data:GetScale()
self.Ent = data:GetEntity()
for i=1,2 do
local em = ParticleEmitter( self.Origin )
local particle = em:Add( "particle/newfire" .. math.random(1,6), self.Origin  )
particle:SetVelocity(VectorRand()*50)
particle:SetDieTime(1)
particle:SetStartAlpha(255)
particle:SetEndAlpha(0)
local matrand = math.random(30,50)
particle:SetStartSize(matrand)
particle:SetEndSize( matrand + 5 )
particle:SetRoll( math.Rand( -255,255  ) )
particle:SetRollDelta(math.Rand( -10, 10 ))
if math.random(1,2) < 2 then
particle:SetColor( 255, 191, 0 )
else
particle:SetColor( 255, 255, 255 )
end
particle:SetCollide( true )
particle:SetBounce( 0.05 )   
particle:SetAirResistance( 8 )
em:Finish()
end
end
	
function EFFECT:Think( )
return false 
end
   
function EFFECT:Render() 
end
	
effects.Register(EFFECT,"flame_stream_effect")

/*---------------------------------------------------------
	Solar Beam effect
---------------------------------------------------------*/

local sparks = Material("effects/spark")
local solarmuzzle = Material("effects/splashwake1")
local solarmuzzle2 = Material("effects/yellowflare")
local solarbeam = Material( "effects/solarbeam" )
local solarbeam2 = Material( "Effects/blueblacklargebeam" )
local glow = CreateMaterial("glow01", "UnlitGeneric", {["$basetexture"] = "sprites/light_glow02", ["$spriterendermode"] = 3, ["$illumfactor"] = 8, ["$additive"] = 1, ["$vertexcolor"] = 1, ["$vertexalpha"] = 1})
local glow2 = Material( "particle/particle_glow_04_additive" )

local EFFECT={}


function EFFECT:Init(data)
self.ParentEntity = data:GetEntity()
self.BeamWidth = 20
self.BeamSpriteSize = 80
self.MinSize = 500
self.MinSize2 = 480
end

function EFFECT:Think()
if self.ParentEntity != NULL then
self.StartPos = self.ParentEntity:GetPos()
local tracebeam = {}
tracebeam.start = self.StartPos
tracebeam.endpos = tracebeam.start - Vector(0,0,90000)
tracebeam.filter = function(ent) if !ent:IsWorld() then return false end end
local traceworldbeam = util.TraceLine(tracebeam)
self.Orig = traceworldbeam.HitPos
self:SetRenderBoundsWS(self.StartPos + Vector(0,0,90000), self.Orig + Vector(0,0,-90000))
end
if !IsValid(self.ParentEntity) then return false end
return true
end

function EFFECT:Render( )
if self.ParentEntity == NULL then return end
self.StartPos = self.ParentEntity:GetPos()
local tracebeam = {}
tracebeam.start = self.StartPos
tracebeam.endpos = tracebeam.start - Vector(0,0,90000)
tracebeam.filter = function(ent) if !ent:IsWorld() then return false end end
local traceworldbeam = util.TraceLine(tracebeam)
self.Orig = traceworldbeam.HitPos
self:SetRenderBoundsWS(self.StartPos + Vector(0,0,90000), self.Orig + Vector(0,0,-90000))

self.BeamDistance = (self.StartPos - self.Orig):Length()


local start_pos = self.StartPos
local end_pos = self.Orig
local dir = ( end_pos - start_pos );
local mindist = math.Clamp(self.MinSize + dir:Length()/8,500,500)
local mindist2 = math.Clamp(self.MinSize2 + dir:Length()/8,480,480)
local maxdist = math.Clamp(dir:Length()/200,2,15)
local increment = dir:Length()  / (tonumber(LocalPlayer():GetInfo("mp_beam_length") or 8.95));
dir:Normalize();
 
// set material
render.SetMaterial( solarbeam2 )
 
// start the beam with 14 points
for i=1,5 do
render.StartBeam( increment );
//
local i;
for i = 1, 10 do
	// get point
	local point = start_pos + dir * ( (i - 1) * increment ) + VectorRand() * math.random( 1, maxdist )
    render.SetMaterial( solarbeam )
	// texture coords
	local tcoord = CurTime() + ( 1 / 30 ) * -i;
 
	// add point
	render.AddBeam(
		point + VectorRand()*50,
		mindist2,
		tcoord*2,
		Color( 255,255,255,255 )
	);
 
end
 
// finish up the beam
render.EndBeam();

end
end

effects.Register(EFFECT, "solar_beam", true)

local EFFECT2={}


function EFFECT2:Init(data)
self.ParentEntity = data:GetEntity()
self.Orig = data:GetOrigin()
self.Norm = data:GetNormal()
self.ParticleLife = CurTime() + 2
self.ParticleTime = 0
self.ParticleNum = 0
self.MuzzleSize = 50
self.MuzzleSize2 = 50
end

function EFFECT2:Think()
if self.ParticleTime < CurTime() then
local emmiter = ParticleEmitter(self.Orig,false)
for i=0,(math.Round(1 + self.ParticleNum)) do
	local particle = emmiter:Add(sparks,self.Orig + Vector(math.Rand(math.Rand(-350,-200),math.Rand(200,350)),math.Rand(math.Rand(-350,-200),math.Rand(200,350)),math.Rand(0,150)))
		if particle then
			particle:SetLifeTime(0)
			particle:SetDieTime( math.Clamp(0.1+(self.ParticleNum/math.Rand(30,40)),0.1,3) )
			particle:SetAirResistance(300)
			particle:SetStartAlpha( math.Rand( 0, 30 ) )
			particle:SetEndAlpha( 255 )
			particle:SetStartSize( math.Rand(3,6) )
			particle:SetEndSize( 0 )
			particle:SetRoll( math.Rand(0, 360) )
			particle:SetRollDelta( 0 )
			particle:SetColor(255,255,255,255)
			particle:SetGravity(Vector(math.Rand(math.Rand(-500,-500),math.Rand(500,500)),math.Rand(math.Rand(-500,-500),math.Rand(500,500)),math.Clamp(50+(self.ParticleNum*math.Rand(9,15)),50,2000)))
		end
	end
	self.ParticleTime = CurTime() + 0.1
end
if self.ParentEntity != NULL then
self.StartPos = self.ParentEntity:GetPos()
local tracebeam = {}
tracebeam.start = self.StartPos
tracebeam.endpos = tracebeam.start - Vector(0,0,90000)
tracebeam.filter = function(ent) if !ent:IsWorld() then return false end end
local traceworldbeam = util.TraceLine(tracebeam)
self.Orig = traceworldbeam.HitPos
self:SetRenderBoundsWS(self.StartPos + Vector(0,0,90000), self.Orig + Vector(0,0,-90000))
end
if !IsValid(self.ParentEntity) then
return false 
end
return true
end

function EFFECT2:Render( )
if self.ParentEntity == NULL then return end
self.StartPos = self.ParentEntity:GetPos()
local tracebeam = {}
tracebeam.start = self.StartPos
tracebeam.endpos = tracebeam.start - Vector(0,0,90000)
tracebeam.filter = function(ent) if !ent:IsWorld() then return false end end
local traceworldbeam = util.TraceLine(tracebeam)
self.Orig = traceworldbeam.HitPos
self.Norm = traceworldbeam.HitNormal
self:SetRenderBoundsWS(self.StartPos + Vector(0,0,90000), self.Orig + Vector(0,0,-90000))
self.ParticleNum = math.Clamp(self.ParticleNum + (FrameTime()*40),0,200)
self.MuzzleSize = math.Clamp(self.MuzzleSize + FrameTime()*1600*2,0,1000)
self.MuzzleSize2 = math.Clamp(self.MuzzleSize2 + FrameTime()*1600*2,0,2500)
render.SetMaterial(solarmuzzle)
render.DrawQuadEasy(self.Orig + self.Norm*2,self.Norm,self.MuzzleSize,self.MuzzleSize,Color(255,255,0,255),CurTime()*-720)
render.SetMaterial(solarmuzzle2)
render.DrawQuadEasy(self.Orig + self.Norm*2,self.Norm,self.MuzzleSize2,self.MuzzleSize2,Color(255,255,255,255),CurTime()*-720)
render.SetMaterial(glow)
render.DrawSprite(self.Orig + Vector(0,0,20),1000,1000,Color(255,255,0,255))
render.SetMaterial(glow2)
render.DrawQuadEasy(self.StartPos,self.ParentEntity:GetAngles():Up()*-1,self.MuzzleSize,self.MuzzleSize,Color(255,255,0,255),CurTime()*-720)
end

effects.Register(EFFECT2, "solar_beam_particle", true)

local EFFECT3={}

function EFFECT3:Init( data )
self.Position = data:GetOrigin()
self.Angle = data:GetNormal()
self.Angle.z = 0.4*self.Angle.z

local Emitter = ParticleEmitter(self.Position)

	if Emitter then
		for i=1,50 do
			local particle = Emitter:Add( "effects/fleck_antlion"..math.random(1,2), self.Position + Vector(math.Rand(-8,8),math.Rand(-8,8),math.Rand(-32,32)))
				particle:SetVelocity( self.Angle*math.Rand(256,385) + VectorRand()*64)
				particle:SetLifeTime( math.Rand(-0.3, 0.1) )
				particle:SetDieTime( math.Rand(0.7, 1) )
				particle:SetStartAlpha( 255 )
				particle:SetEndAlpha( 0 )
				particle:SetStartSize( math.Rand( 1.5, 1.7) )
				particle:SetEndSize( math.Rand( 1.8, 2) )
				particle:SetRoll( math.Rand( 360, 520 ) )
				particle:SetRollDelta( math.random( -2, 2 ) )
				particle:SetColor( 70, 70, 70 )	
		end
	
		
		for i=1,20 do
			local particle = Emitter:Add( "particles/smokey", self.Position + Vector(math.Rand(-8,9),math.Rand(-8,8),math.Rand(-32,32)) - self.Angle*8)
				particle:SetVelocity( self.Angle*math.Rand(256,385) + VectorRand()*64  )
				particle:SetDieTime( math.Rand(0.4, 0.8) )
				particle:SetStartAlpha( 140 )
				particle:SetEndAlpha( 0 )
				particle:SetStartSize( math.Rand( 8, 12) )
				particle:SetEndSize( math.Rand( 24, 32) )
				particle:SetRoll( math.Rand( 360, 520 ) )
				particle:SetRollDelta( math.random( -2, 2 ) )
				particle:SetColor( 50, 50, 50 )	
		end

		Emitter:Finish()
	end
end


function EFFECT3:Think()
	return false
end


function EFFECT3:Render()
end


effects.Register(EFFECT3, "solarbeam_disslove" )
end
