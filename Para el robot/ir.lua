-- Requirimientos previos
local robot = require("robot")
local sides = require("sides")
local shell = require("shell")
local component = require("component")

local args = shell.parse(...)

for i = 1, #args/2 do
	if (args[i*2] == "w") then
		for j = 1, tonumber(args[(i*2)-1]) do
			robot.forward()
		end
	end
	if (args[i*2] == "a") then
		robot.turnLeft()
		for j = 1, tonumber(args[(i*2)-1]) do
			robot.forward()
		end
	end
	
	if (args[i*2] == "s") then
		robot.turnLeft()
		robot.turnLeft()
		for j = 1, tonumber(args[(i*2)-1]) do
			robot.forward()
		end
	end
	
	if (args[i*2] == "d") then
		robot.turnRight()
		for j = 1, tonumber(args[(i*2)-1]) do
			robot.forward()
		end
	end
	
	if (args[i*2] == "r") then
		for j = 1, tonumber(args[(i*2)-1]) do
			robot.up()
		end
	end
	
	if (args[i*2] == "f") then
		for j = 1, tonumber(args[(i*2)-1]) do
			robot.down()
		end
	end
	
	if (args[i*2] == "q") then
		for j = 1, tonumber(args[(i*2)-1]) do
			robot.turnLeft()
		end
	end
	
	if (args[i*2] == "e") then
		for j = 1, tonumber(args[(i*2)-1]) do
			robot.turnRight()
		end
	end
end

print(#args)