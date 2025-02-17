--Add Playermodel
player_manager.AddValidModel( "Rilla Roo Fake 1", 					"models/CJDucky/RillaRooFake/RillaRooFakePM.mdl" )
player_manager.AddValidHands( "Rilla Roo Fake 1", 					"models/CJDucky/RillaRooFake/RillaRooFakeArms.mdl", 0, "00000000" )
list.Set( "PlayerOptionsModel",  "Rilla Roo Fake 1",				"models/CJDucky/RillaRooFake/RillaRooFakePM.mdl" )



if CLIENT then
    local function Viewmodel( vm, ply, weapon )
        if ply:GetModel() == "models/cjducky/rillaroofake/rillaroofakepm.mdl" then
            local skin = ply:GetSkin()
			
            local hands = ply:GetHands()
            if ( weapon.UseHands or !weapon:IsScripted() ) then
                if ( IsValid( hands ) ) then
                    hands:SetSkin( skin )
                end
            end
        end
    end
    hook.Add( "PostDrawViewModel", "rillaroo_fake", Viewmodel )
end