function GFL:PlayerUse()
	return false
end

function GFL:ShouldPlayerTakeDamage()
	return false
end

function GFL:EntityTakeDamage()
	return true
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
	local physObj = ball:GetPhysicsObject()

	if (IsValid(physObj)) then
		physObj:SetMaterial( "gmod_bouncy" )
		physObj:EnableMotion(false)
		timer.Simple(1, function()
			if not (IsValid(physObj)) then return end
			physObj:Wake()
			ball:EmitSound("gfl/whistle.wav")
			physObj:EnableMotion(true)
		end)
	end
	gfl.ball = ball
end

function GFL:InitPostEntity()
	gfl.ReloadBall()
	gfl.MatchStart()
end


timer.Create("GFL-CHECK-FOR-BALL", 5, 0, function()
	if IsValid(gfl.ball) then
		for v,k in pairs(ents.FindInBox(gfl.GetStadium().Boundary1,gfl.GetStadium().Boundary2)) do
			if k:GetClass() == "gfl_ball" then
				return
			end
		end

		for v,k in pairs(player.GetAll()) do
			k:Notify(0,1,"Ball automatically respawned.")
		end
		return gfl.ReloadBall()
	end
end)
