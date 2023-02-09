local love = require 'love'
local Player = require 'Player'
local Platform = require 'Platform'
local player = Player()
local platform = Platform()

function love.load()
  love.window.setTitle('Hello, World')
  love.mouse.setVisible(false)
  love.graphics.setBackgroundColor(120/255, 200/255, 255/255)
end

function love.update(dt)
  player.y = platform.bottom(128)

  if love.keyboard.isDown('d') or love.keyboard.isDown('a') then
    player.sprite_change_marker = player.sprite_change_marker + 0.5
    if math.ceil(player.sprite_change_marker)==math.floor(player.sprite_change_marker) then
      player.img_position = player.img_position + 4
      player.sprite_change_marker = 0.0
    end
  end 

  if love.keyboard.isDown('d') then
    if player.img_position>=Player():quads().n or player.img_position==2 or player.img_position==6 or player.img_position==8 then
      player.img_position = 3
    end
    player.x = player.x + 1
  end  

  if love.keyboard.isDown('a') then
    if player.img_position>=Player():quads().n or player.img_position==3 or player.img_position==7 or player.img_position==10 then
      player.img_position = 2
    end
    player.x = player.x - 1
  end  
end

function love.draw()
  platform:load_scenery()
  love.graphics.draw(player.sprite.image, Player():quads().quads[player.img_position], player.x, player.y)
  
end


