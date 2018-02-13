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

	end

	function ENT:PhysicsCollide(data, collider)
		local ply = data.HitEntity
		if IsValid(ply) and ply:IsPlayer() then
			self.lastToucher = ply
			local phys = self:GetPhysicsObject()
			phys:ApplyForceOffset(ply:GetAimVector():GetNormalized() * 1000, ply:GetEyeTrace().HitPos)
			self:EmitSound("gfl/kick_"..math.random(1,4)..".wav", 70)
			for v,k in pairs(player.GetAll()) do
				netstream.Start(k, "ballDribbleAnim", ply)
			end
		end
	end
end
