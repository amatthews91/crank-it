import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

DISPLAY_W = 400
DISPLAY_H = 240

local gfx <const> = playdate.graphics
local timer <const> = playdate.timer

currentOperation = nil

function buttonDownHandler()
  if (currentOperation == '*Tap-It!*') then
    print('Tapped it!')
  else
    print('You werent meant to tap it')
  end
end

function crankHandler(change, _)
  if (math.abs(change) > 45) then
    if (currentOperation == '*Crank-It!*') then
      print('Cranked it!')
    else
      print('You werent meant to crank it')
    end
  end
end

inputHandlers  = {
  AButtonDown = buttonDownHandler,
  BButtonDown = buttonDownHandler,
  downButtonDown = buttonDownHandler,
  upButtonDown = buttonDownHandler,
  leftButtonDown = buttonDownHandler,
  rightButtonDown = buttonDownHandler,
  cranked = crankHandler
}
playdate.inputHandlers.push(inputHandlers)

function newOperation(title)
  return { title = title }
end

operations = {
  newOperation('*Crank-It!*'),
  -- newOperation('*Shake-It!*'),
  -- newOperation('*Blow-It!*'),
  newOperation('*Tap-It!*')
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
  currentOperation = operations[index].title
  timer.performAfterDelay(5000, doOperation)
end

function playdate.update()
  timer.updateTimers()
end

doOperation()
