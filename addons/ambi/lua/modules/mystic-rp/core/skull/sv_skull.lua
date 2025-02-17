local C, SQL = Ambi.General.Global.Colors, Ambi.SQL
local PLAYER = FindMetaTable( 'Player' )

-- ====================================================================================================================================================== --
function PLAYER:OpenSkull( nType )
    self.nw_Skull = nType

    local items = Ambi.MysticRP.cases[ nType ]
    if not items then return end

    local random = {}
    for class, tab in pairs( items ) do
        if ( class == 'item' ) then continue end

        for i = 1, 100 do
            random[ i ] = ( math.random( 0, 100 ) <= tab.chance ) and class or random[ i ]
            if not random[ i ] then random[ i ] = 'Ничего' end
        end
    end

    local reward = random[ 60 ] -- on client only 60-th slot is reward

    self:RemoveInvItem( items.item, 1 )
    self:ChatPrint( 'Вы открыли кейс: '..items.item )

    if ( reward == 'Ничего' ) then
        self:ChatPrint( 'К сожалению, Вы ничего не выйграли' )
    else
        local item = Ambi.Inv.GetItem( reward )
        if not item then self:ChatPrint( 'Такого предмета нет! Обратитесь к администраторам' ) return end

        self:AddInvItemOrDrop( reward, 1 )
        self:ChatSend( '~AMBI~ Вы получили: ~AMBI_BLUE~ '..item.name )
    end

    hook.Call( '[Ambi.MysticRP.OpenSkull]', nil, self )
end

-- ====================================================================================================================================================== --
net.AddString( 'ambi_mysticrp_case_give_reward' )

net.AddString( 'ambi_mysticrp_case_start' )
net.Receive( 'ambi_mysticrp_case_start', function( _, ePly )
    if ePly:GetTimer( 'CaseStart' ) then return end
    ePly:SetTimer( 'CaseStart', '', 6 )

    local type = net.ReadUInt( 2 ) -- [0;3]
    local items = Ambi.MysticRP.cases[ type ]
    if not items then return end

    local random = {}
    for class, tab in pairs( items ) do
        if ( class == 'item' ) then continue end

        for i = 1, 100 do
            random[ i ] = ( math.random( 0, 100 ) <= tab.chance ) and class or random[ i ]
            if not random[ i ] then random[ i ] = 'Ничего' end
        end
    end

    local reward = random[ 60 ] -- on client only 60-th slot is reward
    net.Start( 'ambi_mysticrp_case_give_reward' ) 
        net.WriteString( reward )
    net.Send( ePly )

    ePly:RemoveInvItem( items.item, 1 )
    ePly:ChatPrint( 'Вы открыли кейс: '..items.item )

    timer.Simple( 28, function()
        if not IsValid( ePly ) then return end

        if ( reward == 'Ничего' ) then
            ePly:ChatPrint( 'К сожалению, Вы ничего не выйграли' )
        else
            local item = Ambi.Inv.GetItem( reward )
            if not item then ePly:ChatPrint( 'Такого предмета нет! Обратитесь к администраторам' ) return end

            ePly:AddInvItemOrDrop( reward, 1 )
            ePly:ChatSend( '~AMBI~ Вы получили: ~AMBI_BLUE~ '..item.name )
        end

        hook.Call( '[Ambi.MysticRP.OpenSkull]', nil, ePly )
    end )
end )

net.AddString( 'ambi_mysticrp_case_cancel' )
net.Receive( 'ambi_mysticrp_case_cancel', function( _, ePly )
    if not ePly.nw_Skull then return end

    ePly.nw_Skull = nil
end )