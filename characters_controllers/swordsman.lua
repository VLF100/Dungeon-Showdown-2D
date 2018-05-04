
require "characters_controllers/common_player"

function generateSwordsman(init_x,init_y)

	Swordsman = getPlayableCharacter(init_x,init_y)
	
	Swordsman.animation = newAnimation(love.graphics.newImage("swordman.png"), 80, 63, 0.5)

	Swordsman.startTurn = function()
		love.keypressed = function(key)
			if key == "up" then
				if char.currentPos.y > 0 then
					char.currentPos.y = char.currentPos.y - 1
					return char:endTurn()
				end
			elseif key == "down" then
				if char.currentPos.y < 17 then
					char.currentPos.y = char.currentPos.y + 1
					return char:endTurn()
				end
			elseif key == "left" then
				if char.currentPos.x > 0 then
					char.currentPos.x = char.currentPos.x - 1
					return char:endTurn()
				end
			elseif key == "right" then
				if char.currentPos.x < 31 then
					char.currentPos.x = char.currentPos.x + 1
					return char:endTurn()
				end
			end
		end
	end

	Swordsman.endTurn = function()
		return nextTurn()
	end

	return Swordsman

end

