

local function index_namepacks(t,k)
	-- body
	namepacks = t.__namepacks or {}

	-- print("e3gwag4 key :"..k)
	-- dump_table(t,3,-2)

	for i = #namepacks,1,-1 do
		local namepack = namepacks[i]
		local v = rawget(namepack,k)
		if v then 
			return v
		end		
	end
end

local namepacked_table_mt = {
	__index = index_namepacks
}


g_namepacks={}

g_namepacks['a']={
		g_namepacks = g_namepacks,	
		print = print,
		getfenv = getfenv,
		display=display,
		dump_table = dump_table,
		u = u,
		math = math,
		unpack = unpack
	
}



function namepacked(...)
	local t = {}
	setmetatable(t,namepacked_table_mt)
	local namepacks = {}

	for i,v in ipairs(arg) do
		print("inserting namepack ".. v .. " : " .. tostring(g_namepacks[v]))
		table.insert(namepacks,g_namepacks[v])
	end

	t.__namepacks = namepacks

	return t
end


