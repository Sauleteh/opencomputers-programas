local component = require("component")
local event = require("event")
local m = component.modem

while (true) do  
  -- Wait for a message from another network card.
  local _, _, _, _, _, message = event.pull("modem_message")
  print(tostring(message))

  if (message == "problemasRobot") then
    component.computer.beep(1000,2)
    print("!PROBLEMA! El robot ha sufrido un problema y se ha pausado su función !PROBLEMA!")
  end
end