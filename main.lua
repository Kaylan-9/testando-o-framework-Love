local love = require 'love'
local Player = require 'Player'
local Platform = require 'Platform'
local Demon = require 'Demon'
local Tree = require 'Tree'
local player = Player()
local platform = Platform()
local demon = Demon()
local update_frame = 0
local collision_objs= {
  Tree(200, 190), 
  Tree(250, 250),
  Tree(450, 120),
  Tree(350, 370),
  Tree(200, 300),
  Tree(331, 350),
  Tree(331, 130),
  Tree(131, 230),
  Tree(431, 200),
  Tree(431, 100),
  Tree(100, 100),
  Tree(50, 70),
  Tree(20, 170),
  Tree(20, 250),
  Tree(420, 50),
  Tree(400, 150),
  Tree(600, 150),
  Tree(570, 100),
  Tree(499, 320),
  Tree(559, 420),
  Tree(559, 350),
  Tree(620, 250),
  Tree(175, 410),
  Tree(295, 425),
  Tree(495, 405),
  Tree(45, 445),
  Tree(25, 335),
  Tree(654, 405),
  Tree(654, 105),
  demon
}
local objs= collision_objs
local colission_values= {y=0, x=0, colission=false}

local function animation_control()
  player.sprite_change_marker = player.sprite_change_marker + 0.25
  if math.ceil(player.sprite_change_marker)==math.floor(player.sprite_change_marker) then
    player.img_position = player.img_position + 4
    player.sprite_change_marker = 0.0
  end
end 

local function colissions(self, playerx, playery, objs) 
  self.x= playerx
  self.y= playery
  self.colission= false
  for i=1, #collision_objs do
    if (self.x>=objs[i].x+90 and self.x<=objs[i].x+120) then
      if (self.y==objs[i].y) then
        self.colission= true
        self.y= self.y+2
      elseif (self.y==objs[i].y-20) then
        self.colission= true
        self.y= self.y-2
      end
    end

    if (self.y<=objs[i].y+7 and self.y>=objs[i].y-10) then
      if (self.x==objs[i].x+70) then
        self.colission= true
        self.x= self.x-2
      elseif (self.x==objs[i].x+120) then
        self.colission= true
        self.x= self.x+2
      end
    end
  end
  return self
end

function love.load()
  love.window.setTitle('Hello, World')
  love.mouse.setVisible(false)
  love.graphics.setBackgroundColor(120/255, 200/255, 255/255)
  player.y = platform.bottom-90
  player.quads= Player():quads().quads
  demon.quads= Demon():quads().quads
  table.insert(objs, player)
end

function love.update(dt)
  if player.life>0 then
    colission_values = colissions({}, player.x, player.y, collision_objs)
    player.x = colission_values.x

    update_frame= update_frame + (dt)

    if player.x<platform.right then
      if love.keyboard.isDown('d') then
        animation_control()
        if player.img_position>=Player():quads().n or (player.img_position~=3 and player.img_position~=7 and player.img_position~=10) then
          player.img_position = 3
        end
        player.x = colission_values.x
        player.x = player.x + 2
      end  
    end

    if player.x-player.quad.w-20>platform.left then
      if love.keyboard.isDown('a') then
        animation_control()
        if player.img_position>=Player():quads().n or (player.img_position~=2 and player.img_position~=6 and player.img_position~=8) then
          player.img_position = 2
        end
        player.x = colission_values.x
        player.x = player.x - 2
      end  
    end

    if player.y-20>platform.top then 
      if love.keyboard.isDown('w') then
        animation_control()
        if player.img_position>=Player():quads().n or (player.img_position~=4 and player.img_position~=8 and player.img_position~=12) then
          player.img_position = 4
        end
        player.y = colission_values.y
        player.y = player.y - 2
      end  
    end

    if player.y<platform.bottom then 
      if love.keyboard.isDown('s') then
        animation_control()
        if player.img_position>=Player():quads().n or (player.img_position~=1 and player.img_position~=5 and player.img_position~=9) then
          player.img_position = 1
        end
        player.y = colission_values.y
        player.y = player.y + 2
      end  
    end

    if demon.x<=player.x-((player.quad.w/2)+10) then
      if demon.img_position>=16 or (demon.img_position~=12 and demon.img_position~=8 and demon.img_position~=4) then 
        demon.img_position = 4 
      end
      if demon.x~=player.x-((player.quad.w/2)+10) then
        demon.x = demon.x + 1
      end
      if demon.x==player.x-((player.quad.w/2)+10) then
        if demon.y<player.y+20 and demon.y>player.y+5 then
          player.life = player.life - 1 
        end
      end
    elseif demon.x>=player.x+((player.quad.w/2)+10) then
      if demon.img_position>=14 or (demon.img_position~=10 and demon.img_position~=6 and demon.img_position~=2) then 
        demon.img_position = 2
      end
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
      if demon.img_position>=13 or (demon.img_position~=9 and demon.img_position~=5 and demon.img_position~=1) then 
        demon.img_position = 1
      end
      if demon.y~=player.y+20 then
        demon.y = demon.y - 1
      end 
      if demon.y==player.y+20 then
        if demon.x>=player.x-((player.quad.w/2)+10) and demon.x<=player.x+((player.quad.w/2)+10) then
          player.life = player.life - 1 
        end
      end   
    elseif demon.y<=player.y+5 then
      if demon.img_position>=15 or (demon.img_position~=11 and demon.img_position~=7 and demon.img_position~=3) then 
        demon.img_position = 3 
      end
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
  end

  table.sort(objs, function(o1, o2) return o1.y<o2.y end)
end

function love.draw()
  platform:load_scenery()
  for i=1,#objs do
    if objs[i].quads~=nil then
      if objs[i].life>0 then
        love.graphics.draw(objs[i].sprite.image, objs[i].quads[objs[i].img_position], objs[i].x, objs[i].y, 0, 1.5, 1.5, (objs[i].quad.w/2), objs[i].quad.h)
      end
    else 
      love.graphics.draw(objs[i].sprite.image, objs[i].quad, objs[i].x, objs[i].y, 0, 1.5, 1.5, 0, objs[i].h)    
    end
  end   
  love.graphics.print((player.life>0 and 'LIFE '..player.life or 'DIED'), 0, 0, 0, 1.25, 1.25)
end

