local loaded = loaded or false

if loaded == false then
	EmitSound( Sound( "gfl/genericloop.wav" ), LocalPlayer():GetPos(), 1, CHAN_STATIC, 0.2, 75, 0, 100 )
	loaded = true
end

netstream.Hook("score", function(scorer, scoringTeam)
	EmitSound(Sound("gfl/goal.wav"), LocalPlayer():GetPos(), 1, CHAN_STATIC, 1, 110, 0, 100)

	if scorer:Team() == scoringTeam and scorer == LocalPlayer() then
		LocalPlayer().ScoreTime = CurTime()
	end

	timer.Simple(5, function()
		LocalPlayer():ScreenFade(SCREENFADE.OUT, Color(0,0,0, 255), 3, 2.1)
		timer.Simple(5, function() LocalPlayer():ScreenFade(SCREENFADE.IN, Color(0,0,0, 255), 3, 0.1) end)

	end)
end)
