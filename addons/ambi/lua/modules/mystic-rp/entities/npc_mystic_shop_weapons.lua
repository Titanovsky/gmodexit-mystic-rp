local Ents, C = Ambi.Packages.Out( 'regentity, colors' )

-- ---------------------------------------------------------------------------------------------------------------------------------------------------
local ENT = {}

ENT.Class       = 'npc_mystic_shop_weapons'
ENT.Base	    = 'base_ai'
ENT.Type	    = 'ai'

ENT.PrintName	= 'NPC Show Weapons'
ENT.Author		= 'Ambi'
ENT.Category	= 'DarkRP - Мистик РП'
ENT.Spawnable   =  true

ENT.Stats = {
    type = 'Entity',
    module = 'MysticRP',
    model = 'models/player/space_kook_npc.mdl',
    date = '28.06.2023 13:20'
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
            draw.SimpleTextOutlined( 'Продавец Оружия', UI.SafeFont( '26 Ambi' ), 4, 0, C.AMBI, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, C.ABS_BLACK )
        cam.End3D2D()
    end

    function Ambi.MysticRP.ShowShopWeapons( nObj )
        local buyer = Entity( nObj )
        if not IsValid( buyer ) then return end

        local frame = GUI.DrawFrame( nil, 400, 600, 0, 0, '', true, true, true, function( self, w, h ) 
            Draw.Box( w, h, 0, 0, C.AMBI_BLACK )
        end )
        frame:Center()

        local pages = GUI.DrawScrollPanel( frame, frame:GetWide(), frame:GetTall() - 35, 0, 35, function( self, w, h ) 
        end )

        local offset = 0
        for i, wep in ipairs( Ambi.MysticRP.Config.buyer_weapons ) do
            local item = Ambi.Inv.GetItem( wep.item )
            if not item then return end
            if wep.perma then continue end

            offset = offset + 1

            local icon = item.icon

            local page = GUI.DrawPanel( pages, pages:GetWide(), 64, 0, ( offset - 1 ) * ( 64 + 4 ), function( self, w, h ) 
                Draw.Box( w, h, 0, 0, C.AMBI )

                Draw.SimpleText( 68, 4, item.name, UI.SafeFont( '26 Ambi' ), C.ABS_WHITE, 'top-left', 1, C.ABS_BLACK )
                Draw.SimpleText( 68, 26, wep.money..'$', UI.SafeFont( '20 Ambi' ), C.AMBI_GREEN, 'top-left', 1, C.ABS_BLACK )

                if wep.level then
                    Draw.SimpleText( 68, 44, wep.level..' LVL', UI.SafeFont( '20 Ambi' ), C.AMBI_PURPLE, 'top-left', 1, C.ABS_BLACK )
                end

                if icon and string.StartsWith( icon, 'http' ) then
                    Draw.Material( 128, 128, w / 2 - 128 / 2, 0, CL.Material( 'inv_'..item.class ) )
                end
            end )

            if icon and string.StartsWith( icon, 'model' ) then
                local mdl = GUI.DrawModel( page, 64, 64, 0, 0, icon )
            end

            local buy = GUI.DrawButton( page, page:GetWide(), page:GetTall(), 0, 0, nil, nil, nil, function( self )
                if ( LocalPlayer():GetMoney() < wep.money ) then surface.PlaySound( 'Error4' ) return end
                if ( LocalPlayer():GetLevel() < wep.level ) then surface.PlaySound( 'Error4' ) return end

                net.Start( 'ambi_mysticrp_buy_weapon' )
                    net.WriteUInt( i, 10 )
                    net.WriteEntity( buyer )
                net.SendToServer()
            end, function() end )
        end
        --        icon
        --        text (money and level)
        --        button
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
    ePly:SendLua( 'Ambi.MysticRP.ShowShopWeapons('..self:EntIndex()..')' )
end

net.AddString( 'ambi_mysticrp_buy_weapon' )
net.Receive( 'ambi_mysticrp_buy_weapon', function( _, ePly ) 
    local i = net.ReadUInt( 10 )
    
    local wep = Ambi.MysticRP.Config.buyer_weapons[ i ]
    if not wep then return end
    if ( ePly:GetMoney() < wep.money ) then return end
    if ( ePly:GetLevel() < wep.level ) then return end

    local buyer = net.ReadEntity()
    if not IsValid( buyer ) then return end
    if not buyer:CheckDistance( ePly, 80 ) then return end

    local count = ePly:GetInvItemCount( wep.item )

    ePly:AddInvItemOrDrop( wep.item, 1 )

    ePly:AddMoney( -wep.money )
    ePly:ChatPrint( 'Вы купили оружие: '..wep.item )
    ePly:EmitSound( 'ambi/money/send2.ogg' )

    hook.Call( '[Ambi.MysticRP.BuyedShopWeapons]', nil, ePly )
end )