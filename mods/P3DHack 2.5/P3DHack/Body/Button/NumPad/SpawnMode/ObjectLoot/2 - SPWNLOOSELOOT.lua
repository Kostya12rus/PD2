------------------------------------------------
--------- RANDOM LOOT TO PICK UP v1.3 ----------
------------- By PierreDjays -------------------
-----  Fixed/Add/Cleanup By: Sirgoodsmoke ------
------------------------------------------------
spawnloose01 = spawnloose01 or function()
	local id_table = {	
	Idstring("units/payday2/props/bnk_prop_vault_loot/bnk_prop_vault_loot_value_a"),
	Idstring("units/payday2/props/bnk_prop_vault_loot/bnk_prop_vault_loot_value_b"),
	Idstring("units/payday2/props/bnk_prop_vault_loot/bnk_prop_vault_loot_value_c"),
	Idstring("units/payday2/props/bnk_prop_vault_loot/bnk_prop_vault_loot_value_d"),
	Idstring("units/payday2/props/bnk_prop_vault_loot/bnk_prop_vault_loot_value_e"),
	Idstring("units/payday2/props/gen_prop_bank_atm_standing/gen_prop_bank_atm_standing_spawn")
	}
	local pos = get_crosshair_pos()
	local rot = Rotation(managers.player:local_player():movement():m_head_rot():yaw(),0,0)
	if not pos or not rot then
		return
	end
	World:spawn_unit(id_table[math.random(6)], pos, rot)
end

spawnloose02 = spawnloose02 or function()
	local id_table = {	
	Idstring("units/payday2/props/com_prop_jewelry_jewels/com_prop_jewelry_box_01"),
    Idstring("units/payday2/props/com_prop_jewelry_jewels/com_prop_jewelry_box_02"),
    Idstring("units/payday2/props/com_prop_jewelry_jewels/com_prop_jewelry_box_03")
	}
	local pos = get_crosshair_pos()
	local rot = Rotation(managers.player:local_player():movement():m_head_rot():yaw(),0,0)
	if not pos or not rot then
		return
	end
	World:spawn_unit(id_table[math.random(3)], pos, rot)
end

spawnloose03 = spawnloose03 or function()
	local id_table = {	
	Idstring("units/payday2/props/bnk_prop_vault_loot/bnk_prop_vault_loot_value_c"),
	Idstring("units/payday2/props/bnk_prop_vault_loot/bnk_prop_vault_loot_value_d"),
	Idstring("units/payday2/props/bnk_prop_vault_loot/bnk_prop_vault_loot_value_e"),
	Idstring("units/world/props/diamondheist_diamond_pickups/diamond_pickup_02")
	}
	local pos = get_crosshair_pos()
	local rot = Rotation(managers.player:local_player():movement():m_head_rot():yaw(),0,0)
	if not pos or not rot then
		return
	end
	World:spawn_unit(id_table[math.random(4)], pos, rot)
end

spawnloose04 = spawnloose04 or function()
	local id_table = {	
	Idstring("units/payday2/props/bnk_prop_vault_loot/bnk_prop_vault_loot_value_a"),
	Idstring("units/payday2/props/bnk_prop_vault_loot/bnk_prop_vault_loot_value_b"),
	Idstring("units/payday2/props/bnk_prop_vault_loot/bnk_prop_vault_loot_value_c"),
	Idstring("units/payday2/props/bnk_prop_vault_loot/bnk_prop_vault_loot_value_d"),
	Idstring("units/payday2/props/bnk_prop_vault_loot/bnk_prop_vault_loot_value_e")
	}
	local pos = get_crosshair_pos()
	local rot = Rotation(managers.player:local_player():movement():m_head_rot():yaw(),0,0)
	if not pos or not rot then
		return
	end
	World:spawn_unit(id_table[math.random(8)], pos, rot)
end

spawnloose05 = spawnloose05 or function()
	local pos = get_crosshair_pos()
	local rot = Rotation(managers.player:local_player():movement():m_head_rot():yaw(),0,0)
	if not pos or not rot then
		return
	end
	World:spawn_unit(Idstring("units/payday2/props/gen_prop_methlab_meth/gen_prop_methlab_meth"), pos, rot)
end

spawnloose06 = spawnloose06 or function()
	local pos = get_crosshair_pos()
	local rot = Rotation(managers.player:local_player():movement():m_head_rot():yaw(),0,0)
	if not pos or not rot then
		return
	end
	World:spawn_unit(Idstring("units/payday2/props/bnk_prop_vault_loot/bnk_prop_vault_loot_special_money"), pos, rot)
end

spawnloose07 = spawnloose07 or function()
	local pos = get_crosshair_pos()
	local rot = Rotation(managers.player:local_player():movement():m_head_rot():yaw(),0,0)
	if not pos or not rot then
		return
	end
	World:spawn_unit(Idstring("units/payday2/equipment/gen_interactable_weapon_case_2x1/gen_interactable_weapon_case_2x1"), pos, rot)
end

spawnloose08 = spawnloose08 or function()
	local id_table = {	
	Idstring("units/payday2/props/bnk_prop_vault_loot/bnk_prop_vault_loot_special_money"),
	Idstring("units/payday2/pickups/gen_pku_cocaine/gen_pku_cocaine"),
	Idstring("units/payday2/equipment/gen_interactable_weapon_case_2x1/gen_interactable_weapon_case_2x1")
	}
	local pos = get_crosshair_pos()
	local rot = Rotation(managers.player:local_player():movement():m_head_rot():yaw(),0,0)
	if not pos or not rot then
		return
	end
	World:spawn_unit(id_table[math.random(3)], pos, rot)
