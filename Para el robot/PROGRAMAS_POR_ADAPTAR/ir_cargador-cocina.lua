local robot = require("robot")
local left = robot.turnLeft
local right = robot.turnRight
local fw = robot.forward
local up = robot.up
local down = robot.down

right()
fw()
fw()
right()
fw()
fw()
fw()
up()
up()
fw()
fw()
fw()
left()
fw()
fw()
left()
for i=1,2 do
  up()
  up()
  fw()
  fw()
end
up()
for i=1,16 do
  fw()
end
left()
fw()
fw()
right()
for i=1,4 do
  fw()
end
left()