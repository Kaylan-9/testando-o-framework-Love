require 'love'
local Demon = require 'Demon'

local function Enemies(platform)
  local width, height = love.graphics.getDimensions()
  local objs = {}
  for i=1, 5 do 
    local x= math.random(width)
    local y= math.random(platform.top*2)+85
    table.insert(objs, Demon(x, y))
  end 

  return {
    objs= objs
  }
end

return Enemies