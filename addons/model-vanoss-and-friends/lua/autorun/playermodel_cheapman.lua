if(SERVER)then
resource.AddWorkshop(910498558)
end
AddCSLuaFile()
local mdls = {}
table.insert(mdls,{"FourZer0Seven","fourzer0seven"})
table.insert(mdls,{"H2O Delirious","h2o"})
table.insert(mdls,{"BigJigglyPanda","jiggly"})
table.insert(mdls,{"Moo Snuckel","moo"})
table.insert(mdls,{"Nogla","nogla"})
table.insert(mdls,{"Ohmwrecker","ohm"})
table.insert(mdls,{"Terroriser","terroriser"})
table.insert(mdls,{"Vanoss","vanoss"})
table.insert(mdls,{"Wildcat","wildcat"})
table.insert(mdls,{"BasicallyIDoWrk","wrk"})
for k,v in pairs(mdls)do
player_manager.AddValidModel( "Low-Budget "..v[1], "models/player/cheapman_"..v[2]..".mdl")
end