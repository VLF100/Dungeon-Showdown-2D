function _MENU_LOAD()

	buttonsDeclaration = {
		"startbutton",
		"aboutbutton",
		"exitbutton"
	}

	buttonslist = {}
	
	menu_position_x = 13
	menu_position_y = 5
	
	for index,name in pairs(buttonsDeclaration) do 
		button = {}
		button.graphics = {}
		button.graphics.spritesheet = love.graphics.newImage("resources/menu/"..name..".png")
		button.graphics.quads = {}
		
		button.graphics.quads[1] = love.graphics.newQuad(0, 0, 170, 80, button.graphics.spritesheet:getDimensions())
		button.graphics.quads[2] = love.graphics.newQuad(0, 80, 170, 80, button.graphics.spritesheet:getDimensions())
		
		button.graphics.duration = 1.2
		button.graphics.currentTime = 0
		button.graphics.state = 1
		
		button.marked = false
		button.x = menu_position_x
		button.y = menu_position_y
		
		menu_position_y = menu_position_y + 1
		
		table.insert(buttonslist,button)
		
	end
	
	title = {}
	title.graphics = love.graphics.newImage("resources/menu/title.png")
	title.x = 0
	title.y = 0
	
	currentlyMarked = 1
	buttonslist[currentlyMarked].marked = true

	love.keypressed = _MENU_KEYBINDINGS
	
end

function _MENU_UPDATE(dt)

	for index,button in pairs(buttonslist) do 
	
		if button.marked == true then
		
			button.graphics.currentTime = button.graphics.currentTime + dt
			
			if button.graphics.currentTime >= button.graphics.duration then
				button.graphics.currentTime = button.graphics.currentTime - button.graphics.duration
			end

			button.graphics.state = math.floor(button.graphics.currentTime / button.graphics.duration * #button.graphics.quads) + 1
			
		else
			button.graphics.state = 1
		end
		
	end
	
end

function _MENU_DRAW(dt)

	love.graphics.draw(title.graphics, title.x * cellSize, title.y * cellSize)

	for index,button in pairs(buttonslist) do 
		love.graphics.draw(button.graphics.spritesheet, button.graphics.quads[button.graphics.state], button.x * cellSize, button.y * cellSize)
	end
end

_MENU_KEYBINDINGS = function(key)
	if key == "down" then
		if currentlyMarked < table.getn(buttonslist) then 
			buttonslist[currentlyMarked].marked = false
			buttonslist[currentlyMarked+1].marked = true
			currentlyMarked = currentlyMarked + 1
		end
	end
	if key == "up" then
		if currentlyMarked > 1 then 
			buttonslist[currentlyMarked].marked = false
			buttonslist[currentlyMarked-1].marked = true
			currentlyMarked = currentlyMarked - 1
		end
	end
end