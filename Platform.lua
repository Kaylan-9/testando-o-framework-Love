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
    tree= {
      sprite= {
        image= love.graphics.newImage('sprites/scenographicobjects.png'),
        quad= nil,
        w=80,
        h=90
      }
    }
  }
  objs.tree.sprite.quad= love.graphics.newQuad(0, 0, objs.tree.sprite.w, objs.tree.sprite.h, 169, 154)
  local nBlocksInY = 10
  local bottom = function (size) 
    local width, height = love.graphics.getDimensions()
    return height-size
  end
  local top= bottom(0) - (nBlocksInY * objs.one.size)

  return {
    objs= objs,
    bottom= bottom,
    top= top,
    load_scenery = function(self)
      self.position = { 
        x= 32,
        y = bottom(32)
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