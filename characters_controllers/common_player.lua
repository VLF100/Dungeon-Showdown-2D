
function getPlayableCharacter(init_x,init_y)

	PlayerCharacter = {}
	PlayerCharacter.currentPos = {x = init_x, y = init_y}
	PlayerCharacter.startTurn = nil
	PlayerCharacter.endTurn = nil

	return PlayerCharacter

end


