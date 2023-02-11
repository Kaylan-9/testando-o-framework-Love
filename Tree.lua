local love = require 'love'

local function Tree()
  local width, height = love.graphics.getDimensions()
  return {
    x= 250,
    y= height-102,
    quad= love.graphics.newQuad(0, 0, 80, 90, 169, 154),
    sprite= {
      image= love.graphics.newImage('sprites/scenographicobjects.png'),
    }
  }
end

return Tree