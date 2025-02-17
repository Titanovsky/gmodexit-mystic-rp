if not Ambi.MultiHUD then return end

local CL = Ambi.Packages.Out( 'ContentLoader' )

-- ---------------------------------------------------------------------------------------------------------------------------------------
CL.CreateDir( 'ambi_mystic_rp' )

CL.DownloadMaterial( 'mrp_f4_background', 'ambi_mystic_rp/mrp_f4_background.png', 'https://i.ibb.co/DCfhyGj/background-mystic.png' )
CL.DownloadMaterial( 'mrp_f4_background1', 'ambi_mystic_rp/mrp_f4_background1.png', 'https://i.ibb.co/1Z4Xf7f/wallpaper-2.png' )

CL.DownloadMaterial( 'mrp_hud_health', 'ambi_mystic_rp/mrp_hud_health.png', 'https://i.ibb.co/9TXKsrn/icon-heart.png' )
CL.DownloadMaterial( 'mrp_hud_armor', 'ambi_mystic_rp/mrp_hud_armor.png', 'https://i.ibb.co/mC12fFV/armor.png' )
CL.DownloadMaterial( 'mrp_hud_wallet', 'ambi_mystic_rp/mrp_hud_wallet.png', 'https://i.ibb.co/myyQ3bV/money1.png' )