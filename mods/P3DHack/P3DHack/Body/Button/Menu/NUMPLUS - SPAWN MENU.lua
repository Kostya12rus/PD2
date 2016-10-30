----------------------------------
----- SPAWN MODES v3.4 -----------
------ BY PIERREDJAYS ------------
--- REDONE BY SIRGOODMOKE --------
----------------------------------
if not NumpadMenu then
	if not load_data then
		data_se = false
		data_ses = false
		data_seeg = false
		data_sa = false
		data_sas = false
		data_saeg = false
		data_sb = false
		data_sbs = false
		data_sr = false
		data_srs = false
		data_off = false
		spawn_crosshair = true
		load_data = true
	end
	-- BODYBAGS CASE SPAWNER
	function BODYBAGCASE()
	if inGame() and isPlaying() and isHost() then
	local position = get_crosshair_ray().hit_position
	local rotation = Rotation(managers.player:local_player():movement():m_head_rot():yaw(),0,0)
	local amount_upgrade_lvl = 0
	local peer_id = managers.network:session():local_peer():id()
	local unit_name = "units/payday2/equipment/gen_equipment_bodybags_bag/gen_equipment_bodybags_bag"
	local unit = World:spawn_unit(Idstring(unit_name), position, rotation)
	managers.network:session():send_to_peers_synched("sync_equipment_setup", unit, amount_upgrade_lvl, peer_id or 0)
	unit:base():setup(amount_upgrade_lvl)
	end
	end
	-- AMMO BAG SPAWNER
	function AMMOBAG()
	if inGame() and isPlaying() and isHost() then
	local position = get_crosshair_ray().hit_position
	local rotation = Rotation(managers.player:local_player():movement():m_head_rot():yaw(),0,0)
	local peer_id = managers.network:session():local_peer():id()
	local ammo_upgrade_lvl = managers.player:upgrade_level("ammo_bag", "ammo_increase")
	local unit_name = "units/payday2/equipment/gen_equipment_ammobag/gen_equipment_ammobag"
	local unit = World:spawn_unit(Idstring(unit_name), position, rotation, ammo_upgrade_lvl)
	managers.network:session():send_to_peers_synched("sync_equipment_setup", unit, ammo_upgrade_lvl, peer_id or 0)
	unit:base():setup(ammo_upgrade_lvl)
	end
	end
	
	-- SPAWN GRENADE CASE
	function GRDCASE()
	if inGame() and isPlaying() and isHost() then
	local position = get_crosshair_ray().hit_position
	local rotation = Rotation(managers.player:local_player():movement():m_head_rot():yaw(),0,0)
	local unit_name = "units/payday2/equipment/gen_equipment_grenade_crate/gen_equipment_grenade_crate"
	local unit = World:spawn_unit(Idstring(unit_name), position, rotation)
	managers.network:session():send_to_peers_synched("sync_unit_event_id_16", unit, "sync", 1)
	end
	end
	-----SPAWNSPAWNSPAWNSPAWNSPAWNSPAWNSPAWN
	
	-- SPAWN SENTRY ON SELF
	function SENTRY()
	if inGame() and isPlaying() then
	local ammo_multiplier = managers.player:upgrade_value( "sentry_gun", "extra_ammo_multiplier", 1 )
	local armor_multiplier = managers.player:upgrade_value( "sentry_gun", "armor_multiplier", 1 )
	local damage_multiplier = managers.player:upgrade_value( "sentry_gun", "damage_multiplier", 1 )
	local unit = managers.player:player_unit()
	local from = managers.player:player_unit():movement():m_head_pos()
	local to = from + managers.player:player_unit():movement():m_head_rot():y() * 999999
	local ray = managers.player:player_unit():raycast("ray", from, to, "slot_mask", managers.slot:get_mask("trip_mine_placeables"), "ignore_unit", {})
	if ray then
		local pos = ray.position
		local rot = managers.player:player_unit():movement():m_head_rot()
		local rot = Rotation( rot:yaw(), 0, 0 )
		local selected_index = nil
		if Network:is_client() then
			managers.network:session():send_to_host( "place_sentry_gun", pos, rot, ammo_multiplier, armor_multiplier, damage_multiplier, selected_index, unit )
			PlayerEquipment.sentrygun_placement_requested = true
		else
			local shield = managers.player:has_category_upgrade( "sentry_gun", "shield" )
			local sentry_gun_unit = SentryGunBase.spawn( unit, pos, rot, ammo_multiplier, armor_multiplier, damage_multiplier )
			if sentry_gun_unit then
				managers.network:session():send_to_peers_synched( "from_server_sentry_gun_place_result", managers.network:session():local_peer():id(), selected_index, sentry_gun_unit, sentry_gun_unit:movement()._rot_speed_mul, sentry_gun_unit:weapon()._setup.spread_mul, shield )
			else
			end	
		end	
	end	
	end
	end
	
	
	function spawn_enemy()
		data_se = true
		data_ses = false
		data_seeg = false
		data_sa = false
		data_sas = false
		data_saeg = false
		data_sb = false
		data_sbs = false
		data_sr = false
		data_srs = false
		data_off = false
	end

	function spawn_enemy_special()
		data_se = false
		data_ses = true
		data_seeg = false
		data_sa = false
		data_sas = false
		data_saeg = false
		data_sb = false
		data_sbs = false
		data_sr = false
		data_srs = false
		data_off = false
	end

	function spawn_enemy_elitegensec()
		data_se = false
		data_ses = false
		data_seeg = true
		data_sa = false
		data_sas = false
		data_saeg = false
		data_sb = false
		data_sbs = false
		data_sr = false
		data_srs = false
		data_off = false
	end

	function spawn_allied()
		data_se = false
		data_ses = false
		data_seeg = false
		data_sa = true
		data_sas = false
		data_saeg = false
		data_sb = false
		data_sbs = false
		data_sr = false
		data_srs = false
		data_off = false
	end

	function spawn_allied_special()
		data_se = false
		data_ses = false
		data_seeg = false
		data_sa = false
		data_sas = true
		data_saeg = false
		data_sb = false
		data_sbs = false
		data_sr = false
		data_srs = false
		data_off = false
	end

	function spawn_allied_elitegensec()
		data_se = false
		data_ses = false
		data_seeg = false
		data_sa = false
		data_sas = false
		data_saeg = true
		data_sb = false
		data_sbs = false
		data_sr = false
		data_srs = false
		data_off = false
	end

	function spawn_on_crosshair()
		spawn_crosshair = true
	end

	function spawn_on_self()
		spawn_crosshair = false
	end

	-- LOAD MODE 
	-- SPAWN BAGS (ON SELF)
	mode100 = mode100 or function()
		Toggle.self_bags = not Toggle.self_bags		
		if not Toggle.self_bags then			
			UnbindKey("VK_NUMPAD0")
			UnbindKey("VK_NUMPAD1")
			UnbindKey("VK_NUMPAD2")
			UnbindKey("VK_NUMPAD3")
			UnbindKey("VK_NUMPAD4")
			UnbindKey("VK_NUMPAD5")
			UnbindKey("VK_NUMPAD6")
			UnbindKey("VK_NUMPAD7")
			UnbindKey("VK_NUMPAD8")
			UnbindKey("VK_NUMPAD9")
			BindKey("VK_NUMPAD0", "P3DHack/Main/KeyBinds/NumPad/SpawnMode/LootBag/NUM0.lua")
			BindKey("VK_NUMPAD1", "P3DHack/Main/KeyBinds/NumPad/SpawnMode/LootBag/NUM1.lua") 
			BindKey("VK_NUMPAD2", "P3DHack/Main/KeyBinds/NumPad/SpawnMode/LootBag/NUM2.lua")
			BindKey("VK_NUMPAD3", "P3DHack/Main/KeyBinds/NumPad/SpawnMode/LootBag/NUM3.lua")
			BindKey("VK_NUMPAD4", "P3DHack/Main/KeyBinds/NumPad/SpawnMode/LootBag/NUM4.lua") 
			BindKey("VK_NUMPAD5", "P3DHack/Main/KeyBinds/NumPad/SpawnMode/LootBag/NUM5.lua")
			BindKey("VK_NUMPAD6", "P3DHack/Main/KeyBinds/NumPad/SpawnMode/LootBag/NUM6.lua")
			BindKey("VK_NUMPAD7", "P3DHack/Main/KeyBinds/NumPad/SpawnMode/LootBag/NUM7.lua") 
			BindKey("VK_NUMPAD8", "P3DHack/Main/KeyBinds/NumPad/SpawnMode/LootBag/NUM8.lua")
			BindKey("VK_NUMPAD9", "P3DHack/Main/KeyBinds/NumPad/SpawnMode/LootBag/NUM9.lua")
			ChatMessage('Отключено', 'Спавн сумок на себя')
		else	
			UnbindKey("VK_NUMPAD0")
			UnbindKey("VK_NUMPAD1")
			UnbindKey("VK_NUMPAD2")
			UnbindKey("VK_NUMPAD3")
			UnbindKey("VK_NUMPAD4")
			UnbindKey("VK_NUMPAD5")
			UnbindKey("VK_NUMPAD6")
			UnbindKey("VK_NUMPAD7")
			UnbindKey("VK_NUMPAD8")
			UnbindKey("VK_NUMPAD9")
			BindKey("VK_NUMPAD0", "P3DHack/Main/KeyBinds/NumPad/SpawnMode/SelfLootBag/0J.lua")
			BindKey("VK_NUMPAD1", "P3DHack/Main/KeyBinds/NumPad/SpawnMode/SelfLootBag/1J.lua")
			BindKey("VK_NUMPAD2", "P3DHack/Main/KeyBinds/NumPad/SpawnMode/SelfLootBag/2J.lua")
			BindKey("VK_NUMPAD3", "P3DHack/Main/KeyBinds/NumPad/SpawnMode/SelfLootBag/3J.lua")
			BindKey("VK_NUMPAD4", "P3DHack/Main/KeyBinds/NumPad/SpawnMode/SelfLootBag/4J.lua")
			BindKey("VK_NUMPAD5", "P3DHack/Main/KeyBinds/NumPad/SpawnMode/SelfLootBag/5J.lua")
			BindKey("VK_NUMPAD6", "P3DHack/Main/KeyBinds/NumPad/SpawnMode/SelfLootBag/6J.lua")
			BindKey("VK_NUMPAD7", "P3DHack/Main/KeyBinds/NumPad/SpawnMode/SelfLootBag/7J.lua")
			BindKey("VK_NUMPAD8", "P3DHack/Main/KeyBinds/NumPad/SpawnMode/SelfLootBag/8J.lua")
			BindKey("VK_NUMPAD9", "P3DHack/Main/KeyBinds/NumPad/SpawnMode/SelfLootBag/9J.lua")
			ChatMessage('Включено', 'Спавн сумок на себя')
		end 
	end
	
	-- SPAWN BAGS (ON CROSSHAIR)
	spawncross = spawncross or function()
		Toggle.cross_bags = not Toggle.cross_bags		
		if not Toggle.cross_bags then			
			UnbindKey("VK_NUMPAD0")
			UnbindKey("VK_NUMPAD1")
			UnbindKey("VK_NUMPAD2")
			UnbindKey("VK_NUMPAD3")
			UnbindKey("VK_NUMPAD4")
			UnbindKey("VK_NUMPAD5")
			UnbindKey("VK_NUMPAD6")
			UnbindKey("VK_NUMPAD7")
			UnbindKey("VK_NUMPAD8")
			UnbindKey("VK_NUMPAD9")
			BindKey("VK_NUMPAD0", "P3DHack/Main/KeyBinds/NumPad/SpawnMode/LootBag/NUM0.lua")
			BindKey("VK_NUMPAD1", "P3DHack/Main/KeyBinds/NumPad/SpawnMode/LootBag/NUM1.lua") 
			BindKey("VK_NUMPAD2", "P3DHack/Main/KeyBinds/NumPad/SpawnMode/LootBag/NUM2.lua")
			BindKey("VK_NUMPAD3", "P3DHack/Main/KeyBinds/NumPad/SpawnMode/LootBag/NUM3.lua")
			BindKey("VK_NUMPAD4", "P3DHack/Main/KeyBinds/NumPad/SpawnMode/LootBag/NUM4.lua") 
			BindKey("VK_NUMPAD5", "P3DHack/Main/KeyBinds/NumPad/SpawnMode/LootBag/NUM5.lua")
			BindKey("VK_NUMPAD6", "P3DHack/Main/KeyBinds/NumPad/SpawnMode/LootBag/NUM6.lua")
			BindKey("VK_NUMPAD7", "P3DHack/Main/KeyBinds/NumPad/SpawnMode/LootBag/NUM7.lua") 
			BindKey("VK_NUMPAD8", "P3DHack/Main/KeyBinds/NumPad/SpawnMode/LootBag/NUM8.lua")
			BindKey("VK_NUMPAD9", "P3DHack/Main/KeyBinds/NumPad/SpawnMode/LootBag/NUM9.lua")
			ChatMessage('Отключено', 'Спавн сумок на прицел')
		else				
			UnbindKey("VK_NUMPAD0")
			UnbindKey("VK_NUMPAD1")
			UnbindKey("VK_NUMPAD2")
			UnbindKey("VK_NUMPAD3")
			UnbindKey("VK_NUMPAD4")
			UnbindKey("VK_NUMPAD5")
			UnbindKey("VK_NUMPAD6")
			UnbindKey("VK_NUMPAD7")
			UnbindKey("VK_NUMPAD8")
			UnbindKey("VK_NUMPAD9")
			BindKey("VK_NUMPAD0", "P3DHack/Main/KeyBinds/NumPad/SpawnMode/CrosshairLootBag/0 - Cross.lua")
			BindKey("VK_NUMPAD1", "P3DHack/Main/KeyBinds/NumPad/SpawnMode/CrosshairLootBag/1 - TurretCross.lua")
			BindKey("VK_NUMPAD2", "P3DHack/Main/KeyBinds/NumPad/SpawnMode/CrosshairLootBag/2 - AmmoCross.lua")
			BindKey("VK_NUMPAD3", "P3DHack/Main/KeyBinds/NumPad/SpawnMode/CrosshairLootBag/3 - WeaponCross.lua")
			BindKey("VK_NUMPAD4", "P3DHack/Main/KeyBinds/NumPad/SpawnMode/CrosshairLootBag/4 - MoneyCross.lua")
			BindKey("VK_NUMPAD5", "P3DHack/Main/KeyBinds/NumPad/SpawnMode/CrosshairLootBag/5 - GoldCross.lua")
			BindKey("VK_NUMPAD6", "P3DHack/Main/KeyBinds/NumPad/SpawnMode/CrosshairLootBag/6 - JewelryCross.lua")
			BindKey("VK_NUMPAD7", "P3DHack/Main/KeyBinds/NumPad/SpawnMode/CrosshairLootBag/7 - CokeCross.lua")
			BindKey("VK_NUMPAD8", "P3DHack/Main/KeyBinds/NumPad/SpawnMode/CrosshairLootBag/8 - MethCross.lua")
			BindKey("VK_NUMPAD9", "P3DHack/Main/KeyBinds/NumPad/SpawnMode/CrosshairLootBag/9 - PaintingCross.lua")
			ChatMessage('Включено', 'Спавн сумок на прицел')
		end 
	end
	
	-- LOOT SET
	lootmode = lootmode or function()
		Toggle.loot = not Toggle.loot	
		if not Toggle.loot then
			UnbindKey("VK_NUMPAD0")
			UnbindKey("VK_NUMPAD1")
			UnbindKey("VK_NUMPAD2")
			UnbindKey("VK_NUMPAD3")
			UnbindKey("VK_NUMPAD4")
			UnbindKey("VK_NUMPAD5")
			UnbindKey("VK_NUMPAD6")
			UnbindKey("VK_NUMPAD7")
			UnbindKey("VK_NUMPAD8")
			UnbindKey("VK_NUMPAD9")
			BindKey("VK_NUMPAD0", "P3DHack/Main/KeyBinds/NumPad/SpawnMode/LootBag/NUM0.lua")
			BindKey("VK_NUMPAD1", "P3DHack/Main/KeyBinds/NumPad/SpawnMode/LootBag/NUM1.lua") 
			BindKey("VK_NUMPAD2", "P3DHack/Main/KeyBinds/NumPad/SpawnMode/LootBag/NUM2.lua")
			BindKey("VK_NUMPAD3", "P3DHack/Main/KeyBinds/NumPad/SpawnMode/LootBag/NUM3.lua")
			BindKey("VK_NUMPAD4", "P3DHack/Main/KeyBinds/NumPad/SpawnMode/LootBag/NUM4.lua") 
			BindKey("VK_NUMPAD5", "P3DHack/Main/KeyBinds/NumPad/SpawnMode/LootBag/NUM5.lua")
			BindKey("VK_NUMPAD6", "P3DHack/Main/KeyBinds/NumPad/SpawnMode/LootBag/NUM6.lua")
			BindKey("VK_NUMPAD7", "P3DHack/Main/KeyBinds/NumPad/SpawnMode/LootBag/NUM7.lua") 
			BindKey("VK_NUMPAD8", "P3DHack/Main/KeyBinds/NumPad/SpawnMode/LootBag/NUM8.lua")
			BindKey("VK_NUMPAD9", "P3DHack/Main/KeyBinds/NumPad/SpawnMode/LootBag/NUM9.lua")
			ChatMessage('Отключено', 'Спавн награбленного/реквизита')
		else	
			UnbindKey("VK_NUMPAD0")
			UnbindKey("VK_NUMPAD1")
			UnbindKey("VK_NUMPAD2")
			UnbindKey("VK_NUMPAD3")
			UnbindKey("VK_NUMPAD4")
			UnbindKey("VK_NUMPAD5")
			UnbindKey("VK_NUMPAD6")
			UnbindKey("VK_NUMPAD7")
			UnbindKey("VK_NUMPAD8")
			UnbindKey("VK_NUMPAD9")
			BindKey("VK_NUMPAD1", "P3DHack/Main/KeyBinds/NumPad/SpawnMode/ObjectLoot/1 - SPWNLOOT.lua")
			BindKey("VK_NUMPAD2", "P3DHack/Main/KeyBinds/NumPad/SpawnMode/ObjectLoot/2 - SPWNLOOSELOOT.lua") 
			BindKey("VK_NUMPAD3", "P3DHack/Main/KeyBinds/NumPad/SpawnMode/ObjectLoot/3 - SPWNOBJECT.lua")
			BindKey("VK_NUMPAD4", "P3DHack/Main/KeyBinds/NumPad/SpawnMode/ObjectLoot/4 - SPWNVEHICLE.lua")
			BindKey("VK_NUMPAD5", "P3DHack/Main/KeyBinds/NumPad/SpawnMode/ObjectLoot/5 - SPWNAIRVEHICLE.lua")
			ChatMessage('Включено', 'Спавн награбленного/реквизита')
		end 
	end
	
	-- EQUIPMENT SET
	modeequip = modeequip or function()
		Toggle.equip = not Toggle.equip	
		if not Toggle.equip then	
			dofile(ModPath .."P3DHack/Body/Button/NumPad/SpawnMode\Equipment/1 - BODYBAGCASE.lua")
			ChatMessage('Отключено', 'Спавн оборудования')
		else
			dofile(ModPath .."P3DHack/Body/Button/NumPad/SpawnMode\Equipment/1 - BODYBAGCASE.lua")
			ChatMessage('Включено', 'Спавн оборудования')
		end 
	end
	
	--BIND ENEMIES
	startnow = startnow or function()
		Toggle.start = not Toggle.start
		if not Toggle.start then
			UnbindKey("VK_NUMPAD0")
			UnbindKey("VK_NUMPAD1")
			UnbindKey("VK_NUMPAD2")
			UnbindKey("VK_NUMPAD3")
			UnbindKey("VK_NUMPAD4")
			UnbindKey("VK_NUMPAD5")
			UnbindKey("VK_NUMPAD6")
			UnbindKey("VK_NUMPAD7")
			UnbindKey("VK_NUMPAD8")
			UnbindKey("VK_NUMPAD9")
			BindKey("VK_NUMPAD0", "P3DHack/Main/KeyBinds/NumPad/SpawnMode/LootBag/NUM0.lua")
			BindKey("VK_NUMPAD1", "P3DHack/Main/KeyBinds/NumPad/SpawnMode/LootBag/NUM1.lua") 
			BindKey("VK_NUMPAD2", "P3DHack/Main/KeyBinds/NumPad/SpawnMode/LootBag/NUM2.lua")
			BindKey("VK_NUMPAD3", "P3DHack/Main/KeyBinds/NumPad/SpawnMode/LootBag/NUM3.lua")
			BindKey("VK_NUMPAD4", "P3DHack/Main/KeyBinds/NumPad/SpawnMode/LootBag/NUM4.lua") 
			BindKey("VK_NUMPAD5", "P3DHack/Main/KeyBinds/NumPad/SpawnMode/LootBag/NUM5.lua")
			BindKey("VK_NUMPAD6", "P3DHack/Main/KeyBinds/NumPad/SpawnMode/LootBag/NUM6.lua")
			BindKey("VK_NUMPAD7", "P3DHack/Main/KeyBinds/NumPad/SpawnMode/LootBag/NUM7.lua") 
			BindKey("VK_NUMPAD8", "P3DHack/Main/KeyBinds/NumPad/SpawnMode/LootBag/NUM8.lua")
			BindKey("VK_NUMPAD9", "P3DHack/Main/KeyBinds/NumPad/SpawnMode/LootBag/NUM9.lua")
			ChatMessage('Отключено', 'Враг/Союзник')
		else
			UnbindKey("VK_NUMPAD0")
			UnbindKey("VK_NUMPAD1")
			UnbindKey("VK_NUMPAD2")
			UnbindKey("VK_NUMPAD3")
			UnbindKey("VK_NUMPAD4")
			UnbindKey("VK_NUMPAD5")
			UnbindKey("VK_NUMPAD6")
			UnbindKey("VK_NUMPAD7")
			UnbindKey("VK_NUMPAD8")
			UnbindKey("VK_NUMPAD9")
			BindKey("VK_NUMPAD1", "P3DHack/Main/KeyBinds/NumPad/SpawnMode/EnemiesAlly/NUMPAD 1.lua") 
			BindKey("VK_NUMPAD2", "P3DHack/Main/KeyBinds/NumPad/SpawnMode/EnemiesAlly/NUMPAD 2.lua") 
			BindKey("VK_NUMPAD3", "P3DHack/Main/KeyBinds/NumPad/SpawnMode/EnemiesAlly/NUMPAD 3.lua") 
			BindKey("VK_NUMPAD4", "P3DHack/Main/KeyBinds/NumPad/SpawnMode/EnemiesAlly/NUMPAD 4.lua") 
			BindKey("VK_NUMPAD5", "P3DHack/Main/KeyBinds/NumPad/SpawnMode/EnemiesAlly/NUMPAD 5.lua") 
			BindKey("VK_NUMPAD6", "P3DHack/Main/KeyBinds/NumPad/SpawnMode/EnemiesAlly/NUMPAD 6.lua") 
			BindKey("VK_NUMPAD7", "P3DHack/Main/KeyBinds/NumPad/SpawnMode/EnemiesAlly/NUMPAD 7.lua") 
			BindKey("VK_NUMPAD8", "P3DHack/Main/KeyBinds/NumPad/SpawnMode/EnemiesAlly/NUMPAD 8.lua") 
			BindKey("VK_NUMPAD9", "P3DHack/Main/KeyBinds/NumPad/SpawnMode/EnemiesAlly/NUMPAD 9.lua")
			ChatMessage('Включено', 'Враг/Союзник')
		end 
	end
