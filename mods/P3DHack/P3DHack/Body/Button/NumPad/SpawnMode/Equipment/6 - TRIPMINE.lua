if inGame() and isPlaying() and isHost() then
	-- TRIPMINE SPAWNER
	local from = managers.player:player_unit():movement():m_head_pos()
	local to = from + managers.player:player_unit():movement():m_head_rot():y() * 999999
	local ray = managers.player:player_unit():raycast("ray", from, to, "slot_mask", managers.slot:get_mask("trip_mine_placeables"), "ignore_unit", {})
	local position = get_crosshair_ray().hit_position
	local rotation = Rotation( ray.normal, math.UP )
	local peer_id = managers.network:session():local_peer():id()
	local sensor_upgrade = managers.player:has_category_upgrade("trip_mine", "sensor_toggle")
	local unit = World:spawn_unit(Idstring("units/payday2/equipment/gen_equipment_tripmine/gen_equipment_tripmine"), position, rotation)
	managers.network:session():send_to_peers_synched("sync_trip_mine_setup", unit, sensor_upgrade, peer_id or 0)
	unit:base():setup(sensor_upgrade)
	unit:base():set_active(true, managers.player:player_unit())
end