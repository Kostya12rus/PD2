if P3DGroup_P3DHack.Restart_Job then	
	if isHost() and inGame() and not inChat() then
		local Unknown_Cheats = true
		for k,v in pairs(managers.network:session():peers()) do
			if not v:synched() then
				Unknown_Cheats = false
			end
		end
		if Unknown_Cheats then
			managers.game_play_central:restart_the_game()
		else
		end
	end
end