local love = require 'love'

local function Platform()
  local objs = {
    one= {
      image= love.graphics.newImage('sprites/Grass1.jpg'),
      size= 32
    },
    two= {
      image= love.graphics.newImage('sprites/Grass2.jpg'),
      size= 32
    }
  }
  local bottom = function (size) 
    local width, height = love.graphics.getDimensions()
    return height-size
  end

  return {
    objs= objs,
    bottom= bottom,
    load_scenery = function(self)
      self.position = { 
        x= 32,
        y = bottom(32)
      }
      for i=1, 25 do
        love.graphics.draw(objs.two.image, self.position.x * (i - 1), self.position.y - objs.one.size)
        love.graphics.draw(objs.one.image, self.position.x * (i - 1), self.position.y)
      end
    end
  }
end

return Platform