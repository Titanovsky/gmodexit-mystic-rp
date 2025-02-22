att.PrintName = "Shrapnel Slugs"
att.Icon = Material("entities/acwatt_ammo_frangible.png")
att.Description = "Slug that explodes into shrapnel upon firing. Has reduced precision and range."
att.Desc_Pros = {
    "+ 16 pellets per shot"
}
att.Desc_Cons = {
}
att.Slot = "gauss_rifle_bullet"
att.InvAtt = "ammo_frangible"

att.AutoStats = true
att.Override_Num = 16
att.Mult_AccuracyMOA = 12
att.Mult_Range = 0.5
att.Mult_Penetration = 0.2

if engine.ActiveGamemode() == "terrortown" then
    att.Free = true
end