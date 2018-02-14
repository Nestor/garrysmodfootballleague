function gfl.meta:PlayGesture(act)
	for v,k in pairs(player.GetAll()) do
		netstream.Start(k, "playGesture", self, act)
	end
end

function gfl.meta:Notify(icX,icY,text,lifeTime,target)
	netstream.Start(self,"notify",icX,icY,text,lifeTime,target)
end

function gfl.meta:RestoreStamina(amount)
	local current = self.stamina or 0
	local value = math.Clamp(current + amount, 0, 100)
	self.stamina = value
	netstream.Start(client, "stamUpdt", value)
end

function gfl.meta:SetGFLClass(name)
	self:SetNW2String("class", name)
end
