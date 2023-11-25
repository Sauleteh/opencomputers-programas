-- USO: enviarMensaje "<mensaje>" (Puerto por defecto: 1111)
local shell = require("shell")

local args = shell.parse(...)
component.modem.broadcast(1111, args[1])