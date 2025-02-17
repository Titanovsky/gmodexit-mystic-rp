local Ents, C = Ambi.RegEntity, Ambi.General.Global.Colors

local function GetConfigValue( sSubClass, sKey )
    return Ambi.SmallMoneyPrinters.Config[ sSubClass..'_printer_'..sKey ]
end

function Ambi.SmallMoneyPrinters.CreateServerSideMoneyPrinter( tEntity, tInfo, sSubClass )
    local ENT = tEntity
    local info = tInfo
    local subclass = sSubClass

    function ENT:SetUpgrade( nAmount )
        self.nw_Upgrade = nAmount

        Ambi.SmallMoneyPrinters.Upgrade( self )
    end

    function ENT:SetMoney( nAmount )
        self.nw_Money = nAmount
    end

    function ENT:Initialize()
        Ents.Initialize( self, 'models/props_lab/reciever01b.mdl' )
        Ents.Physics( self, MOVETYPE_VPHYSICS, SOLID_VPHYSICS, nil, true, true )

        self:SetHealth( GetConfigValue( subclass, 'health' ) )
        self:SetMaxHealth( GetConfigValue( subclass, 'health' ) )
        
        if info.material then self:SetMaterial( info.material ) end
        if info.color then self:SetColor( info.color ) end

        self:SetUpgrade( 0 )
        self:SetMoney( 0 )
        self:GenerateMoney()
    end

    function ENT:GenerateMoney()
        if not Ambi.SmallMoneyPrinters.Config.enable then return end

        local minus_delay = 0
        if info.upgrades then minus_delay = GetConfigValue( subclass, 'minus_delay' ) * self:GetUpgrade() end

        local delay = GetConfigValue( subclass, 'delay' ) - minus_delay
        if ( delay < 0 ) then delay = 0 end

        timer.Create( 'SMPGenerateMoney:'..self:EntIndex(), delay, 1, function() 
            if not IsValid( self ) then return end

            local amount = 0
            if info.random_amount then
                amount = math.random( GetConfigValue( subclass, 'min_random_amount' ), GetConfigValue( subclass, 'max_random_amount' ) )
            else
                amount = GetConfigValue( subclass, 'amount' ) * self:GetUpgrade()
            end

            self:SetMoney( self:GetMoney() + Ambi.DarkRP.Config.money_printer_amount )

            self:GenerateMoney()
        end )
    end

    function ENT:OnTakeDamage( damageInfo )
        self:SetHealth( self:Health() - damageInfo:GetDamage() )
        if ( self:Health() <= 0 ) then self:Remove() return end
    end

    function ENT:StartTouch( eObj )
        local hp, new_hp = self:Health(), Ambi.SmallMoneyPrinters.Config.repair
        if IsValid( eObj ) and ( eObj:GetClass() == Ambi.SmallMoneyPrinters.Config.repair_class ) and ( hp <= self:GetMaxHealth() - new_hp ) then
            eObj:Remove()
            self:SetHealth( hp + new_hp )
        end

        if IsValid( eObj ) and ( eObj:GetClass() == Ambi.SmallMoneyPrinters.Config.upgrader_class ) and ( self:GetUpgrade() < self.max_upgrade ) then
            eObj:Remove()
            self:SetUpgrade( self:GetUpgrade() + 1 )
        end
    end

    function ENT:Use( ePly )
        if not ePly:IsPlayer() then return end
        if not Ambi.SmallMoneyPrinters.Config.enable then ePly:ChatSend( C.ERROR, '•  ', C.ABS_WHITE, 'Simple Money Printers - Отключены!' ) return end
        
        local money = self:GetMoney()
        if ( money <= 0 ) then return end

        ePly:AddMoney( money )
        self:SetMoney( 0 )
    end
end