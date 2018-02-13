AddStadium("df_soccer_2006_v6", {
	ballPos = Vector(6144, 3328, 1050)
})

if SERVER then
	hook.Add("InitPostEntity", "SpawnMakeDoGoals", function()
		--local goal = ents.Create("gfl_trigger")
		--goal:SetCollisionBoundsWS(Vector(6378.980469, 4743.854492, 1180.64428),Vector(6023.311035, 4746.623535, 1047.638184))
		--goal:SetType("goal", 1) -- 1 or 2 is the team
		--goal:SetTrigger(true)
		--goal:Spawn()

		--local goal = ents.Create("gfl_trigger")
		--goal:SetCollisionBoundsWS(Vector(5918.492188, 1910.079834, 1207.106567),Vector(6232.312012, 1906.166504, 1113.491089))
		--goal:SetType("goal", 2) -- 1 or 2 is the team
		--goal:SetTrigger(true)
		--goal:Spawn()

		-- BLUE GOAL (TEAM 1)
		local goal = ents.Create( "base_anim" )
		goal:SetModel( "models/hunter/blocks/cube2x4x1.mdl" )
		goal:SetAngles( Angle( 90, 90, 0 ) )
		goal:SetPos( Vector( 6140, 1915, 1065 ) )
		goal:SetRenderMode( RENDERMODE_TRANSALPHA )
		goal:SetColor( Color( 255, 255, 255, 0) )
		goal:SetSolid( SOLID_OBB )
		goal:SetCustomCollisionCheck( true )
		goal:SetTrigger( true )
		goal.StartTouch = function( self, otherEntity )
			if otherEntity == gfl.ball then
				gfl.ScoreGoal(TEAM_HOME, otherEntity.lastToucher)
				self:SetTrigger(false)
				timer.Simple(10, function() self:SetTrigger(true) end)
			end
		end

		-- RED GOAL (TEAM 2)
		local goal = ents.Create( "base_anim" )
		goal:SetModel( "models/hunter/blocks/cube2x4x1.mdl" )
		goal:SetAngles( Angle( 90, 90, 0 ) )
		goal:SetPos( Vector( 6140, 4743, 1065 ) )
		goal:SetRenderMode( RENDERMODE_TRANSALPHA )
		goal:SetColor( Color( 255, 255, 255, 0) )
		goal:SetSolid( SOLID_OBB )
		goal:SetCustomCollisionCheck( true )
		goal:SetTrigger( true )
		goal.StartTouch = function( self, otherEntity )
			if otherEntity == gfl.ball then
				gfl.ScoreGoal(TEAM_AWAY, otherEntity.lastToucher)
				self:SetTrigger(false)
				timer.Simple(10, function() self:SetTrigger(true) end)
			end
		end
	end)
end
