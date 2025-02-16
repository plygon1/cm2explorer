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
        if ez.good then
            local mesh = g3d.newModel("assets/cube.obj", nil, {ez.x*0.5,ez.z*0.5,ez.y*0.5},nil,{0.25,0.25,0.25})
            table.insert(objects, {mesh=mesh,id=ez["id"]})
        end
    end
    return objects
end

local idColor = {
    [0] = {130,0,0},
    [1] = {21.6,47.5,93.7},
    [2] = {26.3,100.0,26.7},
    [3] = {54.1,0,84.3},
    [4] = {92.5,44.7,0},
    [5] = {2.7,2.7,2.7},
    [6] = {130,130,130},
    [7] = {89.0,62.0,19.6},
    [8] = {20.8,67.8,89.4},
    [9] = {130,130,130}, -- Not implemented because it's the custom block
    [10] = {3.1,0,43.9},
    [11] = {100,25.5,78.4},
    [12] = {36.1,4.3,0},
    [13] = {0,22,33.3},
    [14] = {130,130,130},
    [15] = {60.4,69.4,81.6},
    [16] = {32.2,0,68.6},
    [17] = {87.1,89.8,75.3},
    [18] = {14.5,58.0,77.6},
    [19] = {130,130,130}
}

function renderer.draw(objects)
    local shader = love.graphics.newShader(g3d.shaderpath, "cm2.frag")
    for i=1,#objects do
        local v = objects[i]
        shader:send("mainColor", {idColor[v["id"]][1]/130,idColor[v["id"]][2]/130,idColor[v["id"]][3]/130,1})
        v["mesh"]:draw(shader)
    end
end

return renderer