--[[
	$> squarry x y z
	
	<-------- x -------->			↑ (Al frente, no hacia arriba como tal)
	 _ _ _ _ _ _ _ _ _ _			x _ _ _ _ _ _ _ _ _
    |                   | ↑		   |_ _ _ _ _ _ _ _ _ _| ↑
    |                   | |		   |_ _ _ _ _ _ _ _ _ _| z (altura)
    |                   | y		   |_ _ _ _ _ _ _ _ _ _| ↓
    |↑                  | |		   
    |x _ _ _ _ _ _ _ _ _| ↓
	
	El robot debe estar posicionado tal y como se indica en el dibujo superior:
	en la esquina inferior izquierda mirando al frente Y UN BLOQUE POR ENCIMA DEL
	LUGAR DE MINADO. Ejemplo: Se quiere minar un área de z = 3 (3 de profundidad),
	en tal caso el robot se colocará encima de la capa más superior, la primera
	para ser exactos.
	
			  _ _ _ _ _ _ _ _ _ _
		     /					 |
		    /				    /| # Ejemplo de un "squarry 10 5 3", el robot (X)
		   /				   //| # está mirando a la esquina superior izquierda
		  /⭎				  ///| # mientras él se coloca en la inferior izquierda
		 /X _ _ _ _ _ _ _ _  ////  # a la altura de z + 1, es decir, encima del suelo
		|_ _ _ _ _ _ _ _ _ _|///   # que se va a minar.
		|_ _ _ _ _ _ _ _ _ _|//
		|_ _ _ _ _ _ _ _ _ _|/
--]]

-- Requerimientos previos
local robot = require("robot")
local sides = require("sides")
local shell = require("shell")
local component = require("component")

function huboProblemas(hercios)
	os.sleep(3)
	component.computer.beep(hercios, 2)
	os.execute("enviarMensaje 'problemasRobot'")
end

function romper(lado)
	if (lado == "frente") then
		while (not(robot.swing()) and not(select(2, robot.detect()) == "air")) do
			huboProblemas(500)
		end
	else
		while (not(robot.swingDown()) and not(select(2, robot.detectDown()) == "air")) do
			huboProblemas(500)
		end
	end
end

function moverse(lado)
	if (lado == "frente") then
		while (not(robot.forward())) do
			huboProblemas(1000)
		end
	else
		while (not(robot.down())) do
			huboProblemas(1000)
		end
	end
end

function quarry(x,y,z)

	local contador = 0
	
	for k = 1, z do
		romper("abajo")
		moverse("abajo")
		
		for j = 1, x do
		
			for i = 1, y - 1 do
				romper("frente")
				moverse("frente")
			end
			
			if (j ~= x) then
				if (contador % 2 == 0) then
					robot.turnRight()
					romper("frente")
					moverse("frente")
					robot.turnRight()
				else
					robot.turnLeft()
					romper("frente")
					moverse("frente")
					robot.turnLeft()
				end
				
				contador = contador + 1
			else
				robot.turnAround()
				print("Capa terminada")
			end
		end
	end
end

local args = shell.parse(...)
quarry(tonumber(args[1]), tonumber(args[2]), tonumber(args[3]))