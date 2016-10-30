dofile(ModPath .."P3DHack/Head/Config_(P3DGroup).lua")

if P3DGroup_P3DHack.Restart_Pro_Job then	
	function MenuCallbackHandler:_restart_level_visible()
		if not self:is_multiplayer() or managers.job:stage_success() then
			return false
		end
		local state = game_state_machine:current_state_name()
		return state ~= "ingame_waiting_for_players" and state ~= "ingame_lobby_menu" and state ~= "empty"
	end

	function MenuCallbackHandler:singleplayer_restart()
		return self:is_singleplayer() and self:has_full_game() and not managers.job:stage_success()
	end
end