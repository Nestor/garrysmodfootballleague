AddStadium("df_soccer_2006_v6", {
	ballPos = Vector(6187.709961, 3230.755127, 1090.717773)
})

if SERVER then
	local goal = ents.Create("gfl_trigger")
	goal:SetCollisionBoundsWS(Vector(6378.980469, 4743.854492, 1180.64428),Vector(6023.311035, 4746.623535, 1047.638184))
	goal:SetType("goal", 1) -- 1 or 2 is the team

	local goal = ents.Create("gfl_trigger")
	goal:SetCollisionBoundsWS(Vector(5918.492188, 1910.079834, 1207.106567),Vector(6232.312012, 1906.166504, 1113.491089))
	goal:SetType("goal", 2) -- 1 or 2 is the team

end
