local SKILL = 'mystic_run'

local ACCESS_JOBS = {
    [ 'M | Dark' ] = true,
    [ 'M | Light' ] = true,
}

Ambi.Skills.AddSkill( SKILL, 'Мистическая Скорость', 'Навыки для мистиков' )
Ambi.Skills.AddNode( 1, SKILL, 32, '', '', function( ePly ) 
    ePly:SetTimerSimple( 0.25, function() --! Из-за разных таймингов Оружия, Проф. Способностей и так далее, нужен таймер
        if not ACCESS_JOBS[ ePly:GetJob() ] then return end

        local runspeed = ePly:GetRunSpeed() * 1.25
        local walkspeed = ePly:GetWalkSpeed() * 1.25

        ePly:SetRunSpeed( runspeed )
        ePly:SetWalkSpeed( walkspeed )
    end )
end )
Ambi.Skills.AddNode( 2, SKILL, 64, '', '', function( ePly )
    ePly:SetTimerSimple( 0.25, function()
        if not ACCESS_JOBS[ ePly:GetJob() ] then return end

        local runspeed = ePly:GetRunSpeed() * 1.5
        local walkspeed = ePly:GetWalkSpeed() * 1.5

        ePly:SetRunSpeed( runspeed )
        ePly:SetWalkSpeed( walkspeed )
    end )
end )