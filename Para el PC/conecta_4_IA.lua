local term = require("term")

function textoFinPartida(t, ganador)
  mostrarTablero(t)
  if (ganador == "r") then
    io.write("Partida terminada, ha ganado \27[31mrojo\27[0m.")
  elseif (ganador == "a") then
    io.write("Partida terminada, ha ganado \27[33mamarillo\27[0m.")
  else
    io.write("Partida terminada en empate.")
  end
end

function comprobarFinPartida(tab, jugador)
  -- horizontalCheck 
  for i = 1, 6 do
    for j = 1, 4 do
      if (tab[i][j] == jugador and tab[i][j+1] == jugador and tab[i][j+2] == jugador and tab[i][j+3] == jugador) then
        textoFinPartida(tab, jugador)
        return true
      end
    end
  end
  
  -- verticalCheck
  for j = 1, 7 do
    for i = 1, 3 do
      if (tab[i][j] == jugador and tab[i+1][j] == jugador and tab[i+2][j] == jugador and tab[i+3][j] == jugador) then
        textoFinPartida(tab, jugador)
        return true
      end
    end
  end
  
  -- ascendingDiagonalCheck 
  for i = 4, 6 do
    for j = 1, 4 do
      if (tab[i][j] == jugador and tab[i-1][j+1] == jugador and tab[i-2][j+2] == jugador and tab[i-3][j+3] == jugador) then
        textoFinPartida(tab, jugador)
        return true
      end
    end
  end
  
  -- descendingDiagonalCheck
  for i = 4, 6 do
    for j = 4, 7 do
      if (tab[i][j] == jugador and tab[i-1][j-1] == jugador and tab[i-2][j-2] == jugador and tab[i-3][j-3] == jugador) then
        textoFinPartida(tab, jugador)
        return true
      end
    end
  end
  
  if (turno == 42) then
    textoFinPartida(tab, "empate")
    return true
  end
  
  return false
end

function letraActual()
  if (turno % 2 == 0) then
    return "a"
  else
    return "r"
  end
end

function procesarInput(inp, tab)
  local fila = 6
  while (fila ~= 0 and tab[fila][tonumber(inp)] ~= " ") do
    fila = fila - 1
  end
  if (fila == 0) then
    return procesarInput(pedirInput(), tab)
  else
    tab[fila][tonumber(inp)] = letraActual()
    return tab
  end
end

function procesarInputIA(inpIA, tab)
  local fila = 6
  while (fila ~= 0 and tab[fila][inpIA[1]] ~= " ") do
    fila = fila - 1
  end
  tab[fila][inpIA[1]] = letraActual()
  return tab
end

function pedirInput()
  local res = "0"
  while (not(res == "1" or res == "2" or res == "3" or res == "4" or res == "5" or res == "6" or res == "7")) do
    io.write("Turno ", turno, " (", elementoTablero(letraActual()), "), elige una posición [1-7]: ")
    res = io.read()
  end
  return res
end

function elementoTablero(elem)
  if (elem == "r") then
    return "\27[31m●\27[0m"
  elseif (elem == "a") then
    return "\27[33m●\27[0m"
  else
    return " "
  end
end

function mostrarTablero(tab)
  io.write("\n")
  for i = 1, 13 do
    for j = 1, 15 do
      if (i % 2 ~= 0) then
        if (j ~= 15) then
          io.write("--")
        else
          io.write("-")
        end
      elseif (j % 2 == 0) then
        io.write(" ", elementoTablero(tab[i/2][j/2]), " ")
      else
        io.write("|")
      end
    end
    io.write("\n")
  end
  for i = 1, 7 do
    if (i == 1) then io.write("  ", i)
    else io.write("   ", i)
    end
  end
  io.write("\n\n")
end

-- A partir de aquí estan las funciones para la IA
intento = 0
function intentarDormir()
  if (intento == 6000) then
    os.sleep(0)
	intento = 0
  else
    intento = intento + 1
  end
end

function letraIA(opc)
  if (opc == 1) then
    return "a"
  else
    return "r"
  end
end

