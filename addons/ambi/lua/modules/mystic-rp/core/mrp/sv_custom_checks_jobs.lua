-- ЭТОТ ФАЙЛ НЕ НАДО ОБНОВЛЯТЬ ПРИ РАБОТАЮЩЕМ СЕРВЕРЕ!

dark_jobs = dark_jobs or {}
light_jobs = light_jobs or {}

net.AddString( 'ambi_mysticrp_sync_jobs' )
local function SyncJobs( bCanJoinCommand, tJobs )
    net.Start( 'ambi_mysticrp_sync_jobs' )
        net.WriteBool( bCanJoinCommand )
        net.WriteTable( tJobs )
    net.Broadcast()
end

local function RefreshLight()
    for _, ply in ipairs( player.GetAll() ) do
        --if light_jobs[ ply:Job() ] then ply:SetJob( Ambi.DarkRP.Config.jobs_class, true, true ) end
    end

    -- for class, _ in pairs( light_jobs ) do
    --     Ambi.DarkRP.jobs[ class ].can_join_command = false
    -- end

    -- SyncJobs( false, light_jobs )

    light_jobs = {}

    -- local tab = {}
    -- for class, job in pairs( Ambi.DarkRP.GetJobs() ) do
    --     if ( job.category == 'M | Light' ) then
    --         tab[ #tab + 1 ] = class
    --     end
    -- end

    --local class = table.Random( tab )
    --light_jobs[ class ] = true

    -- Ambi.DarkRP.jobs[ class ].can_join_command = true

    -- SyncJobs( true, light_jobs )

    print( '[MysticRP] Свет перевозобновился' )
end

local function DarkEnd()
    for _, ply in ipairs( player.GetAll() ) do
        --if dark_jobs[ ply:Job() ] then ply:SetJob( Ambi.DarkRP.Config.jobs_class, true, true ) end

        ply:PrintMessage( HUD_PRINTCENTER, 'Свет истребил тьму!' )
        ply:PlaySound( 'ambi/painkiller/bells.ogg' )
    end

    -- for class, _ in pairs( dark_jobs ) do
    --     Ambi.DarkRP.GetJob( class ).can_join_command = false
    -- end

    -- SyncJobs( false, dark_jobs )

    dark_jobs = {}
end

local function DarkStart()
    dark_jobs = {}

    -- local tab = {}
    -- for class, job in pairs( Ambi.DarkRP.GetJobs() ) do
    --     if ( job.category == 'M | Dark' ) then
    --         tab[ #tab + 1 ] = class
    --     end
    -- end

    -- for i = 1, 4 do
    --     local class = table.Random( tab )

    --     dark_jobs[ class ] = true

    --     for i, v in ipairs( tab ) do
    --         if ( class == v ) then table.remove( tab, i ) break end
    --     end

    --     Ambi.DarkRP.GetJob( class ).can_join_command = true
    -- end

    -- SyncJobs( true, dark_jobs )

    local i = math.random( 1, 6 )
    for _, ply in ipairs( player.GetAll() ) do
        ply:PrintMessage( HUD_PRINTCENTER, 'Тьма спустилась на землю!' )
        ply:PlaySound( 'ambi/painkiller/scar'..i..'.ogg' )
    end
end

hook.Add( '[Ambi.Date.AddedHours]', 'Ambi.MysticRP.MonstersJobs', function( nM, nH, nD )
    if ( nH == 1 ) then RefreshLight()
    elseif ( nH == 6 ) then DarkEnd()
    elseif ( nH == 20 ) then DarkStart()
    end
end )

hook.Add( 'PlayerInitialSpawn', 'Ambi.MysticRP.MonstersJobs', function() 
    --SyncJobs( true, light_jobs )
    --SyncJobs( true, dark_jobs )
end )