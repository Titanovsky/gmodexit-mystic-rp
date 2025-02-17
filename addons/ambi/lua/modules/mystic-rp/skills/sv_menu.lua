net.AddString( 'ambi_mystic_buy_skill' )

net.Receive( 'ambi_mystic_buy_skill', function( _, ePly ) 
    local skill = net.ReadString()

    local tab = Ambi.Skills.GetSkill( skill )
    if not tab then return end

    local len = #tab.nodes
    
    local node = ( ePly.skills[ skill ] or 0 ) + 1
    if ( node > #tab.nodes ) then return end

    node = tab.nodes[ node ]
    
    local points = ePly:GetSkillPoints()
    if ( points < node.cost ) then return end

    ePly:AddSkillPoints( -node.cost )
    ePly:AddSkill( skill )
    ePly:ChatPrint( 'Вы улучшили навык '..tab.name..' ('..ePly:GetSkill( skill )..'/'..#tab.nodes..')' )
end )