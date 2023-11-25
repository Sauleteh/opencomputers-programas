function dibujarTablero(tab)
  io.write(tab[1][1], " | ", tab[1][2], " | ", tab[1][3], "\n")
  io.write("---------\n")
  io.write(tab[2][1], " | ", tab[2][2], " | ", tab[2][3], "\n")
  io.write("---------\n")
  io.write(tab[3][1], " | ", tab[3][2], " | ", tab[3][3], "\n")
end

function comprobarEstado(tab)
  -- Comprobar líneas horizontales y verticales
  for i = 1, 3 do
    if (tab[1][i] ~= " " and tab[1][i] == tab[2][i] and tab[1][i] == tab[3][i] or tab[i][1] ~= " " and tab[i][1] == tab[i][2] and tab[i][1] == tab[i][3]) then
      return true
    end
  end

  -- Comprobas las diagonales
  if (tab[2][2] ~= " " and (tab[1][1] == tab[2][2] and tab[1][1] == tab[3][3] or tab[3][1] == tab[2][2] and tab[3][1] == tab[1][3])) then
    return true
  end

  return false
end

function marcar(cambio)
  turno = turno + 1
  if (turno % 2 == 0) then -- Si el siguiente turno es par, le toca a "x"
    if (not(cambio)) then turno = turno - 1 end
    return "x"
  else
    if (not(cambio)) then turno = turno - 1 end
    return "o" -- Si el turno es impar, es "o"
  end
end

function procesarInput(inp, tab)
  if (inp == "1" and tab[3][1] == " ") then
    tab[3][1] = marcar(true)
  elseif (inp == "2" and tab[3][2] == " ") then
    tab[3][2] = marcar(true)
  elseif (inp == "3" and tab[3][3] == " ") then
    tab[3][3] = marcar(true)
  elseif (inp == "4" and tab[2][1] == " ") then
    tab[2][1] = marcar(true)
  elseif (inp == "5" and tab[2][2] == " ") then
    tab[2][2] = marcar(true)
  elseif (inp == "6" and tab[2][3] == " ") then
    tab[2][3] = marcar(true)
  elseif (inp == "7" and tab[1][1] == " ") then
    tab[1][1] = marcar(true)
  elseif (inp == "8" and tab[1][2] == " ") then
    tab[1][2] = marcar(true)
  elseif (inp == "9" and tab[1][3] == " ") then
    tab[1][3] = marcar(true)
  else
    io.write("Error en la posición introducida, vuelve a intentarlo\n")
  end

  return tab
end

function procesarInputIA(inpIA, tab)
	tab[inpIA[1]][inpIA[2]] = marcar(true)
	return tab
end

-- This function returns true if there are moves
-- remaining on the board. It returns false if
-- there are no moves left to play.
function isMovesLeft(tabL)
    for i = 1, 3 do
        for j = 1, 3 do
            if (tabL[i][j] == " ") then
                return true
			end
		end
	end
	
    return false
end
 
-- This is the evaluation function
function evaluate(tabI)
    -- Checking for Rows for X or O victory
	for row = 1, 3 do
        if (tabI[row][1] == tabI[row][2] and tabI[row][2] == tabI[row][3]) then
            if (tabI[row][1] == letraIA("jugador")) then
                return 10
            elseif (tabI[row][1] == letraIA("oponente")) then
                return -10
			end
        end
    end
 
    -- Checking for Columns for X or O victory.
    for col = 1, 3 do
        if (tabI[1][col] == tabI[2][col] and tabI[2][col] == tabI[3][col]) then
            if (tabI[1][col] == letraIA("jugador")) then
                return 10
            elseif (tabI[1][col] == letraIA("oponente")) then
                return -10
			end
        end
    end
 
    -- Checking for Diagonals for X or O victory.
    if (tabI[1][1] == tabI[2][2] and tabI[2][2] == tabI[3][3]) then
        if (tabI[1][1] == letraIA("jugador")) then
            return 10
        elseif (tabI[1][1] == letraIA("oponente")) then
            return -10
		end
    end
 
    if (tabI[1][3] == tabI[2][2] and tabI[2][2] == tabI[3][1]) then
        if (tabI[1][3] == letraIA("jugador")) then
            return 10
        elseif (tabI[1][3] == letraIA("oponente")) then
            return -10
		end
    end
 
    -- Else if none of them have won then return 0
    return 0
end

