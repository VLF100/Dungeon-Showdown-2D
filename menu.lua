function _MENU_UPDATE(dt)
	if love.keyboard.isDown("right") then
   		x = x + 100 * dt
	end
	if love.keyboard.isDown("left") then
	    x = x - 100 * dt
	end
	if love.keyboard.isDown("up") then
	    y = y - 100 * dt
	end
	if love.keyboard.isDown("down") then
	    y = y + 100 * dt
	end
end

function _MENU_DRAW(dt)
    love.graphics.setColor(0, 100, 100)
    love.graphics.rectangle("fill", x, y, w, h)
end