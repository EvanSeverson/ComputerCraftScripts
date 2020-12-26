local xJobSize = 6
local yJobSize = 6
local zJobSize = 6

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

local active_turtles = {}

for i=ymax,ymin,-yJobSize
do
        for j=xmin,xmax,xJobSize
        do
                for k=zmin,zmax,zJobSize
                do
                        local senderId, message, protocol = rednet.receive()
                        if (message == "request_job")
                        then
                                print("sending "..j..","..i..","..k.." to "..senderId)
                                rednet.send(senderId, "not_done", "is_done")
                                rednet.send(senderId, j, "jobx")
                                rednet.send(senderId, i, "joby")
                                rednet.send(senderId, k, "jobz")

                                active_turtles[senderId] = true
				sleep(0.5)
                        end
                end
        end
end

local inactive_turtles = {}
while (GetTableLng(active_turtles) > GetTableLng(inactive_turtles))
do
        local senderId, message, protocol = rednet.receive()
        if (message == "request_job")
        then
                print("sending done signal to " .. senderId)
                rednet.send(senderId, "done", "is_done")
                inactive_turtles[senderId] = true
        end
end

