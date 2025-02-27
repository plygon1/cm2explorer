local g3d = require("g3d")
local renderer = require("renderer")
local cm2 = require("OPTcm2Lua")
local fps = 0
_G.objects = {}

local imgui = require("imgui")

function love.load()
    print("Circuit Maker 2 Explorer")
    local aSave = cm2.new(4,0)
    aSave:addBlock(1,0,0,0)
    aSave:addBlock(2,1,0,0)
    aSave:addBlock(3,2,0,0)
    aSave:addBlock(4,3,0,0)
    objects = renderer.load(aSave)
    imgui.requestReload = function() objects = renderer.load(aSave) end
    imgui.objects = objects
    imgui.save = aSave
    imgui.load()
end
function love.update(dt)
    fps = 1/dt
    g3d.camera.firstPersonMovement(dt)
    imgui.update(dt)
end
function love.draw()
    love.graphics.clear(0.25,0.25,0.25)
    renderer.draw(objects)
    love.graphics.print("FPS: "..tostring(math.floor(fps)),0,0)
    imgui.draw()
end
function love.mousemoved(x,y,dx,dy)
    if love.mouse.isDown(2) then
        g3d.camera.firstPersonLook(dx,dy)
    end
    imgui.mousemoved(x,y,dx,dy)
end
function love.mousepressed(x,y,btn)
    if btn == 2 then
        love.mouse.setRelativeMode(true)
    end
    imgui.mousepressed(x,y,btn)
end
function love.mousereleased(x,y,btn)
    if btn == 2 then
        love.mouse.setRelativeMode(false)
        love.mouse.setX(math.floor(love.graphics.getWidth()/2))
        love.mouse.setY(math.floor(love.graphics.getHeight()/2))
    end
    imgui.mousereleased(x,y,btn)
end

love.wheelmoved  = imgui.wheelmoved
love.keypressed  = imgui.keypressed
love.keyreleased = imgui.keyreleased
love.textinput   = imgui.textinput
love.quit        = imgui.quit