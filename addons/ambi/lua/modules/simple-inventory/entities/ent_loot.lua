local Ents, NW, C = Ambi.RegEntity, Ambi.NW, Ambi.General.Global.Colors
local ENT = {}

ENT.Class       = 'sinv_loot'
ENT.Type	    = 'anim'

ENT.PrintName	= 'Loot'
ENT.Author		= 'Ambi'
ENT.Category	= 'SimpleInventory'
ENT.Spawnable   = true

ENT.Stats = {
    type = 'Entity',
    module = 'SimpleInventory',
    model = Ambi.SimpleInventory.Config.model_loot,
    date = '27.06.2021 20:35:38'
}

Ents.Register( ENT.Class, 'ents', ENT )

if CLIENT then
    local UI = Ambi.Packages.Out( 'ui' )
    
    ENT.RenderGroup = RENDERGROUP_BOTH

    function ENT:DrawTranslucent()
        self:DrawShadow( false )

        if ( LocalPlayer():GetPos():Distance( self:GetPos() ) > 800 ) then return end

        local rot = ( self:GetPos() - EyePos() ):Angle().yaw - 90
        local pos = self:GetPos() + Vector( 0, 0, self:GetModelRadius() )

        cam.Start3D2D( pos + Vector( 0, 0, 12 ), Angle( 0, rot, 90 ), 0.1 )
            draw.SimpleTextOutlined( self:GetNWString( 'Header' ), UI.SafeFont( '26 Ambi' ), 4, 0, self:GetColor(), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, C.ABS_BLACK )
        cam.End3D2D()
    end
    
    return Ents.Register( ENT.Class, 'ents', ENT )
end 

function ENT:Initialize()
    Ents.Initialize( self, ENT.Stats.model )
    Ents.Physics( self )

    self.header = ''
    self.items = {}
end

function ENT:SetOptions( sHeader, sType, sModel, cColor, tItems )
    self.items = {}
    self:SetType( sType )
    self:SetHeader( sHeader )
    if sModel then self:SetModel( sModel ) end
    if cColor then self:SetColor( cColor ) end
    Ents.Physics( self )

    for slot, item in ipairs( tItems ) do
        self.items[ slot ] = item
    end
end

function ENT:SetType( sType )
    self.type = sType or ''
    self:SetNWString( 'Type', sType or '' )
end

function ENT:SetHeader( sHeader )
    self.header = sHeader or ''
    self:SetNWString( 'Header', sHeader or '' )
end

function ENT:GetItems()
    return self.items
end

function ENT:Use( ePly )
    if self.player then ePly:ChatPrint( 'В этот лут смотрит '..self.player:Nick() ) return end

    self.player = ePly
    Ambi.SimpleInventory.SetLoot( ePly, self )

    net.Start( 'ambi_sinv_loot_open' )
    net.Send( ePly )
end

function ENT:Think()
    if self.player then 
        if not IsValid( self.player ) or not self.player:Alive() then self.player = nil end
    end
end

function ENT:OnTakeDamage( damageInfo )
    self:SetHealth( self:Health() - damageInfo:GetDamage() )

    if ( self:Health() <= 0 ) then self:Remove() return end
end

Ents.Register( ENT.Class, 'ents', ENT )