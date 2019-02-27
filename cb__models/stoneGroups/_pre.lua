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
		for k,v in pairs(b) do 
			if a[v] ~= b[v] then
				return false
			end
		end

		return true
	end

	o.lib = {}

	for k,stoneGroupMVSyncer in pairs(modular_ros("mvSyncers.stoneGroups").lib) do 

		local model = {}
		o.lib[k] = model

		--print(" dcode - gau29ae " ..k)

		model.syncer = stoneGroupMVSyncer
		stoneGroupMVSyncer.model = model

		model.unconfirmedStart = 1 
		model.RN = -1
		model.records = {}


		function model:sync(packet)
			-- body

			if self.RN ~= packet.RN then 
				self.unconfirmedStart = 1
			end

			for i = self.unconfirmedStart,#packet.records do 
				self.records[i] = copy(packet.records[i])
			end

			local redunIdx = #packet.records+1
			while self.records[redunIdx] do 
				self.records[redunIdx] = nil
				redunIdx = redunIdx + 1
			end

			self.RN = packet.RN 
			self.unconfirmedStart = #packet.records + 1

			self.syncer:sync()
		end

		function model:put(record)
			table.insert(self.records,record)
			self.syncer:sync()
		end
	end


	
end