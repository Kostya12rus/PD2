------------------------------------------------
--------- SPAWN RANDOM OBJECTS -----------------
--------- By SirGoodsmoke -- v1.0 --------------
------------------------------------------------
spawnobjectb = spawnobjectb or function()
	local id_table = {
	Idstring("units/payday2/props/bnk_prop_harvest_sign/bnk_prop_harvest_sign_cube"),
	Idstring("units/payday2/props/bnk_prop_vault_table/bnk_prop_vault_table"),
	Idstring("units/payday2/props/bnk_prop_entrance_carpet/bnk_prop_entrance_carpet")
	}
	local pos = get_crosshair_pos()
	local rr = math.random(-180,180)
	local rot = Rotation(rr)
	if not pos or not rot then
		return
	end
	World:spawn_unit(id_table[math.random(3)], pos, rot)
end

spawnobjectjs = spawnobjectjs or function()
	local id_table = {
	Idstring("units/world/street/fire_hydrant/fire_hydrant"),	
	Idstring("units/payday2/props/str_prop_street_usmailbox/str_prop_street_usmailbox"),
	Idstring("units/payday2/props/str_prop_street_newsbox/str_prop_street_newsbox_a"),
	Idstring("units/payday2/props/str_prop_street_newsbox/str_prop_street_newsbox_b"),
	Idstring("units/payday2/props/str_prop_street_newsbox/str_prop_street_newsbox_c")
	}
	local pos = get_crosshair_pos()
	local rr = math.random(-180,180)
	local rot = Rotation(rr)
	if not pos or not rot then
		return
	end
	World:spawn_unit(id_table[math.random(5)], pos, rot)
end

spawnobjectgb = spawnobjectgb or function()
	local id_table = {
	Idstring("units/pd2_dlc2/props/cs_prop_briefcase/cs_prop_briefcase"),
	Idstring("units/pd2_dlc2/props/cs_prop_banknote/cs_prop_banknote"),
	Idstring("units/pd2_dlc2/props/gen_prop_boombox/gen_prop_boombox"),
	Idstring("units/pd2_dlc2/csgo_models/props_bank/construction_lift_cs"),
	Idstring("units/pd2_dlc2/csgo_models/props_equipment/phone_booth"),
	Idstring("units/pd2_dlc2/csgo_models/props_equipment/gas_pump"),
	Idstring("units/pd2_dlc2/csgo_models/props_equipment/fountain_drinks")
	}
	local pos = get_crosshair_pos()
	local rr = math.random(-180,180)
	local rot = Rotation(rr)
	if not pos or not rot then
		return
	end
	World:spawn_unit(id_table[ math.random(7)], pos, rot)
end

spawnobjectds = spawnobjectds or function()
	local id_table = {	
	Idstring("units/world/street/fire_hydrant/fire_hydrant"),
	Idstring("units/payday2/props/str_prop_street_usmailbox/str_prop_street_usmailbox"),
	Idstring("units/payday2/props/str_prop_street_newsbox/str_prop_street_newsbox_a"),
	Idstring("units/payday2/props/str_prop_street_newsbox/str_prop_street_newsbox_b"),
	Idstring("units/payday2/props/str_prop_street_newsbox/str_prop_street_newsbox_c")
	}
	local pos = get_crosshair_pos()
	local rr = math.random(-180,180)
	local rot = Rotation(rr)
	if not pos or not rot then
		return
	end
	World:spawn_unit(id_table[math.random(5)], pos, rot )
end

spawnobject05 = spawnobject05 or function()
	local pos = get_crosshair_pos()
	local rot = Rotation(managers.player:local_player():movement():m_head_rot():yaw(),0,0)
	if not pos or not rot then
		return
	end
	World:spawn_unit(Idstring("units/payday2/props/gen_prop_methlab_meth/gen_prop_methlab_meth"), pos, rot)
end

