


u = {}

table.pack = function(...)
	arg.n = nil
	return arg
end

u.randoms = function(num)
	local ary = {}
	for i = 1,num do
		table.insert(ary,math.random())
	end
	return unpack(ary)
end

u.decodeColRow = function(colrow)
	return string.match(colrow,"(%d+)_(%d+)")
end

local colors = {
	

}


u.hexColor = function(str)
	local vals = table.pack(string.match(str,"(%x%x)(%x%x)(%x%x)"))
	for i = 1,#vals do
		vals[i] = tonumber("0x"..vals[i])/255
	end
	return vals
end


function u.randomInt(a,b)
	if not b then 
		b = a
		a = 1
	end

	

end