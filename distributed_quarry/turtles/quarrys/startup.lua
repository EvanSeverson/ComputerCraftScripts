while (true)
do
        -- Wait for the signal to start
        print("Waiting for the start signal")
        serverId=0
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
                rednet.send(serverId, "request_job")
                local is_done = select(2, rednet.receive("is_done"))
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

                sleep(1) -- simulate working on the job for 5 seconds
        end
end
