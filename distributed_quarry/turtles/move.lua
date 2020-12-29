local M = {}

handleIt = require("handle")

function tryForward()
	if turtle.getFuelLevel() == 0
	then
		return false
	end
	while not turtle.forward()
	do
		if not handle("front")
		then
			break
		end
	end
	return true
end

function tryBackward()
		if turtle.getFuelLevel() == 0
		then
			return false
		end
		while not turtle.back()
		do
			if not handle("back")
			then
				break
			end
		end
		return true
end

function tryUp()
	if turtle.getFuelLevel() == 0
	then
		return false
	end
	while not turtle.up()
	do
		if not handle("up")
		then
			break
		end
	end
	return true
end

function tryDown()
	if turtle.getFuelLevel() == 0
	then
		return false
	end
	while not turtle.down()
	do
		if not handle("down")
		then
			break
		end
	end
	return true
end


return M
