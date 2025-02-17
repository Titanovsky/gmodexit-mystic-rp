function Ambi.RobObj.StartEvent()
    timer.Create( 'Ambi.RobObj.StartEvent', math.random( Ambi.RobObj.Config.delays.min_delay, Ambi.RobObj.Config.delays.max_delay ), 1, function()
        Ambi.RobObj.StartEvent()

        if ( #player.GetAll() < Ambi.RobObj.Config.min_online ) then return end

        Ambi.RobObj.Start()
    end )
end

function Ambi.RobObj.Pay()
    if ( #ents.FindByClass( Ambi.RobObj.Config.object.class ) >= #Ambi.RobObj.Config.object.places ) then
        local money = math.random( Ambi.RobObj.Config.rewards.min_money_save, Ambi.RobObj.Config.rewards.max_money_save )

        for _, ply in ipairs( player.GetAll() ) do
            if Ambi.RobObj.Config.can_rob_jobs[ ply:GetJob() ] then continue end
            
            ply:AddMoney( money )
            ply:ChatSend( 'Груз был благополучно доставлен' )
        end
    end
end

function Ambi.RobObj.Start()
    Ambi.RobObj.valid_event = true

    Ambi.RobObj.SpawnNPCs()
    Ambi.RobObj.SpawnObjects()
    if Ambi.RobObj.Config.security.repeat_spawn then Ambi.RobObj.RepeatSpawnNPCs() end

    for _, ply in ipairs( player.GetAll() ) do
        ply:ChatSend( '~AMBI~ [•] ~W~ На Городской Склад прибыл груз с Золотом, его выгруз будет через 10 минут.' )
    end 

    timer.Create( 'Ambi.RobObj.EndEvent', Ambi.RobObj.Config.delays.time_rob, 1, Ambi.RobObj.End )
end

function Ambi.RobObj.End()
    Ambi.RobObj.valid_event = false

    Ambi.RobObj.Pay()
    Ambi.RobObj.GarbageCollector()
end

-- ---------------------\------------------------------------------------------------------------------------------------------------------------
hook.Add( 'Initialize', 'Ambi.RobObj.StartEvent', Ambi.RobObj.StartEvent )