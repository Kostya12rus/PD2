-----------------------------------------
--- RANDOM LOOT TO PICK UP --------------
---- By: PierreDjays v1.3 ---------------
--  Fixed/Add/Cleanup By: Sirgoodsmoke --
-----------------------------------------
spawn01 = spawn01 or function()	
	local id_table = { 
	Idstring("units/payday2/props/bnk_prop_vault_loot/bnk_prop_vault_loot_special_money"), -- CASH
	Idstring("units/payday2/props/bnk_prop_vault_loot/bnk_prop_vault_loot_special_gold"), -- GOLD
	Idstring("units/payday2/pickups/gen_pku_gold/gen_pku_gold"),
	Idstring("units/payday2/pickups/gen_pku_money/gen_pku_money")
	}
	local pos = get_crosshair_pos()
	local rot = Rotation(managers.player:local_player():movement():m_head_rot():yaw(),0,0)
	if not pos or not rot then
		return
	end
	local unit = World:spawn_unit(id_table[math.random(4)], pos, rot)
	if unit and unit:interaction() then
		unit:interaction():set_active(true, true)
	end
end

spawn02 = spawn02 or function()
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

spawn03 = spawn03 or function()
	local pos = get_crosshair_pos()
	local rot = Rotation(managers.player:local_player():movement():m_head_rot():yaw(),0,0)
	if not pos or not rot then
		return
	end
	World:spawn_unit(Idstring("units/payday2/props/bnk_prop_vault_loot/bnk_prop_vault_loot_special_money"), pos, rot)
end

spawn04 = spawn04 or function()
	local id_table = {	
	Idstring("units/payday2/props/bnk_prop_vault_loot/bnk_prop_vault_loot_special_money"), -- CASH
    Idstring("units/payday2/props/bnk_prop_vault_loot/bnk_prop_vault_loot_special_gold") -- GOLD
	}
	local pos = get_crosshair_pos()
	local rot = Rotation(managers.player:local_player():movement():m_head_rot():yaw(),0,0)
	if not pos or not rot then
		return
	end
	World:spawn_unit(id_table[math.random(2)], pos, rot)
end

spawn05 = spawn05 or function()
	local pos = get_crosshair_pos()
	local rot = Rotation(managers.player:local_player():movement():m_head_rot():yaw(),0,0)
	if not pos or not rot then
		return
	end
	World:spawn_unit(Idstring("units/payday2/props/gen_prop_methlab_meth/gen_prop_methlab_meth"), pos, rot)
end

spawn06 = spawn06 or function()
	local id_table = { 
	Idstring("units/payday2/props/bnk_prop_vault_loot/bnk_prop_vault_loot_special_money"),
	Idstring("units/payday2/pickups/gen_pku_bucket_of_money/gen_pku_bucket_of_money")
	}
	local pos = get_crosshair_pos()
	local rot = Rotation(managers.player:local_player():movement():m_head_rot():yaw(),0,0)
	if not pos or not rot then
		return
	end
	World:spawn_unit(id_table[math.random(2)], pos, rot)
end

spawn07 = spawn07 or function()
	local pos = get_crosshair_pos()
	local rot = Rotation(managers.player:local_player():movement():m_head_rot():yaw(),0,0)
	if not pos or not rot then
		return
	end
	World:spawn_unit(Idstring("units/payday2/equipment/gen_interactable_weapon_case_2x1/gen_interactable_weapon_case_2x1"), pos, rot)
end

spawn08 = spawn08 or function()
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

spawn09 = spawn09 or function()
    local id_table = {   
	Idstring("units/payday2/pickups/gen_pku_cocaine/gen_pku_cocaine"),
    Idstring("units/payday2/equipment/gen_interactable_weapon_case_2x1/gen_interactable_weapon_case_2x1")
	}
	local pos = get_crosshair_pos()
	local rot = Rotation(managers.player:local_player():movement():m_head_rot():yaw(),0,0)
	if not pos or not rot then
		return
	end
	World:spawn_unit(id_table[math.random(2)], pos, rot)
end

spawn10 = spawn10 or function()
	local pos = get_crosshair_pos()
	local rot = Rotation(managers.player:local_player():movement():m_head_rot():yaw(),0,0)
	if not pos or not rot then
		return
	end
	World:spawn_unit(Idstring("units/payday2/pickups/gen_pku_money_luggage/gen_pku_luggage_money_pile"), pos, rot)
end

spawn11 = spawn11 or function()
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

spawn12 = spawn12 or function()
	local pos = get_crosshair_pos()
	local rot = Rotation(managers.player:local_player():movement():m_head_rot():yaw(),0,0)
	if not pos or not rot then
		return
	end
	World:spawn_unit(Idstring("units/payday2/pickups/gen_pku_cocaine/gen_pku_cocaine"), pos, rot)
end
-------------------------------------------------------------------------------------------------------------------------------
if inGame() and isPlaying() and isHost() and not inChat() then		
	if managers.job:current_level_id() == "branchbank" then -- BANK HEIST
		spawn01()
	elseif managers.job:current_level_id() == "jewelry_store" then
		spawn02()
	elseif managers.job:current_level_id() == "roberts" then
		spawn04()
	elseif managers.job:current_level_id() == "family" then
		spawn03()	
	elseif managers.job:current_level_id() == "arm_hcm" then -- DOWNTOWN
		spawn01()	
	elseif managers.job:current_level_id() == "arm_cro" then -- CROSSROADS
		spawn01()	
	elseif managers.job:current_level_id() == "arm_fac" then -- HARBOR
		spawn01()	
	elseif managers.job:current_level_id() == "arm_par" then -- PARK
		spawn01()	
	elseif managers.job:current_level_id() == "arm_und" then -- UNDERPASS
		spawn01()	
	elseif managers.job:current_level_id() == "alex_1" then
		spawn05()	
	elseif managers.job:current_level_id() == "alex_2" then
		spawn06()	
	elseif managers.job:current_level_id() == "alex_3" then
		spawn10()
	elseif managers.job:current_level_id() == "firestarter_1" then
		spawn07()	
	elseif managers.job:current_level_id() == "firestarter_2" then
		spawn09()	
	elseif managers.job:current_level_id() == "firestarter_3" then
		spawn01()	
	elseif managers.job:current_level_id() == "welcome_to_the_jungle_1" then
		spawn08()	
	elseif managers.job:current_level_id() == "election_day_2" then
		spawn06()	
	elseif managers.job:current_level_id() == "election_day_3_skip1" then
		spawn06()	
	elseif managers.job:current_level_id() == "election_day_3_skip2" then
		spawn06()	
	elseif managers.job:current_level_id() == "mallcrasher" then
		spawn11()	
	elseif managers.job:current_level_id() == "ukrainian_job" then
		spawn02()	
	elseif managers.job:current_level_id() == "nightclub" then
		spawn12()	
	else
		showHint("Спавн случайного лута [Недоступен здесь]")	
	end
else	
	showHint("Спавн случайного лута [Только хост]")	
end