AddStadium("df_soccer_2006_v6", {
	ballPos = Vector(6187.709961, 3230.755127, 1090.717773)
})

if SERVER then
	local goal1 = ents.Create("gfl_trigger")
	goal1:SetCollisionBoundsWS(Vector(),Vector())
	goal1:SetType("goal", 1) -- 1 or 2 is the team

end
