local love = require 'love'
local player = require 'Player'

function love.load()
  love.window.setTitle('Hello, World')
  love.mouse.setVisible(false)
  _G.position = 12
end


function love.update(dt)
  if love.keyboard.isDown('d') then
    position = position + 1
  end  
  if position>=player():quads().n then
    position = 1
  end
end

function love.draw()
  love.graphics.draw(player().sprite.image, player():quads().quads[position], player().x, player().y)
  love.graphics.print(#player():quads().quads)
end