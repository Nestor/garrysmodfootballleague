local gap = 5
local length = gap + 5

function GFL:HudPaint()
	local p = LocalPlayer():GetEyeTrace().HitPos:ToScreen()
	local x,y = p.x, p.y
	print("r")
	surface.SetDrawColor( 255, 255,255, 155 )

	surface.DrawCircle(x,y,500,Color(255,255,255,255))
end
