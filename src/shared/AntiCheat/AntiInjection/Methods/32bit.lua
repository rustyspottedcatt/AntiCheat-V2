--[[
	@class 32Bit
	
	Detects 32 bit clients
]]

local Bit = {}
Bit.__index = Bit
Bit.ClassName = "Bit"

local UserInputService = game:GetService("UserInputService")

function Bit:isMobile()
	if UserInputService.TouchEnabled and UserInputService.KeyboardEnabled == false then
		return true
	else
		return false
	end
end

function Bit:method(... : any)
	local tableAddress = tonumber(string.sub(tostring{}, 8))
	if #tostring(tableAddress) <= 10 and self:isMobile() == false then
		return true
	else
		return false
	end
end

return Bit