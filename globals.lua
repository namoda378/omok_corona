


local indents = {}
indents[0] = ""
for i = 1,10 do 
	indents[i] = indents[i-1] .. "   "
end


function print_in(call_stack,s)
	type_ = type(call_stack)
	if type_ == 'number' then
		indent = ""
		while call_stack > 0 do 
			indent = indent .. "	"
			call_stack = call_stack - 1 
		end
		print(indent .. s)
	elseif type_ == "string" then
		print(call_stack .. s)
	end
end


function dump_table(...)
	

	local args = {}

	for i,v in ipairs(arg) do
		local type_ = type(v)
		if type_ =="number" then
			if v <= 0 then
				type_ = "dep"
			end
		end
		args[type_] = v
	end

	if args['string'] then
		print(args['string'])
	end

	if not args['number'] then
		args['number'] = 1
	end

	if not args['dep'] then
		args['dep'] = -2
	end

	if args['dep'] == 0 then 
		return
	end


	for k,v in pairs(args['table']) do

		print(indents[args['number']]..tostring(k).." : " .. tostring(v))
		if type(v) == 'table' then
			dump_table(v,args['number']+1,args['dep']+1)
		end

	end
end

function strfy(list)
	local str = ""
	for i,v in ipairs(list) do
		str = str ..tostring(v) .. ' , '	
	end
	return str
end

function list_cmp(a,b)
	if #a == #b then 
		for i = 1,#a do
			if a[i] ~= b[i] then 
				return false
			end
		end
		return true
	end	
end

function list_list_remove_list_list(list_list,list_list_to_remove)
	local res_list = {}
	for i,v in ipairs(list_list) do 
		local should_insert_to_res = true
		for i1,v1 in ipairs(list_list_to_remove) do
			if list_cmp(v,v1) then 
				should_insert_to_res = false
				break
			end
		end
		if should_insert_to_res then
			table.insert(res_list,v)
		end	
	end
	return res_list
end

function modular_rbp_to_name(rbp)
	local module_name = string.match( rbp , "([%w_]+)%._init$" ) 
	if not module_name then
		module_name = string.match( rbp , "([%w_]+)$" ) 
	end
	assert(module_name)
	return module_name
end


function modular_namemap(tab)
	-- body
	local res_tab = {}
	for i,v in ipairs(tab) do
		res_tab[modular_rbp_to_name(v)] = v
	end
	return res_tab
end

function modular_require_s(rbp_s,parent,order)
	
	local  modules = {}

	if order then
		for i,v in ipairs(order) do
			modules[v] = require(rbp_s[v])(v)
		end
	else
		for k,v in pairs(rbp_s) do 
			modules[k] = require(v)(k)
		end 
	end
	return modules
end

function dsp_to_namestack(dsp)
	local namestack = {}
	for name in string.gmatch( dsp, "[^.]+" ) do
	    table.insert(namestack,name)
	end
	return namestack
end

function get_longest_list_len(list_list)
	local longest_list_len = 0
	for i,v in pairs(list_list) do 
		if #v > longest_list_len then
			longest_list_len = #v
		end
	end
	return longest_list_len
end

modular_root_holder = {__child_s={}}

local function modular_get_single(namestack)
	-- body
	local module_ = modular_root_holder.__child_s.root

	for i,v in ipairs(namestack) do 
		if module_.__child_s[v] then 
			module_ = module_.__child_s[v]
		end
	end
	return module_
end

function list_init(len_,val)
	local list = {}
	for i = 1,len_ do 
		table.insert(list,val)
	end
	return list
end


local function modular_crawler(len_)
	local crawler = {}
	crawler.cur_namestack = list_init(len_,"...")
	return crawler
end

local function modular_crawler_up()
	-- body
end

function modular_get(parent_module,...)
	local returns = {}

	local namestack_s = {}

	for i,v in ipairs(arg) do 
		local namestack = dsp_to_namestack(v)
		table.insert(namestack_s,namestack)
	end

	for i,v in ipairs(namestack_s) do
		local module_ = modular_get_single(v)
		table.insert(returns,module_)
	end

	return unpack(returns)
end

function get_by_keypath(o,keypath)
	for key in keypath:gmatch("[^%.]+") do
		if o[key] then 
			o = o[key]
		else
			return nil
		end
	end
	return o
end


function modular_gos(module_,namestr)
	-- body
	local cur_module = module_
	for name in namestr:gmatch("[^%.]+") do 
		assert(cur_module.__child_s[name])
		cur_module = cur_module.__child_s[name]
	end
	return cur_module
end

function modular_ros(namestr)
	return modular_gos(modular_root_holder.__child_s.root,namestr)
end


function insert_childs(group,childs)
	for k,v in pairs(childs) do 	
		group:insert(v)
		if type(k) ~= "number" then
			group[k] = v
		end
	end
	return group
end


function safe_get(o,namestack)
	-- body\
	for name in namestack:gmatch("[^%.]+") do 
		if name(1) == "#" then 
			name = tonumber(name(2,#name))
		end

		if o[name] then 
			o = o[name]
		else
			o = nil
			break
		end
	end
	return  o
end