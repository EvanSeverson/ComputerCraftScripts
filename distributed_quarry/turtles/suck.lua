if arg[1] == "down"
then
	turtle.suckDown()
elseif arg[1] == nil
then
	turtle.suck()
elseif arg[1] == "up"
then
	turtle.suckUp()
else
	print("Invalid drop direction.")
end