function minimax(tab, depth, alpha, beta, maximizingPlayer)
  local valid_locations = getValidLocations(tab)
  local is_terminal = isTerminalNode(tab)
  
  if (depth == 0 or is_terminal) then
    if (is_terminal) then
	  if (winningMove(tab, letraIA(tonumber(opcionEmpezar)))) then
	    return {nil, 100000000000000}
	  elseif (winningMove(tab, letraIA(tonumber(opcionEmpezar)-1))) then
	    return {nil, -10000000000000}
	  else
	    return {nil, 0}
	  end
    else
	  return {nil, scorePosition(tab, letraIA(tonumber(opcionEmpezar)))}
	end
  end
  
  if (maximizingPlayer) then
    value = -math.huge
	column = valid_locations[1]
	for col = 1, #valid_locations do
	  row = getNextOpenRow(tab, valid_locations[col])
	  b_copy = deepCopy(tab)
	  b_copy[row][valid_locations[col]] = letraIA(tonumber(opcionEmpezar))
	  intentarDormir()
	  new_score = minimax(b_copy, depth - 1, alpha, beta, false)[2]
	  if (new_score > value) then
	    value = new_score
		column = valid_locations[col]
	  end
	  alpha = math.max(alpha, value)
	  if (alpha >= beta) then break end
	end
	return {column, value}

  else
    value = math.huge
	column = valid_locations[1]
	for col = 1, #valid_locations do
	  row = getNextOpenRow(tab, valid_locations[col])
	  b_copy = deepCopy(tab)
	  b_copy[row][valid_locations[col]] = letraIA(tonumber(opcionEmpezar)-1)
	  intentarDormir()
	  new_score = minimax(b_copy, depth - 1, alpha, beta, true)[2]
	  if (new_score < value) then
	    value = new_score
		column = valid_locations[col]
	  end
	  beta = math.min(beta, value)
	  if (alpha >= beta) then break end
	end
	return {column, value}
  end
end

function deepCopy(tbl)
    local copy = {}
    for key, value in pairs(tbl) do
        if type(value) ~= 'table' then
            copy[key] = value
        else
            copy[key] = deepCopy(value)
        end
    end
    return copy
end

function getValidLocations(t)
  local cont = 1
  local valid_locs = {}
  for col = 1, 7 do
    if (isValidLocation(t, col)) then
	  valid_locs[cont] = col
	  cont = cont + 1
	end
  end
  return valid_locs
end

function isValidLocation(t1, c1)
  return t1[1][c1] == " "
end

function isTerminalNode(t)
  return winningMove(t, letraIA(tonumber(opcionEmpezar)-1)) or winningMove(t, letraIA(tonumber(opcionEmpezar))) or #getValidLocations(t) == " "
end

function winningMove(t, letra)
  -- horizontalCheck 
  for i = 1, 6 do
    for j = 1, 4 do
      if (t[i][j] == letra and t[i][j+1] == letra and t[i][j+2] == letra and t[i][j+3] == letra) then
        return true
      end
    end
  end
  
  -- verticalCheck
  for j = 1, 7 do
    for i = 1, 3 do
      if (t[i][j] == letra and t[i+1][j] == letra and t[i+2][j] == letra and t[i+3][j] == letra) then
        return true
      end
    end
  end
  
  -- ascendingDiagonalCheck 
  for i = 4, 6 do
    for j = 1, 4 do
      if (t[i][j] == letra and t[i-1][j+1] == letra and t[i-2][j+2] == letra and t[i-3][j+3] == letra) then
        return true
      end
    end
  end
  
  -- descendingDiagonalCheck
  for i = 4, 6 do
    for j = 4, 7 do
      if (t[i][j] == letra and t[i-1][j-1] == letra and t[i-2][j-2] == letra and t[i-3][j-3] == letra) then
        return true
      end
    end
  end
  
  return false
end

