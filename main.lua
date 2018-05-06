local state = 0 --Global state of the game

function love.load()

	flags = {}
	flags["fullscreen"] = false
	flags["centered"] = true
	love.window.setMode(1280, 720, flags)
	screen_width = love.graphics.getWidth()
	screen_height = love.graphics.getHeight()

	cellSize = 80
	minCellX = 0
	minCellY = 0
	maxCellX = (1280/cellSize)-1 --16
	maxCellY = (720/cellSize)-1 --9
	
	font = love.graphics.newFont("resources/VCR_OSD_MONO_1.001.ttf", 18)
	love.graphics.setFont(font)
	
	states={}
	states[1] = "_MENU_"	require "menu"
	
	first_state = 1
	
	change_state(first_state)
	
end

function love.draw()

	--Set to white before drawing images from files
	--love.graphics.setColor(255,255,255,255);
	
    --love.graphics.draw(char.graphics.spriteSheet, char.graphics.quads[char.animation], char.currentPos.x * --cellSize, char.currentPos.y * cellSize)

	_G[states[actual].."DRAW"]()
	
end

function love.update(dt)

	--char:updateAnimation(dt)
	
	_G[states[actual].."UPDATE"](dt)
	
end

function change_state(next_state)
	_G[states[next_state].."LOAD"]()
	actual = next_state
end

-- Function to generate a sheet of animations
-- Thanks to https://love2d.org/wiki/Tutorial:Animation
function newAnimation(image, width, height, duration)
    local animation = {}
    animation.spriteSheet = image;
    animation.quads = {};
 
    for y = 0, image:getHeight() - height, height do
        for x = 0, image:getWidth() - width, width do
            table.insert(animation.quads, love.graphics.newQuad(x, y, width, height, image:getDimensions()))
        end
    end
 
    animation.duration = duration or 1
    animation.currentTime = 0
 
    return animation
end
 
 

