local selected_pchar = ''
local selected_lvl = ''

function _SCENARIO_SELECT_LOAD()

	--Keybindings
	love.keypressed = _SCENARIO_SELECT_KEYBINDINGS

	--Background
	background = {}
	background.graphics = love.graphics.newImage("resources/menu/titlebackground.png")

	--Menu windows
	selected_window = {}
	selected_window.graphics = love.graphics.newImage("resources/selected.png")
	selected_window.lock = function(self)
		selected_window.graphics = love.graphics.newImage("resources/selectedlocked.png")
	end
	selected_window.unlock = function(self)
		selected_window.graphics = love.graphics.newImage("resources/selected.png")
	end

	function goToMainMenu()
			change_state(1)
	end

	--Character selection section
	characters_window = {}
	characters_window.name = "Characters Window"
	characters_window.graphics =  love.graphics.newImage("resources/selectcharacter.png")
	characters_window.x = 0
	characters_window.y = 2
	characters_window.selected = false
	characters_window.trigger = function(self)
		selected_window.lock()
		selected_character.unlock()
		currently_selected = selected_pchar
		currently_selected.selected = true
	end
	characters_window.back = goToMainMenu

	--Level selection section
	level_window = {}
	level_window.name = "Levels window"
	level_window.graphics =  love.graphics.newImage("resources/selectlevel.png")
	level_window.x = 8
	level_window.y = 2
	level_window.selected = false
	level_window.trigger = function(self)
		selected_window.lock()
		selected_level.unlock()
		currently_selected = selected_lvl
		currently_selected.selected = true
	end
	level_window.back = goToMainMenu

	--Fight button
	fight = {}
	fight.graphics = love.graphics.newImage("resources/fightbutton.png")
	fight.quad = love.graphics.newQuad(0,0,160,100,fight.graphics:getDimensions())
	fight.quadSelected = love.graphics.newQuad(160,0,160,100,fight.graphics:getDimensions())
	fight.selected = false
	fight.x = 7
	fight.y = 7
	fight.adjustY = 40
	fight.trigger = function(self)
		createBattle(selected_pchar.name)
		change_state(3)
	end

	--Menu movement
	characters_window.right = level_window
	characters_window.down = fight
	level_window.left = characters_window
	level_window.down = fight
	fight.up = characters_window
	fight.left = characters_window
	fight.right = level_window

	--Character Select
	selected_character = {}
	selected_character.graphics = love.graphics.newImage("resources/frameselected.png")
	selected_character.lock = function(self)
		selected_character.graphics = love.graphics.newImage("resources/frameselectedlocked.png")
	end
	selected_character.unlock = function(self)
		selected_character.graphics = love.graphics.newImage("resources/frameselected.png")
	end

	--Level select
	selected_level = {}
	selected_level.graphics = love.graphics.newImage("resources/frameselected.png")
	selected_level.lock = function(self)
		selected_level.graphics = love.graphics.newImage("resources/frameselectedlocked.png")
	end
	selected_level.unlock = function(self)
		selected_level.graphics = love.graphics.newImage("resources/frameselected.png")
	end

	--Draw selectable playable characters
	characters_drawables = {}
	init_x = characters_window.x + 1
	init_y = characters_window.y + 1
	x = init_x
	y = init_y

	list_char = {}

	row = 0
	column = 0
	last_pchar = nil
	for name,value in ipairs(playable) do
		frame = {}
		frame.graphics = love.graphics.newImage("resources/frame.png")
		frame.x = x
		frame.y = y
		frame.adjustX = column * 50
		frame.adjustY = row * 30
		if value ~= "empty" then
			pchar = {}
			pchar.name = value
			pchar.selected = false
			pchar.trigger = function(self)
					selected_character.lock()
					selected_window.unlock()
					selected_pchar = self
					currently_selected = characters_window
					currently_selected.selected = true
			end
			pchar.graphics = love.graphics.newImage("resources/characters/"..value..".png")
			pchar.quad = love.graphics.newQuad(0,0,80,80,pchar.graphics:getDimensions())
			pchar.x = x
			pchar.y = y
			pchar.adjustX = column * 50 + 13
			pchar.adjustY = row * 30 + 4
			if(last_pchar ~= nil) then
				last_pchar.right = pchar
				pchar.left = last_pchar
			end
			last_pchar = pchar
		end

		x = x + 1
		column = column + 1
		if x > init_x + 3 then
			x = init_x
			column = 0
			y = y + 1
			row = row + 1
		end

		table.insert(characters_drawables,frame)
		table.insert(characters_drawables,pchar)

		table.insert(list_char,pchar)

	end

	--Draw selectable playable characters
	levels_drawables = {}
	init_x_lvl = level_window.x + 1
	init_y_lvl = level_window.y + 1
	x = init_x_lvl
	y = init_y_lvl

	list_lvl = {}

	row = 0
	column = 0
	last_lvl = nil
	for name,value in ipairs(levels) do
		frame = {}
		frame.graphics = love.graphics.newImage("resources/frame.png")
		frame.x = x
		frame.y = y
		frame.adjustX = column * 50
		frame.adjustY = row * 30
		if value ~= "empty" then
			lvl = {}
			lvl.name = value
			lvl.selected = false
			lvl.trigger = function(self)
					selected_level.lock()
					selected_window.unlock()
					selected_lvl = self
					currently_selected = level_window
					currently_selected.selected = true
			end
			lvl.graphics = love.graphics.newImage("resources/enemies/"..value..".png")
			lvl.quad = love.graphics.newQuad(0,0,80,80,pchar.graphics:getDimensions())
			lvl.x = x
			lvl.y = y
			lvl.adjustX = column * 50 + 13
			lvl.adjustY = row * 30 + 4
			if(last_lvl ~= nil) then
				last_lvl.right = lvl
				lvl.left = last_lvl
			end
			last_lvl = lvl
		end

		x = x + 1
		column = column + 1
		if x > init_x_lvl + 3 then
			x = init_x_lvl
			column = 0
			y = y + 1
			row = row + 1
		end

		table.insert(levels_drawables,frame)
		table.insert(levels_drawables,lvl)

		table.insert(list_lvl,lvl)

	end



	--Initialize menu

	--Default position cursor
	currently_selected = characters_window
	characters_window.selected = true
	--Default character selected
	selected_character.lock()
	selected_pchar = list_char[1]
	list_char[1].selected = true
	--Default level selected
	selected_level.lock()
	selected_lvl = list_lvl[1]
	list_lvl[1].selected = true

