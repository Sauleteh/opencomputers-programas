local robot = require("robot")

local left = robot.turnLeft
local right = robot.turnRight
local fw = robot.forward
local up = robot.up
local down = robot.down

up()
up()
for i=1,3 do
  fw()
end
right()
for i=1,4 do
  fw()
end
left()
for i=1,9 do
  fw()
end
left()
for i=1,15 do
  fw()
end
left()
for i=1,19 do
  fw()
end
right()
fw()
fw()
for i=1,5 do
  down()
end
for i=1,2 do
  fw()
end
for i=1,3 do
  down()
end
left()
fw()
fw()
right()
fw()
fw()
for i=1,3 do
  up()
end
right()
down()