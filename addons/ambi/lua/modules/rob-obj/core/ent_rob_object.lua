local Ents, C = Ambi.RegEntity, Ambi.General.Global.Colors
local ENT = {}

ENT.Class       = 'rob_object'
ENT.Type	    = 'anim'

ENT.PrintName	= 'Rob Object'
ENT.Author		= 'Ambi'
ENT.Category	= 'Rob Object'
ENT.Spawnable   = true

ENT.Stats = {
    type = 'Entity',
    model = 'models/props_junk/wood_crate001a_damaged.mdl',
    module = 'Rob Object',
    date = '19.09.2023 23:14'
}

Ents.Register( ENT.Class, 'ents', ENT )

if CLIENT then
    local C, GUI, Draw, UI = Ambi.Packages.Out( '@d' )

    local function PrintChat( sText )
        chat.AddText( C.AMBI, '[•] ', C.ABS_WHITE, sText )
    end
    
    local max_dist = 2400
    local font = 'ambFont22'
    local COLOR_GREEN = Color( 0, 255, 0 )
    
    local w_ent = 270
    local h_ent = 120
    local x_ent = -130
    local y_ent = -182

    ENT.RenderGroup = RENDERGROUP_BOTH

    function ENT:DrawTranslucent()
        self:DrawShadow( false )

        if ( LocalPlayer():GetPos():Distance( self:GetPos() ) > 400 ) then return end

        local rot = ( self:GetPos() - EyePos() ):Angle().yaw - 90
        local pos = self:GetPos() + Vector( 0, 0, self:GetModelRadius() )

        cam.Start3D2D( pos + Vector( 0, 0, 12 ), Angle( 0, rot, 90 ), 0.1 )
            draw.SimpleTextOutlined( Ambi.RobObj.Config.object.name, UI.SafeFont( '46 Ambi' ), 4, 0, self:GetNWBool( 'Stealing' ) and C.AMBI_RED or C.AMBI_GREEN, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, C.ABS_BLACK )
        cam.End3D2D()

        Ents.Draw( self, false )
    end
    
    return Ents.Register( ENT.Class, 'ents', ENT )
end 

function ENT:Initialize()
    Ents.Initialize( self, self.Stats.model )
    Ents.Physics( self, MOVETYPE_VPHYSICS, SOLID_VPHYSICS, nil, true, true )

    self:SetTrigger()
    self:SetHealth( Ambi.RobObj.Config.object.hp )

    local phys = self:GetPhysicsObject()
	if IsValid( phys ) then
		phys:EnableMotion( false )
	end

    self:SetNWBool( 'Stealing', false )
end

function ENT:Use( ePly )
    if not Ambi.RobObj.Config.can_rob_jobs[ ePly:GetJob() ] then ePly:ChatSend( '~R~ Вы не сможете ограбить!' ) return end

    if ( self:GetNWBool( 'Stealing' ) == false ) then
        self:Steal( ePly )
    elseif self:GetNWBool( 'Stealing' ) then
        ePly:ChatPrint( 'Груз уже кто-то грабит' )
    end
end

function ENT:Steal( ePly )
    local delay = Ambi.RobObj.Config.delays.time_rob_object

	ePly:Freeze( true )
	ePly:ChatSend( 'Вы начали ограбление, ждите '..delay..' секунд' )

	self:SetNWBool( 'Stealing', true )

	timer.Simple( delay, function() 
        if IsValid( ePly ) then
		    ePly:Freeze( false )

            if not ePly:Alive() then
                ePly:ChatSend( 'Вы потеряли груз!' )
                ePly:Spawn()

                self:SetNWBool( 'Stealing', false )
            else
                local money = math.random( Ambi.RobObj.Config.rewards.min_money_rob, Ambi.RobObj.Config.rewards.max_money_rob )

                ePly:ChatSend( 'Вы закончили ограбление: '..money..'$')
                ePly:AddMoney( money )
            end
        end

        if IsValid( self ) then self:Remove() end
	end )
end

function ENT:OnTakeDamage( dmg )
	self:SetHealth( self:Health() - dmg:GetDamage() )

	if ( self:Health() <= 0 ) and IsValid( self ) then self:Remove() end
end

Ents.Register( ENT.Class, 'ents', ENT )