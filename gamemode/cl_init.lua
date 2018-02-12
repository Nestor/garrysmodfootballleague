/*
** Copyright (c) 2017 Jake Green (TheVingard)
** This file is private and may not be shared, downloaded, used or sold.
*/

DeriveGamemode("base")
util.PrecacheSound("gfl/genericloop.wav")
util.PrecacheSound("gfl/goal.wav")
util.PrecacheSound("gfl/lalalala_chant.mp3")
util.PrecacheSound("gfl/wonderland_chant.wav")

util.PrecacheSound("gfl/kick_1.wav")
util.PrecacheSound("gfl/kick_2.wav")
util.PrecacheSound("gfl/kick_3.wav")
util.PrecacheSound("gfl/kick_4.wav")

util.PrecacheModel("konnie/football/football.mdl")


gfl = {} -- defining global function table
gfl.meta = FindMetaTable( "Player" )

include("shared.lua")
