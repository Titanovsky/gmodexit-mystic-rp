local Ents, NW, C = Ambi.RegEntity, Ambi.NW, Ambi.General.Global.Colors
local ENT = {}

ENT.Class       = 'sinv_storage'
ENT.Type	    = 'anim'

ENT.PrintName	= 'Storage'
ENT.Author		= 'Ambi'
ENT.Category	= 'SimpleInventory'
ENT.Spawnable   = true

ENT.Stats = {
    type = 'Entity',
    module = 'SimpleInventory',
    model = 'models/props_junk/wood_crate001a.mdl',
    date = '27.06.2021 03:23:36'
}

Ents.Register( ENT.Class, 'ents', ENT )

if CLIENT then
    ENT.RenderGroup = Ambi.General.Global.RENDER

    function ENT:DrawTranslucent()
        self:DrawShadow( false )
    end
    
    return Ents.Register( ENT.Class, 'ents', ENT )
end 

function ENT:Initialize()
    Ents.Initialize( self, ENT.Stats.model )
    Ents.Physics( self )

    self.header = ''
    self.slots = 10
    self.items = {}

    for i = 1, self.slots do
        self.items[ i ] = { empty = true }
    end
end

function ENT:SetSlots( nSlots )
    for i = 1, math.floor( nSlots ) do
        self.items[ i ] = { empty = true }
    end

    self.slots = nSlots
end

function ENT:SetOptions( sHeader, sModel, nSlots )
    self:SetHeader( sHeader )
    self:SetModel( sModel )
    Ents.Physics( self )

    self:SetSlots( nSlots )
end

function ENT:SetItems( tItems )
    for slot, item in ipairs( tItems ) do
        if ( slot > self.slots ) then return end

        self.items[ slot ] = item
    end
end

function ENT:SetHeader( sHeader )
    self.header = sHeader or ''
    self:SetNWString( 'Header', sHeader or '' )
end

function ENT:GetItems()
    return self.items
end

function ENT:SetFilter( fFilter )
    -- new method from 20.04.2023
    self.Filter = fFilter
end

function ENT:Use( ePly )
    if self.player then ePly:ChatPrint( 'В этот ящик смотрит '..self.player:Nick() ) return end
    if self.Filter and not self.Filter( ePly ) then return end

    self.player = ePly
    Ambi.SimpleInventory.SetStorage( ePly, self )

    net.Start( 'ambi_sinv_storage_open' )
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