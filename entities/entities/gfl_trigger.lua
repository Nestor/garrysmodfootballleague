ENT.Base = "base_brush"
ENT.Type = "brush"

if SERVER then

	function ENT:Initialize()
		self:SetSolid(SOLID_BBOX)
		self:SetTrigger(true)
	end

	function ENT:SetType(type,int)
		self.type = type
		self.typeVar = int
	end

	function ENT:StartTouch(entity)
		if self.type == "goal" and entity == gfl.ball then
			gfl.GoalScore(self.typeVar)
		end
	end

end
