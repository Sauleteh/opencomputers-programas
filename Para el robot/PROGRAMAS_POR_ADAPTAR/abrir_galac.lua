local robot = require("robot")

local left = robot.turnLeft
local right = robot.turnRight
local fw = robot.forward
local up = robot.up
local down = robot.down

local sUp = robot.swingUp

function romper55()
  --Estar en la esquina izquierda inferior mirando al frente para que funcione correctamente
  for i=1,4 do
    sUp()
    fw()
  end
  sUp()
  right()
  fw()
  right()
  for i=1,4 do
    sUp()
    fw()
  end
  sUp()
  left()
  fw()
  left()
  for i=1,4 do
    sUp()
    fw()
  end
  sUp()
  right()
  fw()
  right()
  for i=1,4 do
    sUp()
    fw()
  end
  sUp()
  left()
  fw()
  left()
  for i=1,4 do
    sUp()
    fw()
  end
  sUp()
  --Termina en la esquina derecha superior mirando al frente
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
for i=1,3 do
  fw()
end
for i=1,5 do
  up()
end
left()
fw()
fw()
romper55()
up()
robot.turnAround()
romper55()
down()
for i=1,4 do
  fw()
end
left()
romper55()
up()
robot.turnAround()
romper55()
down()
right()
fw()
fw()
right()
for i=1,5 do
  fw()
end
for i=1,6 do
  down()
end
robot.turnAround()
robot.select(2) --Dejar la tierra en el 1er slot del cofre
robot.dropDown()
robot.select(1) --Dejar los bloques de lab en el 2o slot del cofre
robot.dropDown()
up()
for i=1,13 do
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