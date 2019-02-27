return function (o,c)

	
	local stones = modular_gos(o,"stones")

	local colubrowToXYInT3 = modular_ros("views.pan.t3").colubrowToXYInT3

	local function put(self,record)
		local stone = stones.new(record)  
		self:insert(stone)
		stone.x,stone.y = colubrowToXYInT3(record.colubrow)
		return stone
	end

	local kanPlaceSize = modular_ros("dimensions").kanPlaceSize

	local function globalXYtoColubrow(self,x,y)
		local x_l,y_l = self:contentToLocal(x,y)
		print(" dcode - g0m3932 xl " .. x_l .. " yl " .. y_l)
		
		local col = math.floor((x_l+kanPlaceSize/2)/kanPlaceSize)+6
		local row = math.floor((y_l+kanPlaceSize/2)/kanPlaceSize)+6

		return col.."_"..row

	end

	for k,stoneGroup in pairs(o.lib) do 
		stoneGroup.put = put
		stoneGroup.globalXYtoColubrow = globalXYtoColubrow
	end


end