
require "characters_controllers/common_player"

function generate_swordsman(init_x,init_y)

	Swordsman = getPlayableCharacter(init_x,init_y)

	Swordsman.graphics = newAnimation(love.graphics.newImage("resources/characters/swordsman.png"), 80, 63, 0.25)

	Swordsman.startTurn = function(self)
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

					if self.animation == 3 then
						self.state = "IDLE"
						self.graphics.currentTime = 0
					end
			end

			self.animation = math.floor(self.graphics.currentTime / self.graphics.duration * #self.graphics.quads) + 1

		end
	end

	return Swordsman

end
