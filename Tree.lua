local love = require 'love'

local function Tree(x, y)
  local spritesheet= {w=169, h=154}
  local tree_quad= {w=80, h=85}
  local width, height = love.graphics.getDimensions()
  return {
    x= x,
    exist= true,
    y= height-y,
    w= tree_quad.w,
    h= tree_quad.h,
    spritesheet= spritesheet,
    quad= love.graphics.newQuad(0, 0, tree_quad.w, tree_quad.h, spritesheet.w, spritesheet.h),
    sprite= {
      image= love.graphics.newImage('sprites/scenographicobjects.png'),
    } 
  }
end

return Tree