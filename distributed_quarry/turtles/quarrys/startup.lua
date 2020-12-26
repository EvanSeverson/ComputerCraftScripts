local homeX,homeY,homeZ = gps.locate()

local staleDir = true
local currentDir = 0;

function fwd()
	local lastX = 0
	local lastZ = 0
	if (staleDir) then
		local x, y, z = gps.locate()
		lastX = x
		lastZ = z
	end

	local res = fwdNoDir()

	if (staleDir) then
		local x, y, z = gps.locate()
		local zDir = z - lastZ
		local xDir = x - lastX
		if (xDir ~= 0 or zDir ~= 0) then
			currentDir = math.abs(zDir) * (zDir + 1) + math.abs(xDir) * (xDir + 2)
			staleDir = false
			return true
		end
		return false
	end
	return res
end

function fwdNoDir()
	while not turtle.forward() do
		local count = 0
		while (peripheral.getType("front") ~= nil) do
			sleep(0.1)
			count = count + 1
			local dirBefore = currentDir
			if (count % 30 == 0) then
				turnLeft()
				sleep(1)
				if (fwdNoDir()) then
					sleep(math.random(0,3))
					while(not back()) do
					end
				end
	                        setDir(dirBefore)
                                sleep(1)
			end
		end
		turtle.dig()
	end
	return true
end

function up()
	while not turtle.up() do
                local count = 0
                while (peripheral.getType("top") ~= nil) do
                        sleep(0.1)
                        count = count + 1
                        local dirBefore = currentDir
                        if (count % 30 == 0) then
                                turnLeft()
				sleep(1)
                                if (fwdNoDir()) then
                                        sleep(math.random(0,3))
                                        while(not back()) do
                                        end
                                end
                        	setDir(dirBefore)
                                sleep(1)
                        end
                end
		turtle.digUp()
	end
	return true
end

function down()
	if not turtle.down() then
		local count = 0
                while (peripheral.getType("bottom") ~= nil) do
                        sleep(1)
                        count = count + 1
                        local dirBefore = currentDir
                        if (count % 30 == 0) then
                                turnLeft()
				sleep(0.1)
                                if (fwdNoDir()) then
                                        sleep(math.random(0,3))
                                        while(not back()) do
                                        end
                                end
	                        setDir(dirBefore)
                                sleep(1)
                        end
                end
		turtle.digDown()
		return turtle.down()
	end
	return true
end

function back()
	return turtle.back()
end

function turnRight()
	if (turtle.turnRight()) then
		currentDir = (currentDir + 3) % 4
		return true
	end
	return false
end

function turnLeft()
	if (turtle.turnLeft()) then
		currentDir = (currentDir + 1) % 4
		return true
	end
	return false
end

function setDir(dir)
	if (staleDir)
	then
		if (not fwd()) then
			back()
		end
	end

	diffDir = (dir - currentDir + 4) % 4

	if (diffDir == 0) then
		return staleDir
	elseif (diffDir == 1) then
		return turnLeft() and staleDir
	elseif (diffDir == 2) then
		return turnLeft() and turnLeft() and staleDir
	elseif (diffDir == 3) then
		return turnRight() and staleDir
	end
end


function go(x, y, z)
	local curX, curY, curZ = gps.locate()

	if (curY == homeY) then
		if (not up()) then
			if (not down()) then
				return false
			else
				curY = curY - 1
			end
		else
			curY = curY + 1
		end
	end

	if (curZ < z) then
		goX(curX, x)
		goZ(curZ, z)
	else
		goZ(curZ, z)
		goX(curX, x)
	end

	goY(curY, y)

end

function goS(cur, val)
	local success = true;
	for i = 1, math.abs(cur - val), 1 do
		success = success and fwd()
	end

	return success
end

function goX(curX, x)
	if (curX == x) then
		return true
	end
	if (curX < x) then
		setDir(3)
	else
		setDir(1)
	end

	return goS(curX, x)
end

function goZ(curZ, z)
	if (curZ == z) then
		return true
	end
	if (curZ < z) then
		setDir(2)
	else
		setDir(0)
	end

	return goS(curZ, z)
end

function goY(curY, y)
	if (curY == y) then
		return true
	end
	if (curY < y) then
		for i = 1, y - curY, 1 do
			up()
		end
	else
		for i = 1, curY - y, 1 do
			down()
		end
	end
end


function doJob(x, y, z)
	turtle.refuel()
	go(x, y + 1, z)
	setDir(0)
	shell.run("quarry 6 6 6")
	go(homeX, homeY, homeZ)
end


local serverId = 0;
while (true)
do
        -- Wait for the signal to start
        print("Waiting for the start signal")
        while (true)
                do
                rednet.open("left")
                local senderId, message, protocol = rednet.receive()

                if (message == "start")
                then
			serverId = senderId
                        break;
                end
        end

        -- Keep polling until the signal to stop
        while (true)
        do
                rednet.open("left")
		local is_done = nil
		while (is_done == nil) do
			print("polling for a job")
                	rednet.send(serverId, "request_job")
                	is_done = select(2, rednet.receive("is_done", 0.5))

		end
                if (is_done == "done")
                then
                        print("received the done signal")
                        break;
                end
                local jobx = select(2,rednet.receive("jobx"))
                local joby = select(2,rednet.receive("joby"))
                local jobz = select(2,rednet.receive("jobz"))

                rednet.close("left")

                print("Received job at "..jobx..","..joby..","..jobz)

                doJob(jobx, joby, jobz)
        end
end

