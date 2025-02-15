-- CM2 Explorer: A tool to make large-scale builds quickly.
-- Renderer Engine: This component helps preview the blocks and connections on the screen and showing them with g3d.
-- @module: renderer

local g3d = require("g3d")
local renderer = {}

local function split(str,sep)
    if type(str) == "boolean" then
        return ""
    end
    if sep == nil then
        sep = "%s"
    end
    local t = {}
    for str in string.gmatch(str, "([^"..sep.."]+)") do
        table.insert(t, str)
    end
    return t
end
local function convert(string)
    if string == "" then
        return {
            good = false
        }
    end
    local data = split(string,",")
    if data[3] == nil or data[4] == nil or data[5] == nil or data[1] == nil then
        return {
            good = false
        }
    end
    return {
        id = tonumber(data[1]),
        x = tonumber(data[3]),
        y = tonumber(data[4]),
        z = tonumber(data[5]),
        good = true
    }
end

function renderer.load(save)
    local objects = {}
    print("Loading "..tostring(#save._blocks-1).." blocks...")
    for i=1,#save._blocks-1 do
        local v = save._blocks[i]
        local ez = convert(v) --tfw you run out of variable name ideas
        print(i,ez["id"],ez["x"],ez["y"],ez["z"])
        if ez.good then
            local mesh = g3d.newModel("assets/cube.obj", "assets/blocks/"..tostring(ez.id)..".png", {ez.x*0.5,ez.y*0.5,ez.z*0.5},nil,{0.25,0.25,0.25})
            table.insert(objects, mesh)
        end
    end
    return objects
end

function renderer.draw(objects)
    for i=1,#objects do
        local v = objects[i]
        v:draw()
    end
end

return renderer