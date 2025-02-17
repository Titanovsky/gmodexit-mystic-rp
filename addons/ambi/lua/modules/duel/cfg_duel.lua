Ambi.General.CreateModule( 'Duel' )

-- ---------------------------------------------------------------------------------------------------------------------------------------
Ambi.Duel.Config.min_award = 500
Ambi.Duel.Config.max_award = 100000

Ambi.Duel.Config.max_health = 400

Ambi.Duel.Config.delay = 40
Ambi.Duel.Config.time_duel = 300
Ambi.Duel.Config.time_accept = 10
Ambi.Duel.Config.delay_start = 15

Ambi.Duel.Config.bet = true

Ambi.Duel.Config.places = { 
    [1] = { pos = Vector( -252, 143, -12241 ), ang = Angle( 0, 90, 0 ) },
    [2] = { pos = Vector( -267, -84, -12238 ), ang = Angle( 0, -90, 0 ) },
    ['end'] = { pos = Vector( 2880, 1439, -125 ), ang = Angle( 0, -180, 0 ) },
}

Ambi.Duel.Config.access_guns = {
    'weapon_crossbow',
    'weapon_357',
    'weapon_stunstick',

    'arccw_minigun',
    'weapon_smg1',

    'arccw_ragingbull',
    'arccw_welrod',
    'arccw_db_sawnoff',
    'arccw_melee_fists'
}