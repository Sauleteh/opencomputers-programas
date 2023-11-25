-- USO: estaAbiertoPuerto <puerto>
local shell = require("shell")

local args = shell.parse(...)
print(component.modem.isOpen(tonumber(args[1])))