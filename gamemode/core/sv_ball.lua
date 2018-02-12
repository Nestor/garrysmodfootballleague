function GFL:EntityTakeDamage( target, dmginfo )
	if target == "gfl_ball" then
		gfl.lastKicker = dmginfo:GetAttacker()
	end
end

function GFL:PlayerUse()
	return false
end
