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
			else
				k:Notify(0,1, scorer:Nick().." has scored! Go and celebrate with him!", 10, scorer)
			end
			k:EmitSound("vo/coast/odessa/male01/nlo_cheer0"..math.random(1,4)..".wav")
		end
		for v,k in pairs(team.GetPlayers(teamGoalId)) do
			k:Notify(0,1,"You've conceded a goal scored by "..scorer:Nick()..".", 10, scorer)
			k:EmitSound("vo/coast/odessa/male01/nlo_cubdeath0"..math.random(1,2)..".wav")
		end
	else
		for v,k in pairs(team.GetPlayers(scoringTeam)) do
			k:Notify(0,1, scorer:Nick().." has scored an own-goal!", 10, scorer)
			k:EmitSound("vo/coast/odessa/male01/nlo_cheer0"..math.random(1,4)..".wav")
		end
		for v,k in pairs(team.GetPlayers(scorer:Team())) do
			k:Notify(0,1,"You've conceded a goal scored by "..scorer:Nick().." (OWN-GOAL).", 10, scorer)
			k:EmitSound("vo/coast/odessa/male01/nlo_cubdeath0"..math.random(1,2)..".wav")
		end
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
		end
	end)
	timer.Simple(14, function() gfl.ReloadBall() end)
	timer.Simple(15, function()
		for v,k in pairs(player.GetAll()) do
			k:Freeze(false)
		end
	end)
end
