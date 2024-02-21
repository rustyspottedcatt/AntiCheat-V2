local start = os.clock()

local Players = game:GetService("Players")

local Player = Players.LocalPlayer
local hashLib = require(script.HashLib)
local AntiInjectionModule = require(script.AntiInjection)

coroutine.wrap(function()
	local function randomIntegrerString(min, max)
		return tostring(math.random(min, max)) .. tostring(math.random(min, max)) .. tostring(math.random(min, max)) .. tostring(math.random(min, max)) .. tostring(math.random(min, max)) .. tostring(math.random(min, max)) .. tostring(math.random(min, max)) .. tostring(math.random(min, max)) .. tostring(math.random(min, max)) .. tostring(math.random(min, max)) .. tostring(math.random(min, max)) .. tostring(math.random(min, max))
	end
	
	task.spawn(function()
		script:GetPropertyChangedSignal("Enabled"):Once(function()
			Player:Kick("Don't tamper with the scripts kid")
		end) 
	end)
	
	task.spawn(function()
		local sha256 = hashLib.sha256(randomIntegrerString(1, 99))
		local sha224 = hashLib.sha224(sha256)
		local sha3_256 = hashLib.sha3_256(sha224)
		local sha3_224 = hashLib.sha3_224(sha3_256)
		local sha3_384 = hashLib.sha3_384(sha3_224)
		local final = hashLib.sha512(sha3_384)

		script.Name = tostring(final)
		script.Parent = game:GetChildren()[math.random(1, #game:GetChildren())]
	end)
	
	task.spawn(function()
		script:GetPropertyChangedSignal("Parent"):Once(function()
			Player:Kick("Don't tamper with the scripts kid")
		end)
	end)
	
	task.spawn(function()
		script.Destroying:Once(function()
			Player:Kick("Don't tamper with the scripts kid")
		end)
	end)
	
	task.spawn(function()
		script.DescendantRemoving:Once(function(descendant : Instance)
			Player:Kick("Don't tamper with the scripts kid")
		end)
	end)

	task.spawn(function()
		script.DescendantAdded:Once(function(descendant : Instance)
			if descendant:IsA("ScreenGui") or descendant:IsA("Folder") then return end
			Player:Kick("Don't tamper with the scripts kid")
		end)
	end)
end)()

--[[

	When using :_useMethod()

	The 1st argument is a string and in this case the method name.
	Methods can be found under the module > Methods

	The 2nd argument is the player that will be punished when the method is called.
]]--

AntiInjectionModule:_useMethod("recursive", nil :: nil)
AntiInjectionModule:_useMethod("32bit", nil :: nil)

warn(string.format("Initiliazed client script in under %s seconds", os.clock() - start))
