surface.CreateFont("Screenfont",{
	font = "Arial",
	size = 50,
	antialias = true,
	shadow = true,
})

surface.CreateFont("ScreenfontSmall",{
	font = "Arial",
	size = 25,
	antialias = true,
	shadow = true,
})


function GFL:PostDrawOpaqueRenderables()
	local TextPos = gfl.GetStadium().manualTextPos1
	local TextVertPos = 30
	local angle = gfl.GetStadium().manualTextAngle1
	local scale = 1
	local timeLeft = string.FormattedTime((GetGlobalInt("gfl_matchStart")+900)-math.floor(CurTime()),"%02i:%02i")

	cam.Start3D2D( TextPos, angle, scale )
		render.PushFilterMin( TEXFILTER.ANISOTROPIC )
		draw.RoundedBox( 0, 0, 0, 111, 116, Color( 255, 51, 51 ) )
		draw.RoundedBox( 0, 111, 0, 111, 116, Color( 51, 51, 255 ) )
		draw.DrawText( team.GetScore( 2 ), "Screenfont", 55.5, TextVertPos, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER )
		draw.DrawText( team.GetScore( 1 ), "Screenfont", 166.5, TextVertPos, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER )
		draw.DrawText( timeLeft, "ScreenfontSmall", 111, 80, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER )
		render.PopFilterMin()
	cam.End3D2D()

	local TextPos = gfl.GetStadium().manualTextPos2
	local angle = gfl.GetStadium().manualTextAngle2

	cam.Start3D2D( TextPos, angle, scale )
		render.PushFilterMin( TEXFILTER.ANISOTROPIC )
		draw.RoundedBox( 0, 0, 0, 111, 116, Color( 255, 51, 51 ) )
		draw.RoundedBox( 0, 111, 0, 111, 116, Color( 51, 51, 255 ) )
		draw.DrawText( team.GetScore( 2 ), "Screenfont", 55.5, TextVertPos, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER )
		draw.DrawText( team.GetScore( 1 ), "Screenfont", 166.5, TextVertPos, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER )
		draw.DrawText( timeLeft, "ScreenfontSmall", 111, 80, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER )
		render.PopFilterMin()
	cam.End3D2D()
end
