-- INSTANT REVIVE ALL PLAYERS
if isPlaying() and not inChat() then
	InteractType({"free", "revive"})
	showHint("Союзники подняты", 2)
end