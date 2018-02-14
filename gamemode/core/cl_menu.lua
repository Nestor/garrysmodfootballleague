local function openMenu()
	local Menu = vgui.Create( "DFrame" )
	Menu:SetSize( 300, 400 )
	Menu:Center()
	Menu:SetTitle( "Menu" )
	Menu:MakePopup()

	local redPlayers = #team.GetPlayers(2)
	local bluePlayers = #team.GetPlayers(1)

	local button = vgui.Create( "DButton", Menu )
	button:SetText( "Change to red team" )
	button:SetPos( 25, 50 )
	button:SetSize( 250, 30 )
	button.DoClick = function()
		netstream.Start("switchRed")
		Menu:Remove()
	end

	if redPlayers > bluePlayers or LocalPlayer():Team() == 2 then
		button:SetEnabled(false)
	end


	local button = vgui.Create( "DButton", Menu )
	button:SetText( "Change to blue team" )
	button:SetPos( 25, 80 )
	button:SetSize( 250, 30 )
	button.DoClick = function()
		netstream.Start("switchBlue")
		Menu:Remove()
	end

	if bluePlayers > redPlayers or LocalPlayer():Team() == 1 then
		button:SetEnabled(false)
	end

	local desc = [[
	Information:
	Garry's Mod Football League is a gamemode created
	by vin. You can click the link below to
	goto our workshop page.

	Controls:
	LEFT MOUSE - Kick ball
	E - Celebrate
	R - Call for team
	SHIFT - Sprint
	F1 - Open menu
	F2 - Class menu
	]]

	local info = vgui.Create( "DLabel", Menu )
	info:SetText( desc )
	info:SetPos(25, 115)
	info:SizeToContents()

	local button = vgui.Create( "DButton", Menu )
	button:SetText( "Open Steam Workshop page" )
	button:SetPos( 25, 275 )
	button:SetSize( 250, 30 )
	button.DoClick = function()
		gui.OpenURL( "http://steamcommunity.com/sharedfiles/filedetails/?id=1301275288" )
	end

	local button = vgui.Create( "DButton", Menu )
	button:SetText( "Open GitHub page" )
	button:SetPos( 25, 305 )
	button:SetSize( 250, 30 )
	button.DoClick = function()
		gui.OpenURL( "https://github.com/vingard/garrysmodfootballleague" )
	end
end
concommand.Add("gfl_openmenu", openMenu)

local function ClassMenu()
	local keeperOnline = false
	local lpIsKeeper = false

	for v,k in pairs(team.GetPlayers(LocalPlayer():Team())) do
		local class = k:GetNW2String("class","error")
		if class == "Goalkeeper" then
			keeperOnline = true
			if k == LocalPlayer() then
				lpIsKeeper = true
			end
		end
	end

	local lpIsPlayer = (LocalPlayer():GetNW2String("class", "error")=="Player")


	local ClassSelect = vgui.Create("DFrame")
	ClassSelect:SetSize(300,100)
	ClassSelect:Center()
	ClassSelect:SetTitle("Class Selection")
	ClassSelect:MakePopup()

	local button = vgui.Create("DButton", ClassSelect)
	button:SetPos(25,30)
	button:SetSize(250,30)
	button:SetText("Become Goalkeeper")
	button:SetEnabled((not keeperOnline and not lpIsKeeper))
	button.DoClick = function()
		netstream.Start("becomeKeeper")
		ClassSelect:Remove()
	end

	local button = vgui.Create("DButton", ClassSelect)
	button:SetPos(25,60)
	button:SetSize(250,30)
	button:SetText("Become Player")
	button:SetEnabled(lpIsPlayer)
	button.DoClick = function()
		netstream.Start("becomePlayer")
		ClassSelect:Remove()
	end
end
concommand.Add("gfl_openclassmenu", ClassMenu)