end

spawnloose09 = spawnloose09 or function()
	local id_table = {   	
	Idstring("units/payday2/pickups/gen_pku_cocaine/gen_pku_cocaine"),
    Idstring("units/payday2/equipment/gen_interactable_weapon_case_2x1/gen_interactable_weapon_case_2x1"),
    Idstring("units/payday2/pickups/gen_pku_money/gen_pku_money"),
   	Idstring("units/payday2/pickups/gen_pku_gold/gen_pku_gold")
	}
	local pos = get_crosshair_pos()
	local rot = Rotation(managers.player:local_player():movement():m_head_rot():yaw(),0,0)
	if not pos or not rot then
		return
	end
	World:spawn_unit(id_table[math.random(4)], pos, rot)
end

spawnloose10 = spawnloose10 or function()
	local id_table = {	
	Idstring("units/payday2/props/bnk_prop_vault_loot/bnk_prop_vault_loot_value_a"),
	Idstring("units/payday2/props/bnk_prop_vault_loot/bnk_prop_vault_loot_value_b"),
	Idstring("units/payday2/props/bnk_prop_vault_loot/bnk_prop_vault_loot_value_c"),
	Idstring("units/payday2/props/bnk_prop_vault_loot/bnk_prop_vault_loot_value_d"),
	Idstring("units/payday2/props/bnk_prop_vault_loot/bnk_prop_vault_loot_value_e")
	}
	local pos = get_crosshair_pos()
	local rot = Rotation(managers.player:local_player():movement():m_head_rot():yaw(),0,0)
	if not pos or not rot then
		return
	end
	World:spawn_unit(id_table[math.random(5)], pos, rot)
end

spawnloose11 = spawnloose11 or function()
	local id_table = {	
	Idstring("units/payday2/props/com_prop_jewelry_jewels/com_prop_jewelry_box_01"),
    Idstring("units/payday2/props/com_prop_jewelry_jewels/com_prop_jewelry_box_02"),
	Idstring("units/payday2/props/com_prop_jewelry_jewels/com_prop_jewelry_box_04"),
    Idstring("units/payday2/props/com_prop_jewelry_jewels/com_prop_jewelry_box_03"),
	Idstring("units/payday2/props/bnk_prop_vault_loot/bnk_prop_vault_loot_special_money")
	}
	local pos = get_crosshair_pos()
	local rot = Rotation(managers.player:local_player():movement():m_head_rot():yaw(),0,0)
	if not pos or not rot then
		return
	end
	World:spawn_unit(id_table[math.random(5)], pos, rot)
end

spawnloose12 = spawnloose12 or function(id)
	local pos = get_crosshair_pos()
	local rot = Rotation(managers.player:local_player():movement():m_head_rot():yaw(),0,0)
	if not pos or not rot then
		return
	end
	World:spawn_unit(Idstring("units/payday2/pickups/gen_pku_cocaine/gen_pku_cocaine"), pos, rot)
end
-----------------------------------------------------------------------------------------------------------------------------------
if inGame() and isPlaying() and isHost() and not inChat() then	
	if managers.job:current_level_id() == "branchbank" then -- BANK HEIST
		spawnloose01()
	elseif managers.job:current_level_id() == "jewelry_store" then
		spawnloose02()
	elseif managers.job:current_level_id() == "roberts" then
		spawnloose04()	
	elseif managers.job:current_level_id() == "family" then
		spawnloose03()	
	elseif managers.job:current_level_id() == "arm_hcm" then -- DOWNTOWN
		spawnloose01()	
	elseif managers.job:current_level_id() == "arm_cro" then -- CROSSROADS
		spawnloose01()	
	elseif managers.job:current_level_id() == "arm_fac" then -- HARBOR
		spawnloose01()	
	elseif managers.job:current_level_id() == "arm_par" then -- PARK
		spawnloose01()	
	elseif managers.job:current_level_id() == "arm_und" then -- UNDERPASS
		spawnloose01()	
	elseif managers.job:current_level_id() == "alex_1" then
		spawnloose05()	
	elseif managers.job:current_level_id() == "alex_2" then
		spawnloose06()	
	elseif managers.job:current_level_id() == "four_stores" then
		spawnloose10()
	elseif managers.job:current_level_id() == "firestarter_1" then
		spawnloose07()
	elseif managers.job:current_level_id() == "firestarter_2" then
		spawnloose09()	
	elseif managers.job:current_level_id() == "firestarter_3" then
		spawnloose01()	
	elseif managers.job:current_level_id() == "welcome_to_the_jungle_1" then
		spawnloose08()	
	elseif managers.job:current_level_id() == "election_day_2" then
		spawnloose06()	
	elseif managers.job:current_level_id() == "election_day_3_skip1" then
		spawnloose06()	
	elseif managers.job:current_level_id() == "election_day_3_skip2" then
		spawnloose06()	
	elseif managers.job:current_level_id() == "mallcrasher" then
		spawnloose11()	
	elseif managers.job:current_level_id() == "ukrainian_job" then
		spawnloose02()	
	elseif managers.job:current_level_id() == "nightclub" then
		spawnloose12()
	else
		showHint("Спавн случайного лута [Недоступен здесь]", 2)	
	end
else
	showHint("Спавн случайного лута [Только хост]", 2)	
end