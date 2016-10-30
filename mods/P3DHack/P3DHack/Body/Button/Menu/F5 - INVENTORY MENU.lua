if not InventoryMenu then
--A rain of bags are now moved here
local radius = 13000 --Radius for bag storming

local function testray(reach)
	return World:raycast("ray", reach, reach + Vector3(0,0,-40000), "slot_mask", managers.slot:get_mask("bullet_impact_targets"))
end

rand_pos = function(pos)
	local p = Vector3(math.random(radius*-1,radius), math.random(radius*-1,radius), 6000)
	local p = pos + p
	if testray(p) then
		return p
	else
		return rand_pos(pos) --Test failed, try again
	end	
end

local rand_rot = function()
	return Rotation(math.random(-180,180), math.random(-180,180), 0)
end

local rain_bag = function(name, amount)
	local camera_ext = managers.player:player_unit():camera()
	local carry_data = tweak_data.carry[name]
	if isClient() then
		for _=1,amount do
			managers.network:session():send_to_host("server_drop_carry", name, carry_data.multiplier, carry_data.dye_initiated, carry_data.has_dye_pack, carry_data.dye_value_multiplier, rand_pos(camera_ext:position()), rand_rot(), math.UP, 100, nil)
		end
	else
		for _=1,amount do
			managers.player:server_drop_carry(name, carry_data.multiplier, carry_data.dye_initiated, carry_data.has_dye_pack, carry_data.dye_value_multiplier, rand_pos(camera_ext:position()), rand_rot(), math.UP, 100, nil, managers.network:session():local_peer())
		end	
	end	
end

RainBags = function(name, amount) --Global function, call this!
	if not amount then
		amount = 100
	end
	rain_bag(name, amount)