-- This is the minimax function. It considers all
-- the possible ways the game can go and returns
-- the value of the board
function minimax(tabP, depth, isMax)
    local score = evaluate(tabP)
	--io.write(score,"|")
	--io.write(tabP[3][1], tabP[2][2])
    -- If Maximizer has won the game return his/her
    -- evaluated score
    if (score == 10) then
        return score
	end
	
    -- If Minimizer has won the game return his/her
    -- evaluated score
    if (score == -10) then
        return score
	end
	
    -- If there are no more moves and no winner then
    -- it is a tie
    if (not(isMovesLeft(tabP))) then
        return 0
	end
	
    -- If this maximizer's move
    if (isMax) then
        local best = -1000
 
        -- Traverse all cells
		for i = 1, 3 do
            for j = 1, 3 do
                -- Check if cell is empty
                if (tabP[i][j] == " ") then
                    -- Make the move
                    tabP[i][j] = letraIA("jugador")
 
                    -- Call minimax recursively and choose
                    -- the maximum value
                    best = math.max(best, minimax(tabP, depth+1, not(isMax)))
 
                    -- Undo the move
                    tabP[i][j] = " "
                end
            end
        end
		
        return best
 
    -- If this minimizer's move
    else
        local best = 1000
 
        -- Traverse all cells
        for i = 1, 3 do
            for j = 1, 3 do
                -- Check if cell is empty
                if (tabP[i][j] == " ") then
                    -- Make the move
                    tabP[i][j] = letraIA("oponente")
 
                    -- Call minimax recursively and choose
                    -- the minimum value
                    best = math.min(best, minimax(tabP, depth+1, not(isMax)))
 
                    -- Undo the move
                    tabP[i][j] = " "
                end
            end
        end
		
        return best
    end
end

-- Buscar el mejor movimiento para la IA
function findBestMove(tab)
    local bestVal = -1000
    local bestMove = {}
    bestMove[1] = -1 -- Mejor fila
    bestMove[2] = -1 -- Mejor columna
 
    -- Traverse all cells, evaluate minimax function for
    -- all empty cells. And return the cell with optimal
    -- value.
	for i = 1, 3 do
        for j = 1, 3 do
            -- Check if cell is empty
            if (tab[i][j] == " ") then
                -- Make the move
                tab[i][j] = letraIA("jugador")
 
                -- compute evaluation function for this
                -- move.
                local moveVal = minimax(tab, 0, false)
				--io.write(bestMove[1], "|", bestMove[2], "|", moveVal)
                -- Undo the move
                tab[i][j] = " "
 
                -- If the value of the current move is
                -- more than the best value, then update
                -- best
                if (moveVal > bestVal) then
                    bestMove[1] = i
                    bestMove[2] = j
                    bestVal = moveVal
                end
            end
        end
    end
	
    return bestMove
end

function letraIA(soy)
  if (saltarTurno == "2") then
    if (soy == "jugador") then
	  return "x"
	else
	  return "o"
	end
  else
    if (soy == "jugador") then
	  return "o"
	else
	  return "x"
	end
  end
end

local tablero = {} -- Creación del tablero
for i = 1, 3 do
  tablero[i] = {}
  for j = 1, 3 do
    tablero[i][j] = " " -- Por defecto tendrá un espacio en blanco
  end
end

local partidaTerminada = false
turno = 1

io.write("Bienvenido al tres en raya por ElMineToFlama\n")
io.write("Controles: Usa números del 1 al 9 para elegir una posición en el tablero (usa el numpad para un mejor entendimiento)\n")
local oponente = "0"
while (oponente ~= "1" and oponente ~= "2") do
  io.write("Decide tu oponente (Escribe el número) [1: vs J2 | 2: vs IA]: ")
  oponente = io.read()
end

saltarTurno = "0"
if (oponente == "2") then
  while (saltarTurno ~= "1" and saltarTurno ~= "2") do
    io.write("¿Quién empieza primero? [1: Tú | 2: La IA]: ")
    saltarTurno = io.read()
  end
end

function quienEmpieza()
  if (saltarTurno == "2") then
    if ((turno+1) % 2 == 0) then
      return true
    else
      return false
    end
  else
    if (turno % 2 == 0) then
		return true
	else
		return false
	end
  end
end
 
while (not(partidaTerminada)) do
  dibujarTablero(tablero) -- Mostrar tablero

  io.write("Turno ", turno, " (", marcar(false), "), introduce una posición [1-9]: ")
  
  if (quienEmpieza() and oponente == "2") then -- "o" es la IA
    mejorMove = findBestMove(tablero)
    io.write("Fila ", mejorMove[1], " | Columna ", mejorMove[2], "\n")
    tablero = procesarInputIA(mejorMove, tablero)
  else
    tablero = procesarInput(io.read(), tablero) -- Realizar el turno por el jugador
  end
  partidaTerminada = comprobarEstado(tablero) or ((turno-1) == 9) -- Mirar si se terminó la partida
end

dibujarTablero(tablero)
if (comprobarEstado(tablero)) then
  marcar(true)
  io.write("Partida terminada, ha ganado ", marcar(false))
else
  io.write("Partida terminada en empate")
end