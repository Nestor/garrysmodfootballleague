/*
** Copyright (c) 2017 Jake Green (TheVingard)
** This file is private and may not be shared, downloaded, used or sold.
*/

DeriveGamemode("base")

print("\nGFL 2018:")
print('\nCopyright (c) 2018 Jake Green')
print('No permission is granted to USE, REPRODUCE, EDIT or SELL this software.')

gfl = gfl or {} -- defining global function table

gfl.meta = FindMetaTable( "Player" )


AddCSLuaFile("shared.lua")
include("shared.lua")
MsgC(Color(255,255,0), "\nINSTALLED GFL VERSION: "..GFL.Version)

MsgC(Color(255,255,0), "\nGetting latest version from master server...\n")

http.Fetch("https://raw.githubusercontent.com/vingard/garrysmodfootballleague/master/version", function(text)
	gfl.latestVersion = text
end)


timer.Simple(6, function()
	if not gfl.latestVersion then
		gfl.latestVersion = 1 -- Future proof
	end
	MsgC(Color(255,255,0), "\nLATEST GFL VERSION: "..gfl.latestVersion)

	if  gfl.latestVersion == GFL.Version then
		MsgC(Color(10,255,0), "\nYOU ARE ON THE LATEST VERSION :)")
	else
		MsgC(Color(255,255,0), "\nGFL IS OUT OF DATE!")
		MsgC(Color(255,10,0), "\nUpdate at: https://github.com/vingard/garrysmodfootballleague/releases")
		MsgC(Color(255,255,0), "\nINSTALLED VERSION: "..GFL.Version.. " | LATEST VERSION: "..gfl.latestVersion)
	end
end)
