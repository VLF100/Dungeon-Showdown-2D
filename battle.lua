require "characters_controllers/swordsman"

function _BATTLE_LOAD()

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

function _BATTLE_DRAW()

	love.graphics.draw(char.graphics.spriteSheet, char.graphics.quads[char.animation], char.currentPos.x * cellSize, char.currentPos.y * cellSize)
	
end

function _BATTLE_UPDATE(dt)

	char:updateAnimation(dt)
	
end

function startBattle (characters)

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

function nextTurn()
	nextTurnChar = turns[(turn%2)+1]
	turn = turn +1
	return nextTurnChar:startTurn()
end

