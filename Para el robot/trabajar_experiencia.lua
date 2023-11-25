local component = require("component")
local robot = require("robot")

while true do
robot.place()
robot.swing()
print(component.experience.level())
end