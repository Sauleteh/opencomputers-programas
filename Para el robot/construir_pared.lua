--[[
	$> pared x y
	
	<-------- x -------->
	 _ _ _ _ _ _ _ _ _ _
    |                   | ↑
    |                   | |		(Vista desde el lado derecho)
    |                   | y
    |                   | |	   
    |x>_ _ _ _ _ _ _ _ _| ↓
	
	El robot debe estar posicionado tal y como se indica en el dibujo superior:
	en la esquina inferior izquierda mirando al frente y teniendo a sus dos lados
	el fondo de la pared, es decir, COLOCÁNDOSE DENTRO de la pared a construir.
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

function colocar(lado)
	if (lado == "frente") then
		while (not(robot.place())) do
			huboProblemas(500)
		end
	else
		while (not(robot.placeDown())) do
			huboProblemas(500)
		end
	end
end

function moverse(lado)
	if (lado == "frente") then
		while (not(robot.forward())) do
			huboProblemas(1000)
		end
	elseif (lado == "arriba") then
		while (not(robot.up())) do
			huboProblemas(1000)
		end
	elseif (lado == "atras") then
		while (not(robot.back())) do
			huboProblemas(1000)
		end
	else
		while (not(robot.down())) do
			huboProblemas(1000)
		end
	end
end

function pared(x,y)

	local contador = 0
	local slot = 1
	robot.select(slot)
	
	moverse("arriba")
	
	for j = 1, y - 1 do
		
		for i = 1, x - 1 do
			while (robot.count(slot) == 0) do
				slot = slot + 1
				robot.select(slot)
			end
			colocar("abajo")
			moverse("frente")
		end
			
		if (j ~= y - 1) then
			if (contador % 2 == 0) then
				while (robot.count(slot) == 0) do
					slot = slot + 1
					robot.select(slot)
				end
				colocar("abajo")
				robot.turnRight()
				moverse("arriba")
				robot.turnRight()
			else
				while (robot.count(slot) == 0) do
					slot = slot + 1
					robot.select(slot)
				end
				colocar("abajo")
				robot.turnLeft()
				moverse("arriba")
				robot.turnLeft()
			end
				
			contador = contador + 1
		else
			while (robot.count(slot) == 0) do
				slot = slot + 1
				robot.select(slot)
			end
			colocar("abajo")
			for k = 1, x - 1 do
				moverse("atras")
				while (robot.count(slot) == 0) do
					slot = slot + 1
					robot.select(slot)
				end
				colocar("frente")
			end
			
			if (contador % 2 == 0) then
				robot.turnLeft()
			else
				robot.turnRight()
			end
			
			moverse("atras")
			while (robot.count(slot) == 0) do
				slot = slot + 1
				robot.select(slot)
			end
			colocar("frente")
			
			for l = 1, y - 1 do
				moverse("abajo")
			end
			print("Pared terminada")
		end
	end
end

local args = shell.parse(...)
pared(tonumber(args[1]), tonumber(args[2]))