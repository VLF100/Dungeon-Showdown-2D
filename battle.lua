require "characters_controllers/swordsman"

local characters = {}

function _BATTLE_LOAD()

	nextTurn()

end

function _BATTLE_DRAW()

	for index,character in pairs(characters) do
		love.graphics.draw(character.graphics.spriteSheet, character.graphics.quads[character.animation], character.currentPos.x * cellSize, character.currentPos.y * cellSize)
	end

end

function _BATTLE_UPDATE(dt)

	for index,character in pairs(characters) do
		character:updateAnimation(dt)
	end
end

function createBattle (playerClass,enemies)

	player = _G['generate'..playerClass](0,maxCellY-3)
	table.insert(characters,player)

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

	turns = {player,enemy}

	turn = 2

end

function nextTurn()
	nextTurnChar = turns[(turn%2)+1]
	turn = turn +1
	return nextTurnChar:startTurn()
end
