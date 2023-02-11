local love = require 'love'
local Player = require 'Player'
local Platform = require 'Platform'
local Tree = require 'Tree'
local player = Player()
local platform = Platform()
local tree = Tree()
local objs= {
  tree, 
  player
}

local function animation_control()
  player.sprite_change_marker = player.sprite_change_marker + 0.25
  if math.ceil(player.sprite_change_marker)==math.floor(player.sprite_change_marker) then
    player.img_position = player.img_position + 4
    player.sprite_change_marker = 0.0
  end
end 

function love.load()
  love.window.setTitle('Hello, World')
  love.mouse.setVisible(false)
  love.graphics.setBackgroundColor(120/255, 200/255, 255/255)
  player.y = platform.bottom-90
  player.quads= Player():quads().quads
end

function love.update(dt)
  table.sort(objs, function(o1, o2) return o1.y<o2.y end)

  if love.keyboard.isDown('d') then
    animation_control()
    if player.img_position>=Player():quads().n or (player.img_position~=3 and player.img_position~=7 and player.img_position~=10) then
      player.img_position = 3
    end
    player.x = player.x + 2
  end  

  if love.keyboard.isDown('a') then
    animation_control()
    if player.img_position>=Player():quads().n or (player.img_position~=2 and player.img_position~=6 and player.img_position~=8) then
      player.img_position = 2
    end
    player.x = player.x - 2
  end  

  if player.y>platform.top-60 then 
    if love.keyboard.isDown('w') then
      animation_control()
      if player.img_position>=Player():quads().n or (player.img_position~=4 and player.img_position~=8 and player.img_position~=12) then
        player.img_position = 4
      end
      player.y = player.y - 2
    end  
  end

  if player.y<platform.bottom-(65*1.5) then 
    if love.keyboard.isDown('s') then
      animation_control()
      if player.img_position>=Player():quads().n or (player.img_position~=1 and player.img_position~=5 and player.img_position~=9) then
        player.img_position = 1
      end
      player.y = player.y + 2
    end  
  end

end

function love.draw()
  platform:load_scenery()
  for i=1,#objs do
    if objs[i].quads~=nil then
      love.graphics.draw(objs[i].sprite.image, objs[i].quads[player.img_position], objs[i].x, objs[i].y, 0, 1.5, 1.5)
    else 
      love.graphics.draw(objs[i].sprite.image, objs[i].quad, objs[i].x, objs[i].y)    
    end
  end
end

