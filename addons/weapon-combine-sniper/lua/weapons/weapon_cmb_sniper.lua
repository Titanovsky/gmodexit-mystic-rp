if SERVER then
	AddCSLuaFile()
else
	SWEP.Category	= "Half-Life 2"
	SWEP.PrintName	= "Combine Sniper"		
	
	SWEP.Slot				= 2
	SWEP.SlotPos			= 2
	SWEP.ViewModelFOV		= 70
	SWEP.CSMuzzleFlashes    = true
	SWEP.BounceWeaponIcon   = false
	SWEP.Author				= "CMB T3CH"
	SWEP.Contact			= "Nearest Nexus/Checkpoint/Citadel"
	SWEP.Purpose			= "Neutralize Resistance Forces"
	SWEP.Instructions		= "Left to fire, Right to zoom."
	
	language.Add("weapon_cmb_sniper", "CMB Sniper")
	language.Add("SniperRound_ammo", "Sniper Rounds")
	killicon.Add("weapon_cmb_sniper", "effects/killicons/weapon_cmb_sniper", color_white )
	SWEP.WepSelectIcon		= surface.GetTextureID("HUD/swepicons/weapon_cmb_sniper/icon") 
end

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true
SWEP.AdminOnly          = false

SWEP.HoldType 			= "ar2"
SWEP.ViewModel			= "models/weapons/c_combinesniper_e2.mdl"
SWEP.WorldModel			= "models/weapons/w_combinesniper_e2.mdl"
SWEP.ViewModelFlip		= false
SWEP.UseHands			= true

SWEP.SwayScale			= 1.0
SWEP.BobScale			= 1.0

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= true
SWEP.AutoSwitchFrom		= true

SWEP.Idle = 0
SWEP.IdleTimer = CurTime()

SWEP.Primary.Sound			= Sound( "npc/sniper/echo1.wav" )
SWEP.Primary.Damage			= 20
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= .001
SWEP.Primary.ClipSize		= -1
SWEP.Primary.Delay			= 0.9
SWEP.Primary.DefaultClip	= 20
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "SniperRound"

SWEP.Secondary.ScopeZoom			= 4
SWEP.Secondary.Automatic	= false
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.ScopeScale 			= 1.5
SWEP.ReticleScale 			= 1.75
SWEP.IronsightTime 			= 0.25
SWEP.IronSightsPos = Vector(0, 0, 0)
SWEP.IronSightsAng = Angle(0, 0, 0)
SWEP.SightsPos = Vector (-5.2263, -0.0007, 3.715)
SWEP.SightsAng = Vector (0, 0, 0)
SWEP.RunSightsPos = Vector (0, 0, 0)
SWEP.RunSightsAng = Angle (0, 0, 0)

local IRONSIGHT_TIME = 0.2

SWEP.LaserRespawnTime = 1
SWEP.LaserLastRespawn = 0