spawnobject06 = spawnobject06 or function()
	local pos = get_crosshair_pos()
	local rot = Rotation(managers.player:local_player():movement():m_head_rot():yaw(),0,0)
	if not pos or not rot then
		return
	end
	World:spawn_unit(Idstring("units/payday2/props/bnk_prop_vault_loot/bnk_prop_vault_loot_special_money"), pos, rot)
end

spawnobjectfs1 = spawnobjectfs1 or function()
    local id_table = {	
	Idstring("units/payday2/vehicles/str_vehicle_car_modernsedan/str_vehicle_car_modernsedan"),
	Idstring("units/payday2/vehicles/str_vehicle_car_modernsedan2/str_vehicle_car_modernsedan2"),
	Idstring("units/payday2/vehicles/air_truck_baggage/air_truck_baggage"),
	Idstring("units/payday2/vehicles/air_vehicle_truck_firetruck/air_vehicle_truck_firetruck")
	}
	local pos = get_crosshair_pos()
	local rr = math.random(-180,180)
	local rot = Rotation(rr)
	if not pos or not rot then
		return
	end
	World:spawn_unit(id_table[math.random(4)], pos, rot)
end

spawnobjectbo2 = spawnobjectbo2 or function()
	local pos = get_crosshair_pos()
	local rr = math.random(-180,180)
	local rot = Rotation(rr)
	if not pos or not rot then
		return
	end
	World:spawn_unit(Idstring("units/world/props/prop_basketball/basketball"), pos, rot)
end

spawnobject09 = spawnobject09 or function()
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

spawnobject10 = spawnobject10 or function()
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

spawnobject11 = spawnobject11 or function()
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

spawnobject12 = spawnobject12 or function(id)
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
		spawnobjectb()	
	elseif managers.job:current_level_id() == "roberts" then -- GO BANK
		spawnobjectgb()	
	elseif managers.job:current_level_id() == "jewelry_store" then -- JEWLERY STORE
		spawnobjectjs()	
	elseif managers.job:current_level_id() == "family" then
		spawnobjectjs()	
	elseif managers.job:current_level_id() == "arm_hcm" then -- DOWNTOWN
		spawnobject01()	
	elseif managers.job:current_level_id() == "arm_cro" then -- CROSSROADS
		spawnobject01()	
	elseif managers.job:current_level_id() == "arm_fac" then -- HARBOR
		spawnobject01()	
	elseif managers.job:current_level_id() == "arm_par" then -- PARK
		spawnobject01()	
	elseif managers.job:current_level_id() == "arm_und" then -- UNDERPASS
		spawnobject01()	
	elseif managers.job:current_level_id() == "alex_1" then
		spawnobject05()	
	elseif managers.job:current_level_id() == "alex_2" then
		spawnobject06()
	elseif managers.job:current_level_id() == "firestarter_1" then -- FIRESTARTER DAY 1
		spawnobjectfs1()
	elseif managers.job:current_level_id() == "firestarter_2" then -- FIRESTARTER DAY 2
		spawnobject09()
	elseif managers.job:current_level_id() == "firestarter_3" then -- FIRESTARTER DAY 3
		spawnobjectb()
	elseif managers.job:current_level_id() == "welcome_to_the_jungle_2" then -- BIG OIL DAY 2
		spawnobjectbo2()
	elseif managers.job:current_level_id() == "election_day_2" then
		spawnobject06()
	elseif managers.job:current_level_id() == "election_day_3_skip1" then
		spawnobject06()	
	elseif managers.job:current_level_id() == "election_day_3_skip2" then
		spawnobject06()	
	elseif managers.job:current_level_id() == "mallcrasher" then
		spawnobject01()	
	elseif managers.job:current_level_id() == "ukrainian_job" then
		spawnobject02()	
	elseif managers.job:current_level_id() == "nightclub" then
		spawnobject12()
	else
		showHint("Спавн случайного лута [Недоступен здесь]")	
	end
else	
	showHint("Спавн случайного лута [Только хост]" )	
end