return function (p,o,c)
	-- body


	local json = require("json")

	local receiver = modular_ros("network.receiver") 
	local receiver_func = receiver.func 

	local userInfo = modular_ros("models.user")
	local view_t3 = modular_ros("views.pan.t3")


	

	local receiver = modular_ros("network.receiver")

	local function check_and_pass(event)
		-- body
		if ( event.isError ) then 
			printANZ( "Network error: ", event.response ) 
		else
	        local response = json.decode(event.response)
			
			if response then
				--l0gUpdateGameColRow(response);
				--l0gUpdateGamePoints(response);        	
	        	receiver.func(response)
			else
				printANZ ("error : response not json parsable")
			end

	    end
	end

	local packets = {}
	local packet = {}
	packet['reqnames'] = {"model","t3"}
	packet['colubrow'] = "3_3"
	packets[1] = packet


	local params = {headers = {["Content-Type"] = "application/json"}}

	local function request()
		-- body

		params.body = json.encode(packets)

		--print(params.body)
		network.request( "http://127.0.0.1:8080/","POST", check_and_pass , params)
		
		-- packets = {}
	end





	timer.performWithDelay(500,request,0)


end