end
--A rain of bags are now moved here
	-- SPAWN BAG
	function spawn_bag(name)
		if Toggle.is_rain then
			return RainBags(name, 100)		
		elseif Toggle.is_self then
			return GiveBag(name)
		elseif Toggle.is_cross then
			return ServerSpawnBagCrossHair(name)
		end
		ServerSpawnBag(name)
	end
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------			
	-- ADD ITEM
	function add_item(name)
		managers.player:add_special({name = name, silent = true, amount = 1})
	end
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------			
	-- AMMO BAG EXPLOSIVE
	function shells()
		Toggle.Explosive_Shells = not Toggle.Explosive_Shells
		
		if not Toggle.Explosive_Shells then
			tweak_data.carry.ammo.type = "medium"
			ChatMessage('Отключены', 'Фугасные снаряды')
			return
		end
		
		tweak_data.carry.ammo.type = "explosives"
		ChatMessage('Включены', 'Фугасные снаряды')
	end
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
	InventoryMenu = CustomMenuClass:new()
	InventoryMenu:addMainMenu('main_menu', {title = 'Инвентарь - Выберите опцию'})
	InventoryMenu:addMenu('add_items_menu', {title = 'Добавить предметов - Выберите предмет'})
	InventoryMenu:addMenu('loot_menu', {title = 'Мешки с добычей - Выберите сумку'})
	InventoryMenu:addMenu('equipment_menu', {title = 'Сумка с оборудованием - Выберите сумку'})
	InventoryMenu:addMenu('engine_menu', {title = 'Нефтяное Дело - Выберите двигатель'})

	-- Inventory Main Menu
	InventoryMenu:addInformationOption('main_menu', 'Добавить предметов в инвентарь', {textColor = Color.red })
	InventoryMenu:addMenuOption('main_menu','Добавить предметов в инвентарь', 'add_items_menu', {rectHighlightColor = Color.red})
	InventoryMenu:addGap('main_menu')
	InventoryMenu:addInformationOption('main_menu', 'Спавн сумок', { textColor = Color.red })	
	InventoryMenu:addMenuOption('main_menu','Нефтяное Дело', 'engine_menu', {rectHighlightColor = Color.red})
	InventoryMenu:addOption('engine_menu', 'Двигатель 01', {callback = spawn_bag, callbackData = 'engine_01'})
	InventoryMenu:addOption('engine_menu', 'Двигатель 02', {callback = spawn_bag, callbackData = 'engine_02'})
	InventoryMenu:addOption('engine_menu', 'Двигатель 03', {callback = spawn_bag, callbackData = 'engine_03'})
	InventoryMenu:addOption('engine_menu', 'Двигатель 04', {callback = spawn_bag, callbackData = 'engine_04'})
	InventoryMenu:addOption('engine_menu', 'Двигатель 05', {callback = spawn_bag, callbackData = 'engine_05'})
	InventoryMenu:addOption('engine_menu', 'Двигатель 06', {callback = spawn_bag, callbackData = 'engine_06'})
	InventoryMenu:addOption('engine_menu', 'Двигатель 07', {callback = spawn_bag, callbackData = 'engine_07'})
	InventoryMenu:addOption('engine_menu', 'Двигатель 08', {callback = spawn_bag, callbackData = 'engine_08'})
	InventoryMenu:addOption('engine_menu', 'Двигатель 09', {callback = spawn_bag, callbackData = 'engine_09'})
	InventoryMenu:addOption('engine_menu', 'Двигатель 10', {callback = spawn_bag, callbackData = 'engine_10'})
	InventoryMenu:addOption('engine_menu', 'Двигатель 11', {callback = spawn_bag, callbackData = 'engine_11'})
	InventoryMenu:addOption('engine_menu', 'Двигатель 12', {callback = spawn_bag, callbackData = 'engine_12'})
	
	InventoryMenu:addMenuOption('main_menu','Сумка с оборудованием', 'equipment_menu', {rectHighlightColor = Color(255, 138, 17, 9) / 255})
	InventoryMenu:addOption('equipment_menu', 'Труп', {callback = spawn_bag, callbackData = 'person'})
	InventoryMenu:addOption('equipment_menu', 'Подрывные снаряды', {callback = spawn_bag, callbackData = 'breaching_charges'})
	InventoryMenu:addOption('equipment_menu', 'Клетка', {callback = spawn_bag, callbackData = 'cage_bag'})
	InventoryMenu:addOption('equipment_menu', 'Каустическая сода', {callback = spawn_bag, callbackData = 'nail_caustic_soda'})
	InventoryMenu:addOption('equipment_menu', 'Улики', {callback = spawn_bag, callbackData = 'evidence_bag'})
	InventoryMenu:addOption('equipment_menu', 'Таблетки эфедрина', {callback = spawn_bag, callbackData = 'nail_euphadrine_pills'})
	InventoryMenu:addOption('equipment_menu', 'Снаряжение', {callback = spawn_bag, callbackData = 'equipment_bag_global_event'})
	InventoryMenu:addOption('equipment_menu', 'Фейерверк', {callback = spawn_bag, callbackData = 'fireworks'})
	InventoryMenu:addOption('equipment_menu', 'Сервер', {callback = spawn_bag, callbackData = 'circuit'})
	InventoryMenu:addOption('equipment_menu', 'Хлористый водород', {callback = spawn_bag, callbackData = 'nail_hydrogen_chloride'})
	if managers.job:current_level_id() == 'crojob2' or managers.job:current_level_id() == 'crojob2_night' or managers.job:current_level_id() == 'crojob3' or managers.job:current_level_id() == 'crojob3_night' then	
		InventoryMenu:addOption('equipment_menu', 'Стремянка', {callback = spawn_bag, callbackData = 'ladder_bag'})
	end
	InventoryMenu:addOption('equipment_menu', 'Главный сервер', {callback = spawn_bag, callbackData = 'master_server'})
	InventoryMenu:addOption('equipment_menu', 'Соляная кислота', {callback = spawn_bag, callbackData = 'nail_muriatic_acid'})
	InventoryMenu:addOption('equipment_menu', 'Парашют', {callback = spawn_bag, callbackData = 'parachute'})
	InventoryMenu:addOption('equipment_menu', 'Зверь', {callback = spawn_bag, callbackData = 'lance_bag_large'})
	InventoryMenu:addOption('equipment_menu', 'Термобур', {callback = spawn_bag, callbackData = 'lance_bag'})
	InventoryMenu:addOption('equipment_menu', 'Снаряжение', {callback = spawn_bag, callbackData = 'equipment_bag'})
	InventoryMenu:addOption('equipment_menu', 'Деталь лебедки', {callback = spawn_bag, callbackData = 'winch_part'})
	
	InventoryMenu:addMenuOption('main_menu','Сумки с добычей', 'loot_menu', {rectHighlightColor = Color(255, 138, 17, 9) / 255})
	InventoryMenu:addOption('loot_menu', 'Тост Алмира', {callback = spawn_bag, callbackData = 'sandwich'})
	InventoryMenu:addOption('loot_menu', 'Снаряды', {callback = spawn_bag, callbackData = 'ammo'})
	InventoryMenu:addOption('loot_menu', 'Артефакт', {callback = spawn_bag, callbackData = 'artifact_statue'})
	InventoryMenu:addOption('loot_menu', 'Часть бомбы', {callback = spawn_bag, callbackData = 'cro_loot1'})
	InventoryMenu:addOption('loot_menu', 'Часть бомбы 2', {callback = spawn_bag, callbackData = 'cro_loot2'})
	InventoryMenu:addOption('loot_menu', 'Кокаин', {callback = spawn_bag, callbackData = 'coke'})
	InventoryMenu:addOption('loot_menu', 'Украшения', {callback = spawn_bag, callbackData = 'diamonds'})
	InventoryMenu:addOption('loot_menu', 'Коза', {callback = spawn_bag, callbackData = 'goat'})
	InventoryMenu:addOption('loot_menu', 'Золото', {callback = spawn_bag, callbackData = 'gold'})
	InventoryMenu:addOption('loot_menu', 'Осколочные гранаты', {callback = spawn_bag, callbackData = 'grenades'})
	InventoryMenu:addOption('loot_menu', 'Потерянный артефакт', {callback = spawn_bag, callbackData = 'lost_artifact'})
	InventoryMenu:addOption('loot_menu', 'Шедевр искусства', {callback = spawn_bag, callbackData = 'masterpiece_painting'})
	InventoryMenu:addOption('loot_menu', 'Мет', {callback = spawn_bag, callbackData = 'meth'})
	InventoryMenu:addOption('loot_menu', 'Мет', {callback = spawn_bag, callbackData = 'meth_half'})
	InventoryMenu:addOption('loot_menu', 'Деньги', {callback = spawn_bag, callbackData = 'money'})
	InventoryMenu:addOption('loot_menu', 'Артефакт', {callback = spawn_bag, callbackData = 'mus_artifact'})
	InventoryMenu:addOption('loot_menu', 'Артефакт', {callback = spawn_bag, callbackData = 'mus_artifact_paint'})
	InventoryMenu:addOption('loot_menu', 'Картина', {callback = spawn_bag, callbackData = 'painting'})
	InventoryMenu:addOption('loot_menu', 'Свиная туша', {callback = spawn_bag, callbackData = 'din_pig'})
	InventoryMenu:addOption('loot_menu', 'Подарок', {callback = spawn_bag, callbackData = 'present'})
	InventoryMenu:addOption('loot_menu', 'Прототип', {callback = spawn_bag, callbackData = 'prototype'})
	InventoryMenu:addOption('loot_menu', 'Кокаин', {callback = spawn_bag, callbackData = 'coke_pure'})
	InventoryMenu:addOption('loot_menu', 'Броня самурая', {callback = spawn_bag, callbackData = 'samurai_suit'})
	InventoryMenu:addOption('loot_menu', 'Сейф Overkill', {callback = spawn_bag, callbackData = 'safe_ovk'})
	InventoryMenu:addOption('loot_menu', 'Сейф спутник', {callback = spawn_bag, callbackData = 'safe_wpn'})
	InventoryMenu:addOption('loot_menu', "Доля дантиста", {callback = spawn_bag, callbackData = 'unknown'})
	InventoryMenu:addOption('loot_menu', 'Бриллиант', {callback = spawn_bag, callbackData = 'hope_diamond'})
	InventoryMenu:addOption('loot_menu', 'Деталь турели', {callback = spawn_bag, callbackData = 'turret'})
	InventoryMenu:addOption('loot_menu', 'Боеголовка', {callback = spawn_bag, callbackData = 'warhead'})
	InventoryMenu:addOption('loot_menu', 'Оружие', {callback = spawn_bag, callbackData = 'weapon'})
	InventoryMenu:addGap('main_menu')
	InventoryMenu:addGap('main_menu')
	InventoryMenu:addGap('main_menu')
	InventoryMenu:addGap('main_menu')
	InventoryMenu:addGap('main_menu')
	InventoryMenu:addGap('main_menu')
	InventoryMenu:addInformationOption('main_menu', 'Спавн опции', {textColor = Color.DodgerBlue })
	InventoryMenu:addToggleOption('main_menu', 'Спавн на себя', {callback = function() Toggle.is_self = not Toggle.is_self end})
	InventoryMenu:addToggleOption('main_menu', 'Дождь из сумок', {callback = function() Toggle.is_rain = not Toggle.is_rain end, help = 'Do Not Spam, Will Cause Crash'})
	InventoryMenu:addToggleOption('main_menu', 'Спавн на прицел', {callback = function() Toggle.is_cross = not Toggle.is_cross end})
	InventoryMenu:addGap('main_menu')
	InventoryMenu:addGap('main_menu')
	InventoryMenu:addGap('main_menu')
	InventoryMenu:addGap('main_menu')
	InventoryMenu:addGap('main_menu')
	InventoryMenu:addGap('main_menu')
	InventoryMenu:addInformationOption('main_menu', 'Наст', {textColor = Color.DodgerBlue })
	InventoryMenu:addOption('main_menu', 'Упаковать все трупы в мешки', {callback = InteractType, callbackData = {'corpse_dispose'}, help = 'Упаковать все трупы в мешки'})
	InventoryMenu:addToggleOption('main_menu', 'Разрывные снаряды', {callback = shells, help = 'Теперь сумки взрываются'})
	InventoryMenu:addOption('main_menu', 'Забрать все сумки', {callback = InteractType, callbackData = {'carry_drop', 'painting_carry_drop', 'safe_carry_drop', 'parachute_carry_drop'}, help = 'Переносить болше сумок - должно быть включено или сумки пропадут'})

	InventoryMenu:addInformationOption('add_items_menu', 'Основные предметы', {textColor = Color.DodgerBlue})
	InventoryMenu:addOption('add_items_menu','Ключ-карточка', {callback = add_item, callbackData = 'bank_manager_key'})
	InventoryMenu:addOption('add_items_menu','Образец крови', {callback = add_item, callbackData = 'blood_sample'})
	InventoryMenu:addOption('add_items_menu','Доски', {callback = add_item, callbackData = 'boards'})
	InventoryMenu:addOption('add_items_menu','C4', {callback = add_item, callbackData = 'c4'})
	InventoryMenu:addOption('add_items_menu','Кабельные стяжки', {callback = add_item, callbackData = 'cable_tie'})
	InventoryMenu:addOption('add_items_menu','Ключи от машины', {callback = add_item, callbackData = 'c_keys'})
	InventoryMenu:addOption('add_items_menu','Ключ от самолета', {callback = add_item, callbackData = 'chavez_key'})
	InventoryMenu:addOption('add_items_menu','Круг-резак', {callback = add_item, callbackData = 'circle_cutter'})
	InventoryMenu:addOption('add_items_menu','Лом', {callback = add_item, callbackData = 'crowbar'})
	InventoryMenu:addGap('add_items_menu')
	InventoryMenu:addOption('add_items_menu','Газовый Баллон', {callback = add_item, callbackData = 'gas'})
	InventoryMenu:addOption('add_items_menu','Стеклорез', {callback = add_item, callbackData = 'mus_glas_cutter'})
	InventoryMenu:addOption('add_items_menu','Жесткий диск', {callback = add_item, callbackData = 'harddrive'})
	InventoryMenu:addOption('add_items_menu','Огнетушитель', {callback = add_item, callbackData = 'fire_extinguisher'})
	InventoryMenu:addOption('add_items_menu','Брелок', {callback = add_item, callbackData = 'keychain'})
	InventoryMenu:addOption('add_items_menu','Копье', {callback = add_item, callbackData = 'lance'})
	InventoryMenu:addOption('add_items_menu','Часть копья', {callback = add_item, callbackData = 'lance_part'})
	InventoryMenu:addOption('add_items_menu','Органы', {callback = add_item, callbackData = 'organs'})
	InventoryMenu:addGap('add_items_menu')
	InventoryMenu:addGap('add_items_menu')
	InventoryMenu:addOption('add_items_menu','Доски', {callback = add_item, callbackData = 'planks'})
	InventoryMenu:addOption('add_items_menu','Термит', {callback = add_item, callbackData = 'thermite_paste'})
	InventoryMenu:addGap('add_items_menu')
	InventoryMenu:addInformationOption('add_items_menu', 'Крысы/HOTLINE MIAMI химические ингредиенты', {textColor = Color.DodgerBlue})
	InventoryMenu:addOption('add_items_menu','Каустическая сода', {callback = add_item, callbackData = 'caustic_soda'})
	InventoryMenu:addOption('add_items_menu','Хлористый водород', {callback = add_item, callbackData = 'hydrogen_chloride'})
	InventoryMenu:addOption('add_items_menu','Соляная кислота', {callback = add_item, callbackData = 'acid'})	
	InventoryMenu:addGap('add_items_menu')
	InventoryMenu:addGap('add_items_menu')
	InventoryMenu:addGap('add_items_menu')
	InventoryMenu:addInformationOption('add_items_menu', 'HOTLINE MIAMI штрих-коды', {textColor = Color.DodgerBlue})
	InventoryMenu:addOption('add_items_menu','Downtown(Центр) Штрих-код', {callback = add_item, callbackData = 'barcode_downtown'})
	InventoryMenu:addOption('add_items_menu','Foggy Bottom(Туманное дно) Штрих-код', {callback = add_item, callbackData = 'barcode_isles_beach'})
	InventoryMenu:addOption('add_items_menu','George Town(Джордж Таун) Штрих-код', {callback = add_item, callbackData = 'barcode_brickell'})		
	InventoryMenu:addOption('add_items_menu','Shaw(Шоу) Штрих-код', {callback = add_item, callbackData = 'barcode_opa_locka'})	
	InventoryMenu:addOption('add_items_menu','West End(Уэст-Энд) Штрих-код', {callback = add_item, callbackData = 'barcode_edgewater'})
	InventoryMenu:addGap('add_items_menu')
	InventoryMenu:addGap('add_items_menu')
	InventoryMenu:addGap('add_items_menu')
	InventoryMenu:addGap('add_items_menu')
	InventoryMenu:addInformationOption('add_items_menu', 'Спасение Хокстона', {textColor = Color.DodgerBlue})
	InventoryMenu:addOption('add_items_menu','Мост ', {callback = add_item, callbackData = 'bridge'})
	InventoryMenu:addOption('add_items_menu','Доказательства', {callback = add_item, callbackData = 'evidence'})
	InventoryMenu:addOption('add_items_menu','Файлы', {callback = add_item, callbackData = 'files'})	
	InventoryMenu:addOption('add_items_menu','Жесткий диск', {callback = add_item, callbackData = 'harddrive'})
	InventoryMenu:addOption('add_items_menu','Билет', {callback = add_item, callbackData = 'ticket'})	
	InventoryMenu:addGap('add_items_menu')
	InventoryMenu:addGap('add_items_menu')
	InventoryMenu:addGap('add_items_menu')
	InventoryMenu:addGap('add_items_menu')
	InventoryMenu:addInformationOption('add_items_menu', 'Казино GOLDEN GRIN - Предметы', {textColor = Color.DodgerBlue})
	InventoryMenu:addOption('add_items_menu','BFD Инструмент', {callback = add_item, callbackData = 'cas_bfd_tool'})
	InventoryMenu:addOption('add_items_menu','План ', {callback = add_item, callbackData = 'blueprints'})
	InventoryMenu:addOption('add_items_menu','Бутылка ', {callback = add_item, callbackData = 'bottle'})
	InventoryMenu:addOption('add_items_menu','Ключ от лифта', {callback = add_item, callbackData = 'cas_elevator_key'})
	InventoryMenu:addOption('add_items_menu','Ключ от номера в отеле', {callback = add_item, callbackData = 'hotel_room_key'})
	InventoryMenu:addOption('add_items_menu','Успящий газ', {callback = add_item, callbackData = 'cas_sleeping_gas'})
	InventoryMenu:addOption('add_items_menu','USB-ключ (Данные)', {callback = add_item, callbackData = 'cas_data_usb_key'})	
	InventoryMenu:addOption('add_items_menu','Крюк от лебедки', {callback = add_item, callbackData = 'cas_winch_hook'})
end
-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------	
if inGame() and isPlaying() then
	if InventoryMenu:isOpen() then
		InventoryMenu:close()
	else
		if ChangerMenu then
			if ChangerMenu:isOpen() then
				ChangerMenu:close()
			end	
		end
		if PlayerMenu then
			if PlayerMenu:isOpen() then
				PlayerMenu:close()
			end	
		end	
		if StealthMenu then
			if StealthMenu:isOpen() then
				StealthMenu:close()
			end	
		end	
		if MissionMenu then
			if MissionMenu:isOpen() then
				MissionMenu:close()
			end	
		end
		if MoneyMenu then
			if MoneyMenu:isOpen() then
				MoneyMenu:close()
			end	
		end
		if NumpadMenu then
			if NumpadMenu:isOpen() then
				NumpadMenu:close()
			end	
		end
		if TrollMenu then
			if TrollMenu:isOpen() then
				TrollMenu:close()
			end	
		end
		if InteractTimerMenu then	
			if InteractTimerMenu:isOpen() then
				InteractTimerMenu:close()
			end	
		end	
		InventoryMenu:open()
	end 
end