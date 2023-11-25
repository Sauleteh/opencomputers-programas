--ic2_reactor_nuclear [maxTemperatura]. Si se establece una temperatura máxima el reactor se parará solo al llegar a dicha temperatura
--Necesario un adapter con "inventory controller upgrade" al lado de un reactor chamber y conectado por cable al PC
--El redstone I/O debe ir debajo de un reactor chamber y conectado por cable al PC
--El PC debe tener una network card
--Es posible que se necesite editar el programa para elegir bien el lado por el que entra la energía de la palanca en el redstone I/O
--Recomendado usar una screen 3x2
--Para cerrar el programa pulsar y mantener el SHIFT izquierdo
--Cambiar las direcciones de las screens para que se adecuen a las que se tiene

local version="8.0"

local component = require("component")
local computer = require("computer")
local event = require("event")
local term = require("term")
local sides = require("sides")

local gpu = component.gpu
local beep = component.computer.beep
local reactor=component.reactor_chamber

local screen1 = "9719f1e1-e77c-4914-9e06-08a0b27b70a7" --Cambiar por dirección 1er monitor principal
local screen2 = "..." --Cambiar por dirección 2o monitor reactor
local keyboard = require("keyboard")
local contador = 2

local rodSlot = component.inventory_controller.getStackInSlot

local redstone = component.redstone
local shell = require("shell")
local args = shell.parse(...)

if args[1] == nil then
  args[1] = 0
end

local function tempMax()
  if tonumber(args[1]) > 0 then
    return args[1]
  else
    return "n/a "
  end
end

--reactor
Heat=reactor.getMaxHeat
getHeat=reactor.getHeat 
EUOutput=reactor.getReactorEUOutput 
--reactor

--tables
local items={}
local currentRods={}
local rodTypes={"gt.reactorUraniumQuad.name", "gt.reactorMOXQuad.name", "gt.Quad_Thoriumcell.name"}
local rodEmpty={"Quad Fuel Rod (Depleted Uranium)", "Quad Fuel Rod (Depleted MOX)", "gt.Quad_ThoriumcellDep.name"}
--tables

--rods
local rod1 = rodSlot(1, 21)
local rod2 = rodSlot(1, 25)
local rod3 = rodSlot(1, 30)
local rod4 = rodSlot(1, 34)
--rods

--rod functions
local function draw1()
  if currentRods[1] == rodTypes[1] then
    return "U"
  elseif currentRods[1] == rodEmpty[1] then
    return "0"
  elseif currentRods[1] == rodTypes[2] then
    return "M"
  elseif currentRods[1] == rodEmpty[2] then
    return "0"
  elseif currentRods[1] == rodTypes[3] then
    return "T"
  elseif currentRods[1] == rodEmpty[3] then
    return "0"
  elseif currentRods[1] == "empty" then
    return "E"
  end
  end
  
local function draw2()
  if currentRods[2] == rodTypes[1] then
    return "U"
  elseif currentRods[2] == rodEmpty[1] then
    return "0"
  elseif currentRods[2] == rodTypes[2] then
    return "M"
  elseif currentRods[2] == rodEmpty[2] then
    return "0"
  elseif currentRods[2] == rodTypes[3] then
    return "T"
  elseif currentRods[2] == rodEmpty[3] then
    return "0"
  elseif currentRods[2] == "empty" then
    return "E"
  end
  end
  
local function draw3()
  if currentRods[3] == rodTypes[1] then
    return "U"
  elseif currentRods[3] == rodEmpty[1] then
    return "0"
  elseif currentRods[3] == rodTypes[2] then
    return "M"
  elseif currentRods[3] == rodEmpty[2] then
    return "0"
  elseif currentRods[3] == rodTypes[3] then
    return "T"
  elseif currentRods[3] == rodEmpty[3] then
    return "0"
  elseif currentRods[3] == "empty" then
    return "E"
  end
  end
  
local function draw4()
  if currentRods[4] == rodTypes[1] then
    return "U"
  elseif currentRods[4] == rodEmpty[1] then
    return "0"
  elseif currentRods[4] == rodTypes[2] then
    return "M"
  elseif currentRods[4] == rodEmpty[2] then
    return "0"
  elseif currentRods[4] == rodTypes[3] then
    return "T"
  elseif currentRods[4] == rodEmpty[3] then
    return "0"
  elseif currentRods[4] == "empty" then
    return "E"
  end
  end
