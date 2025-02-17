local SKILL = 'civil_phys'

Ambi.Skills.AddSkill( SKILL, 'Физическая Сила', 'Навыки для обычных людей' )
Ambi.Skills.AddNode( 1, SKILL, 1, '', '', function( ePly ) ePly.skill_phys_damage = 1.05 end )
Ambi.Skills.AddNode( 2, SKILL, 5, '', '', function( ePly ) ePly.skill_phys_damage = 1.1 end )
Ambi.Skills.AddNode( 3, SKILL, 10, '', '', function( ePly ) ePly.skill_phys_damage = 1.25 end )
Ambi.Skills.AddNode( 4, SKILL, 25, '', '', function( ePly ) ePly.skill_phys_damage = 1.5 end )
Ambi.Skills.AddNode( 5, SKILL, 50, '', '', function( ePly ) ePly.skill_phys_damage = 1.75 end  )

-- ------------------------------------------------------------------------------------------------------------
local SKILL = 'civil_medic'

Ambi.Skills.AddSkill( SKILL, 'Медицина', 'Навыки для обычных людей' )
Ambi.Skills.AddNode( 1, SKILL, 15, '', '', function( ePly ) 
    ePly:SetTimerSimple( 0.25, function() --! Из-за разных таймингов Оружия, Проф. Способностей и так далее, нужен таймер
        local hp = ePly:Health() * 1.25
        local max_hp = ePly:GetMaxHealth() * 1.25

        ePly:SetHealth( hp )
        ePly:SetMaxHealth( max_hp ) 
    end )
end )
Ambi.Skills.AddNode( 2, SKILL, 30, '', '', function( ePly )
    ePly:SetTimerSimple( 0.25, function()
        local hp = ePly:Health() * 1.5
        local max_hp = ePly:GetMaxHealth() * 1.5

        ePly:SetHealth( hp )
        ePly:SetMaxHealth( max_hp ) 
    end )
end )

-- ------------------------------------------------------------------------------------------------------------
if CLIENT then return end

hook.Add( 'EntityTakeDamage', 'Ambi.MysticRP.SkillsDamage', function( eObj, dmgInfo ) 
    local attacker = dmgInfo:GetAttacker()
    if not IsValid( attacker ) or not attacker.skill_phys_damage then return end

    dmgInfo:SetDamage( dmgInfo:GetDamage() * attacker.skill_phys_damage )
end )