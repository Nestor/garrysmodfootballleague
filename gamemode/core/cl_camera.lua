function GM:ShouldDrawLocalPlayer()
    return true
end

local distance = 100

function GM:CalcView(ply, pos, angles, fov)
	local trace = {}
	local view = {}

	trace.start = pos
	trace.endpos = pos - (angles:Forward() * distance)
	trace.filter = LocalPlayer()
	local trace = util.TraceLine(trace)
	if( trace.HitPos:Distance( pos ) < distance - 10 ) then
		dist = trace.HitPos:Distance( pos ) - 10
	end

	view.origin = pos - (angles:Forward() * 100) + (angles:Right() * 40)
	view.angles = angles
	view.fov = fov

	return view
end
