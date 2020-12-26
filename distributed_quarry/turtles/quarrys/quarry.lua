moves = require("move")
fuel = require("checkFuel")

for n = 0,3,1
do
	if arg[n] ~= nil
	then
		arg[n] = tonumber(arg[n])
	else
		arg[n] = 1
	end
end

orient = 0


tryDown()

for k = 0,arg[3]-1,1
do
	for l = 0,arg[2]-1,1
	do
		for m = 0,arg[1]-2,1
		do
			tryForward()
		end

		if l < arg[2]-1
		then
			if orient == 2*(k%2)
			then
				turtle.turnRight()
				tryForward()
				turtle.turnRight()
				orient = (orient - 2)%4
			else
				turtle.turnLeft()
				tryForward()
				turtle.turnLeft()
				orient = (orient + 2)%4
			end
		end
	end
	if k ~= arg[3]-1
	then
		tryDown()
		turtle.turnLeft()
		turtle.turnLeft()
		orient = (orient + 2)%4
	end

end

while (orient ~= 0)
do
	if orient < 0
	then
		turtle.turnLeft()
		orient = (orient + 1)%4
	elseif orient > 0
	then
		turtle.turnRight()
		orient = (orient - 1)%4
	end
end
