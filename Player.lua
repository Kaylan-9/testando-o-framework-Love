require 'love'

local function Player()
  local width, height = love.graphics.getDimensions()
  local props= {
    img_position=3,
    sprite_change_marker=0.0,
    x=(width/2),
    y=(height/2),
    life=10000,
    sprite= {
      image= love.graphics.newImage("sprites/fox.png"),
      h=256,
      w=144,
    },
    max_frames= {x= 3, y= 4},
    quad= {h = 64, w = 48},
    quads= {},
    collision = {
      top= false, 
      bottom= false, 
      left= false, 
      right= false
    },
    animationControl= function(self)
      self.sprite_change_marker = self.sprite_change_marker + 0.25
      if math.ceil(self.sprite_change_marker)==math.floor(self.sprite_change_marker) then
        self.img_position = self.img_position + 4
        self.sprite_change_marker = 0.0
      end
    end,    
    collides= function(self, platform, interactions)
      self.objs= objs
      for j=1, #interactions do
        self.objs= interactions[j].objs
        for i=1, #self.objs do
          if self.objs[i].exist then 
            if self.x>self.objs[i].x-(self.quad.w/2)-15 and self.x<self.objs[i].x then
              if self.y<self.objs[i].y+10 and self.y>self.objs[i].y-10 then
                self.collision.left= true
                interactions[j].func(i)
              end
            elseif self.x<self.objs[i].x+(self.quad.w/2)+15 and self.x>self.objs[i].x then
              if self.y<self.objs[i].y+10 and self.y>self.objs[i].y-10 then
                self.collision.right= true
                interactions[j].func(i)
              end
            end 
            if self.y>self.objs[i].y-10 and self.y<self.objs[i].y+10 then
              if self.x>self.objs[i].x-(self.quad.w/2) and self.x<self.objs[i].x+(self.quad.w/2) then
                self.collision.bottom= true
                interactions[j].func(i)
              end
            elseif self.y<self.objs[i].y+20 and self.y>self.objs[i].y+10 then
              if self.x>self.objs[i].x-(self.quad.w/2) and self.x<self.objs[i].x+(self.quad.w/2) then
                self.collision.top= true
                interactions[j].func(i)
              end
            end
          end
        end
      end

      if self.collision.top then platform.y= platform.y - 2
      elseif self.collision.bottom then platform.y= platform.y + 2
      end
      if self.collision.left then platform.x= platform.x + 2
      elseif self.collision.right then platform.x= platform.x - 2
      end

      for j=1, #interactions do
        self.objs= interactions[j].objs
        for i=1, #self.objs do
          if self.objs[i].exist then 
            if self.collision.top then self.objs[i].y= self.objs[i].y - 2
            elseif self.collision.bottom then self.objs[i].y= self.objs[i].y + 2
            end
            if self.collision.left then self.objs[i].x= self.objs[i].x + 2
            elseif self.collision.right then self.objs[i].x= self.objs[i].x - 2
            end
          end
        end
      end
    end,
    reactivateObjMovement=function(self)
      self.collision.top= false 
      self.collision.bottom= false
      self.collision.left= false
      self.collision.right= false
    end,
    controls= function(self, platform, enemies)
      if self.x<platform.right then
        if love.keyboard.isDown('d') then
          self:animationControl()
          if self.img_position>=#self.quads or (self.img_position~=3 and self.img_position~=7 and self.img_position~=10) then
            self.img_position = 3
          end

          platform.x = platform.x - 2
          for i=1, #platform.objs.trees do platform.objs.trees[i].x = platform.objs.trees[i].x - 2 end
          for i=1, #platform.objs.items do platform.objs.items[i].x = platform.objs.items[i].x - 2 end
          for i=1, #enemies.objs do enemies.objs[i].x = enemies.objs[i].x - 2 end
        end  
      end
  
      if self.x-(self.quad.w/2)>platform.left then
        if love.keyboard.isDown('a') then
          self:animationControl()
          if self.img_position>=#self.quads or (self.img_position~=2 and self.img_position~=6 and self.img_position~=8) then
            self.img_position = 2
          end

          -- self.x = self.x - 2
          platform.x = platform.x + 2
          for i=1, #platform.objs.trees do platform.objs.trees[i].x = platform.objs.trees[i].x + 2 end
          for i=1, #platform.objs.items do platform.objs.items[i].x = platform.objs.items[i].x + 2 end
          for i=1, #enemies.objs do enemies.objs[i].x = enemies.objs[i].x + 2 end
        end  
      end
  
      if self.y>platform.top then 
        if love.keyboard.isDown('w') then
          self:animationControl()
          if self.img_position>=#self.quads or (self.img_position~=4 and self.img_position~=8 and self.img_position~=12) then
            self.img_position = 4
          end

          -- self.y = self.y - 2
          platform.y = platform.y + 2
          for i=1, #platform.objs.trees do platform.objs.trees[i].y = platform.objs.trees[i].y + 2 end
          for i=1, #platform.objs.items do platform.objs.items[i].y = platform.objs.items[i].y + 2 end
          for i=1, #enemies.objs do enemies.objs[i].y = enemies.objs[i].y + 2 end
        end  
      end
  
      if self.y<platform.bottom then 
        if love.keyboard.isDown('s') then
          self:animationControl()
          if self.img_position>=#self.quads or (self.img_position~=1 and self.img_position~=5 and self.img_position~=9) then
            self.img_position = 1
          end

          -- self.y = self.y + 2
          platform.y = platform.y - 2
          for i=1, #platform.objs.trees do platform.objs.trees[i].y = platform.objs.trees[i].y - 2 end
          for i=1, #platform.objs.items do platform.objs.items[i].y = platform.objs.items[i].y - 2 end
          for i=1, #enemies.objs do enemies.objs[i].y = enemies.objs[i].y - 2 end
        end  
      end
    end
  }
  
  for i=1, props.max_frames.x do
    for j=1, props.max_frames.y do
      table.insert(props.quads, love.graphics.newQuad(props.quad.w * (i - 1), props.quad.h * (j - 1), props.quad.w, props.quad.h, props.sprite.w, props.sprite.h))
    end
  end
  return props
end

return Player
