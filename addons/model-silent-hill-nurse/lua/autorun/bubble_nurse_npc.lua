--я вообще не доволен, что ради создани€ NPC, пришлось создавать их отдельные модели. 
--ѕочему нельз€ было сделать специального NPC, с одинаковым с игроком анимаци€ми, и гибкими настройками типа: враг или союзник, какой бодигруп и скин и.т.д.
--Ќо, бл€ть, нет же. 
--"¬от вам npc_citizen и npc_combine_s, из half-life 2, и на основе них и делаете, только не забудь сделать отдельно дл€ каждого модельку"
--∆опа горит, пиздец.

local Category = "Silent Hill (PsycedeliCum)"

local NPC = { 	Name = "Bubble Nurse (Enemy)", 
				Class = "npc_combine_s",
				Model = "models/psychedelicum/silent_hill/bubble_nurse/npc/bubble_nurse_combine.mdl",
				Health = "250",
				Squadname = "MEA01",
				Numgrenades = "4",
                                Category = Category    }

list.Set( "NPC", "npc_bubble_nurse_combine", NPC )

local NPC = { 	Name = "Bubble Nurse (Friendly)", 
				Class = "npc_citizen",
				Model = "models/psychedelicum/silent_hill/bubble_nurse/npc/bubble_nurse_citizen.mdl",
				Health = "250",
				KeyValues = { citizentype = 4 },
                                Category = Category    }

list.Set( "NPC", "npc_bubble_nurse_citizen", NPC )
