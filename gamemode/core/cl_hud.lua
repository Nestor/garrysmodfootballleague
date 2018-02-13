local gap = 5
local length = gap + 5
local crosshair_acc = 25
local white = Color(255,255,255,255)
local red = Color(255,10,10,255)

function GFL:HUDPaint()
	if cameraMode then return end
	local p = LocalPlayer():GetEyeTrace().HitPos:ToScreen()
	local x,y = p.x, p.y
	surface.SetDrawColor( 255, 255,255, 155 )

	local trace = LocalPlayer():GetEyeTrace()
	local dist = trace.HitPos:Distance(LocalPlayer():GetPos())/100

	surface.DrawCircle(x,y,crosshair_acc+dist,white)
end

local hidden = {}
hidden["CHudHealth"] = true
hidden["CHudBattery"] = true
hidden["CHudAmmo"] = true
hidden["CHudSecondaryAmmo"] = true
hidden["CHudCrosshair"] = true
hidden["CHudHistoryResource"] = true
hidden["CHudDeathNotice"] = true

function GFL:HUDShouldDraw(name)
	if hidden[name] then
		return false
	end
	return true
end


