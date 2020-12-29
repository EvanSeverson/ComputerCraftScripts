local O = {}

function getOrientation()
	local file = io.open("orient.txt","r")
	orient = tonumber(file:read())
	file:close()
	return orient
end

function setOrientation(orient)
	local file = io.open("orient.txt","w")
	file:write(orient%4)
	file:close()
	return true
end

return O
