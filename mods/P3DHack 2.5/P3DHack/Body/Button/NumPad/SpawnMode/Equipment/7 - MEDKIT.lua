if inGame() and isPlaying() and isHost() then
	-- MEDKIT SPAWNER
	local position = get_crosshair_ray().hit_position
	local rotation = Rotation(managers.player:local_player():movement():m_head_rot():yaw(),0,0)
	local upgrade_lvl = managers.player:has_category_upgrade("first_aid_kit", "damage_reduction_upgrade") and 1 or 0
	local peer_id = managers.network:session():local_peer():id()
	local unit_name = "units/pd2_dlc_old_hoxton/equipment/gen_equipment_first_aid_kit/gen_equipment_first_aid_kit"
	local unit = World:spawn_unit(Idstring(unit_name), position, rotation)
	managers.network:session():send_to_peers_synched("sync_equipment_setup", unit, upgrade_lvl, peer_id or 0)
	unit:base():setup(upgrade_lvl)
end