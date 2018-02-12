function GFL:PlayerUse()
	return false
end

function GFL:ShouldPlayerTakeDamage()
	return false
end

function gfl.ReloadBall()
	for v,k in pairs(ents.GetAll()) do
		if k:GetClass() == "gfl_ball" then
			k:Remove()
		end
	end

	local ball = ents.Create("gfl_ball")
	ball:SetPos(gfl.GetStadium().ballPos)
	ball:Spawn()
	gfl.ball = ball
end
