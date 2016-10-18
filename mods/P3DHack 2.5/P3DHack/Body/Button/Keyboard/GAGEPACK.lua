-- BY BALDWIN
if P3DGroup_P3DHack.Gage_Package then	
	if isPlaying() and not inChat() then
		if isHost() then
			function tweak_data.gage_assignment:get_num_assignment_units() --Patches limit on spawning units. World:spawn_unit somehow obey this value.
				return 9999
			end
			local id_table = {
				Idstring("units/pd2_dlc_gage_jobs/pickups/gen_pku_gage_green/gen_pku_gage_green"),
				Idstring("units/pd2_dlc_gage_jobs/pickups/gen_pku_gage_yellow/gen_pku_gage_yellow"),
				Idstring("units/pd2_dlc_gage_jobs/pickups/gen_pku_gage_red/gen_pku_gage_red"),
				Idstring("units/pd2_dlc_gage_jobs/pickups/gen_pku_gage_blue/gen_pku_gage_blue"),
				Idstring("units/pd2_dlc_gage_jobs/pickups/gen_pku_gage_purple/gen_pku_gage_purple"),
				}
			local pos = get_crosshair_pos()
			local rot = Rotation(managers.player:local_player():movement():m_head_rot():yaw(),0,0)
			if not pos or not rot then
				return
			end
			World:spawn_unit(id_table[math.random(5)], pos, rot)
		else
			showHint("Только хост",2)
		end 
	end
end