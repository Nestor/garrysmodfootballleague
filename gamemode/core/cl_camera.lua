function GFL:ShouldDrawLocalPlayer()
    return true
end


function GFL:CalcView(ply, pos, angles, fov)
	local trace = {}
	local view = {}
	local distance = 110

	trace.start = pos
	trace.endpos = pos - (angles:Forward() * distance)
	trace.filter = LocalPlayer()
	local trace = util.TraceLine(trace)
	if( trace.HitPos:Distance( pos ) < distance - 10 ) then
		distance = trace.HitPos:Distance( pos ) - 10
	end

	view.origin = pos - (angles:Forward() * distance) + (angles:Right() * 40)
	view.angles = angles

	local speed = ply:GetVelocity():Length()
	view.fov = fov + (speed/28)

	return view
end
