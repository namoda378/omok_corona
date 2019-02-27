

	local json = require("json")
	require("globals")


	local packets_s = {
		{
			reqnames = {"model","t2"}
		},
		{
			reqnames = {"model","t3"},
			colubrow = "3_3"
		},
		{
			reqnames = {"putstone"},
			colubrow = "3_3"
		},
		{
			reqnames = {"signup"},
			colubrow = "3_3"
		},
		{
			reqnames = {"validation"},
			colubrow = "3_3"
		}
	}	

	local prev_printed = nil 
	local printed_repeating = nil

	original_print = print

	printAZ = function (s)
		if s == prev_printed then
			if not printed_repeating then
				printed_repeating = true
				original_print(" repeating .... ")
			end 
		else
			printed_repeating = false
			prev_printed = s
			original_print(s)
		end
	end

	local params = {headers = {["Content-Type"] = "application/json"}}


	local function check_and_pass(event)
		if ( event.isError ) then 
			printAZ( "Network error: ", event.response ) 
		else
	        local response = json.decode(event.response)
			
			if response then
				print(" dcode - 09g89h2 ")
	        	dump_table(response)
			else
				printAZ ("error : response not json parsable")
			end

	    end
	end

	local function request()
		-- body
		
		params.body = json.encode(packets)
		--printAZ(params.body)
		network.request( "http://127.0.0.1:8080/","POST", check_and_pass , params)
		
	end



	timer.performWithDelay(500,request,0)