-------------------------------------------------------------------------------------------------------
	NumpadMenu = CustomMenuClass:new()
	NumpadMenu:addMainMenu('main_menu', { title = 'Спавн меню' } )
	NumpadMenu:addMainMenu('spawn_menu', { title = 'Спавн врагов/союзников'} )
	NumpadMenu:addMainMenu('spawn_equipment', { title = 'Спавн оборудования на прицел'} )
	
	NumpadMenu:addInformationOption('main_menu', 'Спавн врагов/союзников', { textColor = Color.red } )
	if isHost() then
		NumpadMenu:addMenuOption('main_menu', 'Враги и союзники', 'spawn_menu', { rectHighlightColor = Color(255, 138, 17, 9) / 255} )
	else
		NumpadMenu:addInformationOption('main_menu', 'Недоступно (Только хост)', { textColor = Color.yellow })
	end
	NumpadMenu:addInformationOption('spawn_menu', 'Должно быть включено первым', { textColor = Color.red } )
	NumpadMenu:addToggleOption('spawn_menu', 'Спавн врагов/союзников', { callback = startnow, help = 'После включения, выберите способ спавна' } )
	NumpadMenu:addOption('spawn_menu', 'Спавн юнитов на прицел', { callback = spawn_on_crosshair } )
	NumpadMenu:addOption('spawn_menu', 'Спавн юнитов на себя', { callback = spawn_on_self } )
	NumpadMenu:addGap('spawn_menu')
	NumpadMenu:addInformationOption('spawn_menu', 'Для спавна используйте NUMPAD 1-9', { textColor = Color.DodgerBlue})
	NumpadMenu:addOption('spawn_menu', 'Спавн юнитов', { callback = spawn_enemy, closeMenu = true } )
	NumpadMenu:addOption('spawn_menu', 'Спавн специальных юнитов', { callback = spawn_enemy_special, closeMenu = true } )
	NumpadMenu:addOption('spawn_menu', 'Спавн элитных Gensec юнитов', { callback = spawn_enemy_elitegensec, closeMenu = true } )
	NumpadMenu:addGap('spawn_menu')
	NumpadMenu:addGap('spawn_menu')
	NumpadMenu:addGap('spawn_menu')
	NumpadMenu:addGap('spawn_menu')
	NumpadMenu:addGap('spawn_menu')
	NumpadMenu:addGap('spawn_menu')
	NumpadMenu:addGap('spawn_menu')
	NumpadMenu:addOption('spawn_menu', 'Спавн союзников', { callback = spawn_allied, closeMenu = true } )
	NumpadMenu:addOption('spawn_menu', 'Спавн специальных союзников', { callback = spawn_allied_special, closeMenu = true } )
	NumpadMenu:addOption('spawn_menu', 'Спавн элитных Gensec союзников', { callback = spawn_allied_elitegensec, closeMenu = true } )
	
	NumpadMenu:addGap('main_menu')	
	NumpadMenu:addInformationOption('main_menu', 'Спавн сумок', { textColor = Color.DodgerBlue } )	
	NumpadMenu:addToggleOption('main_menu', 'Спавн сумок на прицел', { callback = spawncross, help = 'Спавн сумок на прицел', closeMenu = true } )
	NumpadMenu:addToggleOption('main_menu', 'Спавн сумок на себя', { callback = mode100, help = 'Спавн сумок на себя', closeMenu = true } )
	for i=1,7 do
		NumpadMenu:addGap('main_menu')
	end
	NumpadMenu:addInformationOption('main_menu', 'Другое', { textColor = Color.DodgerBlue } )
	if isHost() then
		NumpadMenu:addMenuOption('main_menu', 'Спавн оборудования на прицел', 'spawn_equipment', { rectHighlightColor = Color(255, 138, 17, 9) / 255} )
		NumpadMenu:addToggleOption('main_menu', 'Спавн награбленного/объектов/транспорта на прицел', { callback = lootmode, help = 'Спавн награбленного/объектов/транспорта на прицел', closeMenu = true } )
	else
		NumpadMenu:addMenuOption('main_menu', 'Спавн оборудования на прицел', 'spawn_equipment', { rectHighlightColor = Color(255, 138, 17, 9) / 255} )
		NumpadMenu:addInformationOption('main_menu', 'Недоступно (Только хост)', { textColor = Color.yellow })
	end
	NumpadMenu:addInformationOption('spawn_equipment', 'Для спавна используйте NUMPAD 1-9', { textColor = Color.DodgerBlue})
	NumpadMenu:addOption('spawn_equipment', '1 - BODYBAGCASE Host', { callback = BODYBAGCASE, closeMenu = true } )
	NumpadMenu:addOption('spawn_equipment', '2 - AMMOBAG Host', { callback = AMMOBAG, closeMenu = true } )
	NumpadMenu:addOption('spawn_equipment', '3 - GRDCASE Host', { callback = GRDCASE, closeMenu = true } )
	NumpadMenu:addGap('spawn_equipment')
	NumpadMenu:addGap('spawn_equipment')
	NumpadMenu:addGap('spawn_equipment')
	NumpadMenu:addGap('spawn_equipment')
	NumpadMenu:addGap('spawn_equipment')
	NumpadMenu:addGap('spawn_equipment')
	NumpadMenu:addGap('spawn_equipment')
	NumpadMenu:addOption('spawn_equipment', 'Спавн союзников', { callback = spawn_allied, closeMenu = true } )
	NumpadMenu:addOption('spawn_equipment', '5 - SENTRY Host vopros', { callback = SENTRY, closeMenu = true } )
	NumpadMenu:addOption('spawn_equipment', 'Спавн элитных Gensec союзников', { callback = spawn_allied_elitegensec, closeMenu = true } )
end

if inGame() and isPlaying() then
	if NumpadMenu:isOpen() then
		NumpadMenu:close()
else
	if ChangerMenu then
		if ChangerMenu:isOpen() then
			ChangerMenu:close()
	end	end
	if PlayerMenu then
		if PlayerMenu:isOpen() then
			PlayerMenu:close()
	end	end		
	if StealthMenu then
		if StealthMenu:isOpen() then
			StealthMenu:close()
	end	end		
	if MissionMenu then
		if MissionMenu:isOpen() then
			MissionMenu:close()
	end	end
	if InventoryMenu then
		if InventoryMenu:isOpen() then
			InventoryMenu:close()
	end	end		
	if MoneyMenu then
		if MoneyMenu:isOpen() then
			MoneyMenu:close()
	end	end
	if TrollMenu then
		if TrollMenu:isOpen() then
			TrollMenu:close()
	end	end
	if InteractTimerMenu then	
		if InteractTimerMenu:isOpen() then
			InteractTimerMenu:close()
	end	end
	NumpadMenu:open()
end end