moves = require("move")
if arg[2] == nil
then
	arg[2] = 1
end


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
	end
end
