if CLIENT then

	local lastHand = 0
	local lastKick = 0

	function GFL:KeyPress(ply, key)
		local trace = ply:GetEyeTrace()
		if key == IN_ATTACK and CurTime() > lastHand + 1 then
			if trace.Entity:GetPos():Distance(LocalPlayer():GetPos()) > 100 then return end
			if trace.Entity:GetClass() == "gfl_ball" then
				netstream.Start("ballKick")
				lastKick = CurTime()
				return false
			end
		elseif key == IN_RELOAD and CurTime() > lastHand + 3 then
			netstream.Start("handUp")
			lastHand = CurTime()
			return false
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
		if trace.Entity and trace.Entity:IsValid() and trace.Entity:GetClass() == "gfl_ball" then
			for v,k in pairs(player.GetAll()) do
				netstream.Start(k, "ballKickAnim", ply)
			end
			local phys = trace.Entity:GetPhysicsObject()
			local damage = 35
			phys:ApplyForceOffset(ply:GetAimVector():GetNormalized() * (damage * 100 * 5), trace.HitPos)
			trace.Entity:SetVelocity(ply:GetAimVector():GetNormalized() * (damage * 100 * 5))
			trace.lastKicker = ply
		end
	end)

end
