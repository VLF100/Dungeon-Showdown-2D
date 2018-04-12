local state = 0 --Global state of the game

function love.load()

	flags = {}
	flags["fullscreen"] = false
	flags["centered"] = true
	love.window.setMode(1280, 720, flags)
	screen_width = love.graphics.getWidth()
	screen_height = love.graphics.getHeight()

	love.window.setMode(screen_width, screen_height-30, flags)

    x, y, w, h = 20, 20, 60, 20

    states={}
    states[1] = "_MENU_"				require "menu"
    states[2] = "_CHARACTER_SELECT_"	require "character_select"
    states[3] = "_LEVEL_SELECT_"

    levels={}
    levels[1] = "_LEVEL_1_"
    levels[2] = "_LEVEL_2_"
    levels[3] = "_LEVEL_3_"

    player = {
		grid_x = 256,
		grid_y = 256,
		act_x = 200,
		act_y = 200,
		speed = 10
	}

	first_state = 1
	change_state(first_state)
end
 
function love.update(dt)
	_G[states[actual].."UPDATE"](dt)
end
 
function love.draw()
	_G[states[actual].."DRAW"]()
end

function change_state(next_state)
	_G[states[next_state].."LOAD"]()
	actual = next_state
end