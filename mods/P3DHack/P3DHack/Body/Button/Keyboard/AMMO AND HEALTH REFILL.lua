if P3DGroup_P3DHack.Full_Replenish then 	
	if isPlaying() and not inChat() then
		-- REPLENISH HEALTH AND AMMO
		local player = managers.player:player_unit()
		if alive(player) then
			player:base():replenish()
			showHint("Здоровье и патроны пополнены",2)
		end
		-- RESET PLAYER STATE
		managers.player:set_player_state( "standard" )
	end
end