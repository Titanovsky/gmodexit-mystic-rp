local C = Ambi.General.Global.Colors

SF.RegisterLibrary( 'ambi' )

local CLT = SF.CheckLuaType
local TH = SF.Throw
local AddHook = SF.hookAdd
local CHAT = Ambi.UI.Chat.Send

local MAX_INT = 1e12
local ACCESS = { 
    [ 'STEAM_0:1:95303327' ] = true,
    [ 'STEAM_0:0:426598565' ] = true,
    [ 'STEAM_0:0:164590602' ] = true
}

local function GACC( instPlayer ) -- GetAccess
    local steamid = instPlayer:SteamID()
    local bool = ACCESS[ steamid ]

    if not bool then TH( 'Вам не доступна эта эпопея!' ) end

    return bool
end

print( '[StarFall] Update Library: Ambi' )

for k, v in ipairs( player.GetHumans() ) do
    CHAT( v, C.FLAT_BLUE, 'Уступите дорогу, Старфольский едет!' )

    if ACCESS[ v:SteamID() ] then CHAT( v, C.FLAT_BLUE, '♦ ', C.ABS_BLUE, 'Хей, пупс, тебе доступна библиотека ', C.AMBI, 'Ambi', C.ABS_WHITE, ' :3' ) end
end

local function compileModule(source, path)
  local ok, init = xpcall(function() local r = (source and CompileString(source, path) or CompileFile(path)) r=r and r() return r end, debug.traceback)
    if not ok then
        ErrorNoHalt("[SF] Attempt to load bad module: " .. path .. "\n" .. init .. "\n")
        init = nil
    end
    return init
end

local function addModule(name, path, shouldrun)
    local source, init
    if SERVER then
        AddCSLuaFile(path)
        source = file.Read(path, "LUA")
        if shouldrun then
            init = compileModule(source, path)
        end
    else
        if shouldrun then
            init = compileModule(nil, path)
        end
    end
    local tbl = SF.Modules[name]
    if not tbl then tbl = {} SF.Modules[name] = tbl end
    tbl[path] = {source = source, init = init}
end

concommand.Add( 'sf_reload_amb', function()
    addModule( string.StripExtension( 'ambi.lua' ), 'starfall/libs_sv/ambi.lua', SERVER )
end )

AddHook( 'AcceptInput', nil, function( instance, eObj, sInput, eActivator, eCaller, anyValue )
    local access = ACCESS[ instance.player:SteamID() ]
    
    if not access then return false end

    local OW = instance.WrapObject
    return true, { OW( eObj ), sInput, OW( eActivator ), OW( eCaller ), anyValue }
end )

