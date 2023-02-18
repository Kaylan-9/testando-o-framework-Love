require 'love'

local Player= require 'Player'
local Platform= require 'Platform'
local Enemies= require 'Enemies'
local width, heigth = love.graphics.getDimensions()
local platform= Platform()
local player = Player()
local enemies = Enemies(platform)
local objs= {}

function love.load()
  love.window.setTitle('Hello, World')
  love.mouse.setVisible(false)
  love.graphics.setBackgroundColor(120/255, 200/255, 255/255)
  platform:trees()
  platform:items()
  table.insert(objs, player)
  for i=1, #enemies.objs do table.insert(objs, enemies.objs[i]) end
  for i=1, #platform.objs.items do table.insert(objs, platform.objs.items[i]) end
  for i=1, #platform.objs.trees do table.insert(objs, platform.objs.trees[i]) end
end

function love.update(dt)
  if player.life>0 then
    player:controls(platform, enemies)
    player:collides(platform, {
      {
        objs=platform.objs.trees, 
        func=function(i) end
      },
      {
        objs=platform.objs.items, 
        func=function(i) 
          if platform.objs.items[i].type=='item' then
            player.life = player.life + 100 
            platform.objs.items[i].exist=false
          end
        end
      },
    })
    for i=1, #enemies.objs do enemies.objs[i]:collisionMoves(player.collision) end
    for i=1, #enemies.objs do enemies.objs[i]:chaseObj(dt, player) end
    player:reactivateObjMovement()
  end
  table.sort(objs, function(o1, o2) return o1.y<o2.y end)
end

function love.draw()
  platform:ground().draw()
  for i=1,#objs do
    if objs[i].quads~=nil then 
      if objs[i].life>0 then love.graphics.draw(objs[i].sprite.image, objs[i].quads[objs[i].img_position], objs[i].x, objs[i].y, 0, 1.5, 1.5, (objs[i].quad.w/2), objs[i].quad.h) end
    else 
      if objs[i].exist==nil or objs[i].exist==true then love.graphics.draw(objs[i].sprite.image, objs[i].quad, objs[i].x, objs[i].y, 0, 1.5, 1.5, (objs[i].w/2), objs[i].h) end 
    end
  end   
  love.graphics.print((player.life>0 and 'LIFE '..player.life or 'DIED'), 0, 0, 0, 1.25, 1.25)
end

