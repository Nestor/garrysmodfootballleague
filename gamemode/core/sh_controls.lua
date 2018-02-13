if CLIENT then

	local lastHand = 0
	local lastKick = 0
	LocalPlayer().ScoreTime = 0

	function GFL:KeyPress(ply, key)
		local ball = gfl.GetBall()
		if not ball then return end
		local feetPos = LocalPlayer():GetPos() + LocalPlayer():GetAngles():Up() * 3
		if key == IN_ATTACK and CurTime() > lastKick + 1 then
			if feetPos:Distance(gfl.GetBall():GetPos()) > 42 then return end
			--local inFront = ents.FindInCone(feetPos, LocalPlayer():GetAngles():Forward(), 130, 140)
			netstream.Start("ballKick")
			lastKick = CurTime()
			return false
		elseif key == IN_RELOAD and CurTime() > lastHand + 3 then
			netstream.Start("handUp")
			lastHand = CurTime()
			return false
		elseif key == IN_USE and LocalPlayer().ScoreTime + 10 > CurTime() then
			netstream.Start("randomCelebration")
		end
	end


	netstream.Hook("ballKickAnim", function(ply)
		if ply.SetLuaAnimation then
			ply:SetLuaAnimation("gfl_normal_kick")
		end
	end)

	netstream.Hook("playGesture", function(ply, act)
		ply:AnimRestartGesture(GESTURE_SLOT_CUSTOM, act, true)
	end)
else
	netstream.Hook("handUp", function(ply)
		ply:PlayGesture(ACT_SIGNAL_HALT)
	end)

	netstream.Hook("ballKick", function(ply)
		local trace = ply:GetEyeTrace()
		local feetPos = ply:GetPos() + ply:GetAngles():Up() * 3
		local ball = gfl.ball
		if feetPos:Distance(ball:GetPos()) > 50 then return end
			for v,k in pairs(player.GetAll()) do
				netstream.Start(k, "ballKickAnim", ply)
			end
			ball:EmitSound("gfl/kick_"..math.random(1,4)..".wav", 90)
			local phys = gfl.ball:GetPhysicsObject()
			local damage = 35
			phys:ApplyForceOffset(ply:GetAimVector():GetNormalized() * (damage * 100 * 5), trace.HitPos)
			--ball:SetVelocity(ply:GetAimVector():GetNormalized() * (damage * 100 * 5))
			ball.lastKicker = ply
			ball.lastToucher = ply
	end)

	local celebrations = {
	ACT_GMOD_TAUNT_CHEER,
	ACT_GMOD_TAUNT_ROBOT,
	ACT_GMOD_TAUNT_SALUTE,
	ACT_GMOD_TAUNT_DISAGREE
	}

	netstream.Hook("randomCelebration", function()
		gfl.PlayGesutre(celebrations[math.random(0,#celebrations)])
	end)

end
