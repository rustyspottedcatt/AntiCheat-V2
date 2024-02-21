--[[
	@class Recursive
	
	This is for synapse v2 (and maybe v3) & krnl, when attaching it freezes the frame for around 1-2 seconds which stimulates this script.
]]

local Recursive = {}
Recursive.__index = Recursive
Recursive.ClassName = "Recursive"

--[[
	Using a loop instead of a recursive function because of the lua recursion limit of 16,000
	
	only flaw with this is lag because it can stimulate injecting. (only if u got like 0 fps)
]]

function Recursive:method(... : any)
	while true do
		local start = os.clock()
		task.wait()
		if os.clock() - start >= 1.5 then
			return true
		else
			continue
		end
	end
end

return Recursive