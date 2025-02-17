local Ents, C = Ambi.RegEntity, Ambi.General.Global.Colors
local classes = {}

-- ----------------------------------------------------------------------------------------------------------------------------
classes[ 'smp_zero' ] = {}
classes[ 'smp_zero' ].name = 'Zero Printer'
classes[ 'smp_zero' ].material = 'models/debug/debugwhite'
classes[ 'smp_zero' ].color = C.ABS_WHITE
classes[ 'smp_zero' ].max_upgrade = 4

classes[ 'smp_colourful' ] = {}
classes[ 'smp_colourful' ].name = 'Colourful Printer'
classes[ 'smp_colourful' ].material = 'models/debug/debugwhite'
classes[ 'smp_colourful' ].color = C.AMBI_RED
classes[ 'smp_colourful' ].max_upgrade = 3

classes[ 'smp_quantum' ] = {}
classes[ 'smp_quantum' ].name = 'Quantum Printer'
classes[ 'smp_quantum' ].material = 'models/debug/debugwhite'
classes[ 'smp_quantum' ].color = Color( 255, 191, 0, 230 )
classes[ 'smp_quantum' ].max_upgrade = 2

classes[ 'smp_vip' ] = {}
classes[ 'smp_vip' ].name = 'VIP Printer'
classes[ 'smp_vip' ].material = 'models/debug/debugwhite'
classes[ 'smp_vip' ].color = C.ABS_YELLOW
classes[ 'smp_vip' ].max_upgrade = 0
classes[ 'smp_vip' ].random_amount = true

classes[ 'smp_premium' ] = {}
classes[ 'smp_premium' ].name = 'Premium Printer'
classes[ 'smp_premium' ].material = 'models/debug/debugwhite'
classes[ 'smp_premium' ].color = Color( 152, 60, 171, 255 )
classes[ 'smp_premium' ].max_upgrade = 0
classes[ 'smp_premium' ].random_amount = true

-- ----------------------------------------------------------------------------------------------------------------------------
for class, info in pairs( classes ) do
    local subclass = string.Explode( '_', class )[ 2 ]
    local ENT = {}

    ENT.Class       = class
    ENT.Type	    = 'anim'

    ENT.PrintName	= info.name
    ENT.Author		= 'Ambi'
    ENT.Category	= 'Small Money Printers'
    ENT.Spawnable   =  true
    ENT.max_upgrade = info.max_upgrade

    ENT.Stats = {
        type = 'Entity',
        module = 'SmallMoneyPrinters',
        date = '06.07.2022 07:41'
    }

    function ENT:GetMoney()
        return self.nw_Money
    end

    function ENT:GetUpgrade()
        return self.nw_Upgrade
    end

    if CLIENT then        
        ENT.RenderGroup = RENDERGROUP_BOTH

        function ENT:Draw()
            self:DrawModel()
            self:DrawShadow( false )

            if ( LocalPlayer():GetPos():Distance( self:GetPos() ) <= Ambi.SmallMoneyPrinters.Config.draw_distance ) then Ambi.SmallMoneyPrinters.ShowDisplay( self ) end
        end
    else
        Ambi.SmallMoneyPrinters.CreateServerSideMoneyPrinter( ENT, info, subclass )
    end 

    Ents.Register( ENT.Class, 'ents', ENT )
end

-- ----------------------------------------------------------------------------------------------------------------------------
local ENT = {}

ENT.Class       = 'smp_upgrader'
ENT.Type	    = 'anim'

ENT.PrintName	= 'Upgrader'
ENT.Author		= 'Ambi'
ENT.Category	= 'Small Money Printers'
ENT.Spawnable   =  true

ENT.Stats = {
    type = 'Entity',
    module = 'SmallMoneyPrinters',
    model = 'models/props_c17/playgroundTick-tack-toe_block01a.mdl',
    date = '06.07.2022 07:54'
}

Ents.Register( ENT.Class, 'ents', ENT )

if CLIENT then
    ENT.RenderGroup = RENDERGROUP_BOTH

    function ENT:DrawTranslucent()
        self:DrawShadow( false )
    end

    return Ents.Register( ENT.Class, 'ents', ENT )
end 

function ENT:Initialize()
    Ents.Initialize( self, ENT.Stats.model )
    Ents.Physics( self, MOVETYPE_VPHYSICS, SOLID_VPHYSICS, nil, true, true )

    self:SetHealth( 20 )
    self:SetMaxHealth( 20 )
    self:SetColor( C.AMBI_YELLOW ) 
    self:SetMaterial( 'models/debug/debugwhite' )
end

function ENT:OnTakeDamage( damageInfo )
    self:SetHealth( self:Health() - damageInfo:GetDamage() )
    if ( self:Health() <= 0 ) then self:Remove() return end
end

Ents.Register( ENT.Class, 'ents', ENT )