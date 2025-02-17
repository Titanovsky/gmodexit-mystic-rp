local Ents, NW, C = Ambi.RegEntity, Ambi.NW, Ambi.General.Global.Colors
local ENT = {}

ENT.Class       = 'metz_muratic_acid'
ENT.Type	    = 'anim'

ENT.PrintName	= 'Соляная Кислота'
ENT.Author		= 'Ambi'
ENT.Category	= 'Metz'
ENT.Spawnable   =  true

ENT.Stats = {
    type = 'Entity',
    module = 'Metz',
    date = '04.07.2022 17:36'
}

function ENT:GetAmount()
    return self.nw_amount
end

Ents.Register( ENT.Class, 'ents', ENT )

if SERVER then
    function ENT:Initialize()
        Ents.Initialize( self, Ambi.Metz.Config.ingredient_muratic_acid_model )
        Ents.Physics( self, MOVETYPE_VPHYSICS, SOLID_VPHYSICS, nil, true, true )

        self:SetColor( Ambi.Metz.Config.ingredient_muratic_acid_color )
        self:SetAmount( Ambi.Metz.Config.ingredient_muratic_acid_amount )
    end

    function ENT:OnTakeDamage( dmgInfo )
        Ambi.Metz.IngredientTakeRemove( eObj, dmgInfo )
    end

    function ENT:StartTouch( eObj )
        Ambi.Metz.IngredientStartTouch( self, eObj )
    end

    function ENT:SetAmount( nAmount )
        self.nw_amount = nAmount
    end

    return Ents.Register( ENT.Class, 'ents', ENT )
end

ENT.RenderGroup = RENDERGROUP_BOTH

local COLOR_BLACK = Color(100, 100, 100, 255)
local UI = Ambi.Packages.Out( 'ui' )

function ENT:Draw()
    self:DrawModel()
    self:DrawShadow( false )

    if not self:GetAmount() then return end
    if not self:CheckDistance( LocalPlayer(), Ambi.Metz.Config.draw_distance ) then return end

    local pos = self:GetPos()
	local ang = self:GetAngles()

	ang:RotateAroundAxis( ang:Up(), 90 )
	ang:RotateAroundAxis( ang:Forward(), 90 )

    cam.Start3D2D( pos + ang:Up() * 4.95, ang, 0.07 )
        draw.SimpleTextOutlined( 'Соляная', UI.SafeFont( '24 Ambi' ), 0, -14, C.ABS_WHITE, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, C.ABS_BLACK )
        draw.SimpleTextOutlined( 'Кислота', UI.SafeFont( '24 Ambi' ), 0, 10, C.ABS_WHITE, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, C.ABS_BLACK )
        draw.SimpleTextOutlined( self:GetAmount(), UI.SafeFont( '54 Ambi' ), 0, 64, C.ABS_WHITE, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, C.ABS_BLACK )
    cam.End3D2D()
end

Ents.Register( ENT.Class, 'ents', ENT )