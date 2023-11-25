--chunk_loader [arg]
--Si arg es 0 el chunkloader se desactiva
--Si arg es 1 el chunkloader se activa
--Si no se pone ningún arg se muestra el estado actual del chunkloader

local component = require("component")
local chunkloader = component.chunkloader
local shell = require("shell")
local args = shell.parse(...)

if args[1] == nil then
  if chunkloader.isActive() == true then
    print("Estado del chunkloader: Activado (ON)")
  else
    print("Estado del chunkloader: Desactivado (OFF)")
  end
elseif tonumber(args[1]) == 0 then  
  if chunkloader.isActive() == false then
    print("El chunkloader ya se encuentra deshabilitado")
  else
    chunkloader.setActive(false)
    print("El chunkloader ha sido deshabilitado correctamente")
  end
elseif tonumber(args[1]) == 1 then
  if chunkloader.isActive() == true then
    print("El chunkloader ya se encuentra habilitado")
  else
    chunkloader.setActive(true)
    print("El chunkloader ha sido habilitado correctamente")
  end
end