function _CHARACTER_SELECT_LOAD()
	love.keypressed = _CHARACTER_SELECT_KEYBINDINGS
	player_sprite = love.graphics.newImage("resources/sprites.png")

	quads={}
	quads["orange_quad"] = love.graphics.newQuad( 1, 0, 49, 49, 150, 150 )
	quads["red_quad"] = love.graphics.newQuad( 51, 0, 49, 49, 150, 150 )
	quads["blue_quad"] = love.graphics.newQuad( 101, 0, 50, 50, 150, 150 )

	actual_quad=quads["orange_quad"]


	player = {
		grid_x = 256,
		grid_y = 256,
		act_x = 200,
		act_y = 200,
		speed = 10
	}
end

function _CHARACTER_SELECT_UPDATE(dt)
	player.act_y = player.act_y - ((player.act_y - player.grid_y) * player.speed * dt)
	player.act_x = player.act_x - ((player.act_x - player.grid_x) * player.speed * dt)
end

function _CHARACTER_SELECT_DRAW()
	love.graphics.setColor(255,255,255,255);
	love.graphics.draw(player_sprite,actual_quad,  player.act_x, player.act_y)
end


_CHARACTER_SELECT_KEYBINDINGS = function(key)
	if key == "up" then
		player.grid_y = player.grid_y - 50
		actual_quad=quads["orange_quad"]
	elseif key == "down" then
		player.grid_y = player.grid_y + 50
		actual_quad=quads["orange_quad"]
	elseif key == "left" then
		player.grid_x = player.grid_x - 50
		actual_quad=quads["blue_quad"]
	elseif key == "right" then
		player.grid_x = player.grid_x + 50
		actual_quad=quads["red_quad"]
	end
end
