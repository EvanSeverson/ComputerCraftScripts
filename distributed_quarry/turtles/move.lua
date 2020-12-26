local M = {}

fuel = require("checkFuel")
handle = require("handle")

function tryForward()
	checkFuel()
	while not turtle.forward()
	do
		if not handle()
		then
			break
		end
	end
end

function tryUp()
	checkFuel()
	while not turtle.up()
	do
		if not handle("up")
		then
			break
		end
	end
end

function tryDown()
	checkFuel()
	while not turtle.down()
	do
		if not handle("down")
		then
			break
		end
	end
end


return M
