
require "characters_controllers/common_player"

function generate_archer(init_x,init_y)

	Archer = getPlayableCharacter(init_x,init_y)

	Archer.graphics = newAnimation(love.graphics.newImage("resources/characters/archer.png"), 80, 80, 0.75)

	Archer.startTurn = function(self)
		love.keypressed = function(key)
			if key == "up" then
				if self.currentPos.y > 0 then
					self.currentPos.y = self.currentPos.y - 1
					return self:endTurn()
				end
			elseif key == "down" then
				if self.currentPos.y < maxCellY then
					self.currentPos.y = self.currentPos.y + 1
					return self:endTurn()
				end
			elseif key == "left" then
				if self.currentPos.x > 0 then
					self.currentPos.x = self.currentPos.x - 1
					return self:endTurn()
				end
			elseif key == "right" then
				if self.currentPos.x < maxCellX then
					self.currentPos.x = self.currentPos.x + 1
					return self:endTurn()
				end
			elseif key == "return" then
				self.state = "ATTACK"
				return self:endTurn()
			end
		end
	end

	Archer.endTurn = function()
		return nextTurn()
	end

	Archer.state = "IDLE"
	Archer.animation = 1

	Archer.updateAnimation = function(self,dt)
		if self.state == "IDLE" then
			self.animation = 1
		elseif self.state == "ATTACK" then
			self.graphics.currentTime = self.graphics.currentTime + dt
			if self.graphics.currentTime >= self.graphics.duration then
			    self.graphics.currentTime = self.graphics.currentTime - self.graphics.duration

					if self.animation == 2 then
						self.state = "IDLE"
						self.graphics.currentTime = 0
					end
			end

			self.animation = math.floor(self.graphics.currentTime / self.graphics.duration * #self.graphics.quads) + 1
		end
	end

	return Archer

end
