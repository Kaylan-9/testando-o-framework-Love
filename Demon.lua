_G.love = require 'love'

local function Demon(self)
  local props= {
    update_frame = 0,
    sprite_placements = {top=  1, bottom= 3, left= 2, right= 4},
    enemy_ray = 209,
    img_position=4,
    sprite_change_marker=0.0,
    x=100,
    y=250,
    quad= {h = 64, w = 64}, 
    life=250,
    sprite= {
      image= love.graphics.newImage("sprites/demon.png"),
      h=256,
      w=256,
    },
    max_frames= {x= 4, y= 4},
    quads= {},
    speed= 1,
    chaseObj= function(self, dt, player)
      self.enemy_ray=math.sqrt(((player.x-self.x)^2)+((player.y-self.y)^2))
      if self.enemy_ray>1 and self.enemy_ray<208 then
        self.speed= math.random(1, (100-(((208-self.enemy_ray)*100)/208))/30) * (self.update_frame+1)

        if self.x<=player.x-((player.quad.w/2)+10) and self.y>=player.y+20 then
          if player.x-((player.quad.w/2)+10)-self.x>self.y-player.y+20 then
            self.img_position= self.sprite_placements.right
          else self.img_position= self.sprite_placements.top end
        elseif self.x>=player.x+((player.quad.w/2)+10) and self.y>=player.y+20 then
          if self.x-player.x+((player.quad.w/2)+10)>self.y-player.y+20 then
            self.img_position= self.sprite_placements.left
          else self.img_position= self.sprite_placements.top end
        elseif self.x<=player.x-((player.quad.w/2)+10) and self.y<=player.y+5 then
          if player.x-((player.quad.w/2)+10)-self.x>player.y+5-self.y then
            self.img_position= self.sprite_placements.right
          else self.img_position= self.sprite_placements.bottom end
        elseif self.x>=player.x+((player.quad.w/2)+10) and self.y<=player.y+5 then
          if self.x-player.x+((player.quad.w/2)+10)>player.y+5-self.y then
            self.img_position= self.sprite_placements.left
          else self.img_position= self.sprite_placements.bottom end
        end

        if self.x<=player.x-((player.quad.w/2)+10) then
          if self.x~=player.x-((player.quad.w/2)+10) then
            self.x = self.x + self.speed
          end
          if self.x==player.x-((player.quad.w/2)+10) then
            if self.y<player.y+20 and self.y>player.y+5 then
              player.life = player.life - 1 
            end
          end
        elseif self.x>=player.x+((player.quad.w/2)+10) then
          if self.x~=player.x+((player.quad.w/2)+10) then
            self.x = self.x - self.speed
          end
          if self.x==player.x+((player.quad.w/2)+10) then
            if self.y<player.y+20 and self.y>player.y+5 then
              player.life = player.life - 1 
            end
          end
        else
          if self.y<=player.y+20 and self.y>=player.y+5 then
            player.life = player.life - 1 
          end
        end
      
        if self.y>=player.y+20 then
          if self.y~=player.y+20 then
            self.y = self.y - self.speed
          end 
          if self.y==player.y+20 then
            player.life = player.life - 1 
          end   
        elseif self.y<=player.y+5 then
          if self.y~=player.y+5 then
            self.y = self.y + self.speed
          end
          if self.y==player.y+5 then
            if self.x>=player.x-((player.quad.w/2)+10) and self.x<=player.x+((player.quad.w/2)+10) then
              player.life = player.life - 1 
            end
          end
        else
          if self.x>=player.x-((player.quad.w/2)+10) and self.x<=player.x+((player.quad.w/2)+10) then
            player.life = player.life - 1 
          end
        end
        
        self.update_frame= self.update_frame + dt
        if self.update_frame>=0.3 then
          if (self.img_position<13) then 
            self.img_position = self.img_position + 4 
          end
          self.update_frame= 0
        end
      end
    end,
  }

  for i=1, props.max_frames.x do
    for j=1, props.max_frames.y do
      table.insert(props.quads, love.graphics.newQuad(props.quad.w * (i - 1), props.quad.h * (j - 1), props.quad.w, props.quad.h, props.sprite.w, props.sprite.h))
    end
  end

  return props
end

return Demon