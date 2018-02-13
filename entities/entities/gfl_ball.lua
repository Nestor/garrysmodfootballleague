AddCSLuaFile()

ENT.Type = "anim"
ENT.PrintName = "Ball"
ENT.Category = ""
ENT.Spawnable = false


if SERVER then
	function ENT:Initialize()
		self:SetModel("models/props_phx/misc/soccerball.mdl")
		self:SetSolid(SOLID_VPHYSICS)
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType( MOVETYPE_VPHYSICS )

		local physObj = self:GetPhysicsObject()

		if (IsValid(physObj)) then
			physObj:SetMaterial( "gmod_bouncy" )
			physObj:EnableMotion(true)
			physObj:Wake()
		end
	end

	function ENT:PhysicsCollide(data, collider)
		local player = data.HitEntity
		if IsValid(player) and player:IsPlayer() then
			self.lastToucher = player
			local phys = self:GetPhysicsObject()
			phys:ApplyForceOffset(player:GetAimVector():GetNormalized() * 1000, player:GetEyeTrace().HitPos)
		end
	end
end
