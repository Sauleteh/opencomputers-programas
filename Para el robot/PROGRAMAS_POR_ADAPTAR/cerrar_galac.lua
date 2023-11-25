local robot = require("robot")

local left = robot.turnLeft
local right = robot.turnRight
local fw = robot.forward
local up = robot.up
local down = robot.down

local pUp = robot.placeUp

function poner55()
  for i=1,4 do
    pUp()
    fw()
  end
  pUp()
  right()
  fw()
  right()
  for i=1,4 do
    pUp()
    fw()
  end
  pUp()
  left()
  fw()
  left()
  for i=1,4 do
    pUp()
    fw()
  end
  pUp()
  right()
  fw()
  right()
  for i=1,4 do
    pUp()
    fw()
  end
  pUp()
  left()
  fw()
  left()
  for i=1,4 do
    pUp()
    fw()
  end
  pUp()
end

for i=1,2 do
  up()
end
down()
up()
for i=1,5 do
  fw()
end
left()
for i=1,7 do
  fw()
end
right()
for i=1,8 do
  fw()
end
robot.turnAround()
down()
robot.select(1) --Coger la tierra del cofre
robot.suckDown()
robot.select(2) --Coger los bloques de lab del cofre
robot.suckDown()
for i=1,6 do
  up()
end
for i=1,5 do
  fw()
end
right()
fw()
fw()
up()
robot.select(1)
poner55()
down()
robot.turnAround()
robot.select(2)
poner55()
for i=1,4 do
  fw()
end
left()
up()
robot.select(1)
poner55()
down()
robot.turnAround()
robot.select(2)
poner55()
right()
fw()
fw()
left()
for i=1,5 do
  down()
end
for i=1,8 do
  fw()
end
left()
for i=1,7 do
  fw()
end
left()
down()
down()
up()
down()
robot.select(1)