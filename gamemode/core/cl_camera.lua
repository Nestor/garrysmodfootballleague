function GFL:ShouldDrawLocalPlayer()
	if cameraMode then return false end
    return true
end

concommand.Add("gfl_togglecameramode", function()
	if cameraMode then
		cameraMode = nil
	else
		cameraMode = true
	end
end)

function GFL:CalcView(ply, pos, angles, fov)
	if cameraMode then return end
	local trace = {}
	local view = {}
	local distance = 110

	trace.start = pos
	trace.endpos = pos - (angles:Forward() * distance)
	trace.filter = LocalPlayer()
	local trace = util.TraceLine(trace)
	local current = current or trace.HitPos:Distance( pos ) - 10
	if( trace.HitPos:Distance( pos ) < distance - 1 ) then
		current = math.Approach(current, 159, 1)
	end
	current = math.Approach(current, distance, FrameTime() * 40)

	distance = current
	view.origin = pos - (angles:Forward() * distance) + (angles:Right() * 40)
	view.angles = angles

	local speed = ply:GetVelocity():Length()
	view.fov = fov + (speed/28)

	return view
end
