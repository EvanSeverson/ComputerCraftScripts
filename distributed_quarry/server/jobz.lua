require("split")

function GetTableLng(tbl)
	local getN = 0
	for n in pairs(tbl) do
		getN = getN + 1
	end
	return getN
end



print("please enter the coordiantes of one corner.")
io.write("x: ")
local x1 = io.read()
io.write("y: ")
local y1 = io.read()
io.write("z: ")
local z1 = io.read()

print("please enter the coordiantes of the opposite corner.")
io.write("x: ")
local x2 = io.read()
io.write("y: ")
local y2 = io.read()
io.write("z: ")
local z2 = io.read()

local xmin = math.min(x1, x2)
local xmax = math.max(x1, x2)

local ymin = math.min(y1, y2)
local ymax = math.max(y1, y2)

local zmin = math.min(z1, z2)
local zmax = math.max(z1, z2)

rednet.open("left")
rednet.broadcast("start")

local totalTurtles = tonumber(arg[1])
local numberOfJobTrips = 3

local xSectDims,ySectDims,zSectDims = splitVol(xmax-xmin,ymax-ymin,zmax-zmin,totalTurtles)
local xSectDims2,ySectDims2,zSectDims2 = splitVol(xSectDims,ySectDims,zSectDims,numberOfJobTrips)
