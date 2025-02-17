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
local quest = Ambi.Quest.Create( 'q2', 'Конец Обучения' )

quest:AddStep( 1, 'Купите оружие', 'chat', 1, function( ePly ) 
    ePly:SetESPMarker( 'Продавец Оружия', Vector( -1930, -3191, -146 ) )
    ePly:ChatSend( C.AMBI_BLUE, '[Подсказка] ', C.ABS_WHITE, 'Закупите пару пушек, не забудьте освободить место в инвентаре' ) 
end, function( ePly, tStep ) 
    tStep.OnStart( ePly ) 
end )

quest:AddStep( 2, 'Откройте череп', 'chat', 1, function( ePly ) 
    ePly:AddInvItemOrDrop( 'skull1', 1 )
    ePly:ChatSend( C.AMBI_BLUE, '[Подсказка] ', C.ABS_WHITE, 'В инвентаре находится череп' ) 
    ePly:PlaySound( 'ambi/ui/click_minecraft.mp3' )
    ePly:AddXP( 200 )
end )

quest:AddStep( 3, 'Купите дверь', 'chat', 1, function( ePly ) 
    IGS.UI( ePly )
    ePly:ChatSend( C.AMBI_BLUE, '[Подсказка] ', C.ABS_WHITE, 'В инвентаре находится череп' ) 
    ePly:PlaySound( 'ambi/ui/click_minecraft.mp3' )
end )

quest:AddStep( 4, 'Купите маник Colourful', 'chat', 1, function( ePly ) 
    ePly:ChatSend( C.AMBI_BLUE, '[Подсказка] ', C.ABS_WHITE, 'Купить принтер Colourful' ) 
    ePly:PlaySound( 'ambi/ui/click_minecraft.mp3' )
end )

quest:AddStep( 5, 'Станьте на любую работу', 'chat', 1, function( ePly ) 
end )

quest:AddStep( 6, 'Поиграйте 5 минут', 'chat', 1, function( ePly ) 
    ePly:SendLua( 'Ambi.MysticRP.ShowHint("g7")' )

    timer.Simple( 60 * 5, function()
        if IsValid( ePly ) then ePly:AddQuestCount( 1 ) end
    end )
end, function( ePly, tStep ) 
    tStep.OnStart( ePly ) 
end )

quest.GiveReward = function( self, ePly )
    ePly:ChatSend( C.AMBI, '•', C.ABS_WHITE, 'Отныне Вы вольны в своём выборе! Играйте свою роль и не нарушайте правила :)' ) 

    ePly:PlaySound( 'ambi/csz/music/human4.ogg' )
end 

if CLIENT then return end

hook.Add( '[Ambi.MysticRP.BuyedShopWeapons]', 'Ambi.MysticRP.Quest2', function( ePly ) 
    if ePly:CheckQuest( 'q2', 1 ) then ePly:AddQuestCount( 1 ) return end
end )

hook.Add( '[Ambi.MysticRP.OpenSkull]', 'Ambi.MysticRP.Quest2', function( ePly ) 
    if ePly:CheckQuest( 'q2', 2 ) then ePly:AddQuestCount( 1 ) return end
end )

hook.Add( '[Ambi.DarkRP.BoughtDoor]', 'Ambi.MysticRP.Quest2', function( ePly ) 
    if ePly:CheckQuest( 'q2', 3 ) then ePly:AddQuestCount( 1 ) return end
end )

hook.Add( '[Ambi.DarkRP.BuyShopItem]', 'Ambi.MysticRP.Quest2', function( ePly, eObj ) 
    if ePly:CheckQuest( 'q2', 4 ) and ( eObj:GetClass() == 'smp_colourful' ) then ePly:AddQuestCount( 1 ) return end
end )

hook.Add( '[Ambi.DarkRP.SetJob]', 'Ambi.MysticRP.Quest2', function ( ePly ) 
    if ePly:CheckQuest( 'q2', 5 ) then ePly:AddQuestCount( 1 ) return end
end )