end

function _SCENARIO_SELECT_UPDATE(dt)

end

function _SCENARIO_SELECT_DRAW()

	love.graphics.draw(background.graphics, 0, 0)
	love.graphics.draw(characters_window.graphics, characters_window.x * cellSize, characters_window.y * cellSize)
	if(characters_window.selected) then
			love.graphics.draw(selected_window.graphics, characters_window.x * cellSize, characters_window.y * cellSize)
	elseif(level_window.selected) then
			love.graphics.draw(selected_window.graphics, level_window.x * cellSize, level_window.y * cellSize)
	end
	love.graphics.draw(level_window.graphics, level_window.x * cellSize, level_window.y * cellSize)

	draw_x = init_x * cellSize
	for index,value in ipairs(characters_drawables) do
		if value.quad == nil then
			love.graphics.draw(value.graphics, value.x * cellSize + value.adjustX, value.y * cellSize + value.adjustY)
		else
			love.graphics.draw(value.graphics, value.quad, value.x * cellSize + value.adjustX, value.y * cellSize + value.adjustY)
		end

		if value.selected == true then
			love.graphics.draw(selected_character.graphics, value.x * cellSize + value.adjustX, value.y * cellSize + value.adjustY, 0, 1, 1, 24, 12)
		end

		draw_x = draw_x + 120
	end

	draw_x = init_x_lvl * cellSize
	for index,value in ipairs(levels_drawables) do
		if value.quad == nil then
			love.graphics.draw(value.graphics, value.x * cellSize + value.adjustX, value.y * cellSize + value.adjustY)
		else
			love.graphics.draw(value.graphics, value.quad, value.x * cellSize + value.adjustX, value.y * cellSize + value.adjustY)
		end

		if value.selected == true then
			love.graphics.draw(selected_level.graphics, value.x * cellSize + value.adjustX, value.y * cellSize + value.adjustY, 0, 1, 1, 24, 12)
		end

		draw_x = draw_x + 120
	end
	if fight.selected == false then
		love.graphics.draw(fight.graphics, fight.quad, fight.x * cellSize, fight.y * cellSize + fight.adjustY)
	else
		love.graphics.draw(fight.graphics, fight.quadSelected, fight.x * cellSize, fight.y * cellSize + fight.adjustY)
	end
end


_SCENARIO_SELECT_KEYBINDINGS = function(key)
	if key == "right" then
		if(currently_selected.right ~= nil) then
			currently_selected.selected = false
			currently_selected = currently_selected.right
			currently_selected.selected = true
		end
	end
	if key == "left" then
		if(currently_selected.left ~= nil) then
			currently_selected.selected = false
			currently_selected = currently_selected.left
			currently_selected.selected = true
		end
	end
	if key == "down" then
		if(currently_selected.down ~= nil) then
			currently_selected.selected = false
			currently_selected = currently_selected.down
			currently_selected.selected = true
		end
	end
	if key == "up" then
		if(currently_selected.up ~= nil) then
			currently_selected.selected = false
			currently_selected = currently_selected.up
			currently_selected.selected = true
		end
	end
	if key == "return" then
		print(currently_selected.name)
		currently_selected:trigger()
	end
	if key == "escape" then
		currently_selected.back()
	end
end
