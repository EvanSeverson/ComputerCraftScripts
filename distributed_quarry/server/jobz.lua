require("split")


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

local totalTurtles = tonumber(arg[1])

pos = {xmin,ymin,zmin}
dims = {xmax-xmin,ymax-ymin,zmax-zmin}

local jobs = splitVol(pos,dims,totalTurtles)

max = jobs[1][2][1]*jobs[1][2][2]*jobs[1][2][3]
for m = 1,#jobs
do
	if max < jobs[m][2][1]*jobs[m][2][2]*jobs[m][2][3]
	then
		max = jobs[m][2][1]*jobs[m][2][2]*jobs[m][2][3]
	end
end

local numberOfJobs = math.ceil(max/(6*6*6))

for m = 1,#jobs
do
	jobs[m] = splitVol(jobs[m][1],jobs[m][2],numberOfJobs)
end

local turtles = {}

rednet.open("left")

print("Searching for volunteers...")
while #turtles < totalTurtles
do
	rednet.broadcast("start","quarry_job")
	local senderID, message, protocol = rednet.receive()
	if message == "volunteer"
	then
		table.insert(turtles,{senderID,1,true})
		rednet.send(senderID,"selected","is_selected")
		print("Received volunteer! ("..#turtles.."/"..totalTurtles..")")
	end

end
print("All volunteers found!")
print("Beginning jobs...")


numberDone = 0
jobFinished = false

while not jobFinished
do
	local senderID, message, protocol = rednet.receive()
	if message == "request_job"
	then
		for m = 1,#turtles,1
		do
			if turtles[m][1] == senderID
			then
				nextJob = turtles[m][2]
				turtles[m][2] = turtles[m][2] + 1
				if turtles[m][2] > numberOfJobs
				then
					turtles[m][3] = false
					rednet.send(senderID,"done","is_done")
					numberDone = numberDone + 1
					if numberDone == #turtles
					then
						jobFinished = true
					end
				end
				rednet.send(senderID,"not_done","is_done")

				sPos = "{"..jobs[m][nextJob][1][1]..","..jobs[m][nextJob][1][2]..","..jobs[m][nextJob][1][3].."}"
				sDim = "{"..jobs[m][nextJob][2][1]..","..jobs[m][nextJob][2][2]..","..jobs[m][nextJob][2][3].."}"
				print("Sending job pos "..sPos.." and dimensions "..sDim.." to "..senderID)
				rednet.send(senderID,sPos.." "..sDim,"send_job")
				break
			end
		end
	end
end
