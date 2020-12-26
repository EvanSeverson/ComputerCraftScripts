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
end


return M
