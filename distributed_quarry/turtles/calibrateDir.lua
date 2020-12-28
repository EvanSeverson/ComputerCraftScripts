require("move")
require("orientation")

function calibrateDir()
	local x0,y0,z0 = gps.locate()

	while not tryForward() do end

	local x,y,z = gps.locate()

	if		x-x0 > 0 then setOrientation(3)
	elseif	x-x0 < 0 then setOrientation(1)
	elseif	z-z0 > 0 then setOrientation(2)
	elseif	z-z0 < 0 then setOrientation(0)
	end

	while not tryBackward() do end

	return true
end

calibrateDir()
