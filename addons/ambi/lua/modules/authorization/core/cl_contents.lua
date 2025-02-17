local CL = Ambi.Packages.Out( 'ContentLoader' )

-- ---------------------------------------------------------------------------------------------------------------------------------------
CL.CreateDir( 'authorization' )

CL.DownloadMaterial( Ambi.Authorization.Config.logo.name, 'authorization/'..Ambi.Authorization.Config.logo.name..'.png', Ambi.Authorization.Config.logo.url )