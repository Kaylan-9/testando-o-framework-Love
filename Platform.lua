local love = require 'love'

local function Platform()
  local objs = {
    one= {
      image= love.graphics.newImage('sprites/Grass1.jpg'),
      size= 32 * 1.5
    },
    two= {
      image= love.graphics.newImage('sprites/Grass2.jpg'),
      size= 32 * 1.5
    },
  }
  local nBlocksInY = 10
  local width, height = love.graphics.getDimensions()
  local bottom = height
  local right = width
  local top= bottom - ((nBlocksInY - 1) * objs.one.size)

  return {
    objs= objs,
    bottom= bottom,
    top= top,
    left= 0,
    right= right,
    load_scenery = function(self)
      self.position = { 
        x= 32,
        y = bottom-32
      }
      for i=1, 25 do
        for j=1, nBlocksInY do
          love.graphics.draw(objs.one.image, self.position.x * (i - 1), self.position.y - (objs.one.size * (j - 1)), 0, 1.5, 1.5)
        end
      end
    end
  }
end

return Platform