local C = Ambi.Packages.Out( 'colors' )

-- ----------------------------------------------------------------------------------------------------------------------------
local function AddPostTime( nTime, ePly, fCallback )
    timer.Simple( nTime, function()
        if IsValid( ePly ) then fCallback() end
    end )
end

local function NPCQuestGiverTalk( ePly, nTime, sText )
    AddPostTime( nTime, ePly, function() 
        ePly:ChatSend( C.AMBI_GREEN, 'Квестодатель: ', C.ABS_WHITE, sText ) 
        ePly:PlaySound( 'buttons/button1.wav' )
    end )
end

-- ----------------------------------------------------------------------------------------------------------------------------
local quest = Ambi.Quest.Create( 'q1', 'Обучение' )

quest:AddStep( 1, 'Поговорите с Помощником', 'chat', 1, function( ePly ) 
    ePly:ChatSend( '~AMBI_BLUE~ [Подсказка] ~W~ Подойдите к метке и нажмите на ~G~ NPC Помощника' ) 
    AddPostTime( 1, ePly, function() 
        ePly:SetESPMarker( 'NPC Помощник', Vector( -3748, -4537, -126 ) )
    end )
end, function( ePly, tStep ) 
    tStep.OnStart( ePly ) 
end )

quest:AddStep( 2, 'Напишите /discord', 'chat', 1, function( ePly ) 
    ePly:ChatSend( C.AMBI_BLUE, '[Подсказка] ', C.ABS_WHITE, 'Введите ', C.AMBI, '/discord' ) 
    ePly:ChatSend( C.AMBI_BLUE, '[Подсказка] ', C.ABS_WHITE, 'Чтобы узнать все команды, введите ', C.AMBI, '/cmd'  ) 
    
    ePly:SendLua( 'Ambi.MysticRP.ShowHint("g1")' )

    ePly:AddXP( 200 )
end )

quest:AddStep( 3, 'Напишите /kit starter', 'chat', 1, function( ePly ) 
    ePly:ChatSend( C.AMBI_BLUE, '[Подсказка] ', C.ABS_WHITE, 'Введите ', C.AMBI, '/kit starter' ) 
    ePly:SendLua( 'Ambi.MysticRP.ShowHint("g2")' )

    ePly:AddXP( 200 )
end )

quest:AddStep( 4, 'Нажмите F4', 'chat', 1, function( ePly ) 
    ePly:ChatSend( C.AMBI_BLUE, '[Подсказка] ', C.ABS_WHITE, 'F4' ) 
    ePly:SendLua( 'Ambi.MysticRP.ShowHint("g3")' )

    ePly:AddXP( 200 )
end )

quest:AddStep( 5, 'Сделать видеокарты', 'chat', 4, function( ePly ) 
    ePly:SetESPMarker( 'Склад DNS', Vector( -2187, -5896, -131 ) )

    ePly:ChatSend( C.AMBI_BLUE, '[Подсказка] ', C.ABS_WHITE, 'Отправляйтесь на завод DNS и сделайте видеокарты!' ) 
    ePly:ChatSend( C.AMBI_BLUE, '[Подсказка] ', C.ABS_WHITE, 'Там можно заработать на жизнь' ) 
    ePly:SendLua( 'Ambi.MysticRP.ShowHint("g4")' )

    ePly:AddMoney( 500 )
    ePly:ChatSend( C.AMBI_GREEN, '+500$' ) 
end )

quest:AddStep( 6, 'Сыграть в казино', 'chat', 1, function( ePly ) 
    ePly:SendLua( 'Ambi.MysticRP.ShowHint("g5")' )
    ePly:SetESPMarker( 'Казино', Vector( -3162, -6615, -151 ) )
end )

quest:AddStep( 7, 'Вызвать питомца', 'chat', 1, function( ePly ) 
    ePly:ChatSend( C.AMBI_BLUE, '[Подсказка] ', C.ABS_WHITE, 'F4 > Инвентарь > Нажмите Use на питомца' ) 
    ePly:SendLua( 'Ambi.MysticRP.ShowHint("g6")' )
    ePly:AddInvItemOrDrop( 'pet_pasta', 1 )
end )

quest:AddStep( 8, 'Ввести /promocode', 'chat', 1, function( ePly ) 
    ePly:ChatSend( C.AMBI_BLUE, '[Подсказка] ', C.ABS_WHITE, '/promocode' ) 
    ePly:ChatSend( C.AMBI_BLUE, '[Подсказка] ', C.ABS_WHITE, 'Кстати, вы потом сможете сделать свой /setpromocode из 5 символов' ) 
end )

-- --------------------------------------------------------------------------------------------------------------
local REWARD_MONEY = 2000 -- Наградные Деньги
local REWARD_XP = 666 -- 

quest.GiveReward = function( self, ePly )
    ePly:ChatSend( C.AMBI, '[Награда] ', C.ABS_WHITE, 'Вы получили ', C.AMBI, REWARD_MONEY..'$', C.ABS_WHITE,' и ', C.AMBI, REWARD_XP..' xp' ) 

    ePly:AddMoney( REWARD_MONEY )
    ePly:AddXP( REWARD_XP )

    ePly:PlaySound( 'ambi/other/complete_rank_up.mp3' )

    timer.Simple( 1, function()
        if IsValid( ePly ) then ePly:StartQuest( 'q2' ) end
    end )
end 

-- -- ----------------------------------------------------------------------------------------------------------------------------
if CLIENT then return end

local class = quest.class

hook.Add( '[Ambi.Authorization.Set]', 'Ambi.MysticRP.Quest1', function( ePly, bAuth )
    if not bAuth then return end
    --if ePly:GetFinishedQuest( 'q1' ) then return end

    ePly:StartQuest( 'q1' )
end )

hook.Add( 'PlayerUse', 'Ambi.MysticRP.Quest1', function( ePly, eObj )
    if not IsValid( eObj ) then return end

    if ePly:CheckQuest( 'q1', 1 ) and ( eObj:GetClass() == 'npc_mystic_helper' ) then ePly:AddQuestCount( 1 ) return false end
end )

hook.Add( '[Ambi.ChatCommands.Executed]', 'Ambi.MysticRP.Quest1', function ( ePly, tCommand, sText ) 
    if ( sText == '/discord' ) and ePly:CheckQuest( 'q1', 2 ) then ePly:AddQuestCount( 1 ) return end
    if ( sText == '/kit starter' ) and ePly:CheckQuest( 'q1', 3 ) then ePly:AddQuestCount( 1 ) return end
    if ( sText == '/promocode' ) and ePly:CheckQuest( 'q1', 8 ) then ePly:AddQuestCount( 1 ) return end
end )

hook.Add( 'ShowSpare2', 'Ambi.MysticRP.Quest1', function ( ePly ) 
    if ePly:CheckQuest( 'q1', 4 ) then ePly:AddQuestCount( 1 ) return end
end )

hook.Add( '[Ambi.MysticRP.PutVideocard]', 'Ambi.MysticRP.Quest1', function( ePly )
    if ePly:CheckQuest( 'q1', 5 ) then ePly:AddQuestCount( 1 ) return end
end )

hook.Add( '[Ambi.MysticRP.UsedCasino]', 'Ambi.MysticRP.Quest1', function( ePly )
    if ePly:CheckQuest( 'q1', 6 ) then ePly:AddQuestCount( 1 ) return end
end )

hook.Add( '[Ambi.MysticRP.CallPet]', 'Ambi.MysticRP.Quest1', function( ePly )
    if ePly:CheckQuest( 'q1', 7 ) then ePly:AddQuestCount( 1 ) return end
end )