--� ������ �� �������, ��� ���� �������� NPC, �������� ��������� �� ��������� ������. 
--������ ������ ���� ������� ������������ NPC, � ���������� � ������� ����������, � ������� ����������� ����: ���� ��� �������, ����� �������� � ���� �.�.�.
--��, �����, ��� ��. 
--"��� ��� npc_citizen � npc_combine_s, �� half-life 2, � �� ������ ��� � �������, ������ �� ������ ������� �������� ��� ������� ��������"
--���� �����, ������.

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
