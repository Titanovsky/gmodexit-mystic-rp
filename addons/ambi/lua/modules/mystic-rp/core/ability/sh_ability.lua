local CL = Ambi.Packages.Out( 'ContentLoader' )

Ambi.MysticRP.abilities = Ambi.MysticRP.abilities or {}

if CLIENT then
    CL.CreateDir( 'ambi_mystic_rp' )
end

function Ambi.MysticRP.CreateAbility( sJob, nID, sHeader, sIcon, nDelay, fCallback )
    if not Ambi.MysticRP.abilities[ sJob ] then Ambi.MysticRP.abilities[ sJob ] = {} end

    Ambi.MysticRP.abilities[ sJob ][ nID ] = {
        header = sHeader,
        icon = sIcon,
        delay = nDelay,
        Callback = fCallback,
    }

    if CLIENT and sIcon then
        local str = string.Explode( '/', sIcon )
        str = str[ #str ]:ForceLower()
        CL.DownloadMaterial( 'mrp_ability_'..sHeader..'_'..nID, 'ambi_mystic_rp/mrp_ability_'..str..'.png', sIcon )
    end
end

-- -------------------------------------------------------------------------------------------------------
function Ambi.MysticRP.AbilRegen( ePly )
    local tag = 'Ambi.MysticRP.AbilRegen.'..ePly:SteamID()

    if ePly.abil_regen then 
        ePly:ChatSend( '~R~ [Способность] ~W~ Регенерация окончена!' )
        ePly.abil_regen = false 
        timer.Remove( tag ) 
        return 
    end

    ePly:ChatSend( '~R~ [Способность] ~W~ Регенерация началась на 3 минуты' )
    ePly.abil_regen = true

    timer.Create( tag, 3, 0, function() 
        if not ePly.abil_regen then timer.Remove( tag ) end
        if ( ePly:Health() >= ePly:GetMaxHealth() ) then return end
        
        local hp = 5
        ePly:SetHealth( ePly:Health() + hp )

        if ( ePly:Health() > ePly:GetMaxHealth() ) then ePly:SetHealth( ePly:GetMaxHealth() ) end
    end )

    timer.Simple( 180, function()
        if IsValid( ePly ) and ePly.abil_regen then Ambi.MysticRP.AbilRegen( ePly ) end
    end )
end

hook.Add( 'PlayerDeath', 'Ambi.MysticRP.AbilRegen', function( ePly )
    if ePly.abil_regen then Ambi.MysticRP.AbilRegen( ePly ) end
end )
hook.Add( '[Ambi.DarkRP.SetJob]', 'Ambi.MysticRP.AbilRegen', function( ePly )
    if ePly.abil_regen then Ambi.MysticRP.AbilRegen( ePly ) end
end )

-- -------------------------------------------------------------------------------------------------------
local JOB = 'TEAM_DEMON'

Ambi.MysticRP.CreateAbility( JOB, 1, 'Fireball', 'https://i.ibb.co/LzbPbgw/fireball.png', 15, function( ePly ) 
    if ePly:WaterLevel() > 1 then return false end

    ePly:ChatSend( '~R~ [Способность] ~W~ Fireball' )

    ePly:EmitSound( 'ambi/csz/zombie/attack.ogg' )

    local fire_stream = ents.Create("fire_stream")
    fire_stream:SetPos( ePly:GetShootPos() + Vector(0,0,-25) )
    fire_stream:SetAngles( ePly:EyeAngles() )
    fire_stream:Spawn()
    fire_stream:SetOwner( ePly )
    fire_stream:GetPhysicsObject():SetMass(1)

    local dir = ePly:GetAimVector()*(10000) + VectorRand()*(20^2)
    fire_stream:GetPhysicsObject():SetVelocity(dir)

    local idx = "fire_stream_vel" .. fire_stream:EntIndex()

    timer.Create(idx,0.01,0,function()
        if IsValid(fire_stream) and !fire_stream.Hit then
            fire_stream:GetPhysicsObject():SetVelocity(dir)
        else
            timer.Remove(idx)
        end
    end)
end )

Ambi.MysticRP.CreateAbility( JOB, 2, 'Регенерация', 'https://i.ibb.co/fGBS937/health.png', 300, Ambi.MysticRP.AbilRegen )

Ambi.MysticRP.CreateAbility( JOB, 3, 'Вызов Огня', 'https://i.ibb.co/YbXk9mw/fire.png', 30, function( ePly ) 
    if ePly:WaterLevel() > 1 then return false end

    ePly:ChatSend( '~R~ [Способность] ~W~ Вызов Огня' )

    ePly:EmitSound( 'ambi/csz/zombie/scream2.ogg' )

    for _, ent in ipairs( ents.FindInSphere( ePly:GetPos(), 200 ) ) do
        if ( ent == ePly ) or ( not ent:IsPlayer() ) then continue end

        ent:Ignite( 10 )
    end
end )

-- -------------------------------------------------------------------------------------------------------
local JOB = 'TEAM_VAMPIRE'

-- -------------------------------------------------------------------------------------------------------
local JOB = 'TEAM_NECROMANCER'

-- -------------------------------------------------------------------------------------------------------
local JOB = 'TEAM_LYCAN'

-- -------------------------------------------------------------------------------------------------------
local JOB = 'TEAM_MURDER'

-- -------------------------------------------------------------------------------------------------------
local JOB = 'TEAM_HOMIE'

Ambi.MysticRP.CreateAbility( JOB, 1, 'Spawn', 'https://i.ibb.co/sqmB6gW/Bed.png', 2, function( ePly ) 
    if ePly.homie_spawn then
        ePly.homie_spawn = nil
        ePly:ChatSend( '~R~ [Способность] ~W~ Вы ~R~ убрали ~W~ Spawn зону' )
    else
        ePly.homie_spawn = { pos = ePly:GetPos(), ang = ePly:EyeAngles() }

        ePly:ChatSend( '~R~ [Способность] ~W~ Вы ~G~ создали ~W~ Spawn зону' )
    end
end )

Ambi.MysticRP.CreateAbility( JOB, 2, 'Change Skin', 'https://i.ibb.co/McKx38j/skin.png', 0.25, function( ePly ) 
    ePly:SetSkin( math.random(0, 4) )
 
    ePly:ChatSend( '~R~ [Способность] ~W~ Вы поменяли скин' )
end )

Ambi.MysticRP.CreateAbility( JOB, 3, 'Ничего2', 'https://i.ibb.co/3hsdf6X/question.png', 1, function( ePly ) 
    ePly:ChatSend( '~R~ [Способность] ~W~ Пока что ничего' )
end )

if SERVER then
    hook.Add( 'PlayerSpawn', 'Ambi.MysticRP.AbilityHomieSpawn', function( ePly ) 
        timer.Simple( 0.08, function()
            if not IsValid( ePly ) then return end
            if ( ePly:GetJob() ~= JOB ) then return end
            if not ePly.homie_spawn then return end

            ePly:SetPos( ePly.homie_spawn.pos )
            ePly:SetEyeAngles( ePly.homie_spawn.ang )
        end )
    end )
end

-- -------------------------------------------------------------------------------------------------------
local JOB = 'TEAM_YAGA'

-- -------------------------------------------------------------------------------------------------------
local JOB = 'TEAM_CRACKER'