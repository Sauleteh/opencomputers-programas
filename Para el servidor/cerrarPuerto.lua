-- USO: cerrarPuerto <puerto>
local shell = require("shell")

local args = shell.parse(...)
component.modem.close(tonumber(args[1]))