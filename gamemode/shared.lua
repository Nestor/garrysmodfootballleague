/*
** Copyright (c) 2017 Jake Green (TheVingard)
** This file is private and may not be shared, downloaded, used or sold.
*/


-- Define gamemode information.
GM.Name = "Garry's Mod Football League"
GM.Author = "TheVingard"
GM.Website = "https://www.vingard.github.io"

GFL = GM

-- Called after the gamemode has loaded.
function GFL:Initialize()
	gfl.reload()
end

-- Called when a file has been modified.
function GFL:OnReloaded()
	gfl.reload()
end





function gfl.LoadFile(fileName)
	if (!fileName) then
		error("File to include has no name!")
	end

	if fileName:find("sv_") then
		if (SERVER) then
			include(fileName)
		end
	elseif fileName:find("sh_") then
		if (SERVER) then
			AddCSLuaFile(fileName)
		end

		include(fileName)
	elseif fileName:find("cl_") then
		if (SERVER) then
			AddCSLuaFile(fileName)
		else
			include(fileName)
		end
	else
		if (SERVER) then
			AddCSLuaFile(fileName)
		end

		include(fileName)
	end
end


function gfl.includeDir(directory, fromLua)
	for k, v in ipairs(file.Find(directory.."/*.lua", "LUA")) do
    	gfl.LoadFile(directory.."/"..v)
	end
end


-- Loading 3rd party modules
gfl.includeDir("gfl/gamemode/thirdparty")

if SERVER then
	include("gfl/gamemode/animationapi/boneanimlib.lua")
else
	include("gfl/gamemode/animationapi/cl_boneanimlib.lua")
end

-- Loading core
gfl.includeDir("gfl/gamemode/core")

-- Loading stadiums
gfl.includeDir("gfl/gamemode/stadiums")

-- Loading patches
gfl.includeDir("gfl/gamemode/patches")


function gfl.reload()
    gfl.includeDir("gfl/gamemode/core")
end



