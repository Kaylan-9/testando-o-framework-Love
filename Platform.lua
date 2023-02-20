require 'love'
local Tree= require 'Tree'
local Item= require 'Item'

local width, height = love.graphics.getDimensions()
local nBlocksInY= 30
local nBlocksInX= 30
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
    nBlocksInX = nBlocksInX,
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
          local x, y = grass.one.size, grass.one.size
          for i=1, nBlocksInX do
            for j=1, nBlocksInY do
              local postionx= (x * (i - 1))+self.x+(width/2)-((nBlocksInX*grass.one.size)/2)
              local postiony= (y * (j - 1))+self.y+(height/2)-((nBlocksInX*grass.one.size)/2)
              love.graphics.draw(grass.one.image, postionx, postiony, 0, 1.5, 1.5, (grass.one.size/2), (grass.one.size/2))
            end
          end
        end,
      }
    end,
    trees= function(self) 
      for i=1, 150 do
        local x= math.random((width/2)-((nBlocksInX*grass.one.size)/2), (width/2)+((nBlocksInX*grass.one.size)/2)-32)-32
        local y= math.random((height/2)-((nBlocksInY*grass.one.size)/2), (height/2)+((nBlocksInY*grass.one.size)/2))+32
        table.insert(self.objs.trees, Tree({}, x, y))
      end
      return self.objs.trees
    end,
    items= function(self)
      for i=1, 500 do
        local image_x, image_y= math.random(3), math.random(3)
        local x= math.random((width/2)-((nBlocksInX*grass.one.size)/2), (width/2)+((nBlocksInX*grass.one.size)/2)-32)-32
        local y= math.random((height/2)-((nBlocksInY*grass.one.size)/2), (height/2)+((nBlocksInY*grass.one.size)/2))+32
        table.insert(self.objs.items, Item(x, y, image_x, image_y))
      end
      return self.objs.items
    end
  } 
end

return Platform