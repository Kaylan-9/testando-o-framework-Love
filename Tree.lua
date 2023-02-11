local love = require 'love'

local function Tree(x, y)
  local width, height = love.graphics.getDimensions()
  local w, h = 80, 85
  return {
    x= x,
    y= height-y,
    w= w, 
    h= h,
    quad= love.graphics.newQuad(0, 0, w, h, 169, 154),
    sprite= {
      image= love.graphics.newImage('sprites/scenographicobjects.png'),
    }
  }
end

return Tree