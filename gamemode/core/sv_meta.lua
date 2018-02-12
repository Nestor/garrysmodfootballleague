function gfl.meta:PlayGesture(act)
	for v,k in pairs(player.GetAll()) do
		netstream.Start(k, "playGesture", self, act)
	end
end
