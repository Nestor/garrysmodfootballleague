local loaded = loaded or false

if loaded == false then
	LocalPlayer():ConCommand("stopsound")
	EmitSound( Sound( "gfl/genericloop.wav" ), LocalPlayer():GetPos(), 1, CHAN_STATIC, 0.2, 75, 0, 100 )
	loaded = true
end

netstream.Hook("score", function(scorer, scoringTeam)
	EmitSound(Sound("gfl/goal.wav"), LocalPlayer():GetPos(), 1, CHAN_STATIC, 1, 110, 0, 100)

	if scorer == scoringTeam and scorer == LocalPlayer() then
		LocalPlayer().ScoreTime = CurTime()
	end
end)
