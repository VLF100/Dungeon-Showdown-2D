
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

		button.trigger = _G[name.."_trigger"]

		menu_position_y = menu_position_y + 1

		table.insert(buttonslist,button)

	end

	title = {}
	title.graphics = love.graphics.newImage("resources/menu/title.png")
	title.x = 0
	title.y = 0

	background = {}
	background.graphics = love.graphics.newImage("resources/menu/titlebackground.png")

	currentlyMarked = 1
	buttonslist[currentlyMarked].marked = true

	about = {}
	about.text = 	"Dungeon Showdown by Valkyrio100\n"..
					"Credits:\n"..
					"\tGraphics \"Dungeon Tileset\" by 0x72\n"..
					"\tFont \"VCR OSD Mono\" made by Riciery Leal(mrmanet)\n"..
					"\tMusic \"8bit Dungeon Level\" by Kevin MacLeod\n"

	about.enabled = false

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

	love.graphics.draw(background.graphics, 0, 0)

	love.graphics.draw(title.graphics, title.x * cellSize, title.y * cellSize)

	for index,button in pairs(buttonslist) do
		love.graphics.draw(button.graphics.spritesheet, button.graphics.quads[button.graphics.state], button.x * cellSize, button.y * cellSize)
	end

	if about.enabled == true then

		love.graphics.setColor(0.1882, 0.1137, 0.1529, 0.6)
		love.graphics.rectangle("fill", 1 * cellSize - 20, 5 * cellSize - 20, 8 * cellSize, 3 * cellSize + 50 )

		love.graphics.setColor(255,255,255,255)
		love.graphics.print(about.text, 1 * cellSize, 5 * cellSize)


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
	if key == "return" then
		buttonslist[currentlyMarked].trigger()
	end
end

--BUTTONS FUNCTIONS

function startbutton_trigger()
	change_state(2)
end

function aboutbutton_trigger()
	about.enabled = not about.enabled
end

function exitbutton_trigger()
	love.event.quit(0)
end
