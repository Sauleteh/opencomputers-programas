local robot = require("robot")
local component = require("component")
local invcont = component.inventory_controller
local os = require("os")

local left = robot.turnLeft
local right = robot.turnRight
local fw = robot.forward
local up = robot.up
local down = robot.down

local sides = require("sides")
local front = sides.front

up()
up()
up() --2a cab.
left()
fw()
right() --1a cab.
robot.select(4)
invcont.suckFromSlot(front,1) --Sartén s.4
robot.select(8)
invcont.suckFromSlot(front,2) --Tabla s.8
robot.select(12)
invcont.suckFromSlot(front,11) --Mortero s.12
right()
fw()
left() --2a cab.
robot.select(13)
invcont.suckFromSlot(front,11) --Maíz s.13
robot.select(14)
invcont.suckFromSlot(front,2) --Sal 1a s.14
robot.select(15)
invcont.suckFromSlot(front,4) --Lima 1a s.15
right()
fw()
left() --3a cab.
robot.select(16)
invcont.suckFromSlot(front,12) --Agua s.16
robot.select(12)
robot.transferTo(1) --Mortero s.1
robot.select(13)
robot.transferTo(2) --Maíz s.2
component.crafting.craft(64) --Harina s.13
robot.select(1)
robot.transferTo(12) --Mortero s.12
robot.select(4)
robot.transferTo(1) --Sartén s.1
robot.select(13)
robot.transferTo(2) --Harina s.2
robot.select(16)
robot.transferTo(5) --Agua s.5
component.crafting.craft(64) --Tortilla s.16
robot.select(1)
robot.transferTo(4) --Sartén s.4
robot.select(8)
robot.transferTo(1) --Tabla s.1
robot.select(16)
robot.transferTo(2) --Tortilla s.2
robot.select(14)
robot.transferTo(5) --Sal 1a s.5
robot.select(15)
robot.transferTo(6) --Lima 1a s.6
component.crafting.craft(64) --Patatas tortilla s.15
robot.select(1)
robot.transferTo(8) --Tabla s.8

left()
fw()
fw()
right() --1a cab.
robot.select(4)
invcont.dropIntoSlot(front,1) --X sartén
invcont.suckFromSlot(front,3) --Bote s.4
robot.select(8)
invcont.dropIntoSlot(front,2) --X tabla
invcont.suckFromSlot(front,12) --Bol s.8
robot.select(12)
invcont.dropIntoSlot(front,11) --X mortero
right()
fw()
left() --2a cab.
robot.select(16)
invcont.suckFromSlot(front,14) --Lima 2a s.16
right()
fw()
left() --3a cab.
robot.select(8)
robot.transferTo(1) --Bol s.1
robot.select(2)
invcont.suckFromSlot(front,1) --Tomate s.2
robot.select(3)
invcont.suckFromSlot(front,3) --Cebolla s.3
robot.select(5)
invcont.suckFromSlot(front,11) --Especias s.5
robot.select(7)
invcont.suckFromSlot(front,2) --Ajo s.7
robot.select(16)
robot.transferTo(6) --Lima 2a s.6
component.crafting.craft(64) --Salsa s.16
robot.select(1)
robot.transferTo(8) --Bol s.8

left()
fw()
right() --2a cab.
robot.select(13)
invcont.suckFromSlot(front,3) --Leche soja s.13
robot.select(14)
invcont.suckFromSlot(front,12) --Sal 2a s.14
robot.select(4)
robot.transferTo(1) --Bote s.1
robot.select(13)
robot.transferTo(2) --Leche soja s.2
robot.select(14)
robot.transferTo(5) --Sal 2a s.5
component.crafting.craft(64) --Queso s.14
robot.select(1)
robot.transferTo(4) --Bote s.4

robot.select(12)
invcont.suckFromSlot(front,1) --Tofu sedoso s.12
robot.select(13)
invcont.suckFromSlot(front,13) --Chile s.13
right()
fw()
left() --3a cab.
robot.select(8)
robot.transferTo(1) --Bol s.1
robot.select(15)
robot.transferTo(2) --Patatas tortilla s.2
robot.select(16)
robot.transferTo(3) --Salsa s.3
robot.select(14)
robot.transferTo(5) --Queso s.5
robot.select(6)
invcont.suckFromSlot(front,13) --Comida cocinada s.6
robot.select(13)
robot.transferTo(7) --Chile s.7
robot.select(12)
robot.transferTo(9) --Tofu sedoso s.9
component.crafting.craft(64) --Nachos lujo s.12
robot.select(1)
robot.transferTo(8) --Bol s.8

left()
fw()
fw()
right() --1a cab.
robot.select(4)
invcont.dropIntoSlot(front,3) --X bote
robot.select(8)
invcont.dropIntoSlot(front,12) --X bol
right()
fw()
left()
down()
down()
down() --Pos inicial
robot.select(12)
robot.transferTo(1) --Nachos lujo s.1
robot.select(1)