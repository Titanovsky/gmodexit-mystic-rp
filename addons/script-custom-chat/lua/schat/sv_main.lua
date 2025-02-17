--[[
	SChat by StyledStrike
]]
resource.AddWorkshop('2799307109')

util.AddNetworkString('schat.istyping')
util.AddNetworkString('schat.set_theme')

-- lets restore the "hands on the ear"
-- behaviour from the default chat.
local PLY = FindMetaTable('Player')

PLY.DefaultIsTyping = PLY.DefaultIsTyping or PLY.IsTyping

function PLY:IsTyping()
	return self:GetNWBool('IsTyping', false)
end

net.Receive('schat.istyping', function(_, ply)
	ply:SetNWBool('IsTyping', net.ReadBool())
end)

-- server themes
local serverTheme = ''

-- set/edit/remove the server theme
net.Receive('schat.set_theme', function(_, ply)
	if not SChat:CanSetServerTheme(ply) then
		ply:ChatPrint('SChat: You do not have access to this.')
	end

	serverTheme = net.ReadString()

	-- send to connected players
	net.Start('schat.set_theme', false)
	net.WriteString(serverTheme)
	net.Broadcast()

	file.Write('schat_server_theme.json', serverTheme)
end)

-- load an existing server theme
hook.Add('InitPostEntity', 'schat_InitPostEntity', function()
	serverTheme = file.Read('schat_server_theme.json', 'DATA') or ''
end)

-- send the current theme (if set) at the first spawn
hook.Add('PlayerInitialSpawn', 'schat_PlayerInitialSpawn', function(ply)
	if serverTheme == '' then return end

	-- since PlayerInitialSpawn is called before the player
	-- is fully loaded, we have to use this hook as well 
	hook.Add('SetupMove', ply, function( self, movePly, _, cmd )
		if self == movePly and not cmd:IsForced() then

			-- send the server theme
			net.Start('schat.set_theme', false)
			net.WriteString(serverTheme)
			net.Send(movePly)

			-- remove this hook right after
			hook.Remove('SetupMove', self)
		end
	end)
end)