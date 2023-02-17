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

local Platform= {
  grass= grass, 
  nBlocksInY = nBlocksInY,
  bottom = height,
  right = width,
  left= 0,
  top= height - ((nBlocksInY - 1) * grass.one.size),
  ground={}
} 

Platform.ground.draw= function(self)
  local x, y = 32, Platform.bottom-32
  for i=1, 25 do
    for j=1, Platform.nBlocksInY do
      love.graphics.draw(grass.one.image, x * (i - 1), y - (grass.one.size * (j - 1)), 0, 1.5, 1.5)
    end
  end
end

Platform.trees= function(self) 
  self.objs= {}
  for i=1, 20 do
    local x= math.random(width)
    local y= math.random(Platform.top*2)+85
    table.insert(self.objs, Tree(x, y))
  end
  return self.objs
end

Platform.items= function(self)
  local x, y= 0
  local image_x, image_y= 0, 0 
  self.objs= {}
  for i=1, 20 do
    image_x, image_y= math.random(3), math.random(3)
    x, y= math.random(width), math.random((Platform.top*2)+85)
    table.insert(self.objs, Item(x, y, image_x, image_y))
  end
  return self.objs
end

return Platform