--rod functions
  
--colors
local black = 0x000000
local red = 0xFF0000
local yellow = 0xFFFF00
local white = 0xffffff
--colors

local start_time = computer.uptime()

local modem = component.modem

local w,h = gpu.getResolution()

--maxResolution() 160x50 if 3x2blocks w,h

-- place for config
-------------------
-- end of config


--start_time

--timer
local tickCnt = 0
local running = true
local hours = 0
local mins = 0
--timer

local function centerF(row, msg, ...)
  local mLen = string.len(msg)
  w, h = gpu.getResolution()
  term.setCursor((w - mLen)/2,row)
  print(msg:format(...))
end

--more functions
local function status()
  if EUOutput() == 0 then 
  return "offline" 
  else
  return "online "
  end
end 

local function maxheat()
  return reactor.getMaxHeat()
  end
  
local function getheat()
  if getHeat() == 0 then
  return "0   "
  else
  return reactor.getHeat()
  end
end
  
local function getEU()
  if EUOutput() == 0 then
  return "0   "
  else
  return reactor.getReactorEUOutput()
  end
end
--more functions  

gpu.setForeground(0xffffff)

-----
term.clear()
term.setCursor(1,1)

centerF(5,  "-----------------------------------------")
centerF(6,  "-  IC2 Reactor Controller (Modificado)  -")
centerF(7,  "-----------------------------------------")
centerF(8, string.format("- Reactor is:             %s       -",status())) 
centerF(9, string.format("- Reactor maxheat:        %s         -",maxheat())) 
centerF(10, string.format("- Reactor heat:           %s          -",  getheat())) 
centerF(11, string.format("- Reactor EU Output:      %s          -",  getEU())) 
centerF(12, "-----------------------------------------")
centerF(13, string.format("- Temp. máxima:           %s          -", tempMax()))  
centerF(14, "-----------------------------------------")

gpu.bind(tostring(screen2),true)
gpu.setForeground(0xffffff)

-----
term.clear()
term.setCursor(1,1)

centerF(5,  "-----------------------------------------")
centerF(6,  "-  IC2 Reactor Controller (Modificado)  -")
centerF(7,  "-----------------------------------------")
centerF(8, string.format("- Reactor is:             %s       -",status())) 
centerF(9, string.format("- Reactor maxheat:        %s       -",maxheat())) 
centerF(10, string.format("- Reactor heat:           %s          -",  getheat())) 
centerF(11, string.format("- Reactor EU Output:      %s          -",  getEU())) 
centerF(12, "-----------------------------------------")
centerF(13, string.format("- Temp. máxima:           %s          -", tempMax()))  
centerF(14, "-----------------------------------------")

