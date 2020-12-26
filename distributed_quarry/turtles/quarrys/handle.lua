local H = {}

function handle(param)
	if param == nil
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
