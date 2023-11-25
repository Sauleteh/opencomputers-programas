-- USO: abrirPuerto <puerto>
local shell = require("shell")

local args = shell.parse(...)
component.modem.open(tonumber(args[1]))