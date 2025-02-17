att.PrintName = "Extended Magazine"
att.Icon = Material("entities/acwatt_perk_extendedmags.png")
att.Description = "Lengthened magazines containing standard iron slugs. Slower to reload."
att.Desc_Pros = {
    "+ Magazine capacity",
}
att.Desc_Cons = {
}
att.Slot = "gauss_rifle_bullet"
att.InvAtt = "perk_extendedmags"

att.AutoStats = true
att.Mult_ReloadTime = 1.25
att.MagExtender = true

att.ActivateElements = {"extendedmag"}

if engine.ActiveGamemode() == "terrortown" then
    att.Free = true
end