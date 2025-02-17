hook.Add( 'PlayerInitialSpawn', 'Ambi.Authorization.Start', function( ePly )
    if ePly:IsBot() then return end

    ePly:Freeze( true )
end )

hook.Add( 'PlayerSay', 'Ambi.Authorization.Restrict', function( ePly ) 
    if not ePly:IsAuth() then ePly:AuthKick( 'Авторизуйтесь (Сообщение в чат)' ) return '' end
end )

hook.Add( 'PlayerSpray', 'Ambi.Authorization.Restrict', function( ePly ) 
    if not ePly:IsAuth() then ePly:AuthKick( 'Авторизуйтесь (Спрей)' ) return false end
end )

hook.Add( 'PlayerSpawnObject', 'Ambi.Authorization.Restrict', function( ePly ) 
    if not ePly:IsAuth() then ePly:AuthKick( 'Авторизуйтесь (Спавн Объектов)' ) return false end
end )

hook.Add( 'PlayerSpawnSENT', 'Ambi.Authorization.Restrict', function( ePly ) 
    if not ePly:IsAuth() then ePly:AuthKick( 'Авторизуйтесь (Спавн Энтити)' ) return false end
end )

hook.Add( 'PlayerSpawnSWEP', 'Ambi.Authorization.Restrict', function( ePly ) 
    if not ePly:IsAuth() then ePly:AuthKick( 'Авторизуйтесь (Спавн Оружия)' ) return false end
end )

hook.Add( 'PlayerGiveSWEP', 'Ambi.Authorization.Restrict', function( ePly ) 
    if not ePly:IsAuth() then ePly:AuthKick( 'Авторизуйтесь (Взятие Оружия)' ) return false end
end )

hook.Add( 'PlayerSpawnVehicle', 'Ambi.Authorization.Restrict', function( ePly ) 
    if not ePly:IsAuth() then ePly:AuthKick( 'Авторизуйтесь (Спавн Автомобилей)' ) return false end
end )

hook.Add( 'PlayerSpawnNPC', 'Ambi.Authorization.Restrict', function( ePly ) 
    if not ePly:IsAuth() then ePly:AuthKick( 'Авторизуйтесь (Спавн NPC)' ) return false end
end )

hook.Add( 'PlayerCanHearPlayersVoice', 'Ambi.Authorization.Restrict', function( eListener, eTalker ) 
    if not eTalker:IsAuth() then return false end
end )