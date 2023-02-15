_G.love = require 'love'

local function Demon()
  local demon_quad= {
    h = 64,
    w = 64
  }

  return {
    img_position=4,
    sprite_change_marker=0.0,
    x=100,
    y=250,
    quad= demon_quad, 
    life=250,
    sprite= {
      image= love.graphics.newImage("sprites/demon.png"),
      h=256,
      w=256,
    },
    quads= function (self)
      self.quads= {}
      self.max_frames= {x= 4, y= 4}
      self.n= 1
      for i=1, self.max_frames.x do
        for j=1, self.max_frames.y do
          self.quads[self.n] = love.graphics.newQuad(demon_quad.w * (i - 1), demon_quad.h * (j - 1), demon_quad.w, demon_quad.h, self.sprite.w, self.sprite.h)
          self.n= self.n + 1
        end
      end
      
      return self
    end
  }
end

return Demon