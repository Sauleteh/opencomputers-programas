local robot = require("robot")

local left = robot.turnLeft
local right = robot.turnRight
local around = robot.turnAround
local fw = robot.forward
local up = robot.up
local down = robot.down

up()
for i=1,3 do
  down()
end
right()
fw()
fw()
left()
fw()
fw()
for i=1,3 do
  up()
end
right()
fw()
fw()
for i=1,5 do
  up()
end
fw()
fw()
left()
for i=1,19 do
  fw()
end
right()
for i=1,15 do
  fw()
end
right()
for i=1,9 do
  fw()
end
right()
for i=1,4 do
  fw()
end
left()
for i=1,3 do
  fw()
end
around()
down()
down()