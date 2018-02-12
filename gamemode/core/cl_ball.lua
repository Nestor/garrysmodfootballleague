local ball

function gfl.GetBall()
	if ball and IsValid(ball) then
		return ball
	else
		for v,k in pairs(ents.FindByClass("gfl_ball")) do
			ball = k
			return ball
		end
	end
end
