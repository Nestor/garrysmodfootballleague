/*
** Copyright (c) 2017 Jake Green (TheVingard)
** This file is private and may not be shared, downloaded, used or sold.
*/

DeriveGamemode("base")
MsgC( Color( 83, 143, 239 ), "[IMPULSE] Starting client load...\n" )

gfl = {} -- defining global function table
gfl.meta = FindMetaTable( "Player" )

include("shared.lua")
