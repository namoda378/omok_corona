return function(p,o,c)
	-- body


	local t3_model_lib

	local receive_ = {}


	receive_.model.t3 



	o.func = function(response)

		dump_table(response,-10)

		for i,packet in pairs(response) do 

			local reqnames = packet.reqnames

			-- putstone response doesn't need to be processed

			if reqnames[0] == 'model' then 

				if reqnames[0] == 't3' then 

					local colubrow = packet.colubrow
					local t3_model = t3_model_lib[colubrow]

					t3_model:sync(packet)


				elseif reqnames[0] == 't2' then 



				end


			elseif reqnames[0] == 'model' then 


			end



		end
	end


	


	
end