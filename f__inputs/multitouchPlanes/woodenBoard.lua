return function (p,o,c)
	-- body

	local updateFocusedT3 = modular_ros("actions.updateFocusedT3")
	local stoneGroupModelLib = modular_ros("models.stoneGroups").lib


	local dobj_woodenBoard = modular_ros("views.pan.t3.woodenBoard").dobj



	o.func = function(event)
		-- body
		print(" dcode - 24fqeqfq")	
		
		if event.phase == "ended" then 

			local colubrow = updateFocusedT3.showingStoneGroup:globalXYtoColubrow(event.x,event.y)

			stoneGroupModelLib[updateFocusedT3.showingStoneGroupColUbRow]:put({colubrow=colubrow,color="red",char="a"})


		end
	end

end