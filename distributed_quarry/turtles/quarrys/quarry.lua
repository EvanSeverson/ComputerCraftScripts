require("move")
require("orientation")

local initialOrientation = getOrientation()

for n = 0,3,1
do
	if arg[n] ~= nil
	then
		arg[n] = tonumber(arg[n])
	else
		arg[n] = 1
	end
end

for k = 0,arg[2]-1,1
do
	for l = 0,arg[3]-1,1
	do
		for m = 0,arg[1]-2,1
		do
			tryForward()
		end

		if l < arg[3]-1
		then
			if (getOrientation()-initialOrientation)%4 == 2*(k%2)
			then
				shell.run("turn","right")
				tryForward()
				shell.run("turn","right")
			else
				shell.run("turn","left")
				tryForward()
				shell.run("turn","left")
			end
		end
	end
	if k ~= arg[2]-1
	then
		tryDown()
		shell.run("turn","left",2)
	end

end

if getOrientation() ~= initialOrientation
then
	local amount = getOrientation()-initialOrientation
	shell.run("turn","left",amount)
end
