function escribir()
  asd = 2
  
end

asd = 1

io.write(asd)
escribir()
io.write(asd)

function recursivo(n)
  if (n == 1) then
    return 1
  else
    io.write(n, "|")
    return recursivo(n-1) + n
  end
end

io.write(recursivo(6000))