local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

--[[
	Made by @GramGramGaming123 on Roblox
	@myusernameisyuri on Discord
	@zzen_a on the Twitter
	
	-- // 
	
        MIT License

        Copyright (c) 2023 @GramGramGaming123

        Permission is hereby granted, free of charge, to any person obtaining a copy
        of this software and associated documentation files (the "Software"), to deal
        in the Software without restriction, including without limitation the rights
        to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
        copies of the Software, and to permit persons to whom the Software is
        furnished to do so, subject to the following conditions:

        The above copyright notice and this permission notice shall be included in all
        copies or substantial portions of the Software.

        THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
        IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
        FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
        AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
        LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
        OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
        SOFTWARE.
	
	\\ --

	@class module
]]

type MethodName = () -> string

local warn = function(... : string)
    warn(string.format("[AntiInjectionModule] %s [AntiInjectionModule]", ...))
end

local AntiInjectionModule : table = setmetatable({}, {
    _Connections = {},
    _ID = Random.new(math.randomseed(os.time())):NextInteger(1, 10000000),
    _Destroyed = false,
    _DestroyedEvent = Instance.new("BindableEvent"),
    __call = function(_ : table, ... : any)
        if script:GetAttribute("loaded") then return end

        warn("")
    end,
})
AntiInjectionModule.__index = AntiInjectionModule
AntiInjectionModule.ClassName = "AntiInjectionModule" 

getmetatable(AntiInjectionModule)._Connections["AncestryConnection"] = script.AncestryChanged:Connect(function(child : Instance, parent : Instance)
    if parent == nil then
        getmetatable(AntiInjectionModule)._DestroyedEvent:Fire()
    end
end) or script.Parent.AncestryChanged:Connect(function(child : Instance, parent : Instance)
    if parent == nil then
        getmetatable(AntiInjectionModule)._DestroyedEvent:Fire()
    end
end) or script.Parent.DescendantRemoving:Connect(function(child : Instance)
    getmetatable(AntiInjectionModule)._DestroyedEvent:Fire()
end)

getmetatable(AntiInjectionModule)._DestroyedEvent.Event:Once(function()
    Players.LocalPlayer:Kick("Malicious Activites Detected")
    getmetatable(AntiInjectionModule)._Destroyed = true
end)

local Methods : Folder = script:FindFirstChild("Methods")
local Components : Folder = script:FindFirstChild("Components")
local Dependencies : Folder = script:FindFirstChild("Dependencies")

local Promise = require(script.Promise)

-- function AntiInjectionModule:_changePunishment(newPunishment : any)
--     assert(newPunishment :: any, "newPunishment is not defined in AntiInjectionModule")
--     assert(type(newPunishment) == "function", "newPunishment is not a function")
    
--     getmetatable(self)._punish = newPunishment
--     print(getmetatable(self)._punish)
-- end

function AntiInjectionModule:_useMethod<MethodName>(methodName : MethodName, methodArguments : any)
    assert(methodName, "methodName is not defined in AntiInjectionModule")

    if not RunService:IsClient() then return end
   
    coroutine.wrap(function()
        local method = self:_fetchMethod(methodName :: string)
        assert(method, "method could not be found in AntiInjectionModule")
        method = require(method)
        
        local methodResult = method:method(methodArguments :: any)

        if methodResult == true then
            Players.LocalPlayer:Kick("Malicious Activites Detected")
        end
    end)()
end

function AntiInjectionModule:_fetchMethod<MethodName>(methodName : MethodName)
    assert(methodName, "methodName is not defined in AntiInjectionModule")

    local foundModule : ModuleScript

    Promise.new(function(resolve : any, reject : any)
        local methodModule : any = Methods:FindFirstChild(methodName, true)
        if methodModule then
            resolve(methodModule :: ModuleScript)
        else
            reject()
        end
    end):andThen(function(methodModule : ModuleScript)
        foundModule = methodModule :: ModuleScript
    end):catch(function(... : any)
        foundModule = false
    end)

    return foundModule
end

return AntiInjectionModule