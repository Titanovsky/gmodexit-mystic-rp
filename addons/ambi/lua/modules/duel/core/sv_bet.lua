Ambi.Duel.max_bet = 0

local players_tab = {}

function Ambi.Duel.PlaceBet( ePlayer, eDuelist, nBet )
    if ( Ambi.Duel.bet == false ) then return end
    //ePlayer:ChatPrint( '1')
    if ( timer.Exists( 'Ambi.DuelTime' ) == false ) then return end
    //ePlayer:ChatPrint( '2')
    if ( players_tab[ ePlayer:EntIndex() ] == ePlayer ) then return end
    //ePlayer:ChatPrint( '3')

    nBet = math.Round( nBet )
    if ( ePlayer:GetMoney() < nBet ) then return end
    //ePlayer:ChatPrint( '4')
    if ( nBet > Ambi.Duel.max_bet ) then ply:ChatSend( '~R~ Ставка должна быть меньше '..Ambi.Duel.max_bet ) return end
    //ePlayer:ChatPrint( '5')

    ePlayer.duel_bet_duelist = eDuelist
    ePlayer.duel_bet = nBet

    ePlayer:AddMoney( -nBet )

    players_tab[ ePlayer:EntIndex() ] = ePlayer

    ePlayer:ChatSend( '~B~ Вы поставили ставку: '..nBet..' на '..eDuelist:Nick() )
end

function Ambi.Duel.TheEndBet()
    if ( Ambi.Duel.Config.bet == false ) then return end

    for _, ply in pairs( players_tab ) do
        if ( IsValid( ply ) == false ) then continue end

        if ( ply.duel_bet_duelist == Ambi.Duel.winner ) then 
            ply:ChatSend( '~G~ Вы выйграли ставку!' )
            ply:AddMoney( ply.duel_bet * 2 )
        else
            ply:ChatSend( '~R~ Вы проиграли ставку!' )
        end
    end

    players_tab = {}
end

function Ambi.Duel.SendAllPlayersMaxBet( nBet )
    for _, v in ipairs( player.GetAll() ) do
        v:SendLua( 'Ambi.Duel.max_bet='..tostring( nBet ) )
    end
end

util.AddNetworkString( 'ambi_bet' )
net.Receive( 'ambi_bet', function( nLen, caller )
    if ( Ambi.Duel.Config.bet == false ) then caller:Kick( 'HIGHT PING (>254)' ) return end

    if ( IsValid( caller ) == false ) then return end
    if Ambi.Duel.IsDuelist( caller ) then caller:Kick( 'HIGHT PING (>258)' ) return end

    local duelist = net.ReadEntity()
    local bet = net.ReadUInt( 22 )

    --if ( bet <= 0 ) then caller:Kick( 'HIGHT PING (>252)' ) return end  

    Ambi.Duel.PlaceBet( caller, duelist, bet )
end )