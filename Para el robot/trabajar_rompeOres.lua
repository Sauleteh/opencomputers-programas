-- Programa para minar todos los bloques que tenga en el inventario

local component = require("component")
local robot = require("robot")

local slots = 16
for i = 1, slots do
  robot.select(i)
  for j = 0, 64 do
    robot.place()
    robot.swing()
  end
end
robot.select(1)