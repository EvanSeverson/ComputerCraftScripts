local C = {}

function checkFuel()
	if turtle.getFuelLevel() <= turtle.getFuelLimit()/10
	then
		attempt = 1
		while not turtle.refuel()
		do
			turtle.select(attempt)
			attempt = attempt+1
			if attempt == 17
			then
				attempt = 1
				--getFuel()
				break
			end
		end
	end
end

return C
