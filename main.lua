function love.load()
    x, y, w, h = 20, 20, 60, 20

    states={}
    states[1] = "_MENU_"				require "menu"
    states[2] = "_CHARACTER_SELECT_"
    states[3] = "_LEVEL_SELECT_"

    levels={}
    levels[1] = "_LEVEL_1_"
    levels[2] = "_LEVEL_2_"
    levels[3] = "_LEVEL_3_"

    actual = 1
end
 
function love.update(dt)
	_G[states[actual].."UPDATE"](dt)
end
 
function love.draw()
	_G[states[actual].."DRAW"]()
end

