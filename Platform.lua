require 'love'
local Tree= require 'Tree'
local Item= require 'Item'

local width, height = love.graphics.getDimensions()
local nBlocksInY= 10
local grass= {
  one= {
    image= love.graphics.newImage('sprites/Grass1.jpg'),
    size= 32 * 1.5
  },
  two= {
    image= love.graphics.newImage('sprites/Grass2.jpg'),
    size= 32 * 1.5
  },
}

local function Platform() 
  return {
    grass= grass, 
    nBlocksInY = nBlocksInY,
    bottom = height,
    right = width,
    left= 0,
    top= height - ((nBlocksInY - 1) * grass.one.size),
    x= 0,
    y= 0,
    objs= {
      trees= {},
      items= {},
    }, 
    ground= function(self)
      return {
        draw= function()
          local x, y = 32, self.bottom-32
          for i=1, 25 do
            for j=1, self.nBlocksInY do
              love.graphics.draw(grass.one.image, (x * (i - 1))+self.x, (y - (grass.one.size * (j - 1)))+self.y, 0, 1.5, 1.5)
            end
          end
        end,
      }
    end,
    trees= function(self) 
      for i=1, 20 do
        local x= math.random(width)
        local y= math.random(self.top*2)+85
        table.insert(self.objs.trees, Tree({}, x, y))
      end
      return self.objs.trees
    end,
    items= function(self)
      for i=1, 20 do
        local image_x, image_y= math.random(3), math.random(3)
        local x, y= math.random(width), math.random((self.top*2)+85)
        table.insert(self.objs.items, Item(x, y, image_x, image_y))
      end
      return self.objs.items
    end
  } 
end

return Platform