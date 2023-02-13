local love= require 'love'

local function Item(x, y, c, r)
  local spritesheet= {w=64, h=64}
  local count_frames= {x=4, y=4}
  local quad= {w=(spritesheet.w/count_frames.x), h=(spritesheet.h/count_frames.y)}
  local width, heigth = love.graphics.getDimensions()
  return {
    x= x, 
    y= heigth-y,
    w= quad.w,
    h= quad.h,
    spritesheet= spritesheet,
    quad= love.graphics.newQuad(quad.w*c, quad.h*r, quad.w, quad.h, spritesheet.w, spritesheet.h),
    sprite= {
      image= love.graphics.newImage('sprites/Fruits.png'),
    }
  }
end

return Item