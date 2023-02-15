local love = require 'love'
local width, heigth = love.graphics.getDimensions()
local Player = require 'Player'
local Platform = require 'Platform'
local Demon = require 'Demon'
local Tree = require 'Tree'
local Item = require 'Item'
local player = Player()
local platform = Platform()
local demon = Demon()
local collision_objs= {}

local x, y= 0, 0
for i=1, 20 do
  x, y= math.random(width), math.random((platform.top*2)+85)
  table.insert(collision_objs, Tree(x, y))
end
for i=1, 20 do
  local image_x, image_y= math.random(3), math.random(3)
  x, y= math.random(width), math.random((platform.top*2)+85)
  table.insert(collision_objs, Item(x, y, image_x, image_y))
end

local objs= collision_objs
table.insert(objs, demon)
local colission_values= {y=0, x=0, colission=false}

local function animation_control()
  player.sprite_change_marker = player.sprite_change_marker + 0.25
  if math.ceil(player.sprite_change_marker)==math.floor(player.sprite_change_marker) then
    player.img_position = player.img_position + 4
    player.sprite_change_marker = 0.0
  end
end 

local function colissions(self, objs) 
  self.colission= false
  local function got_item(i) 
    if objs[i].type=='item' then
      player.life = player.life + 100 
      objs[i].exist=false
    end
  end

  for i=1, #collision_objs do
    if collision_objs[i].exist then 

      if self.x>collision_objs[i].x-(self.quad.w/2)-15 and self.x<collision_objs[i].x then
        if self.y<collision_objs[i].y+10 and self.y>collision_objs[i].y-10 then
          self.x= self.x - 2
          got_item(i)
        end
      elseif self.x<collision_objs[i].x+(self.quad.w/2)+15 and self.x>collision_objs[i].x then
        if self.y<collision_objs[i].y+10 and self.y>collision_objs[i].y-10 then
          self.x= self.x + 2
          got_item(i)
        end
      end 

      if self.y>collision_objs[i].y-10 and self.y<collision_objs[i].y+10 then
        if self.x>collision_objs[i].x-(self.quad.w/2) and self.x<collision_objs[i].x+(self.quad.w/2) then
          self.y= self.y - 2
          got_item(i)
        end
      elseif self.y<collision_objs[i].y+20 and self.y>collision_objs[i].y+10 then
        if self.x>collision_objs[i].x-(self.quad.w/2) and self.x<collision_objs[i].x+(self.quad.w/2) then
          self.y= self.y + 2
          got_item(i)
        end
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
    colission_values = colissions(player, collision_objs)
    player.x = colission_values.x

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

    if player.x-(player.quad.w/2)>platform.left then
      if love.keyboard.isDown('a') then
        animation_control()
        if player.img_position>=Player():quads().n or (player.img_position~=2 and player.img_position~=6 and player.img_position~=8) then
          player.img_position = 2
        end
        player.x = colission_values.x
        player.x = player.x - 2
      end  
    end

    if player.y>platform.top then 
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
 
    player.life = demon.ChasePlayer(dt, demon, player)
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
      if objs[i].exist==nil or objs[i].exist==true then
        love.graphics.draw(objs[i].sprite.image, objs[i].quad, objs[i].x, objs[i].y, 0, 1.5, 1.5, (objs[i].w/2), objs[i].h)    
      end
    end
  end   
  love.graphics.print((player.life>0 and 'LIFE '..player.life or 'DIED'), 0, 0, 0, 1.25, 1.25)
end

