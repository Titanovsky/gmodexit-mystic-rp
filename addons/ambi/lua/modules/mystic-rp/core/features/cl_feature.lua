local feature = 0

hook.Add( 'Think', 'Ambi.MysticRP.3DPerson', function()
    if not input.IsKeyDown( KEY_F7 ) then return end
    if not LocalPlayer():IsMystic() then return end
    if timer.Exists( '3dperson_key' ) then return end
    timer.Create( '3dperson_key', 0.25, 1, function() end )

    if person3d_enable then 
        hook.Remove( 'CalcView', 'Ambi.MysticRP.3DPerson' ) 
        person3d_enable = false 
    else
        hook.Add( 'CalcView', 'Ambi.MysticRP.3DPerson', function( ePly, vOrigin, nAng, nFov ) 
            if not LocalPlayer():IsMystic() then 
                hook.Remove( 'CalcView', 'Ambi.MysticRP.3DPerson' ) 
                person3d_enable = false 
                return 
            end

            local view = {
                origin = vOrigin - ( nAng:Forward() * 100 ),
                angles = nAng,
                fov = nFov,
                drawviewer = true
            }
        
            return view
        end )
        
        person3d_enable = true
    end
end )