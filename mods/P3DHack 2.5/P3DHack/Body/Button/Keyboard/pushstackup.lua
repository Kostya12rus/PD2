-- CARRYSTACKER PLUGIN / PUSH STACK UP
if inGame() and isPlaying() and not inChat() then
	managers.player:rotate_stack("up")
else
end