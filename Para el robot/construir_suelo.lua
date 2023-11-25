--[[
	$> suelo x y
	
	<-------- x -------->
	 _ _ _ _ _ _ _ _ _ _
    |                   | ↑
    |                   | |		(Vista desde arriba)
    |                   | y
    |↑                  | |		   
    |x _ _ _ _ _ _ _ _ _| ↓
	
	El robot debe estar posicionado tal y como se indica en el dibujo superior:
	en la esquina inferior izquierda mirando al frente y UN BLOQUE POR ENCIMA
	del suelo a construir.
--]]

-- Requirimientos previos
local robot = require("robot")
local sides = require("sides")
local shell = require("shell")
local component = require("component")

function huboProblemas(hercios)
	os.sleep(3)
	component.computer.beep(hercios, 2)
	os.execute("enviarMensaje 'problemasRobot'")
end

function colocarAbajo()
	while (not(robot.placeDown())) do
		huboProblemas(500)
	end
end

function moverseFrente()
	while (not(robot.forward())) do
		huboProblemas(1000)
	end
end

function suelo(x,y)

	local contador = 0
	local slot = 1
	robot.select(slot)
		
	for j = 1, x do
		
		for i = 1, y - 1 do
			while (robot.count(slot) == 0) do
				slot = slot + 1
				robot.select(slot)
			end
			colocarAbajo()
			moverseFrente()
		end
			
		if (j ~= x) then
			if (contador % 2 == 0) then
				robot.turnRight()
				while (robot.count(slot) == 0) do
					slot = slot + 1
					robot.select(slot)
				end
				colocarAbajo()
				moverseFrente()
				robot.turnRight()
			else
				robot.turnLeft()
				while (robot.count(slot) == 0) do
					slot = slot + 1
					robot.select(slot)
				end
				colocarAbajo()
				moverseFrente()
				robot.turnLeft()
			end
				
			contador = contador + 1
		else
			robot.turnRight()
			robot.turnRight()
			while (robot.count(slot) == 0) do
				slot = slot + 1
				robot.select(slot)
			end
			colocarAbajo()
			print("Suelo terminado")
		end
	end
end

local args = shell.parse(...)
suelo(tonumber(args[1]), tonumber(args[2]))