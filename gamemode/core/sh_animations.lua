local IsValid = IsValid
local os = os
local util = util
local lastfov = 0

RegisterLuaAnimation('gfl_normal_kick', {
	FrameData = {
		{
			BoneInfo = {
				['ValveBiped.Bip01_R_Calf'] = {
					RU = -44.555652469149
				},
				['ValveBiped.Bip01_R_Thigh'] = {
					RU = -50.441395011994
				}
			},
			FrameRate = 30
		},
		{
			BoneInfo = {
				['ValveBiped.Bip01_R_Calf'] = {
				},
				['ValveBiped.Bip01_R_Thigh'] = {
				}
			},
			FrameRate = 2
		}
	},
	Type = TYPE_GESTURE
})

hook.Add("CalcMainActivity", "GFL-ANIMATIONBASE", function( Player, Velocity )
	local speed = Velocity:Length()
	local fov = Player:GetFOV()

	if Player:IsOnGround() then
		if speed > 315 then
			return ACT_HL2MP_RUN_FAST, -1
		else
			return ACT_MP_RUN, -1
		end
	end

end)


