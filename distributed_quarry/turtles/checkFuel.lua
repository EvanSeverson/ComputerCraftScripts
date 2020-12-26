local C = {}

function nearestRefuel()
	
	return pos
end

function checkFuel()
	if turtle.getFuelLevel() <= turtle.getFuelLimit()/10
	then
		attempt = 0
		while not turtle.refuel()
		do
			turtle.select(attempt)
			turtle.refuel()
			attempt = attempt+1
			if attempt == 15
			then
				attempt = 0
				--requestFuel()
				--getFuel()
				break
			end
		end
	end
end

return C
