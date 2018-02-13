
hook.Remove("PlayerInitialSpawn","GFL-earrape")
hook.Add("PlayerInitialSpawn","GFL-earrape", function()
	EmitSound( Sound( "gfl/genericloop.wav" ), LocalPlayer():GetPos(), 1, CHAN_STATIC, 0.2, 75, 0, 100 )
end)

netstream.Hook("score", function(scorer, scoringTeam)
	EmitSound(Sound("gfl/goal.wav"), LocalPlayer():GetPos(), 1, CHAN_STATIC, 1, 110, 0, 100)

	if scorer:Team() == scoringTeam and scorer == LocalPlayer() then
		LocalPlayer().ScoreTime = CurTime()
	end

	timer.Simple(5, function()
		LocalPlayer():ScreenFade(SCREENFADE.OUT, Color(0,0,0, 255), 3, 2.1)
		timer.Simple(4, function() LocalPlayer():ScreenFade(SCREENFADE.IN, Color(0,0,0, 255), 5, 0) end)

	end)
end)
