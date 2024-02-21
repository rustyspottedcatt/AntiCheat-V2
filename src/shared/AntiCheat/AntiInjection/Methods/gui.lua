--[[
	@class Gui
	
	This is for scripts that contain UI elements. 

    this isnt flawless because of coregui, but works against skids and stupid exploit makers
]]

local Gui = {}
Gui.__index = Gui
Gui.ClassName = "Gui"

local function check()
	local PlrGui = {}
	local StarterGui = {}

	for i, v in pairs(game.Players.LocalPlayer.PlayerGui:GetChildren()) do
		if v:IsA("ScreenGui") then
			PlrGui[i] = v
		end
	end

	for i, v in pairs(game.StarterGui:GetChildren()) do
		if v:IsA("ScreenGui") then
			StarterGui[i] = v
		end
	end

	if #PlrGui - 1 >= #StarterGui then -- 1 cause of freecam
		return true
	else
		return false
	end
end

repeat task.wait() until game:IsLoaded() and check() == true 

for _, v in pairs(game.Players.LocalPlayer:WaitForChild("PlayerGui"):GetDescendants()) do
	if v:IsA("ScreenGui") then
		if not script:FindFirstChild("PlayerGui") then  Instance.new("Folder", script).Name = "PlayerGui" end
		local guiClone = v:Clone()

		for i, script in pairs(guiClone:GetDescendants()) do
			if not script:IsA("ScreenGui") then
				script:Destroy()
			end
		end

		guiClone.Parent = script.PlayerGui
		guiClone:SetAttribute("object", v.Name)
	end
end

function Gui:method(... : any)
	local function checkGui(where : Instance, what : Instance) 
		for i,v in pairs(where:GetDescendants()) do
			if v:IsA("ScreenGui") then
				if v.Name == what.Name and typeof(v) == typeof(what) and v.ClassName == what.ClassName then
					return true 
				end 
			end
		end
	end

	for i, descendant in pairs(game.Players.LocalPlayer:WaitForChild("PlayerGui"):GetDescendants()) do
		if descendant:IsA("ScreenGui") and not descendant:FindFirstAncestorOfClass("ScreenGui") then
			if checkGui(script.PlayerGui, descendant) then 
				continue
			else
				warn(string.format("Warning : Fetched Malicious UI : %s", tostring(descendant.Name)))
				return true
			end
		end
	end
end

return Gui