if inGame() and isPlaying() and isHost() and not inChat() then
	if Global.level_data.level_id == "branchbank_prof" or Global.level_data.level_id == "branchbank_cash" or Global.level_data.level_id == "branchbank_gold_prof" or Global.level_data.level_id == "roberts" or Global.level_data.level_id == "gallery" or Global.level_data.level_id == "arm_for" or Global.level_data.level_id == "firestarter_1" or Global.level_data.level_id == "firestarter_3" or Global.level_data.level_id == "watchdogs_2" or Global.level_data.level_id == "pbr" or Global.level_data.level_id == "crojob2" or Global.level_data.level_id == "crojob1" or Global.level_data.level_id == "crojob2_night" or Global.level_data.level_id == "mus" or Global.level_data.level_id == "hox_3" or Global.level_data.level_id == "welcome_to_the_jungle_2" or Global.level_data.level_id == "framing_frame_1" or Global.level_data.level_id == "election_day_1" or Global.level_data.level_id == "election_day_2" or Global.level_data.level_id == "jolly" or Global.level_data.level_id == "peta" or Global.level_data.level_id == "shoutout_raid" or Global.level_data.level_id == "pines" then
		local pos = get_crosshair_pos()
		local rr = math.random(-180,180)
		local rot = Rotation(rr)
		if not pos or not rot then
			return
		end
		World:spawn_unit(Idstring("units/payday2/vehicles/air_vehicle_blackhawk/vehicle_blackhawk"), pos, rot)
	else
		showHint("Недоступно здесь", 2)
	end
end
