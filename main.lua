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

	startbutton = {}
	startbutton.graphics = {}
	startbutton.graphics.spritesheet = love.graphics.newImage("startbutton.png")
	startbutton.graphics.quads = {}
	
	startbutton.graphics.quads[1] = love.graphics.newQuad(0, 0, 170, 80, startbutton.graphics.spritesheet:getDimensions())
	startbutton.graphics.quads[2] = love.graphics.newQuad(0, 80, 170, 80, startbutton.graphics.spritesheet:getDimensions())
	
	startbutton.graphics.duration = 1.2
    startbutton.graphics.currentTime = 0
	startbutton.graphics.state = 1
	
	startbutton.marked = true
	startbutton.x = 13
	startbutton.y = 5
	
	
	exitbutton = {}
	exitbutton.graphics = {}
	exitbutton.graphics.spritesheet = love.graphics.newImage("exitbutton.png")
	exitbutton.graphics.quads = {}
	
	exitbutton.graphics.quads[1] = love.graphics.newQuad(0, 0, 170, 80, exitbutton.graphics.spritesheet:getDimensions())
	exitbutton.graphics.quads[2] = love.graphics.newQuad(0, 80, 170, 80, exitbutton.graphics.spritesheet:getDimensions())
	
	exitbutton.graphics.duration = 1.2
    exitbutton.graphics.currentTime = 0
	exitbutton.graphics.state = 1
	
	exitbutton.marked = false
	exitbutton.x = 13
	exitbutton.y = 6
	
	
	buttonslist = {}
	table.insert(buttonslist, startbutton)
	table.insert(buttonslist, exitbutton)
	
	currentlyMarked = 1
	
end

function love.draw()

	--Set to white before drawing images from files
	--love.graphics.setColor(255,255,255,255);
	
    --love.graphics.draw(char.graphics.spriteSheet, char.graphics.quads[char.animation], char.currentPos.x * --cellSize, char.currentPos.y * cellSize)

	for index,button in pairs(buttonslist) do 
		love.graphics.draw(button.graphics.spritesheet, button.graphics.quads[button.graphics.state], button.x * cellSize, button.y * cellSize)
	end
	

	
end

function love.update(dt)

	--char:updateAnimation(dt)
	
	for index,button in pairs(buttonslist) do 
	
		if button.marked == true then
		
			button.graphics.currentTime = button.graphics.currentTime + dt
			
			if button.graphics.currentTime >= button.graphics.duration then
				button.graphics.currentTime = button.graphics.currentTime - startbutton.graphics.duration
			end

			button.graphics.state = math.floor(button.graphics.currentTime / button.graphics.duration * #button.graphics.quads) + 1
			
		else
			button.graphics.state = 1
		end
		
	end
	
	

	
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

function love.keypressed(key)
	if key == "down" then
		buttonslist[currentlyMarked].marked = false
		buttonslist[currentlyMarked+1].marked = true
		currentlyMarked = currentlyMarked + 1
	end
	if key == "up" then
		buttonslist[currentlyMarked].marked = false
		buttonslist[currentlyMarked-1].marked = true
		currentlyMarked = currentlyMarked - 1
	end
end
 
 

