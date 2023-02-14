_G.love = require 'love'

local function Player()
  local quad= {
    h = 64,
    w = 48
  }

  return {
    img_position=3,
    sprite_change_marker=0.0,
    x=0,
    y=0,
    life=10000,
    sprite= {
      image= love.graphics.newImage("sprites/fox.png"),
      h=256,
      w=144,
    },
    quad= quad,
    quads= function (self)
      self.quads= {}
      self.max_frames= {x= 3, y= 4}
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

return Player
