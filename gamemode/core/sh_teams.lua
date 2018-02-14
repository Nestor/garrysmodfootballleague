function GFL:CreateTeams()
	team.SetUp(1, "HOME", Color(0,0,255,255), true)
	TEAM_HOME = 1
	team.SetUp(2, "AWAY", Color(255,0,0,255), true)
	TEAM_AWAY = 2
	team.SetUp(3, "SPECTATORS", Color(70,70,70,255), false)
	TEAM_SPEC = 3
end

local function ColToVec( color )
	return ( Vector( color.r / 255, color.g / 255, color.b / 255 ) )
end

local classes = {
	"Goalkeeper",
	"Captain",
	"Player"
}

if SERVER then
	function GFL:PlayerInitialSpawn(p)
		p:SetModel("models/konnie/football/football.mdl")
		p:SetTeam(team.BestAutoJoinTeam())
		p:Spawn()
		p:SetPlayerColor(ColToVec(team.GetColor(p:Team())))
		gfl.BeginStamina(p)
		p:SetNW2String("class", "Player")
		p:ConCommand("gfl_openclassmenu")
	end

	function gfl.meta:ChangeTeam(teamx)
		self:SetTeam(teamx)
		self:SetPlayerColor(ColToVec(team.GetColor(teamx)))
		self:ChatPrint("You have switched to team: "..team.GetName(teamx))
		if teamx == 3 then
			self:SetModel("models/player/Group01/male_06.mdl")
		end
		self:Spawn()
		self:SetNW2String("class", "Player")
		self:ConCommand("gfl_openclassmenu")
	end

	function gfl.RespawnAll()
		for v,k in pairs(player.GetAll()) do
			k:Spawn()
		end
	end

	function GFL:PlayerSelectSpawn(ply)
		if ply:Team() == 1 then
			local spawns = ents.FindByClass( "info_player_counterterrorist" )
			for i=0, #spawns do
				local randomSpawn = math.random(#spawns)
				if (self:IsSpawnpointSuitable( ply, spawns[randomSpawn], i == #spawns)) then
					return spawns[randomSpawn]
				end
			end

		elseif ply:Team() == 2 then
			local spawns = ents.FindByClass( "info_player_terrorist" )
			for i=0, #spawns do
				local randomSpawn = math.random(#spawns)
				if (self:IsSpawnpointSuitable( ply, spawns[randomSpawn], i == #spawns)) then
					return spawns[randomSpawn]
				end
			end

		elseif ply:Team() == 3 then
			local spawns = ents.FindByClass( "info_player_start" )
			for i=0, #spawns do
				local randomSpawn = math.random(#spawns)
				if (self:IsSpawnpointSuitable( ply, spawns[randomSpawn], i == #spawns)) then
					return spawns[randomSpawn]
				end
			end
		end
	end

	local captainCandidatesHOME = {}
	local captainCandidatesAWAY = {}


	netstream.Hook("switchBlue", function(ply)
		local redPlayers = #team.GetPlayers(2)
		local bluePlayers = #team.GetPlayers(1)
		if redPlayers > bluePlayers then
			ply:ChangeTeam(1)
		end
	end)

	netstream.Hook("switchRed", function(ply)
		local redPlayers = #team.GetPlayers(2)
		local bluePlayers = #team.GetPlayers(1)
		if bluePlayers > redPlayers then
			ply:ChangeTeam(2)
		end
	end)

	netstream.Hook("becomeKeeper", function(ply)
		for v,k in pairs(team.GetPlayers(ply:Team())) do
			local class = k:GetNW2String("class","error")
			if class == "Goalkeeper" then
				return
			end
		end

		ply:SetNW2String("class", "Goalkeeper")
		ply:Notify(0,1, "You are the Goalkeeper, goto the goal and keep the ball out!", 7)
	end)

	netstream.Hook("becomePlayer", function(ply)
		ply:SetNW2String("class", "Player")
		ply:Notify(0,1, "You are a player press F1 to view the controls and pass to your teammates!", 5)
	end)

	function GFL:ShowHelp(ply)
		ply:ConCommand("gfl_openmenu")
	end

	function GFL:ShowTeam(ply)
		ply:ConCommand("gfl_openclassmenu")
	end
end