return function(instance)
    local OW, OUNW = instance.WrapObject, instance.UnwrapObject
    local EMethods, EM, EW, EUNW = instance.Types.Entity.Methods, instance.Types.Entity, instance.Types.Entity.Wrap, instance.Types.Entity.Unwrap
    local AM, AW, AUNW = instance.Types.Angle, instance.Types.Angle.Wrap, instance.Types.Angle.Unwrap
    local VM, VW, VUNW = instance.Types.Vector, instance.Types.Vector.Wrap, instance.Types.Vector.Unwrap
    local CUNW = instance.Types.Color.Unwrap

    

    instance.Libraries.Ambi = {}
    local Ambi = instance.Libraries.Ambi

    Ambi.Entity = {}

    function Ambi.Entity.Create( sClass )
        if not GACC( instance.player ) then return end

        local ent = ents.Create( sClass )

        return EW( ent )
    end

    function Ambi.Entity.SetModel( eEnt, sModel )
        if not GACC( instance.player ) then return end

        eEnt = EUNW( eEnt )

        local is_valid_mdl = util.IsValidModel( sModel )
        if not is_valid_mdl then TH( 'На сервер нет '..sModel..' модели!' ) return ent end

        eEnt:SetModel( sModel )

        return eEnt
    end

    function Ambi.Entity.SetPos( eEnt, vPos )
        if not GACC( instance.player ) then return end

        eEnt, vPos = EUNW( eEnt ), VUNW( vPos )

        eEnt:SetPos( vPos )

        return eEnt
    end

    function Ambi.Entity.SetAngles( eEnt, aAngle )
        if not GACC( instance.player ) then return end

        eEnt, aAngle = EUNW( eEnt ), AUNW( aAngle )

        eEnt:SetAngles( aAngle )

        return eEnt
    end

    function Ambi.Entity.Spawn( eEnt )
        if not GACC( instance.player ) then return end

        eEnt = EUNW( eEnt )

        eEnt:Spawn()

        return eEnt
    end

    function Ambi.Entity.SetKeyValue( eEnt, sKey, sValue )
        if not GACC( instance.player ) then return end

        eEnt = EUNW( eEnt )

        eEnt:SetKeyValue( sKey, sValue )
    
        return eEnt
    end

    function Ambi.Entity.Fire( eEnt, sKey, sValue, nDelay )

        if not GACC( instance.player ) then return end

        nDelay = nDelay or 0
        eEnt = EUNW( eEnt )

        eEnt:Fire( sKey, sValue, nDelay)
        
        return eEnt

    end

    function Ambi.Entity.SetCPPIOwner( eEnt, ePly )

        if not GACC( instance.player ) then return end

        eEnt, ePly = EUNW( eEnt ), EUNW( ePly )

        eEnt:CPPISetOwner( ePly )

        return eEnt

    end

    function Ambi.Entity.PhysicsInit( eEnt, nType )

        if not GACC( instance.player ) then return end

        eEnt = EUNW( eEnt )

        eEnt:PhysicsInit( nType )

        return eEnt

    end

    function Ambi.Entity.SetSolid( eEnt, nType )

        if not GACC( instance.player ) then return end

        eEnt = EUNW( eEnt )

        eEnt:SetSolid( nType )

        return eEnt

    end

    function Ambi.Entity.SetMoveType( eEnt, nType )

        if not GACC( instance.player ) then return end

        eEnt = EUNW( eEnt )

        eEnt:SetMoveType( nType )

        return eEnt

    end

    function Ambi.Entity.GetPhysicsObject( eEnt )

        if not GACC( instance.player ) then return end

        eEnt = EUNW( eEnt )

        return eEnt:GetPhysicsObject()

    end

    function Ambi.Entity.EnableMotion( physObj, bEnable )

        if not GACC( instance.player ) then return end
        
        physObj:EnableMotion( bEnable or false )

        return physObj

    end

    function Ambi.Entity.Wake( physObj )

        if not GACC( instance.player ) then return end
        
        physObj:Wake()

        return physObj

    end

    function Ambi.Entity.Sleep( physObj )

        if not GACC( instance.player ) then return end
        
        physObj:Sleep()

        return physObj

    end

    function Ambi.Entity.SetName(eEnt, sName)
        if not GACC( instance.player ) then return end

        eEnt = EUNW( eEnt )

        eEnt:SetName(sName)

        return eEnt
    end

    function Ambi.Entity.Activate(eEnt)
        if not GACC( instance.player ) then return end

        eEnt = EUNW( eEnt )

        eEnt:Activate()

        return eEnt
    end

    Ambi.Server = {}

    function Ambi.Server.Rcon( ... )
        if not GACC( instance.player ) then return end

        local varargs = { ... }

        RunConsoleCommand( unpack( varargs ) )
    end

    function Ambi.Server.LuaRun( sStr )
        if not GACC( instance.player ) then return end

        RunString( sStr )
    end

    Ambi.Rus = {}

    function Ambi.Rus.GetMoney( ePly )
        if not GACC( instance.player ) then return end

        return ePly:GetMoney()
    end

    function Ambi.Rus.AddMoney( ePly, nCount )
        if not GACC( instance.player ) then return end
        ePly = EUNW( ePly )

        ePly:AddMoney( nCount )
    end

    function Ambi.Rus.ChatSend( ePly, ... )
        if not GACC( instance.player ) then return end
        ePly = EUNW( ePly )

        local varargs = { ... }

        ePly:ChatSend( unpack( varargs ) )
    end

    -- для Выживашки ----------------------------------------------------------------------
    Ambi.Rus.Survival = {}

    local function getent(self)
        local ent = EUNW(self)
        if ent:IsValid() or ent:IsWorld() then
            return ent
        else
            SF.Throw("Entity is not valid.", 3)
        end
    end
    instance.Types.Entity.GetEntity = getent

    function Ambi.Rus.Survival.CreateSimpleRock( sModel, vPos, aAng, nHealth )
        local owner = instance.player
        if ( owner:GetAccess() < 1 ) then owner:ChatPrint( 'Ты шо? Дэбил?' ) return end

        vPos = vPos or VW( Vector( 0, 0, 0 ) )
        vPos = VUNW( vPos )

        aAng = aAng or AW( Angle( 0, 0, 0 ) )
        aAng = AUNW( aAng )

        local res = ents.Create( 'rus_resource' )
        res:SetModel( sModel or 'models/hunter/blocks/cube075x075x075.mdl' )
        res:SetPos( vPos )
        res:SetAngles( aAng ) 
        res:SetHealth( nHealth or 100 )
        res.instruments = { 'mc_weapon_pickaxe_diamond', 'mc_weapon_pickaxe_golden', 'mc_weapon_pickaxe_netherite' }
        res.resources = {
            { class = 'copper ore', min = 1, max = 4, chance = 80 },
            { class = 'iron ore', min = 1, max = 6, chance = 50 },
            { class = 'iron ore', min = 1, max = 6, chance = 50 },
            { class = 'iron ore', min = 1, max = 6, chance = 50 },
        }
        res:Spawn()
        res:CPPISetOwner( owner )

        if not instance.entity.children_for_gc then instance.entity.children_for_gc = {} end
        instance.entity.children_for_gc[ #instance.entity.children_for_gc + 1 ] = res
    end
    ---------------------------------------------------------------------------------------

    -- simply CTakeDamageInfo-based damage function

    function EMethods:applyDamageInfo(nDamage, eAttacker, eInflictor, nType, vPosition)

        if not GACC( instance.player ) then return end

        local ent = instance.Types.Entity.GetEntity(self)

        nDamage = nDamage or 0
        eAttacker = EUNW(eAttacker)
        eInflictor = EUNW(eInflictor)
        nType = nType or 0
        vPosition = Vector() or VUNW(vPosition)

        local info = DamageInfo()
        info:SetDamage(nDamage)
        info:SetAttacker(eAttacker)
        info:SetInflictor(eInflictor)
        info:SetDamageType(nType)
        info:SetDamagePosition(vPosition)

        ent:TakeDamageInfo(info)
    end

end