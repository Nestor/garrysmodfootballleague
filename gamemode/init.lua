/*
** Copyright (c) 2017 Jake Green (TheVingard)
** This file is private and may not be shared, downloaded, used or sold.
*/

DeriveGamemode("base")

print("\nGFL 2018:")
print('\nCopyright (c) 2018 Jake Green')
print('No permission is granted to USE, REPRODUCE, EDIT or SELL this software.')

gfl = {} -- defining global function table

gfl.meta = FindMetaTable( "Player" )


AddCSLuaFile("shared.lua")
include("shared.lua")



