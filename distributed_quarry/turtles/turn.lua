require("orientation")

if arg[2] == nil
then
	arg[2] = 1
end
arg[2] = tonumber(arg[2])

if arg[1] == "left"
then
	arg[1] = true
elseif arg[1] == "right"
then
	arg[1] = false
else
	print("Invalid turn direction")
	return false
end

if arg[2] < 0
then
	arg[1] = not arg[1]
	arg[2] = math.abs(arg[2])
end

for n = 1,arg[2],1
do
	if arg[1]
	then
		turtle.turnLeft()
		setOrientation((getOrientation()+1)%4)
	else
		turtle.turnRight()
		setOrientation((getOrientation()-1)%4)
	end
end
return true
