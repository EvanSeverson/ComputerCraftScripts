while (true)
do
	-- Wait for the signal to start
	print("Waiting for the start signal")
	local serverID = 0
	local selected = false
	while (selected == false)
	do
		rednet.open("left")
		local senderID, message, protocol = rednet.receive()

		if (message == "start")
		then
			serverID = senderID
			rednet.send(serverID,"volunteer")

			local senderID, is_selected, protocol = rednet.receive("is_selected",10)
			if senderID ~= nil and is_selected ~=nil and senderID == serverID and is_selected == "selected"
			then
				selected == true
			end
		end
	end

	-- Keep polling until the signal to stop
	while (true)
	do
		rednet.open("left")
		rednet.send(serverID, "request_job")
		local is_done = select(2, rednet.receive("is_done"))
		if (is_done == "done")
		then
			print("received the done signal")
			break
		end
		local jobPos = select(2,rednet.receive("jobPos"))
		local jobDim = select(2,rednet.receive("jobDim"))

		rednet.close("left")

		print("Received job at "..jobPos)

		sleep(1) -- simulate working on the job for 5 seconds
	end
end
