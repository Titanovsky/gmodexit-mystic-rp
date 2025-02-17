att.PrintName = "Sabot Slugs"
att.Icon = Material("entities/acwatt_ammo_sabot.png")
att.Description = "Shaped and reinforced slug designed to penetrate entire bunker walls. Has extremely high penetration and long range damage."
att.Desc_Pros = {
}
att.Desc_Cons = {
    "- Magazine capacity"
}
att.Slot = "gauss_rifle_bullet"
att.InvAtt = "ammo_sabot"

att.AutoStats = true
att.Mult_DamageMin = 2
att.Mult_Penetration = 4
att.Mult_Recoil = 1.7
att.Mult_AccuracyMOA = 4
att.Mult_HipDispersion = 1.3
att.MagReducer = true
att.ActivateElements = {"reducedmag"}

if engine.ActiveGamemode() == "terrortown" then
    att.Free = true
end