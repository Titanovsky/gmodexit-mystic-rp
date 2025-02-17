att.PrintName = "Tungsten Slugs"
att.Icon = Material("entities/acwatt_ammo_tmj.png")
att.Description = "Ultra-durable tungsten slugs. Improves damage over range, but has much more kick."
att.Desc_Pros = {
}
att.Desc_Cons = {
}
att.Slot = "gauss_rifle_bullet"
att.InvAtt = "ammo_tmj"

att.AutoStats = true
att.Mult_DamageMin = 2
att.Mult_Penetration = 1.5
att.Mult_Recoil = 1.5

if engine.ActiveGamemode() == "terrortown" then
    att.Free = true
end