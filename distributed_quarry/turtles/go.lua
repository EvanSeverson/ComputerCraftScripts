moves = require("move")
if arg[2] == nil
then
	arg[2] = 1
end
arg[2] = tonumber(arg[2])

for n = 1,arg[2],1
do
	if arg[1] == "up"
	then
		tryUp()
	elseif arg[1] == "down"
	then
		tryDown()
	elseif arg[1] == "forward"
	then
		tryForward()
	elseif arg[1] == "backward"
	then
		tryBackward()
	else
		print("Invalid movement direction.")
		return false
	end
end
return true
