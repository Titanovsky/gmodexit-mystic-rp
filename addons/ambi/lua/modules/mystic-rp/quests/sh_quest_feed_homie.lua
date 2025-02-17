local C = Ambi.Packages.Out( 'colors' )

-- Конфиг
local REWARD_MONEY = 6666 -- Наградные Деньги
local REWARD_XP = 100 -- 

-- ----------------------------------------------------------------------------------------------------------------------------
local function AddPostTime( nTime, ePly, fCallback )
    timer.Simple( nTime, function()
        if IsValid( ePly ) then fCallback() end
    end )
end

local function NPCQuestGiverTalk( ePly, nTime, sText )
    AddPostTime( nTime, ePly, function() 
        ePly:ChatSend( C.AMBI_GREEN, '• ', C.ABS_WHITE, sText ) 
        ePly:PlaySound( 'buttons/button1.wav' )
    end )
end

-- ----------------------------------------------------------------------------------------------------------------------------
local quest = Ambi.Quest.Create( 'feed_homie', 'Накорми молоком Домового' )

-- Про инвентарь, поиграть в казино, купить оружия, открыть череп, отыграть 10 минут, устроиться на любого Мистика

quest:AddStep( 1, 'Выкиньте из инвентаря что-нибудь', 'chat', 1, function( ePly ) 
    ePly:ChatSend( C.AMBI_BLUE, '[Подсказка] ', C.ABS_WHITE, 'Попробуйте выкинуть из инвентаря' ) 
    ePly:PlaySound( 'buttons/button1.wav' )
end, function( ePly, tStep ) 
    tStep.OnStart( ePly ) 
end )

quest.GiveReward = function( self, ePly )
    ePly:ChatSend( C.AMBI, '[Награда] ', C.ABS_WHITE, 'Вы получили ', C.AMBI, REWARD_MONEY..'$' ) 
    ePly:ChatSend( C.AMBI, '[Награда] ', C.ABS_WHITE, 'Отныне Вы вольны в своём выборе! Самое главное: отыгрывать своего персонажа и не нарушать правила.' ) 

    ePly:AddMoney( REWARD_MONEY )

    ePly:PlaySound( 'buttons/button1.wav' )
end 