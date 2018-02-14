local gap = 5
local length = gap + 5
local crosshair_acc = 25
local white = Color(255,255,255,255)
local red = Color(255,10,10,255)
local gradient = Material("vgui/gradient-d")

surface.CreateFont("barFont",{
	font = "Arial",
	size = 24,
	antialias = true,
	shadow = true,
})


function GFL:HUDPaint()
	if cameraMode then return end
	local p = LocalPlayer():GetEyeTrace().HitPos:ToScreen()
	local x,y = p.x, p.y
	surface.SetDrawColor( 255, 255,255, 155 )

	local trace = LocalPlayer():GetEyeTrace()
	local dist = trace.HitPos:Distance(LocalPlayer():GetPos())/100

	surface.DrawCircle(x,y,crosshair_acc+dist,white)

	local barsizex,barsizey = ScrW()/5, 40
	local smoothVal = LocalPlayer().stamina or 0

	surface.SetDrawColor(30,30,30,155)
	surface.DrawRect(0, 0, barsizex, barsizey)
	surface.DrawOutlinedRect(0,0,barsizex, barsizey)

	surface.SetDrawColor(red)

	surface.DrawRect(1,1,barsizex/100*smoothVal, barsizey-1)


	surface.SetDrawColor(200,200,200, 90)
	surface.SetMaterial(gradient)
	surface.DrawTexturedRect(0,0,barsizex,barsizey)

	draw.SimpleText("STAMINA", "barFont", barsizex/2, barsizey/2, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
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


