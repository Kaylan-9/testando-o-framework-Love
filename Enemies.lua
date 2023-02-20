require 'love'
local Demon = require 'Demon'

local function Enemies(platform)
  local width, height = love.graphics.getDimensions()
  local objs = {}
  for i=1, 100 do 
    local x= math.random((width/2)-((platform.nBlocksInX*platform.grass.one.size)/2), (width/2)+((platform.nBlocksInX*platform.grass.one.size)/2)-32)-32
    local y= math.random((height/2)-((platform.nBlocksInY*platform.grass.one.size)/2), (height/2)+((platform.nBlocksInY*platform.grass.one.size)/2))-32
    table.insert(objs, Demon(x, y))
  end 

  return {
    objs= objs
  }
end

return Enemies