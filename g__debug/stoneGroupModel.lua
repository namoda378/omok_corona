return function (p,o,c)
	-- body

	local mlib = modular_ros("models.stoneGroups").lib
	local updateFocusedT3 = modular_ros("actions.updateFocusedT3")


	local packet = {
		records = {

		}
	}
	p.funcs[1] = function()
		-- body

		local record = {}
		record.colubrow = math.random(11).."_"..math.random(11)
		record.char = "X"

		table.insert(packet.records,record)

		mlib[updateFocusedT3.showingStoneGroupColUbRow]:sync(packet)
		

	end

end