require 'love'

local function Demon(x, y)
  local props= {
    update_frame = 0,
    sprite_placements = {top=  1, bottom= 3, left= 2, right= 4},
    enemy_ray = 151,
    img_position=4,
    sprite_change_marker=0.0,
    x=x,
    y=y,
    quad= {h = 64, w = 64}, 
    life=250,
    sprite= {
      image= love.graphics.newImage("sprites/demon.png"),
      h=256,
      w=256,
    },
    max_frames= {x= 4, y= 4},
    quads= {},
    speed= {
      x= 0,
      y= 0
    },
    collisionMoves= function(self, collision)
      if collision.top then self.y= self.y - 2
      elseif collision.bottom then self.y= self.y + 2
      end
      if collision.left then self.x= self.x + 2
      elseif collision.right then self.x= self.x - 2
      end
    end,
    chaseObj= function(self, dt, player)
      self.enemy_ray=math.sqrt(((player.x-self.x)^2)+((player.y-self.y)^2))
      if self.enemy_ray>5 and self.enemy_ray<150 then
        self.speed.y= math.random(1, (100-(((150-self.enemy_ray)*100)/150))/33.3) * (self.update_frame+1)
        self.speed.x= math.random(1, (100-(((150-self.enemy_ray)*100)/150))/33.3) * (self.update_frame+1)

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
            self.x = self.x + self.speed.x
          end
          if self.x==player.x-((player.quad.w/2)+10) then
            if self.y<player.y+20 and self.y>player.y+5 then
              player.life = player.life - 1 
            end
          end
        elseif self.x>=player.x+((player.quad.w/2)+10) then
          if self.x~=player.x+((player.quad.w/2)+10) then
            self.x = self.x - self.speed.x
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
            self.y = self.y - self.speed.y
          end 
          if self.y==player.y+20 then
            player.life = player.life - 1 
          end   
        elseif self.y<=player.y+5 then
          if self.y~=player.y+5 then
            self.y = self.y + self.speed.y
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