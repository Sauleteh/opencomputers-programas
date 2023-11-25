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

  if ((turno-1) == 9) then
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

local tablero = {} -- Creación del tablero
for i = 1, 3 do
  tablero[i] = {}
  for j = 1, 3 do
    tablero[i][j] = " " -- Por defecto tendrá un espacio en blanco
  end
end

local partidaTerminada = false
turno = 1

while (not(partidaTerminada)) do
  dibujarTablero(tablero) -- Mostrar tablero

  io.write("Turno ", turno, " (", marcar(false), "), introduce una posición [1-9]: ")
  tablero = procesarInput(io.read(), tablero) -- Realizar el turno

  partidaTerminada = comprobarEstado(tablero) -- Mirar si se terminó la partida
end

dibujarTablero(tablero)
marcar(true)
io.write("Partida terminada, ha ganado ", marcar(false))