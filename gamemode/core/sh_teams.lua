function GFL:CreateTeams()
	team.SetUp(1, "HOME", Color(255,255,255,255), true)
	TEAM_HOME = 1
	team.SetUp(2, "AWAY", Color(255,255,255,255), true)
	TEAM_AWAY = 2
end

local function ColToVec( color )
	return ( Vector( color.r / 255, color.g / 255, color.b / 255 ) )
end

function GFL:PlayerSpawn(p)
	p:SetModel("models/konnie/football/football.mdl")
	p:SetPlayerColor(ColToVec(Color(255,0,0)))
	p:SetTeam(team.BestAutoJoinTeam())
end

function gfl.RespawnAll()
	for v,k in pairs(player.GetAll()) do
		k:Spawn()
	end
end
