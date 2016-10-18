if inGame() and isPlaying() and isHost() then
	-- AMMO BAG SPAWNER
	local position = get_crosshair_ray().hit_position
	local rotation = Rotation(managers.player:local_player():movement():m_head_rot():yaw(),0,0)
	local peer_id = managers.network:session():local_peer():id()
	local ammo_upgrade_lvl = managers.player:upgrade_level("ammo_bag", "ammo_increase")
	local unit_name = "units/payday2/equipment/gen_equipment_ammobag/gen_equipment_ammobag"
	local unit = World:spawn_unit(Idstring(unit_name), position, rotation, ammo_upgrade_lvl)
	managers.network:session():send_to_peers_synched("sync_equipment_setup", unit, ammo_upgrade_lvl, peer_id or 0)
	unit:base():setup(ammo_upgrade_lvl)
end