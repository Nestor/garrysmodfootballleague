local loaded = loaded or false

if loaded == false then
	LocalPlayer():ConCommand("stopsound")
	EmitSound( Sound( "gfl/genericloop.wav" ), LocalPlayer():GetPos(), 1, CHAN_STATIC, 0.2, 75, 0, 100 )
	loaded = true
end

