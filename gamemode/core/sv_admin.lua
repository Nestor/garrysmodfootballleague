concommand.Add("gfl_admin_ballreset", function(p)
	if not p:IsAdmin() then return end
	gfl.ReloadBall()
	p:ChatPrint("GFL: Ball reset")
end)
concommand.Add("gfl_admin_scorereset", function(p)
	if not p:IsAdmin() then return end
	team.SetScore(1,0)
	team.SetScore(2,0)
	p:ChatPrint("GFL: Score reset")
end)
