local g3d = require("g3d")
local renderer = require("renderer")
local cm2 = require("OPTcm2Lua")
local fps = 0
local objects

function love.load()
    print("Circuit Maker 2 Explorer")
    local aSave = cm2.new(4,0)
    aSave:addBlock(1,0,0,0)
    aSave:addBlock(2,1,0,0)
    aSave:addBlock(3,2,0,0)
    aSave:addBlock(4,3,0,0)
    objects = renderer.load(aSave)
end
function love.update(dt)
    fps = 1/dt
    g3d.camera.firstPersonMovement(dt)
end
function love.draw()
    love.graphics.clear(0.25,0.25,0.25)
    renderer.draw(objects)
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