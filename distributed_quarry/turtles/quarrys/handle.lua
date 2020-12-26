local H = {}

function handle(param)
	if param == nil
	then
		return turtle.dig()
	elseif param == "up"
		return turtle.digUp()
	elseif param == "down"
		return turtle.digDown()
	else
		return false
	end
end