while not keyboard.isKeyDown(keyboard.keys.lshift) do

  centerF(15, "-----------------------------")
  centerF(16, "-     Reactor Fuel Rods     -")
  centerF(17, "-----------------------------") 
  centerF(18, "                             ") 
  centerF(19, "          ---------          ")
  centerF(20, "                             ")
  centerF(21, "                             ")
  centerF(22, "          ---------          ")
  centerF(23, "                             ")   
  centerF(24, "-----------------------------")
  
  if contador == 1 then
    tickCnt = tickCnt + 1
  end
  if tickCnt == 60 then
    mins = mins + 1
    tickCnt = 0
  end
  
  if mins == 60 then
    hours = hours + 1
    mins = 0
  end
  
  rod1 = rodSlot(1, 21)
  if rod1 ~= nil then
    currentRods[1]=rod1.label
   else
    currentRods[1]="empty"
  end
  
  rod2 = rodSlot(1, 25)
  if rod2 ~= nil then
    currentRods[2]=rod2.label
   else
    currentRods[2]="empty"
  end
  
    rod3 = rodSlot(1, 30)
  if rod3 ~= nil then
    currentRods[3]=rod3.label
    else
    currentRods[3]="empty"
  end
  
    rod4 = rodSlot(1, 34)
  if rod4 ~= nil then
    currentRods[4]=rod4.label
    else
    currentRods[4]="empty"
  end
  
  centerF(20, string.format("--%s---%s--",draw1(),draw2()))
  centerF(21, string.format("--%s---%s--",draw3(),draw4()))
  
  centerF(8, string.format("- Reactor is:             %s       -",status())) 
  centerF(9, string.format("- Reactor maxheat:        %s       -",maxheat())) 
  centerF(10, string.format("- Reactor heat:           %s          -",  getheat())) 
  centerF(11, string.format("- Reactor EU Output:      %s          -",  getEU())) 
  centerF(30, "Data updates every second: %2d", tickCnt)
  centerF(31, "Current up time: %2d hours %2d min", hours, mins)
  
  centerF(27, "                                                                                                                                                          ")
  centerF(28, "                                                                                                                                                          ")
  centerF(38, "                                                                                                                                                          ")

  if reactor.getHeat() < (0.4*maxheat()) then
    centerF(27, "        \27[32mReactor nuclear en buen estado\27[0m")
  elseif reactor.getHeat() >= (0.4*maxheat()) and reactor.getHeat() < (0.5*maxheat()) then
    centerF(27, "        \27[33mTemperaturas superiores al 40 por ciento, bloques inflamables en un rango de 5 bloques corren riesgo de quemarse\27[0m")
    beep()
  elseif reactor.getHeat() >= (0.5*maxheat()) and reactor.getHeat() < (0.7*maxheat()) then
    centerF(27, "        \27[33mTemperaturas superiores al 50 por ciento, el agua en un rango de 5 bloques es posible que se evapore en su totalidad\27[0m")
    beep(".")
  elseif reactor.getHeat() >= (0.7*maxheat()) and reactor.getHeat() < (0.85*maxheat()) then
    centerF(27, "        \27[31mPELIGRO: Reactor a más de 70 por ciento de temperatura, peligro de muerte en un rango de 7 bloques por exposición a radiación\27[0m")
    beep("..")
  elseif reactor.getHeat() >= (0.85*maxheat()) then
    centerF(27, "      \27[35mEXTREMA PRECAUCIÓN: Reactor nuclear con temperaturas superiores al 85 por ciento, peligro de lava en un rango de 5 bloques")
    centerF(28, "     Por favor, llame a un especialista lo antes posible, temperaturas acercándose al 100 por ciento con riesgo de explosión nuclear\27[0m")
    beep("----")
  end

  if tonumber(args[1]) == 0 then
    if redstone.getInput(sides.left) > 0 then --Cambiar el lado de la palanca
      redstone.setOutput(sides.up,1)
    else
      redstone.setOutput(sides.up,0)
    end
  else
    if reactor.getHeat() >= tonumber(args[1]) then
      redstone.setOutput(sides.up,0)
      centerF(38, "        \27[31mAPAGADO FORZADO ACTIVADO\27[0m")
    else
      if redstone.getInput(sides.left) > 0 then --Cambiar el lado de la palanca
        redstone.setOutput(sides.up,1)
      else
        redstone.setOutput(sides.up,0)
      end
    end
  end
  
  centerF(33, "No apague el PC ni cierre el programa mientras el reactor está en uso")
  centerF(34, "Por razones de seguridad, solo se puede encender el reactor mediante este programa")
  centerF(35, "Para apagar el reactor, desactive la palanca MIENTRAS este programa está activo, apagar este programa primero podría traer consecuencias muy graves")
  centerF(36, "Por seguridad, asegúrese de conservar energía suficiente para tener el PC encendido durante todo el tiempo que tenga el reactor nuclear encendido")
  
  centerF(39, "                                                                                                             ")
  if redstone.getInput(sides.left) > 0 then --Cambiar el lado de la palanca
    centerF(39, "La palanca del reactor nuclear está activada, no apagar PC")
  else
    centerF(39, "La palanca del reactor nuclear está desactivada, puede mantener SHIFT para cerrar el programa")
  end

  --beep()
  if contador == 2 then
    gpu.bind(tostring(screen1), true)
    contador = 1
  elseif contador == 1 then
    gpu.bind(tostring(screen2), true)
    contador = 2
  end
  os.sleep(0)

end

gpu.bind(tostring(screen2),true)
term.clear()
gpu.bind(tostring(screen1),true)
term.clear()