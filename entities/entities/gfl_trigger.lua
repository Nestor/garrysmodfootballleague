ENT.Base = "base_brush"
ENT.Type = "brush"

if SERVER then

	function ENT:Initialize()
		self:SetSolid(SOLID_BBOX)
		self:SetTrigger(true)
		print("GFL trigger created!")
	end

	function ENT:SetType(type,int)
		self.type = type
		self.typeVar = int
	end

	function ENT:StartTouch(entity)
		print(entity)
		if self.type == "goal" and entity == gfl.ball then
			gfl.ScoreGoal(self.typeVar, entity.lastToucher)
		end
	end
end
