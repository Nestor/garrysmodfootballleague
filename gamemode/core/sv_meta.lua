function gfl.meta:PlayGesture(act)
	for v,k in pairs(player.GetAll()) do
		netstream.Start(k, "playGesture", self, act)
	end
end

function gfl.meta:Notify(icX,icY,text,lifeTime,target)
	netstream.Start(self,"notify",icX,icY,text,lifeTime,target)
end
