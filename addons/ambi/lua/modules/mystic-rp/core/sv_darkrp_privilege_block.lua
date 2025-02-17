hook.Add( '[Ambi.DarkRP.CanSetJob]', 'Ambi.MysticRP.PriviligeBlock', function( ePly, _, _, tJob ) 
    if tJob.is_vip and not ePly:IsVIP() then ePly:ChatSend( '~R~ Вам нужна VIP (F6)' ) return false end
    if tJob.is_premium and not ePly:IsPremium() then ePly:ChatSend( '~R~ Вам нужен Premium (F6)' ) return false end
    if tJob.is_titanium and not ePly:IsTitanium() then ePly:ChatSend( '~R~ Вам нужен Titanium (F6)' ) return false end
end )