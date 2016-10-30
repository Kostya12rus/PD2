if inGame() and isPlaying() and isHost() then
	-- DOCTOR BAG SPAWNER
	local position = get_crosshair_ray().hit_position
	local rotation = Rotation(managers.player:local_player():movement():m_head_rot():yaw(),0,0)
	local amount_upgrade_lvl = managers.player:upgrade_level("doctor_bag", "amount_increase")
	local peer_id = managers.network:session():local_peer():id()
	local unit_name = "units/payday2/equipment/gen_equipment_medicbag/gen_equipment_medicbag"
	local unit = World:spawn_unit(Idstring(unit_name), position, rotation)
	managers.network:session():send_to_peers_synched("sync_equipment_setup", unit, amount_upgrade_lvl, peer_id or 0)
	unit:base():setup(amount_upgrade_lvl)
end
	
