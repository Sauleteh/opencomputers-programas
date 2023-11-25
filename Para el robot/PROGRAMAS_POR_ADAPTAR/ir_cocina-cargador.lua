local robot = require("robot")
local left = robot.turnLeft
local right = robot.turnRight
local fw = robot.forward
local up = robot.up
local down = robot.down

left()
for i=1,4 do
  fw()
end

left()
fw()
fw()
right()
for i=1,16 do
  fw()
end
down()
for i=1,2 do
  fw()
  fw()
  down()
  down()
end
right()
fw()
fw()
right()
fw()
fw()
fw()
down()
down()
fw()
fw()
fw()
left()
fw()
fw()
right()