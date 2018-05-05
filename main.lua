local state = 0 --Global state of the game


require "characters_controllers/swordsman"




function love.load()

	animation = newAnimation(love.graphics.newImage("swordman.png"), 80, 63, 0.5)

	flags = {}
	flags["fullscreen"] = false
	flags["centered"] = true
	love.window.setMode(1280, 720, flags)
	screen_width = love.graphics.getWidth()
	screen_height = love.graphics.getHeight()

	cellSize = 80
	minCellX = 0
	minCellY = 0
	maxCellX = (1280/cellSize)-1
	maxCellY = (720/cellSize)-1

	char = generateSwordsman(0,0)

	enemy = {

		currentPos = {x = maxCellX, y = maxCellY},

		startTurn = function(self)
			love.keypressed = nil
			self.currentPos.x = self.currentPos.x - 1
			return self:endTurn();
		end,

		endTurn = function(self)
			return nextTurn()
		end
	}

	turns = {char,enemy}

	turn = 2

	nextTurn()

end

function love.draw()

	--Set to white before drawing images from files
	love.graphics.setColor(255,255,255,255);
	
	--local spriteNum = math.floor(animation.currentTime / animation.duration * #animation.quads) + 1
    love.graphics.draw(char.graphics.spriteSheet, char.graphics.quads[char.animation], char.currentPos.x * cellSize, char.currentPos.y * cellSize)

	love.graphics.setColor(0, 1, 0, 1)
	love.graphics.rectangle("fill", enemy.currentPos.x * cellSize, enemy.currentPos.y * cellSize, cellSize, cellSize)
end

function love.update(dt)

	char:updateAnimation(dt)
	
end
 

function nextTurn()
	nextTurnChar = turns[(turn%2)+1]
	turn = turn +1
	return nextTurnChar:startTurn()
end

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
 
 

