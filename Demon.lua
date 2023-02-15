_G.love = require 'love'

local function Demon()
  local demon_quad= {
    h = 64,
    w = 64
  }
  local update_frame = 0
  local sprite_placements = {
    top=  1,
    bottom= 3,
    left= 2, 
    right= 4
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
    ChasePlayer= function(dt, demon, player)
      update_frame= update_frame + (dt)
      
      if demon.x<=player.x-((player.quad.w/2)+10) and demon.y>=player.y+20 then
        if player.x-((player.quad.w/2)+10)-demon.x>demon.y-player.y+20 then
          demon.img_position= sprite_placements.right
        else
          demon.img_position= sprite_placements.top
        end
      elseif demon.x>=player.x+((player.quad.w/2)+10) and demon.y>=player.y+20 then
        if demon.x-player.x+((player.quad.w/2)+10)>demon.y-player.y+20 then
          demon.img_position= sprite_placements.left
        else
          demon.img_position= sprite_placements.top
        end
      elseif demon.x<=player.x-((player.quad.w/2)+10) and demon.y<=player.y+5 then
        if player.x-((player.quad.w/2)+10)-demon.x>player.y+5-demon.y then
          demon.img_position= sprite_placements.right
        else
          demon.img_position= sprite_placements.bottom
        end
      elseif demon.x>=player.x+((player.quad.w/2)+10) and demon.y<=player.y+5 then
        if demon.x-player.x+((player.quad.w/2)+10)>player.y+5-demon.y then
          demon.img_position= sprite_placements.left
        else
          demon.img_position= sprite_placements.bottom
        end
      end

      if demon.x<=player.x-((player.quad.w/2)+10) then
        if demon.x~=player.x-((player.quad.w/2)+10) then
          demon.x = demon.x + 1
        end
        if demon.x==player.x-((player.quad.w/2)+10) then
          if demon.y<player.y+20 and demon.y>player.y+5 then
            player.life = player.life - 1 
          end
        end
      elseif demon.x>=player.x+((player.quad.w/2)+10) then
        if demon.x~=player.x+((player.quad.w/2)+10) then
          demon.x = demon.x - 1
        end
        if demon.x==player.x+((player.quad.w/2)+10) then
          if demon.y<player.y+20 and demon.y>player.y+5 then
            player.life = player.life - 1 
          end
        end
      else
        if demon.y<=player.y+20 and demon.y>=player.y+5 then
          player.life = player.life - 1 
        end
      end
    
      if demon.y>=player.y+20 then
        if demon.y~=player.y+20 then
          demon.y = demon.y - 1
        end 
        if demon.y==player.y+20 then
          player.life = player.life - 1 
        end   
      elseif demon.y<=player.y+5 then
        if demon.y~=player.y+5 then
          demon.y = demon.y + 1
        end
        if demon.y==player.y+5 then
          if demon.x>=player.x-((player.quad.w/2)+10) and demon.x<=player.x+((player.quad.w/2)+10) then
            player.life = player.life - 1 
          end
        end
      else
        if demon.x>=player.x-((player.quad.w/2)+10) and demon.x<=player.x+((player.quad.w/2)+10) then
          player.life = player.life - 1 
        end
      end

      if update_frame>=0.3 then
        if (demon.img_position<13) then 
          demon.img_position = demon.img_position + 4 
        end
        update_frame= 0
      end

      return player.life
    end,
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