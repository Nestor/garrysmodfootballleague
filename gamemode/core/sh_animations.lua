local IsValid = IsValid
local os = os
local util = util
local lastfov = 0
hook.Add("CalcMainActivity", "GFL-ANIMATIONBASE", function( Player, Velocity )
	local speed = Velocity:Length()
	local fov = Player:GetFOV()

	if Player:IsOnGround() and not Player:Crouching() then
		if speed <= Player:GetWalkSpeed() + 10 then
			return ACT_HL2MP_WALK, -1
		elseif speed > 290 then
			return ACT_HL2MP_RUN_FAST, -1
		elseif speed > Player:GetRunSpeed() - 10 then
			return ACT_MP_RUN, -1
		end
	end

end)
