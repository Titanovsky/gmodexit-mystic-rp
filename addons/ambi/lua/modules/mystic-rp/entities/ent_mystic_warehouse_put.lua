local Ents, C = Ambi.Packages.Out( 'regentity, colors' )

-- ---------------------------------------------------------------------------------------------------------------------------------------------------
local ENT = {}

ENT.Class       = 'mystic_warehouse_put'
ENT.Type	    = 'anim'

ENT.PrintName	= 'DNS Put'
ENT.Author		= 'Ambi'
ENT.Category	= 'DarkRP - Мистик РП'
ENT.Spawnable   =  true

ENT.Stats = {
    type = 'Entity',
    module = 'MysticRP',
    model = 'models/props_combine/breendesk.mdl',
    date = '28.06.2023 13:20'
}

Ents.Register( ENT.Class, 'ents', ENT )

if CLIENT then
    local Draw, UI = Ambi.Packages.Out( 'draw, ui' )
    
    local DISTANCE = 600
    ENT.RenderGroup = RENDERGROUP_BOTH

    function ENT:DrawTranslucent()
        self:DrawShadow( false )

        if ( LocalPlayer():GetPos():Distance( self:GetPos() ) <= DISTANCE ) then
            local pos = self:GetPos()
	        local ang = self:GetAngles()
            ang:RotateAroundAxis( ang:Up(), 90)

            cam.Start3D2D( pos + ang:Up() * 32, ang, 0.15 )
            Draw.Box( 330, 120, -160, -90, C.AMBI_PURPLE )
                Draw.Box( 330 - 4, 120 - 4, -160 + 2, -90 + 2, C.AMBI_BLACK )
                Draw.SimpleText( 2, -36, 'Положить видеокарту [E]', UI.SafeFont( '34 Ambi' ), C.AMBI_WHITE, 'center', 1, C.ABS_BLACK )
            cam.End3D2D()
        end
    end

    return Ents.Register( ENT.Class, 'ents', ENT )
end 

function ENT:Initialize()
    Ents.Initialize( self, ENT.Stats.model )
    Ents.Physics( self, MOVETYPE_VPHYSICS, SOLID_VPHYSICS, nil, true, true )
end

function ENT:Use( ePly )
    if not ePly:IsPlayer() then return end
    if not ePly.has_videocard then return end

    local money = math.random( 50, 100 )
    ePly:AddMoney( money )
    ePly:ChatSend( '~G~ +'..money )
    ePly:EmitSound( 'ambi/ui/success1.wav' )

    ePly.has_videocard = nil
    
    hook.Call( '[Ambi.MysticRP.PutVideocard]', nil, ePly, self, money )
end

Ents.Register( ENT.Class, 'ents', ENT )