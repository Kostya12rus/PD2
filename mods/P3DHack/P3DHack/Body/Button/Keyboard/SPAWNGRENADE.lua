if P3DGroup_P3DHack.Grenade_Spawn then	
	if inGame() and isPlaying() and isHost() and not inChat() then			
		local grenades = {
			"frag",
			"launcher_frag",
			"rocket_frag",
			"molotov",
			"launcher_incendiary",
			"launcher_frag_m32",
			"wpn_prj_four",
			"wpn_prj_ace",
			"wpn_prj_jav",
		}	
		-- GRENADE SPAWNER
		local grenade_entry
		local player_unit = managers.player:player_unit()
		local owner_peer_id = managers.network:session():local_peer():id()
		local from = managers.player:player_unit():movement():m_head_pos()
		local pos = from + managers.player:player_unit():movement():m_head_rot():y() * 30 + Vector3(0, 0, 0)
		local dir = managers.player:player_unit():movement():m_head_rot():y()
		if (P3DGroup_P3DHack.Grenade_Spawn_Type == 'Random_Projectile') then
			grenade_entry = grenades[math.random(#grenades)]
		else	
			grenade_entry = P3DGroup_P3DHack.Grenade_Spawn_Type
		end
		local tweak_entry = tweak_data.blackmarket.projectiles[grenade_entry]
		-- Unkn0wn Ch3ats
		local unit_name = Idstring(tweak_data.blackmarket.projectiles[grenade_entry].unit)
		local unit = World:spawn_unit(unit_name, pos, Rotation(dir, math.UP))
		if owner_peer_id and managers.network:session() then
			local peer = managers.network:session():peer(owner_peer_id)
			local thrower_unit = peer and peer:unit()
			if alive(thrower_unit) then
				unit:base():set_thrower_unit(thrower_unit)
				if not tweak_entry.throwable and thrower_unit:movement() and thrower_unit:movement():current_state() then
					unit:base():set_weapon_unit(thrower_unit:movement():current_state()._equipped_unit)
				end
			end
		end
		local say_line = tweak_entry.throw_shout or "g43"
		if say_line and say_line ~= true then
			managers.player:player_unit():sound():play(say_line, nil, true)
		end
		unit:base():throw({dir = dir, grenade_entry = grenade_entry})
		managers.network:session():send_to_peers_synched("sync_throw_projectile", unit:id() ~= -1 and unit or nil, pos, dir, grenade_entry, owner_peer_id or 0)
		if tweak_data.blackmarket.projectiles[grenade_entry].impact_detonation then
			unit:damage():add_body_collision_callback(callback(unit:base(), unit:base(), "clbk_impact"))
			unit:base():create_sweep_data()
		end
	end
end

