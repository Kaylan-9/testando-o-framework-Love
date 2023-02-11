local love = require 'love'
local Player = require 'Player'
local Platform = require 'Platform'
local Tree = require 'Tree'
local player = Player()
local platform = Platform()
local collision_objs= {
  Tree(200, 200), 
  Tree(250, 170),
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
  table.insert(objs, player)
end

function love.update(dt)
  colission_values = colissions({}, player.x, player.y, collision_objs)
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

  -- table.sort(objs, function(o1, o2) return o1.y<o2.y end)
end

function love.draw()
  platform:load_scenery()
  if colission_values.colission then
    love.graphics.print('s')
  else
    love.graphics.print('n')
  end 

  for i=1,#objs do
    if objs[i].quads~=nil then
      love.graphics.draw(objs[i].sprite.image, objs[i].quads[player.img_position], objs[i].x, objs[i].y, 0, 1.5, 1.5, objs[i].quad.w, objs[i].quad.h)
    else 
      love.graphics.draw(objs[i].sprite.image, objs[i].quad, objs[i].x, objs[i].y, 0, 1.5, 1.5, 0, objs[i].h)    
    end
  end
end

