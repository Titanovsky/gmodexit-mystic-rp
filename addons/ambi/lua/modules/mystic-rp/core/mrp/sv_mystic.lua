hook.Add( '[Ambi.DarkRP.GetPaydaySalary]', 'Ambi.MysticRP.Payday', function( ePly )
    if ( ePly:TimeConnected() < 60 * 15 ) then ePly:ChatSend( '~R~ Вы не наиграли 15 минут!' ) return end

    local xp = 200 + ( math.random( 2, 10 ) * ePly:GetLevel() )
    ePly:AddXP( xp )
    ePly:ChatSend( '~AMBI~ +'..xp..' XP' )

    local count = math.random( 0, 3 )
    if ( count > 0 ) then
        ePly:AddInvItem( 'skull1', count )

        ePly:ChatSend( '~AMBI~ +'..count..' Черепа' )
    end

    ePly:ChatSend( '~R~ [Мистик РП] ~W~ Спасибо вам за игру :)' )
end )

hook.Add( '[Ambi.Level.SetLevel]', 'Ambi.MysticRP.AddLevel', function( ePly, nLevel )
    ePly:ChatSend( '~AMBI~ • ~W~ Поздравляем, теперь у вас ~AMBI_BLUE~ '..tostring( nLevel )..' ~W~ уровень!' )
    ePly:ChatSend( '~AMBI~ • ~W~ +1 Слот в инвентаре' )
    ePly:SoundSend( 'ambi/other/complete_gta_sa.mp3' )

    local inv = Ambi.Inv.GetInventory( Ambi.Inv.GetKey( ePly ) )
    if not inv then return end

    local items = inv.items

    ePly:SetInvSlots( #items + 1 )
end )

hook.Add( '[Ambi.DarkRP.SetJob]', 'Ambi.MysticRP.GiveLifeForMystic', function( ePly, sClass, _, _, tJob )
    if tJob.dark_mystic or tJob.light_mystic then 
        ePly.nw_Life_job = 4

        ePly:ChatSend( '~AMBI_PURPLE~ • ~W~ У вас ~AMBI_PURPLE~ '..ePly.nw_Life_job..' ~W~ жизней на Мистика' )
        ePly:ChatSend( '~AMBI_PURPLE~ • ~W~ Данный мистик заблокирован на 10 минут для вас!' )
        ePly:BlockJob( sClass, 60 * 10 )
    else
        ePly.nw_Life_job = nil  
    end
end )

hook.Add( '[Ambi.DarkRP.CanSetJob]', 'Ambi.MysticRP.BlockLevel', function( ePly, sClass, bForce, _, tJob ) 
    if not tJob or ePly:IsBot() then return end
    if bForce or ePly:IsAdmin() then return end

    local lvl = tJob.level
    if lvl and ( ePly:GetLevel() < lvl ) then
        ePly:ChatSend( '~R~ Вам нужен '..lvl..' уровень!' ) 
        ePly:SoundSend( 'Error4' ) 
        
        return false 
    end
end )

hook.Add( 'PlayerDeath', 'Ambi.MysticRP.MinusLifeForMystic', function( ePly ) 
    local life = ePly.nw_Life_job
    if not life then return end

    ePly.nw_Life_job = life - 1
    
    if ( ePly.nw_Life_job <= 0 ) then
        ePly:SetJob( 'TEAM_CITIZEN', true )
        ePly:ChatSend( '~AMBI_PURPLE~ • ~W~ У вас закончились жизни на данного мистика' )
    end
end )