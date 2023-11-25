local component = require("component")
local shell     = require("shell")
local gpu = component.gpu


local function setColor(c)
  if c and gpu.getForeground() ~= c then
    gpu.setForeground(c)
  end
end

local function cwrite(c, ...)
  local oldCol = gpu.getForeground()
  setColor(c)
  io.write(...)
  setColor(oldCol)
end

local args = shell.parse(...)
if #args < 1 then
  io.write("Usage: printAll FILE [count]\n")
  os.exit(0)
end
local count = 1
if #args > 1 then
  count = assert(tonumber(args[2]), tostring(args[2]) .. " is not a valid count")
end

local file, reason = io.open(args[1], "r")
if not file then
  io.stderr:write("Failed opening file: " .. reason .. "\n")
  os.exit(1)
end

local rawdata = file:read("*all")
file:close()
local data, reason = load("return " .. rawdata)
if not data then
  io.stderr:write("Failed loading model: " .. reason .. "\n")
  os.exit(2)
end
data = {data()}

cwrite( nil,"  Blocks found: ")
cwrite( 0x00ffff, #data, "\n")

local printers = {}
for addr in component.list("printer3d") do
  table.insert(printers, component.proxy(addr))
end

cwrite( nil,"Printers found: ")
cwrite( 0x00ffff, #printers, "\n")

local pIndex = 0
local printer


-- Loop all models in file
local blockNumber = 1
while blockNumber <= #data do

  -- Looking for idle printer
  pIndex = (pIndex+1)>#printers and 1 or pIndex+1
  printer = printers[pIndex]
  if printer.status() ~= "idle" then goto continue end


  local m = data[blockNumber]

  printer.reset()
  if m.label then
    printer.setLabel(m.label)
  end
  if m.tooltip then
    printer.setTooltip(m.tooltip)
  end
  if m.lightLevel and printer.setLightLevel then -- as of OC 1.5.7
    printer.setLightLevel(m.lightLevel)
  end
  if m.emitRedstone then
    printer.setRedstoneEmitter(m.emitRedstone)
  end
  if m.buttonMode then
    printer.setButtonMode(m.buttonMode)
  end
  for _, shape in ipairs(m.shapes or {}) do
    local result, reason = printer.addShape(shape[1], shape[2], shape[3], shape[4], shape[5], shape[6], shape.texture, shape.state, shape.tint)
    if not result then
      io.write("Failed adding shape: " .. tostring(reason) .. "\n")
    end
  end

  cwrite(nil,"#"); cwrite(0x00ffff,blockNumber); cwrite(nil,": ")
  cwrite(0xffffff, printer.getLabel() or "[no label]", " ")
  cwrite(0x555555, printer.getTooltip() or "[no tooltip]", " ")
  cwrite(0xffff00, printer.getShapeCount()); cwrite(nil,"+"); cwrite(0xffff00, select(2, printer.getShapeCount()))

  local result, reason = printer.commit(count)
  if result then
    cwrite(0x00ff00," >>Success\n");
    blockNumber=blockNumber+1
    os.sleep(0.5)
  else
    io.stderr:write("\nFailed committing job: " .. tostring(reason) .. "\n")
  end

  ::continue::
end
