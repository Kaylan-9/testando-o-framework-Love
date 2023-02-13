_G.love = require 'love'

local function Demon()
  local quad= {
    h = 64,
    w = 64
  }

  return {
    img_position=4,
    sprite_change_marker=0.0,
    x=100,
    y=250,
    life=250,
    sprite= {
      image= love.graphics.newImage("sprites/demon.png"),
      h=256,
      w=256,
    },
    quad= quad,
    quads= function (self)
      self.quads= {}
      self.max_frames= {x= 4, y= 4}
      self.n= 1
      for i=1, self.max_frames.x do
        for j=1, self.max_frames.y do
          self.quads[self.n] = love.graphics.newQuad(quad.w * (i - 1), quad.h * (j - 1), quad.w, quad.h, self.sprite.w, self.sprite.h)
          self.n= self.n + 1
        end
      end
      
      return self
    end
  }
end

return Demon