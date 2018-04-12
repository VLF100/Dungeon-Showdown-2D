function _CHARACTER_SELECT_LOAD()
	love.keypressed = _CHARACTER_SELECT_KEYBINDINGS
end

function _CHARACTER_SELECT_UPDATE(dt)
	player.act_y = player.act_y - ((player.act_y - player.grid_y) * player.speed * dt)
	player.act_x = player.act_x - ((player.act_x - player.grid_x) * player.speed * dt)
end
 
function _CHARACTER_SELECT_DRAW()
	love.graphics.rectangle("fill", player.act_x, player.act_y, 50, 50)
end


_CHARACTER_SELECT_KEYBINDINGS = function(key)
	if key == "up" then
		player.grid_y = player.grid_y - 50
	elseif key == "down" then
		player.grid_y = player.grid_y + 50
	elseif key == "left" then
		player.grid_x = player.grid_x - 50
	elseif key == "right" then
		player.grid_x = player.grid_x + 50
	end
end