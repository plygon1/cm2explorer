local g3d = require("g3d")
local fps = 0

function love.load()
    print("Circuit Maker 2 Explorer")
end
function love.update(dt)
    fps = 1/dt
    g3d.camera.firstPersonMovement(dt)
end
function love.draw()
    love.graphics.clear(0.25,0.25,0.25)
    cube:draw()
    love.graphics.print("FPS: "..tostring(math.floor(fps)),0,0)
end
function love.mousemoved(x,y,dx,dy)
    if love.mouse.isDown(2) then
        g3d.camera.firstPersonLook(dx,dy)
    end
end
function love.mousepressed(x,y,btn)
    if btn == 2 then
        love.mouse.setRelativeMode(true)
    end
end
function love.mousereleased(x,y,btn)
    if btn == 2 then
        love.mouse.setRelativeMode(false)
        love.mouse.setX(math.floor(love.graphics.getWidth()/2))
        love.mouse.setY(math.floor(love.graphics.getHeight()/2))
    end
end