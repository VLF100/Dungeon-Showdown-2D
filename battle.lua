
require "characters_controllers/swordsman"

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

