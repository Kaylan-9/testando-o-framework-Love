require 'love'
local Player= require 'Player'
local platform= require 'Platform'
local Demon= require 'Demon'
local width, heigth = love.graphics.getDimensions()
local player = Player()
local demon = Demon()
local trees= platform:trees()
local items= platform:items()
local objs= trees
for i=1, #items do table.insert(objs, items[i]) end
table.insert(objs, demon)
table.insert(objs, player)

function love.load()
  love.window.setTitle('Hello, World')
  love.mouse.setVisible(false)
  love.graphics.setBackgroundColor(120/255, 200/255, 255/255)
end

function love.update(dt)
  if player.life>0 then
    player:controls(platform)
    player:collides(trees, function() end)
    player:collides(items, function(i) 
      if items[i].type=='item' then
        player.life = player.life + 100 
        items[i].exist=false
      end
    end)
    demon:chaseObj(dt, player)
  end
  table.sort(objs, function(o1, o2) return o1.y<o2.y end)
end

function love.draw()
  platform.ground.draw()
  for i=1,#objs do
    if objs[i].quads~=nil then 
      if objs[i].life>0 then love.graphics.draw(objs[i].sprite.image, objs[i].quads[objs[i].img_position], objs[i].x, objs[i].y, 0, 1.5, 1.5, (objs[i].quad.w/2), objs[i].quad.h) end
    else 
      if objs[i].exist==nil or objs[i].exist==true then love.graphics.draw(objs[i].sprite.image, objs[i].quad, objs[i].x, objs[i].y, 0, 1.5, 1.5, (objs[i].w/2), objs[i].h) end 
    end
  end   
  love.graphics.print((player.life>0 and 'LIFE '..player.life or 'DIED'), 0, 0, 0, 1.25, 1.25)
end

