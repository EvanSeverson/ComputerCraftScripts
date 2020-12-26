local H = {}

function handle(param)

	local periph = peripheral.wrap(param)

	if periph ~= nil
	then
		turtle.turnLeft()
		return true
	end

	if param == "front"
	then
		turtle.dig()
		return true
	elseif param == "up"
	then
		turtle.digUp()
		return true
	elseif param == "down"
	then
		turtle.digDown()
		return true
	end
	return false
end

return H
