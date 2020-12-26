if arg[1] == "down"
then
	turtle.dropDown()
elseif arg[1] == nil
then
	turtle.drop()
elseif arg[1] == "up"
then
	turtle.dropUp()
else
	print("Invalid drop direction.")
end
