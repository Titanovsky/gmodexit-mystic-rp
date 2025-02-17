local CFG = Ambi.Statistic.Config

local db = Ambi.SQL.CreateTable( CFG.survey_db, 'SteamID TEXT, Name TEXT, SurveyID NUMBER, AnswerID NUMBER, Date NUMBER' )

local function SelectDB( sKey, ePly )
    return Ambi.SQL.Select( db, sKey, 'SteamID', ePly:SteamID() )
end 

function Ambi.Statistic.Survey.CallQuestion( ePly, nID )
    if ( SelectDB( 'SteamID', ePly ) == ePly:SteamID() ) and ( SelectDB( 'SurveyID', ePly ) == tostring( nID ) ) then return false end

    ePly.survey_ready = true
    ePly:SendLua( 'Ambi.Statistic.Survey.CallQuestion('..nID..')' )
end

function Ambi.Statistic.Survey.GiveAnswer( ePly, nID, nAnswerID )
    if ( SelectDB( 'SteamID', ePly ) == ePly:SteamID() ) and ( SelectDB( 'SurveyID', ePly ) == nID ) then return false end

    Ambi.Statistic.Survey.Get( nID ).answers[ nAnswerID ].action( ePly, nID, nAnswerID )

    local ID = ePly:SteamID()
    local Name = ePly:Nick()
    local Date = os.time()

    Ambi.SQL.Insert( db, 'SteamID, Name, SurveyID, AnswerID, Date', '%s, %s, %i, %i, %i', ID, Name, nID, nAnswerID, Date )
end

local net_ready_answer = net.AddString( 'amb_statistic_survey_ready_answer' )
net.Receive( net_ready_answer, function( nLen, ePly ) 
    if ( ePly.survey_ready == false ) then ePly:Kick( 'Подозрение в Читерстве: #A0101' ) return end

    ePly.survey_ready = false

    local id_question = net.ReadUInt( 8 )
    if not id_question or not AMB.Statistic.Survey.Get( id_question ) then return end

    local id_answer = net.ReadUInt( 4 )
    if not id_answer or not AMB.Statistic.Survey.Get( id_question ).answers[ id_answer ] then return end

    Ambi.Statistic.Survey.GiveAnswer( ePly, id_question, id_answer )
end )