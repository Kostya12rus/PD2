if inGame() and isPlaying() and isHost() then
	-- SPAWN GRENADE CASE	
	local position = get_crosshair_ray().hit_position
	local rotation = Rotation(managers.player:local_player():movement():m_head_rot():yaw(),0,0)
	local unit_name = "units/payday2/equipment/gen_equipment_grenade_crate/gen_equipment_grenade_crate"
	local unit = World:spawn_unit(Idstring(unit_name), position, rotation)
	managers.network:session():send_to_peers_synched("sync_unit_event_id_16", unit, "sync", 1)
end