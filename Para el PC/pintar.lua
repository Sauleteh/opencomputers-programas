local colors = require "colors"
  local component = require "component"
    local gpu = component.gpu
      
      gpu.setForeground(1, true)
    gpu.setBackground(1, true)
  gpu.fill(1, 1, 10, 100, "x")
os.sleep(1)