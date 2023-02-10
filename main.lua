local love = require 'love'
local Player = require 'Player'
local Platform = require 'Platform'
local player = Player()
local platform = Platform()

function love.load()
  love.window.setTitle('Hello, World')
  love.mouse.setVisible(false)
  love.graphics.setBackgroundColor(120/255, 200/255, 255/255)
  player.y = platform.bottom(90)
end

function love.update(dt)
  local function animation_control()
    player.sprite_change_marker = player.sprite_change_marker + 0.25
    if math.ceil(player.sprite_change_marker)==math.floor(player.sprite_change_marker) then
      player.img_position = player.img_position + 4
      player.sprite_change_marker = 0.0
    end
  end 

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

  if player.y<platform.bottom(65) then 
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
  love.graphics.draw(platform.objs.tree.sprite.image, platform.objs.tree.sprite.quad, 0, platform.bottom(134))
  if player.y<platform.bottom(80*1.5) then 
    love.graphics.draw(player.sprite.image, Player():quads().quads[player.img_position], player.x, player.y, 0, 1.5, 1.5)
  end
  love.graphics.draw(platform.objs.tree.sprite.image, platform.objs.tree.sprite.quad, 250, platform.bottom(102))
  if player.y>platform.bottom(80*1.5) then 
    love.graphics.draw(player.sprite.image, Player():quads().quads[player.img_position], player.x, player.y, 0, 1.5, 1.5)
  end
end


