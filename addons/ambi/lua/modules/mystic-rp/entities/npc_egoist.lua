local Ents, C = Ambi.Packages.Out( 'regentity, colors' )

-- ---------------------------------------------------------------------------------------------------------------------------------------------------
local ENT = {}

ENT.Class       = 'npc_mystic_egoist'
ENT.Base	    = 'base_ai'
ENT.Type	    = 'ai'

ENT.PrintName	= 'NPC Egoist'
ENT.Author		= 'Ambi'
ENT.Category	= 'DarkRP - Мистик РП'
ENT.Spawnable   =  true

ENT.Stats = {
    type = 'Entity',
    module = 'MysticRP',
    model = 'models/player/errol/left4dead/witch.mdl',
    date = '25.07.2023 10:05'
}

Ents.Register( ENT.Class, 'ents', ENT )

if CLIENT then
    local C, GUI, Draw, UI, CL = Ambi.Packages.Out( '@d, ContentLoader' )
    local W, H = ScrW(), ScrH()

    ENT.RenderGroup = RENDERGROUP_BOTH

    function ENT:DrawTranslucent()
        Ents.Draw( self, false )

        if ( LocalPlayer():GetPos():Distance( self:GetPos() ) > 800 ) then return end

        local rot = ( self:GetPos() - EyePos() ):Angle().yaw - 90
        local head_bone = self:LookupBone( 'ValveBiped.Bip01_Head1' )
        local head = self:GetBonePosition( head_bone )

        cam.Start3D2D( head + Vector( 0, 0, 12 ), Angle( 0, rot, 90 ), 0.1 )
            Draw.SimpleText( 22, 1, 'Эгоист', UI.SafeFont( '48 Ambi' ), C.AMBI_BLOOD, 'top-center', 1, C.ABS_BLACK )
        cam.End3D2D()
    end

    return Ents.Register( ENT.Class, 'ents', ENT )
end

function ENT:Initialize()
    Ents.Initialize( self, self.Stats.model )
    Ents.Hull( self )
    Ents.Physics( self, MOVETYPE_NONE, SOLID_BBOX, COLLISION_GROUP_PLAYER, false, false, true )
    Ents.Capability( self, CAP_ANIMATEDFACE )
    Ents.Capability( self, CAP_TURN_HEAD )
end

function ENT:Use( ePly )
    IGS.UI( ePly )
end