function scorePosition(t, letra)
  local score = 0
  
  -- Puntuación por medio
  local center_array = {}
  for i = 1, 6 do
    center_array[i] = t[i][4]
  end
  local center_count = contarCaracteresArray(center_array, letra)
  score = score + (center_count*3)
  
  -- Puntuación por horizontal
  for r = 1, 6 do
    row_array = t[r]
	for c = 1, 4 do
	  window = {}
	  for q = 1, 4 do
	    window[q] = row_array[c+q-1]
	  end
	  score = score + evaluateWindow(window, letra)
	end
  end
  
  -- Puntuación por vertical
  for c = 1, 7 do
    col_array = {}
	for i = 1, 6 do
	  col_array[i] = t[i][c]
	end
	for r = 1, 3 do
	  window = {}
	  for q = 1, 4 do
	    window[q] = col_array[r+q-1]
	  end
	  score = score + evaluateWindow(window, letra)
	end
  end
  
  -- Puntuación por diagonal escalonada inversa
  for r = 1, 3 do
    for c = 1, 4 do
	  window = {}
	  for i = 1, 4 do
	    window[i] = t[r+i-1][c+i-1]
	  end
	  score = score + evaluateWindow(window, letra)
	end
  end
  
  -- Puntuación por diagonal escalonada
  for r = 1, 3 do
    for c = 1, 4 do
	  window = {}
	  for i = 1, 4 do
	    window[i] = t[r+3-i+1][c+i-1]
	  end
	  score = score + evaluateWindow(window, letra)
	end
  end
  
  return score
end

function contarCaracteresArray(v, l)
  local num = 0
  for i = 1, #v do
    if (v[i] == l) then
	  num = num + 1
	end
  end
  return num
end

function evaluateWindow(w, le)
  local sc = 0
  letra_op = letraIA(tonumber(opcionEmpezar)-1)
  if (le == letraIA(tonumber(opcionEmpezar)-1)) then
    letra_op = letraIA(tonumber(opcionEmpezar))
  end
  
  if (contarCaracteresArray(w, le) == 4) then
    sc = sc + 1000
  elseif (contarCaracteresArray(w, le) == 3 and contarCaracteresArray(w, " ") == 1) then
    sc = sc + 5
  elseif (contarCaracteresArray(w, le) == 2 and contarCaracteresArray(w, " ") == 2) then
    sc = sc + 2
  end
  
  if (contarCaracteresArray(w, letra_op) == 4) then
    sc = sc - 1000
  elseif (contarCaracteresArray(w, letra_op) == 3 and contarCaracteresArray(w, " ") == 1) then
    sc = sc - 5
  elseif (contarCaracteresArray(w, letra_op) == 2 and contarCaracteresArray(w, " ") == 2) then
    sc = sc - 2
  end
  
  return sc
end

function getNextOpenRow(t, c)
  local fi = 6
  while (fi ~= 0 and t[fi][c] ~= " ") do
    fi = fi - 1
  end
  return fi
end

local tablero = {}
for i = 1, 6 do
  tablero[i] = {}
  for j = 1, 7 do
    tablero[i][j] = " "
  end
end
turno = 1
local finDeLaPartida = false

io.write("Bienvenido al conecta 4 por ElMineToFlama\n")
io.write("Controles: Usa números del 1 al 7 para elegir una columna del tablero\n")
local oponente = "0"
while (oponente ~= "1" and oponente ~= "2") do
  io.write("Decide tu oponente (Escribe el número) [1: vs J2 | 2: vs IA]: ")
  oponente = io.read()
end

opcionEmpezar = "0"
if (oponente == "2") then
  while (opcionEmpezar ~= "1" and opcionEmpezar ~= "2") do
    io.write("¿Quién empieza primero? [1: Tú | 2: La IA]: ")
    opcionEmpezar = io.read()
  end
end

while (not(finDeLaPartida)) do
  term.clear()
  mostrarTablero(tablero)
  if (opcionEmpezar == "0") then
    tablero = procesarInput(pedirInput(), tablero)
  elseif (opcionEmpezar == "1") then
    if (turno % 2 == 0) then
      tablero = procesarInputIA(minimax(tablero, 5, -math.huge, math.huge, true), tablero)
	else
	  tablero = procesarInput(pedirInput(), tablero)
	end
  elseif (opcionEmpezar == "2") then
    if (turno % 2 == 0) then
	  tablero = procesarInput(pedirInput(), tablero)
	else
	  tablero = procesarInputIA(minimax(tablero, 5, -math.huge, math.huge, true), tablero)
	end
  end
  finDeLaPartida = comprobarFinPartida(tablero, letraActual())
  turno = turno + 1
end