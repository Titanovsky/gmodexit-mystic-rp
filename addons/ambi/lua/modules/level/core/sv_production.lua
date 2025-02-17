hook.Add( 'PlayerDeath', 'Ambi.Level.ProductionXP', function( eVictim, _, eAttacker )
    if ( Ambi.Level.Config.production_xp_for_kill_player == 0 ) then return end 
    if not IsValid( eAttacker ) or not eAttacker:IsPlayer() then return end
    if ( eAttacker == eVictim ) then return end
	print(Ambi.Level.Config.production_xp_for_kill_player)
    eAttacker:AddXP( Ambi.Level.Config.production_xp_for_kill_player )
end )

hook.Add( 'OnNPCKilled', 'Ambi.Level.ProductionXP', function( eNPC, eAttacker )
    if ( Ambi.Level.Config.production_xp_for_kill_npc == 0 ) then return end 
    if not IsValid( eAttacker ) or not eAttacker:IsPlayer() then return end

    eAttacker:AddXP( Ambi.Level.Config.production_xp_for_kill_npc )
end )