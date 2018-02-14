function gfl.ScoreGoal(teamGoalId, scorer)
	local scoringTeam
	if teamGoalId == TEAM_HOME then
		scoringTeam = TEAM_AWAY
	elseif teamGoalId == TEAM_AWAY then
		scoringTeam = TEAM_HOME
	end

	if scorer:Team() == scoringTeam then
		for v,k in pairs(team.GetPlayers(scoringTeam)) do
			if k == scorer then
				k:Notify(0,1,"YOU SCORED! Press E to celebrate!", 7)
				scorer:AddFrags(1)
				scorer:SetPData("goalsScored", scorer:GetPData("goalsScored", 0) + 1) -- Save goals to database
				scorer:ChatPrint("You have scored "..scorer:GetPData("goalsScored", 0).." goal(s) so far on this server!")
			else
				k:Notify(0,1, scorer:Nick().." has scored! Go and celebrate with him!", 10, scorer)
			end
			k:EmitSound("vo/coast/odessa/male01/nlo_cheer0"..math.random(1,4)..".wav")
		end
		for v,k in pairs(team.GetPlayers(teamGoalId)) do
			k:Notify(2,0,"You've conceded a goal scored by "..scorer:Nick()..".", 10, scorer)
			k:EmitSound("vo/coast/odessa/male01/nlo_cubdeath0"..math.random(1,2)..".wav")
		end
	else
		for v,k in pairs(team.GetPlayers(scoringTeam)) do
			k:Notify(0,1, scorer:Nick().." has scored an own-goal!", 10, scorer)
			k:EmitSound("vo/coast/odessa/male01/nlo_cheer0"..math.random(1,4)..".wav")
		end
		for v,k in pairs(team.GetPlayers(scorer:Team())) do
			k:Notify(2,0,"You've conceded a goal scored by "..scorer:Nick().." (OWN-GOAL).", 10, scorer)
			k:EmitSound("vo/coast/odessa/male01/nlo_cubdeath0"..math.random(1,2)..".wav")
		end
		for v,k in pairs(player.GetAll()) do
			if k:IsAdmin() then
				k:ChatPrint("[ADMIN NOTICE] "..scorer:Nick().." scored an own-goal.")
			end
		end
		timer.Simple(10, function()
			if IsValid(scorer) then
				scorer:Notify(1,0,"You may be banned if you continue to score own-goals!")
			end
		end)
	end

	team.SetScore(scoringTeam, team.GetScore(scoringTeam)+1)

	for v,k in pairs(player.GetAll()) do
		netstream.Start(k, "score", scorer, scoringTeam)
	end

	timer.Simple(2, function() gfl.ball:Remove() end)
	timer.Simple(9, function()
		gfl.RespawnAll()
		for v,k in pairs(player.GetAll()) do
			k:Freeze(true)
			k:RestoreStamina(100)
			k:SetRunSpeed(gfl.runSpeed)
		end
	end)
	timer.Simple(14, function() gfl.ReloadBall() end)
	timer.Simple(15, function()
		for v,k in pairs(player.GetAll()) do
			k:Freeze(false)
		end
	end)
end

function gfl.MatchStart()
	gfl.matchStart = math.floor(CurTime())
	gfl.matchEnd = gfl.matchStart + 900 -- 900 is the round length
	SetGlobalInt("gfl_matchstart", gfl.matchStart)
	timer.Remove("gfl_svround")
	timer.Create("gfl_svround", 900, 1, function()
		local homeScore = team.GetScore(1)
		local awayScore = team.GetScore(2)
		for v,k in pairs(player.GetAll()) do
			if homeScore==awayScore then
				k:Notify(0,1,"Game over. Draw, HOME: "..homeScore.." AWAY: "..awayScore, 10)
			else
				k:Notify(0,1,"Game over. Win, HOME: "..homeScore.." AWAY: "..awayScore, 10)
			end
		end
		team.SetScore(1,0)
		team.SetScore(2,0)
		timer.Simple(2, function() gfl.ball:Remove() end)
		timer.Simple(9, function()
			gfl.RespawnAll()
			for v,k in pairs(player.GetAll()) do
				k:Freeze(true)
				k:RestoreStamina(100)
				k:SetRunSpeed(gfl.runSpeed)
			end
		end)
		timer.Simple(14, function() gfl.ReloadBall() end)
		timer.Simple(15, function()
			for v,k in pairs(player.GetAll()) do
				k:Freeze(false)
			end
			gfl.MatchStart()
			gfl.ReloadBall()
		end)
	end)
end

function GFL:CanPlayerSuicide()
	return false
end

