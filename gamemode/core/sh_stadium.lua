stadium = stadium or {}

function AddStadium(mapname, table)
	stadium[mapname] = table
end


function gfl.GetStadium()
	return stadium[game.GetMap()]
end

