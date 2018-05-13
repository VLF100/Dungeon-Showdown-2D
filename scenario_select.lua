local player_selected = ''
local level_selected = ''

function _SCENARIO_SELECT_LOAD()
	love.keypressed = _SCENARIO_SELECT_KEYBINDINGS

	characters_window = {}
	characters_window.graphics =  love.graphics.newImage("resources/selectcharacter.png")
	characters_window.x = 0
	characters_window.y = 2
	level_window = {}
	level_window.graphics =  love.graphics.newImage("resources/selectlevel.png")
	level_window.x = 8
	level_window.y = 2

end

function _SCENARIO_SELECT_UPDATE(dt)

end

function _SCENARIO_SELECT_DRAW()

	love.graphics.draw(characters_window.graphics, characters_window.x * cellSize, characters_window.y * cellSize)
	love.graphics.draw(level_window.graphics, level_window.x * cellSize, level_window.y * cellSize)

end


_SCENARIO_SELECT_KEYBINDINGS = function(key)

end
