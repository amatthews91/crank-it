import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

DISPLAY_W = 400
DISPLAY_H = 240

local gfx <const> = playdate.graphics
local timer <const> = playdate.timer

function newOperation(title)
  return { title = title }
end

operations = {
  newOperation('*Crank-It!*'),
  newOperation('*Shake-It!*'),
  newOperation('*Blow-It!*'),
  newOperation('*Tap-It*')
}
operationsLength = 0
for _ in pairs(operations) do operationsLength = operationsLength + 1 end

function drawTextCenter(str)
  local w, h = gfx.getTextSize(str)
  gfx.drawText(str, (DISPLAY_W/2) - (w/2), (DISPLAY_H/2) - (h/2))
end

function doOperation()
  gfx.clear()
  local index = math.random(1, operationsLength)
  drawTextCenter(operations[index].title)
  timer.performAfterDelay(2000, doOperation)
end

function playdate.update()
  timer.updateTimers()
end

doOperation()
