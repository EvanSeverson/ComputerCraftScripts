if arg[2] == nil
then
	arg[2] = 1
end

for n = 1,arg[2],1
do
	if arg[1] == "right"
	then
		turtle.turnRight()
	elseif arg[1] == "left"
	then
		turtle.turnLeft()
	else
		print("Invalid turn direction")
	end
end
