local Ents, C = Ambi.Packages.Out( 'regentity, colors' )

local MAX = 30000

-- ---------------------------------------------------------------------------------------------------------------------------------------------------
local ENT = {}

ENT.Class       = 'npc_mystic_casino'
ENT.Base	    = 'base_ai'
ENT.Type	    = 'ai'

ENT.PrintName	= 'NPC Casino'
ENT.Author		= 'Ambi'
ENT.Category	= 'DarkRP - Мистик РП'
ENT.Spawnable   =  true

ENT.Stats = {
    type = 'Entity',
    module = 'MysticRP',
    model = 'models/Barney.mdl',
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
            if timer.Exists( 'Casino:'..self:EntIndex() ) then
                local time = tostring( math.floor( timer.TimeLeft( 'Casino:'..self:EntIndex() ) + 1 ) )

                Draw.SimpleText( 8, 4, time, UI.SafeFont( '40 Ambi' ), C.RU_PINK, 'top-left', 1, C.ABS_BLACK )
            else
                draw.SimpleTextOutlined( 'Крупье', UI.SafeFont( '26 Ambi' ), 4, 0, C.RU_PINK, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, C.ABS_BLACK )
            end
        cam.End3D2D()
    end

    function Ambi.MysticRP.ShowCasino( nObj )
        local buyer = Entity( nObj )
        if not IsValid( buyer ) then return end

        local frame = GUI.DrawFrame( nil, 400, 400, 0, 0, '', true, true, true, function( self, w, h ) 
            Draw.Box( w, h, 0, 0, C.AMBI_BLACK )

            Draw.SimpleText( 4, 4, self.text, UI.SafeFont( '28 Ambi' ), self.color, 'top-left', 1, C.ABS_BLACK )
        end )
        frame:Center()
        frame.text = ''
        frame.color = Color( 0, 0, 0 )

        local is_red

        local red = GUI.DrawButton( frame, frame:GetWide() / 2, 200, 0, 40, nil, nil, nil, function( self )
            is_red = true

            frame.text = 'Красный'
            frame.color = Color( 233,81, 76)
        end, function( self, w, h ) 
            Draw.Box( w, h, 0, 0, C.ABS_BLACK )
            Draw.Box( w - 4, h - 4, 2, 2, C.AMBI_RED )
        end )

        local blue = GUI.DrawButton( frame, frame:GetWide() / 2, 200, frame:GetWide() - ( frame:GetWide() / 2 ), 40, nil, nil, nil, function( self )
            is_red = false

            frame.text = 'Синий'
            frame.color = Color( 76,167, 241)
        end, function( self, w, h ) 
            Draw.Box( w, h, 0, 0, C.ABS_BLACK )
            Draw.Box( w - 4, h - 4, 2, 2, C.AMBI_BLUE )
        end )

        local te_money = GUI.DrawTextEntry( frame, frame:GetWide() / 1.4, 28, frame:GetWide() / 2 - ( frame:GetWide() / 1.4 ) / 2, frame:GetTall() - 40 - 28 - 12, UI.SafeFont( '26 Ambi' ), nil, 1000, nil, nil, false, true )

        local use = GUI.DrawButton( frame, frame:GetWide() / 2, 40, frame:GetWide() / 2 - frame:GetWide() / 4, frame:GetTall() - 40 - 4, nil, nil, nil, function( self )
            local money = tonumber( te_money:GetValue() )
            if ( money <= 0 ) or ( money > MAX ) then surface.PlaySound( 'Error4' ) return end
            if ( LocalPlayer():GetMoney() < money ) then surface.PlaySound( 'Error4' ) return end
            if ( is_red == nil ) then surface.PlaySound( 'Error4' ) return end

            net.Start( 'ambi_mysticrp_use_casino' )
                net.WriteBool( is_red )
                net.WriteUInt( money, 15 )
                net.WriteEntity( buyer )
            net.SendToServer()

            timer.Create( 'Casino:'..buyer:EntIndex(), 3, 1, function() end )

            frame:Remove()
        end, function( self, w, h )
            Draw.Box( w, h, 0, 0, Color( 0, 0, 0, 100 ) )

            Draw.SimpleText( w / 2, h / 2, 'Играть', UI.SafeFont( '32 Ambi' ), C.ABS_WHITE, 'center', 1, C.ABS_BLACK )
        end )
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
    ePly:SendLua( 'Ambi.MysticRP.ShowCasino('..self:EntIndex()..')' )
end

net.AddString( 'ambi_mysticrp_use_casino' )
net.Receive( 'ambi_mysticrp_use_casino', function( _, ePly ) 
    if ePly.dont_use_casino then return end

    local is_red = net.ReadBool()
    local money = net.ReadUInt( 15 )
    if ( money > MAX ) then return end
    if ( money <= 0 ) then return end
    if ( ePly:GetMoney() < money ) then return end

    local casino = net.ReadEntity()
    if not IsValid( casino ) then return end
    --todo distance check
    --todo check class

    ePly:AddMoney( -money )
    ePly.dont_use_casino = true

    casino:EmitSound( 'ambi/money/send1.ogg' )

    timer.Simple( 3, function()
        if not IsValid( ePly ) then return end
        ePly.dont_use_casino = false

        local random_is_red = tobool( math.random( 0, 1 ) )

        local color = random_is_red and 'R' or 'B'
        local text = random_is_red and 'Красное' or 'Синее'

        if ( random_is_red == is_red ) then
            money = money * 2

            ePly:ChatSend( '~G~ • ~W~ Выпало ~'..color..'~ '..text..' ~W~ и выйграли: ~G~ '..money..'$' )
            ePly:AddMoney( money )

            casino:EmitSound( 'ambi/other/donationalerts.mp3' )
        else
            ePly:ChatSend( '~R~ • ~W~ Выпало ~'..color..'~ '..text..' ~W~ и проиграли!' )
        end

        hook.Call( '[Ambi.MysticRP.UsedCasino]', nil, ePly )
    end )
end )