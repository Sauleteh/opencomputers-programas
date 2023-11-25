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

local tablero = {}
for i = 1, 6 do
  tablero[i] = {}
  for j = 1, 7 do
    tablero[i][j] = " "
  end
end
turno = 1
local finDeLaPartida = false

while (not(finDeLaPartida)) do
  term.clear()
  mostrarTablero(tablero)
  tablero = procesarInput(pedirInput(), tablero)
  finDeLaPartida = comprobarFinPartida(tablero, letraActual())
  turno = turno + 1  
end