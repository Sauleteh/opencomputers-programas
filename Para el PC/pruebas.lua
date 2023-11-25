function deep_copy( tbl )
    local copy = {}
    for key, value in pairs( tbl ) do
        if type( value ) ~= 'table' then
            copy[key] = value
        else
            copy[key] = deep_copy( value )
        end
    end
    return copy
end

function printFunction (par)
  for i = 1, #par do
    for j = 1, #par[1] do
      io.write(par[i][j], " ")
    end
    io.write("\n")
  end
end

local var1 = {{1,2,3,4,5},{6,7,8,9,10},{11,12,13,14,15},{16,17,18,19,20},{21,22,23,24,25}}
var1[1][1] = 99
local var2 = deep_copy(var1)
var2[3][2] = 1
var1[5][5] = 7

printFunction(var1)
io.write("\n")
printFunction(var2)