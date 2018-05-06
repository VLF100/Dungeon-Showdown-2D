
require "characters_controllers/common_player"

function generateSwordsman(init_x,init_y)

	Swordsman = getPlayableCharacter(init_x,init_y)
	
	Swordsman.graphics = newAnimation(love.graphics.newImage("swordman.png"), 80, 63, 0.5)

	Swordsman.startTurn = function()
		love.keypressed = function(key)
			if key == "up" then
				if char.currentPos.y > 0 then
					char.currentPos.y = char.currentPos.y - 1
					return char:endTurn()
				end
			elseif key == "down" then
				if char.currentPos.y < maxCellY then
					char.currentPos.y = char.currentPos.y + 1
					return char:endTurn()
				end
			elseif key == "left" then
				if char.currentPos.x > 0 then
					char.currentPos.x = char.currentPos.x - 1
					return char:endTurn()
				end
			elseif key == "right" then
				if char.currentPos.x < maxCellX then
					char.currentPos.x = char.currentPos.x + 1
					return char:endTurn()
				end
			elseif key == "return" then
				char.state = "ATTACK"
				return char:endTurn()
			end
		end
	end

	Swordsman.endTurn = function()
		return nextTurn()
	end
	
	Swordsman.state = "IDLE"
	Swordsman.animation = 1
	
	Swordsman.updateAnimation = function(self,dt)
		if self.state == "IDLE" then
			self.animation = 1
		elseif self.state == "ATTACK" then
			self.graphics.currentTime = self.graphics.currentTime + dt
			if self.graphics.currentTime >= self.graphics.duration then
			    self.graphics.currentTime = self.graphics.currentTime - self.graphics.duration
			end
			
			self.animation = math.floor(self.graphics.currentTime / self.graphics.duration * #self.graphics.quads) + 1
			if self.animation == 3 then
				self.state = "IDLE"
				self.graphics.currentTime = 0
			end
		end
	end

	return Swordsman

end

