-- CARRYSTACKER PLUGIN / PUSH STACK DOWN
if inGame() and isPlaying() and not inChat() then
	managers.player:rotate_stack()
else
end