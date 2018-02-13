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
				k:Notify(0,1, scorer:Nick().."has scored! Go and celebrate with him!", 10, scorer)
			end
		end
		for v,k in pairs(team.GetPlayers(scorer:Team())) do
			k:Notify(0,1,"You've conceded a goal by "..scorer:Nick()".", 10, scorer)
		end
	else
		for v,k in pairs(team.GetPlayers(scoringTeam)) do
			k:Notify(0,1, scorer:Nick().."has scored an own-goal!", 10, scorer)
		end
		for v,k in pairs(team.GetPlayers(scorer:Team())) do
			k:Notify(0,1,"You've conceded a goal by "..scorer:Nick().." (OWN-GOAL).", 10, scorer)
		end
	end

	team.SetScore(scoringTeam, team.GetScore(scoringTeam)+1)

	for v,k in pairs(player.GetAll()) do
		netstream.Start(k, "score", scorer, scoringTeam)
	end
end
