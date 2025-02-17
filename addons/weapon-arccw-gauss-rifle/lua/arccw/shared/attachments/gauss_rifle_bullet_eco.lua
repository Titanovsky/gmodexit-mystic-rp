att.PrintName = "Lightweight Slugs"
att.Icon = Material("entities/acwatt_ammo_lowpower.png")
att.Description = "Shortened slugs using light alloy. Improves handling and recoil control, but damage and ranged performance is reduced."
att.Desc_Pros = {
}
att.Desc_Cons = {
}
att.Slot = "gauss_rifle_bullet"
att.InvAtt = "ammo_lowpower"

att.AutoStats = true
att.Mult_Damage = 0.8
att.Mult_Range = 0.8
att.Mult_Penetration = 0.8
att.Mult_Recoil = 0.75
att.Mult_MoveDispersion = 0.75
att.Mult_HipDispersion = 0.75

if engine.ActiveGamemode() == "terrortown" then
    att.Free = true
end