SWEP.ViewModelBoneMods = {
	["base"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_L_Hand"] = { scale = Vector(1, 1, 1), pos = Vector(4.701, -2.013, 1.189), angle = Angle(0, 0, 0) }
}

SWEP.VElements = {
	["v_element"] = { type = "Model", model = "models/weapons/w_combine_sniper.mdl", bone = "base", rel = "", pos = Vector(11.328, 0.948, 0), angle = Angle(0, 180, 90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "jaanus/w_sniper", skin = 0, bodygroup = {} },
	["pipe1+"] = { type = "Model", model = "models/props_c17/GasPipes006a.mdl", bone = "base", rel = "", pos = Vector(-6.273, -3.418, -1.255), angle = Angle(-90, 180, 0.382), size = Vector(0.076, 0.076, 0.076), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/MetalSet_1-2", skin = 0, bodygroup = {} },
	["pipe1"] = { type = "Model", model = "models/props_c17/GasPipes006a.mdl", bone = "base", rel = "", pos = Vector(-6.267, -3.024, -1.43), angle = Angle(-90, 180, 0.382), size = Vector(0.076, 0.076, 0.076), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/MetalSet_1-2", skin = 0, bodygroup = {} },
	["indicator_holder"] = { type = "Model", model = "models/Items/battery.mdl", bone = "base", rel = "", pos = Vector(-8.177, -2.604, -1.203), angle = Angle(180, 180, 90), size = Vector(0.109, 0.109, 0.109), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["indicator"] = { type = "Sprite", sprite = "sprites/glow04", bone = "base", rel = "", pos = Vector(-8.72, -3.498, -1.203), size = { x = 1, y = 1 }, color = Color(21, 186, 7, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false}
}

function SWEP:Precache() -- i dont know if this is pointless but whatever
    util.PrecacheSound("npc/sniper/echo1.wav")
	util.PrecacheSound("npc/sniper/sniper1.wav")
	util.PrecacheSound("npc/sniper/reload1.wav")
	util.PrecacheSound("buttons/weapon_cant_buy.wav")
end

function SWEP:Initialize()

	self:SetHoldType(self.HoldType)
	self:SetWeaponHoldType(self.HoldType)
	
	self.Idle = 0
	self.IdleTimer = CurTime() + 1
	
	self.Fired = false
	
	if CLIENT then
		surface.CreateFont( "CMB_Sniper_Font", -- make a freaking font...
		{
		font = "digital-7",
		size = ScreenScale(20),
		weight = 400
		})
	
		local iScreenWidth = surface.ScreenWidth()
		local iScreenHeight = surface.ScreenHeight()

		self.ScopeTable = {}
		self.ScopeTable.l = iScreenHeight*self.ScopeScale
		self.ScopeTable.x1 = 0.5*(iScreenWidth + self.ScopeTable.l)
		self.ScopeTable.y1 = 0.5*(iScreenHeight - self.ScopeTable.l)
		self.ScopeTable.x2 = self.ScopeTable.x1
		self.ScopeTable.y2 = 0.5*(iScreenHeight + self.ScopeTable.l)
		self.ScopeTable.x3 = 0.5*(iScreenWidth - self.ScopeTable.l)
		self.ScopeTable.y3 = self.ScopeTable.y2
		self.ScopeTable.x4 = self.ScopeTable.x3
		self.ScopeTable.y4 = self.ScopeTable.y1
		self.ScopeTable.l = (iScreenHeight + 1)*self.ScopeScale

		self.QuadTable = {}
		self.QuadTable.x1 = 0
		self.QuadTable.y1 = 0
		self.QuadTable.w1 = iScreenWidth
		self.QuadTable.h1 = 0.5*iScreenHeight - self.ScopeTable.l
		self.QuadTable.x2 = 0
		self.QuadTable.y2 = 0.5*iScreenHeight + self.ScopeTable.l
		self.QuadTable.w2 = self.QuadTable.w1
		self.QuadTable.h2 = self.QuadTable.h1
		self.QuadTable.x3 = 0
		self.QuadTable.y3 = 0
		self.QuadTable.w3 = 0.5*iScreenWidth - self.ScopeTable.l
		self.QuadTable.h3 = iScreenHeight
		self.QuadTable.x4 = 0.5*iScreenWidth + self.ScopeTable.l
		self.QuadTable.y4 = 0
		self.QuadTable.w4 = self.QuadTable.w3
		self.QuadTable.h4 = self.QuadTable.h3

		self.LensTable = {}
		self.LensTable.x = self.QuadTable.w3
		self.LensTable.y = self.QuadTable.h1
		self.LensTable.w = 2*self.ScopeTable.l
		self.LensTable.h = 2*self.ScopeTable.l

		self.ReticleTable = {}
		self.ReticleTable.wdivider = 3.125
		self.ReticleTable.hdivider = 1.7579/self.ReticleScale		-- Draws the texture at 512 when the resolution is 1600x900
		self.ReticleTable.x = (iScreenWidth/2)-((iScreenHeight/self.ReticleTable.hdivider)/2)
		self.ReticleTable.y = (iScreenHeight/2)-((iScreenHeight/self.ReticleTable.hdivider)/2)
		self.ReticleTable.w = iScreenHeight/self.ReticleTable.hdivider
		self.ReticleTable.h = iScreenHeight/self.ReticleTable.hdivider

		self.FilterTable = {}
		self.FilterTable.wdivider = 3.125
		self.FilterTable.hdivider = 1.7579/1.35	
		self.FilterTable.x = (iScreenWidth/2)-((iScreenHeight/self.FilterTable.hdivider)/2)
		self.FilterTable.y = (iScreenHeight/2)-((iScreenHeight/self.FilterTable.hdivider)/2)
		self.FilterTable.w = iScreenHeight/self.FilterTable.hdivider
		self.FilterTable.h = iScreenHeight/self.FilterTable.hdivider
	end

	if CLIENT then
	
		-- Create a new table for every weapon instance
		self.VElements = table.FullCopy( self.VElements )
		self.WElements = table.FullCopy( self.WElements )
		self.ViewModelBoneMods = table.FullCopy( self.ViewModelBoneMods )
        self:SetWeaponHoldType( self.HoldType )
		
		self:CreateModels(self.VElements) -- create viewmodels
		self:CreateModels(self.WElements) -- create worldmodels
		
		-- init view model bone build function
		if IsValid(self.Owner) then
			local vm = self.Owner:GetViewModel()
			if IsValid(vm) then
				self:ResetBonePositions(vm)
				
				-- Init viewmodel visibility
				if (self.ShowViewModel == nil or self.ShowViewModel) then
					vm:SetColor(Color(255,255,255,255))
				else
					-- we set the alpha to 1 instead of 0 because else ViewModelDrawn stops being called
					vm:SetColor(Color(255,255,255,1))
					-- ^ stopped working in GMod 13 because you have to do Entity:SetRenderMode(1) for translucency to kick in
					-- however for some reason the view model resets to render mode 0 every frame so we just apply a debug material to prevent it from drawing
					vm:SetMaterial("Debug/hsv")			
				end
			end
		end
		
	end

end

----------------------------------------------------
if CLIENT then

	SWEP.vRenderOrder = nil
	function SWEP:ViewModelDrawn()
		
		local vm = self.Owner:GetViewModel()
		if !IsValid(vm) then return end
		
		if (!self.VElements) then return end
		
		self:UpdateBonePositions(vm)

		if (!self.vRenderOrder) then
			
			-- we build a render order because sprites need to be drawn after models
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
				--model:SetModelScale(v.size)
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
			-- when the weapon is dropped
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
				--model:SetModelScale(v.size)
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
				ang.r = -ang.r -- Fixes mirrored models
			end
		
		end
		
		return pos, ang
	end

	function SWEP:CreateModels( tab )

		if (!tab) then return end

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
				-- make sure we create a unique name based on the selected options
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
			
			-- !! WORKAROUND !! --
			-- We need to check all model names :/
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
			-- !! ----------- !! --
			
			for k, v in pairs( loopthrough ) do
				local bone = vm:LookupBone(k)
				if (!bone) then continue end
				
				-- !! WORKAROUND !! --
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
				-- !! ----------- !! --
				
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


	function table.FullCopy( tab )

		if (!tab) then return nil end
		
		local res = {}
		for k, v in pairs( tab ) do
			if (type(v) == "table") then
				res[k] = table.FullCopy(v)
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
----------------------------------------------------

function SWEP:PostReloadScopeCheck()
	if self.Weapon != nil then 
	if self.Owner:KeyDown(IN_ATTACK2) and self.Weapon:GetClass() == self.Gun then 
		if CLIENT then return end
		self.Owner:SetFOV( 75/self.Secondary.ScopeZoom, 0.15 )                      		
		self.IronSightsPos = self.SightsPos					-- Bring it up
		self.IronSightsAng = self.SightsAng					-- Bring it up
		self.DrawCrosshair = false
		self:SetIronsights(true, self.Owner)
		self.Owner:DrawViewModel(false)
 	elseif self.Owner:KeyDown(IN_SPEED) and self.Weapon:GetClass() == self.Gun then
		if self.Weapon:GetNextPrimaryFire() <= (CurTime()+0.3) then
			self.Weapon:SetNextPrimaryFire(CurTime()+0.3)				-- Make it so you can't shoot for another quarter second
		end
		self.IronSightsPos = self.RunSightsPos					-- Hold it down
		self.IronSightsAng = self.RunSightsAng					-- Hold it down
		self:SetIronsights(true, self.Owner)					-- Set the ironsight true
		self.Owner:SetFOV( 0, 0.2 )
	else return end
	end
end

function SWEP:IronSight()

	if not IsValid(self) then return end
	if not IsValid(self.Owner) then return end
	
	--if self.Owner:KeyPressed(IN_ATTACK2) then return end

	if self.Owner:KeyPressed(IN_ATTACK2) then
		self.Owner:SetFOV( 75/self.Secondary.ScopeZoom, 0.15 )                      		
		self.IronSightsPos = self.SightsPos					-- Bring it up
		self.IronSightsAng = self.SightsAng					-- Bring it up
		self.DrawCrosshair = false
		self:SetIronsights(true, self.Owner)
		if CLIENT then return end
		self.Owner:DrawViewModel(false)
	elseif self.Owner:KeyPressed(IN_ATTACK2) then
		if self.Weapon:GetNextPrimaryFire() <= (CurTime()+0.3) then
			self.Weapon:SetNextPrimaryFire(CurTime()+0.3)				-- Make it so you can't shoot for another quarter second
		end
		self.IronSightsPos = self.RunSightsPos					-- Hold it down
		self.IronSightsAng = self.RunSightsAng					-- Hold it down
		self:SetIronsights(true, self.Owner)					-- Set the ironsight true
		self.Owner:SetFOV( 0, 0.2 )
	end

	if (self.Owner:KeyReleased(IN_ATTACK2)) then
		self.Owner:SetFOV( 0, 0.2 )
		self:SetIronsights(false, self.Owner)
		self.DrawCrosshair = self.XHair
		-- Set the ironsight false
		if CLIENT then return end
		self.Owner:DrawViewModel(true)
	end

	if self.Owner:KeyDown(IN_ATTACK2) then
		self.SwayScale 	= 0.05
		self.BobScale 	= 0.05
	else
		self.SwayScale 	= 1.0
		self.BobScale 	= 1.0
	end
end

function SWEP:Deploy()
	local vm = self.Owner:GetViewModel()
	vm:SendViewModelMatchingSequence( vm:LookupSequence( "IR_reload" ) )
	vm:SetPlaybackRate(3)
	timer.Simple(0.2,function()
		if !IsValid(self) then return end
		if !IsValid(vm) then return end
		vm:SetPlaybackRate(1)
	end)
	
	self:SetNextPrimaryFire( CurTime() + 0.3)
	self:SetNextSecondaryFire( CurTime() + 0.3)
	
	self:SetNWBool( "CMBBeamOn", false )
	
	self.Idle = 0
	self.IdleTimer = CurTime() + 0.3
	
	self:NextThink( CurTime() + 0.3 )
	self:SetIronsights(false, self.Owner)  
	self.Owner:SetFOV( 0, 0.5 )
	return true
end

function SWEP:Holster()
	if CLIENT and IsValid(self.Owner) then
		local vm = self.Owner:GetViewModel()
		if IsValid(vm) then
			self:ResetBonePositions(vm)
			self.Owner:SetFOV( 0, 0.25 )
		end
	end
	self.Idle = 0
	self.IdleTimer = CurTime()
	self.Fired = false
	return true
end

function SWEP:OnDrop()
	self:Holster()
end

function SWEP:OnRemove()
	self:Holster()
end

function SWEP:Reload() -- we dont need reload code for this
	--[[if self:Clip1() >= self.Primary.ClipSize then return end
	if self.Weapon:Ammo1() <= 0 then return end

	self.Weapon:DefaultReload(ACT_VM_RELOAD)
	self.Weapon:EmitSound("npc/sniper/reload1.wav", 50, 100)]]
end

function SWEP:PrimaryAttack()
	if self.Weapon:Ammo1() <= 0 then self.Weapon:EmitSound("buttons/weapon_cant_buy.wav") self:SetNextPrimaryFire(CurTime() + 0.5) self.Weapon:SendWeaponAnim(ACT_VM_DRYFIRE) return end
	
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay + 0.3)
	self:SetNextSecondaryFire( CurTime() + self.Primary.Delay + 0.3) 
    --if (!self:CanPrimaryAttack()) then return end -- doesnt work with firing from ammo supply directly
	self:TakePrimaryAmmo(1)
	
	if SERVER then -- stop the sound from playing twice
		self.Owner:EmitSound(self.Primary.Sound,100)
		self.Owner:EmitSound("npc/sniper/reload1.wav")
	end
	self.Owner:ViewPunch( Angle( math.Rand(-0.9,0,9), math.Rand(-0.9,0,9), math.Rand(-0.9,0,9) ) )
	
	self.Fired = true
	self:SetNWBool( "CMBBeamOn", false )
	self.VElements["indicator"].color = Color(255, 0, 0, 255)
	timer.Simple(self.Primary.Delay, function() if !self:IsValid() then return false end
		self.VElements["indicator"].color = Color(21, 186, 7, 255)
		self.Fired = false
		self:SetNWBool( "CMBBeamOn", true )
	end)
	
    local bullet = {}
    bullet.Num = self.Primary.NumShots
    bullet.Src = self.Owner:GetShootPos()
    bullet.Dir = self.Owner:GetAimVector()
    bullet.Spread = Vector(self.Primary.Cone,self.Primary.Cone,0)
    bullet.Tracer = 1
	bullet.TracerName = "Ar2Tracer"
    bullet.Force = 2
    bullet.Damage = self.Primary.Damage
	bullet.AmmoType = self.Primary.Ammo
	bullet.HullSize = 2
	bullet.Callback = function(attacker, tr, dmginfo)
		dmginfo:SetDamageType(DMG_SNIPER)
		
		if SERVER then
			if IsValid(tr.Entity) then
				local phys = tr.Entity:GetPhysicsObject()
				if phys:IsValid() then
					if tr.Entity:IsPlayerHolding() then
						tr.Entity:Fire("disablemotion") -- recreate that prop release effect in HL2
						
						tr.Entity:Fire("enablemotion","0",0.001)
						timer.Simple(0.05, function()
							if !IsValid(tr.Entity) then return end
							sound.Play("physics/metal/metal_sheet_impact_bullet"..math.random(1,2)..".wav",tr.Entity:GetPos(),100)
							phys:Wake()
							phys:ApplyForceOffset(Vector(math.random(-2500,2500),math.random(-2500,2500),math.random(-2500,2500)),tr.HitPos)
						end)
					end
				end
			end
			
			for k,v in pairs(ents.FindAlongRay(tr.HitPos,tr.HitPos+self.Owner:GetAimVector()*256,Vector(-20,-20,-20),Vector(20,20,20))) do
				if v~=self.Owner then
					local dmginfo1= DamageInfo()
					dmginfo1:SetAttacker(self.Owner)
					dmginfo1:SetInflictor(self)
					dmginfo1:SetDamageType(DMG_SNIPER)
					dmginfo1:SetDamagePosition(self.Owner:GetShootPos())
					dmginfo1:SetDamageForce(self.Owner:GetAimVector()*100)
					if v:IsNPC() then
						dmginfo1:SetDamage(50)
					else
						dmginfo1:SetDamage(15)
					end
					v:TakeDamageInfo(dmginfo1)
				end
			end
		end
	end
	
	self.Owner:FireBullets(bullet)
	
	local fx = EffectData()
	fx:SetEntity(self.Weapon)
	fx:SetOrigin(self.Owner:GetShootPos())
	fx:SetNormal(self.Owner:GetAimVector())
	util.Effect("rg_muzzle_cmb",fx) 
	
	for k,v in pairs (ents.FindInSphere(self.Owner:GetPos(),8192)) do -- play a sound for players far away
		if v:IsPlayer() and v ~= self.Owner then
			if self.Owner:GetPos():Distance(v:GetPos()) > 3000 then
				sound.Play("npc/sniper/sniper1.wav",v:GetPos() + Vector( math.random(-100, 100), math.random(-100, 100), 30 ), 75, math.random(95,105), 0.5)
			elseif self.Owner:GetPos():Distance(v:GetPos()) > 800 then
				sound.Play("npc/sniper/sniper1.wav",v:GetPos() + Vector( math.random(-100, 100), math.random(-100, 100), 30 ), 75, math.random(95,105))
			end
		end
	end
	
	self.Idle = 0
	self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()

    self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
    self.Owner:MuzzleFlash()
    self.Owner:SetAnimation(PLAYER_ATTACK1)
end

function SWEP:SecondaryAttack()
end

function SWEP:GetViewModelPosition(pos, ang)
	if (not self.IronSightsPos) then return pos, ang end
 
	local bIron = self.Weapon:GetNWBool("Ironsights")
 
	if (bIron != self.bLastIron) then
		self.bLastIron = bIron
		self.fIronTime = CurTime()
	end
 
	local fIronTime = self.fIronTime or 0
 
	if (not bIron and fIronTime < CurTime() - IRONSIGHT_TIME) then
		return pos, ang
	end
 
	local Mul = 1.0
 
	if (fIronTime > CurTime() - IRONSIGHT_TIME) then
		Mul = math.Clamp((CurTime() - fIronTime) / IRONSIGHT_TIME, 0, 1)
 
		if not bIron then Mul = 1 - Mul end
	end
 
	local Offset    = self.IronSightsPos
 
	if (self.IronSightsAng) then
		ang = ang * 1
		ang:RotateAroundAxis(ang:Right(),               self.IronSightsAng.x * Mul)
		ang:RotateAroundAxis(ang:Up(),          self.IronSightsAng.y * Mul)
		ang:RotateAroundAxis(ang:Forward(),     self.IronSightsAng.z * Mul)
	end
 
	local Right     = ang:Right()
	local Up                = ang:Up()
	local Forward   = ang:Forward()
 
	pos = pos + Offset.x * Right * Mul
	pos = pos + Offset.y * Forward * Mul
	pos = pos + Offset.z * Up * Mul
 
	return pos, ang
end

function SWEP:SetIronsights(b)
	self.Weapon:SetNWBool("Ironsights", b)
end
 
function SWEP:GetIronsights()
	return self.Weapon:GetNWBool("Ironsights")
end

function SWEP:AdjustMouseSensitivity()
     
	if self.Owner:KeyDown(IN_ATTACK2) and self:GetIronsights() then
        return (1/(self.Secondary.ScopeZoom/0.7))
    else 
    	return 1
	end
end

function SWEP:CheckTarget(ent)
    if ent:IsPlayer() then
        if !ent:IsValid() then return false end
        if ent:Health() < 1 then return false end
        if ent == self.Owner then return false end    
        return true
    end
    if ent:IsNPC() then
        if ent:GetMoveType() == 0 then return false end
		if ent:Health() < 1 then return false end
		if ent:GetClass():find("prop") then return false end -- ignore those
		if ent:GetClass():find("furniture") then return false end -- ignore that hl1 npc
        return true
    end
    return false
end

function SWEP:GetTargets() -- promise its not for aimbot this time
    local tbl = {}
    for k,ent in pairs(ents.GetAll()) do
        if self:CheckTarget(ent) == true then
            table.insert(tbl,ent)
        end
    end
    return tbl
end

function SWEP:GetClosestTarget()
    local pos = self.Owner:GetPos()
    local ang = self.Owner:GetAimVector()
    local closest = {0,0}
    for k,ent in pairs(self:GetTargets()) do
		if ent:IsLineOfSightClear(pos) then
			local diff = (ent:GetPos()-pos)
			diff:Normalize()
			diff = diff - ang
			diff = diff:Length()
			diff = math.abs(diff)
			if (diff < closest[2]) or (closest[1] == 0) then
				closest = {ent,diff}
			end
		end
    end
    return closest[1]
end

function SWEP:Think()
	local ent = self:GetClosestTarget()
    self.CloseEnt = ent ~= 0 and ent or nil
	if self.Idle == 0 and self.IdleTimer <= CurTime() then
	if SERVER then
		self.Weapon:SendWeaponAnim( ACT_VM_IDLE )
	end
		self.Idle = 1
	end
	self:IronSight()
	
	if self.Fired ~= true then
		if self.Weapon:Ammo1() <= 0 then
			self.VElements["indicator"].color = Color(255, 0, 0, 255)
			self:SetNWBool( "CMBBeamOn", false )
		else
			self.VElements["indicator"].color = Color(21, 186, 7, 255)
			self:SetNWBool( "CMBBeamOn", true )
		end
	end
end

function SWEP:DrawRotatingCrosshair(x,y,time,length,gap)
    surface.DrawLine(
        x + (math.sin(math.rad(time)) * length),
        y + (math.cos(math.rad(time)) * length),
        x + (math.sin(math.rad(time)) * gap),
        y + (math.cos(math.rad(time)) * gap)
    )
end

SWEP.CloseEnt = nil

function SWEP:GetCoordiantes(ent)
	if ent:IsValid() then
		local min,max = ent:OBBMins(),ent:OBBMaxs()
		local corners = {
			Vector(min.x,min.y,min.z),
			Vector(min.x,min.y,max.z),
			Vector(min.x,max.y,min.z),
			Vector(min.x,max.y,max.z),
			Vector(max.x,min.y,min.z),
			Vector(max.x,min.y,max.z),
			Vector(max.x,max.y,min.z),
			Vector(max.x,max.y,max.z)
		}

		local minx,miny,maxx,maxy = ScrW() * 2,ScrH() * 2,0,0
		for _,corner in pairs(corners) do
			local screen = ent:LocalToWorld(corner):ToScreen()
			minx,miny = math.min(minx,screen.x),math.min(miny,screen.y)
			maxx,maxy = math.max(maxx,screen.x),math.max(maxy,screen.y)
		end
		return minx,miny,maxx,maxy
	else
		return 0,0,0,0
	end
end

function SWEP:FixName(ent)
	if ent:IsValid() then
		if ent:IsPlayer() then return ent:Name() end
		if ent:IsNPC() then return ent:GetClass():sub(5,-1) end
	end
	return ""
end

function SWEP:DrawHUD()
    local x,y = ScrW(),ScrH()
    local w,h = x/2,y/2
    
    surface.SetDrawColor(Color(100,100,255,200))
    surface.DrawRect(w - 1, h - 3, 3, 7)
    surface.DrawRect(w - 3, h - 1, 7, 3)

    surface.SetDrawColor(Color(0,0,255,255))
    surface.DrawLine(w, h - 5, w, h + 5)
    surface.DrawLine(w - 5, h, w + 5, h)

    local time = 45    
    local scale = 20 * 0.02 -- self.Cone
    local gap = 1 * scale
    local length = gap + 30 * scale

    surface.SetDrawColor(0,0,255,255)

    self:DrawRotatingCrosshair(w,h,time,      length,gap)
    self:DrawRotatingCrosshair(w,h,time + 90, length,gap)
    self:DrawRotatingCrosshair(w,h,time + 180,length,gap)
    self:DrawRotatingCrosshair(w,h,time + 270,length,gap)
	
	if self.CloseEnt ~= nil then
		if self.Weapon:GetNWBool("Ironsights") then
			local text = "NEAREST TARGET: "
			surface.SetFont("CMB_Sniper_Font")
			local size = surface.GetTextSize(text)
			draw.RoundedBox(4,730,y-990,size+50,150,Color(0,0,255,100))
			draw.DrawText(text,"CMB_Sniper_Font",760,y-980,Color(150,255,255,150),TEXT_ALIGN_LEFT)
			draw.DrawText(""..self:FixName(self.CloseEnt),"CMB_Sniper_Font",760,y-910,Color(150,255,255,150),TEXT_ALIGN_LEFT)
			local x1,y1,x2,y2 = self:GetCoordiantes(self.CloseEnt)
			local edgesize = 50
			local colorRNG = math.random(0,1)*255 -- make it flash
			surface.SetDrawColor(Color(colorRNG,255-colorRNG,255-colorRNG,255))
			
			-- Top left.
			surface.DrawLine(x1,y1,math.min(x1 + edgesize,x2),y1)
			surface.DrawLine(x1,y1,x1,math.min(y1 + edgesize,y2))

			-- Top right.
			surface.DrawLine(x2,y1,math.max(x2 - edgesize,x1),y1)
			surface.DrawLine(x2,y1,x2,math.min(y1 + edgesize,y2))

			-- Bottom left.
			surface.DrawLine(x1,y2,math.min(x1 + edgesize,x2),y2)
			surface.DrawLine(x1,y2,x1,math.max(y2 - edgesize,y1))

			-- Bottom right.
			surface.DrawLine(x2,y2,math.max(x2 - edgesize,x1),y2)
			surface.DrawLine(x2,y2,x2,math.max(y2 - edgesize,y1))
		end
    end
	
	if self.Owner:KeyDown(IN_ATTACK2) and (self:GetIronsights() == true) then
		
		surface.SetDrawColor(255, 255, 255, 255)
		surface.SetTexture(surface.GetTextureID("effects/combine_binocoverlay"))
		surface.DrawTexturedRect(self.ReticleTable.x, self.ReticleTable.y, self.ReticleTable.w, self.ReticleTable.h)
		
		surface.SetDrawColor(0, 0, 0, 255)
		surface.SetTexture(surface.GetTextureID("scope/gdcw_scopesight5"))
		surface.DrawTexturedRect(self.LensTable.x, self.LensTable.y, self.LensTable.w, self.LensTable.h)

		surface.SetDrawColor(0, 0, 0, 255)
		surface.SetTexture(surface.GetTextureID("scope/gdcw_parabolicsight5"))
		surface.DrawTexturedRect(self.LensTable.x, self.LensTable.y, self.LensTable.w, self.LensTable.h)
	end 
end

if CLIENT then

	local LaserBeam = Material( "effects/bluelaser1" )
	local LaserSprite = Material( "sprites/blueglow2" )

	local function GetTracerShootPos( ply, ent, attach )
		if !IsValid( ent ) then return false end
		if !ent:IsWeapon() then return false end

		local pos = false

		if ent:IsCarriedByLocalPlayer() and GetViewEntity() == LocalPlayer() then    
			local ViewModel = LocalPlayer():GetViewModel()
			if IsValid( ViewModel ) then
			local att = ViewModel:GetAttachment( attach )
			if att then
			pos = att.Pos
				end
			end
		else
			local att = ent:GetAttachment( attach )
			if att then
				pos = att.Pos
			end
		end

		return pos
	end

	hook.Add( "RenderScreenspaceEffects", "CMBLaser.RenderScreenspaceEffects", function()
		for k,v in ipairs( player.GetAll() ) do
			local weap = v:GetActiveWeapon()

			if IsValid( weap ) and weap:GetNWBool( "CMBBeamOn", false ) then
				cam.Start3D( EyePos(), EyeAngles() )
					local shootpos = v:GetShootPos()
					local ang = v:GetAimVector()
					local tr = {}
					tr.start = shootpos
					tr.endpos = shootpos + ( ang * 999999 )
					tr.filter = v
					tr.mask = MASK_SHOT

					local trace = util.TraceLine( tr )
					local ang = v:GetAimVector():Angle()
					local beamstartpos = v:WorldSpaceCenter()
					local beamendpos = trace.HitPos
					local size = 3
					
					if LocalPlayer() == v:GetViewEntity() then
						beamstartpos = v:GetShootPos() + ang:Forward() * 32 + ang:Right() * 16 - ang:Up() * 10
					end

					if beamstartpos then
						local Distance = beamstartpos:Distance( beamendpos )
						render.SetMaterial( LaserBeam )
						render.DrawBeam( beamstartpos, beamendpos, size, 10, 0, Color(100, 255, 255, 255)  )
						render.DrawBeam( beamstartpos, beamendpos, size, 10, 0, Color(100, 255, 255, 255)  )
						render.SetMaterial( LaserSprite )
						render.DrawSprite( beamendpos, 8, 8, Color(100, 255, 255, 255)  )
						render.DrawSprite( beamendpos, 8, 8, Color(100, 255, 255, 255)  )
					end
					
				cam.End3D()
			end
		end
	end )
end