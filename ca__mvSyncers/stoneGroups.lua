return function(p,o,c)
	-- body



	local function copy(a)
		-- body
		local o = {}
		for k,v in pairs(a) do 
			o[k] = v
		end
		return o
	end

	local function a_in_b (a,b)
		-- body
		for k,v in pairs(a) do 
			if a[k] ~= b[k] then
				return false
			end
		end

		return true
	end

	o.lib = {}

	for k,stoneGroup in pairs(modular_ros("views.pan.t3.stoneGroups").lib) do 

		local iobj = {}
		o.lib[k] = iobj

		iobj.dobj = stoneGroup
		iobj.model = nil

		iobj.unconfirmedStart = 1 
		iobj.RN = -1
		iobj.records = {}


		function iobj:sync()
			-- body
			local model = self.model

			if self.RN ~= model.RN then 
				self.unconfirmedStart = 1
			end

			print(" dcode - gee93jg3 " .. #model.records)
			for i = self.unconfirmedStart,#model.records do 


				-- print(" dcode - g93j9g3 ".. tostring(safe_get(self,"records.#"..i..".colubrow")))
				-- print(" dcode - g93j9g4 ".. tostring(safe_get(model,"records.#"..i..".colubrow")))

				if self.records[i] and a_in_b(model.records[i],self.records[i]) then
					
					print(" dcode - g93j9g5 ")
				else
					if self.records[i] then 
						print(" dcode - g93j9g6 ")
						self.records[i].dobj:removeSelf()
					end
					self.records[i] = copy(model.records[i])
					self.records[i].dobj = self.dobj:put(self.records[i])
				end

			end

			for i = #model.records+1,#self.records do
				self.records[i].dobj:removeSelf()
				self.records[i] = nil
			end

			self.RN = model.RN 
			self.unconfirmedStart = 1

		end

		function iobj:setModel(model)
			self.model = model
		end

	end


	
end