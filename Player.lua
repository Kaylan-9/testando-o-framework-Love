_G.love = require 'love'

local function Player()
  return {
    img_position=3,
    sprite_change_marker=0.0,
    x=0,
    y=0,
    sprite= {
      image= love.graphics.newImage("sprites/fox.png"),
      h=256,
      w=144,
    },

    quads= function (self)
      self.quad= {}
      self.quad.h = 64
      self.quad.w = 48
      self.quads= {}
      self.max_frames= {x= 3, y= 4}
      self.n= 1
      for i=1, self.max_frames.x do
        for j=1, self.max_frames.y do
          self.quads[self.n] = love.graphics.newQuad(self.quad.w * (i - 1), self.quad.h * (j - 1), self.quad.w, self.quad.h, self.sprite.w, self.sprite.h)
          self.n= self.n + 1
        end
      end
      
      return self
    end
  }
end

return Player
