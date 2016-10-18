if not MissionMenu then
	------------
	--- GAME ---
	------------
	-- ENABLE INTERACTION WITH ANYTHING
	local function enableinteract()
		Toggle.interact_with_all = not Toggle.interact_with_all
			
		-- DISABLE
		if not Toggle.interact_with_all then
			backuper:restore('BaseInteractionExt._has_required_upgrade')
			backuper:restore('BaseInteractionExt._has_required_deployable')
			backuper:restore('BaseInteractionExt.can_interact')
			backuper:restore('PlayerManager.remove_equipment')
			return
		end
		
		-- ENABLE
		backuper:backup('BaseInteractionExt._has_required_upgrade')
		function BaseInteractionExt:_has_required_upgrade(movement_state) return true end
		
		backuper:backup('BaseInteractionExt._has_required_deployable')
		function BaseInteractionExt:_has_required_deployable() return true end
		
		backuper:backup('BaseInteractionExt.can_interact')
		function BaseInteractionExt:can_interact(player) return true end
		
		backuper:backup('PlayerManager.remove_equipment')
		function PlayerManager:remove_equipment(equipment_id) end
	end
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------		
	-- BOARD UP WINDOWS
	function instaboardst()
		enableinteract()
		InteractType({'need_boards', 'stash_planks'})
		enableinteract()
		ChatMessage('Все окна заколочены', 'P3D Hack')
	end
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------				
	-- PLACE/RESTART DRILL ON DOORS/VAULT/SAFE
	function DrillAll()
		InteractType({
		'drill', 'drill_upgrade', 'drill_jammed', 'lance', 'lance_upgrade', 'lance_jammed', 'huge_lance', 'huge_lance_upgrade', 'huge_lance_jammed', 'apartment_drill', 'apartment_drill_jammed', 'suburbia_drill', 'suburbia_drill_jammed', 
		'goldheist_drill', 'goldheist_drill_jammed', 'cas_start_drill', "cas_fix_bfd_drill", "pd1_drill"
		})
		ChatMessage('Дрели установлены/перезапущены', 'P3D Hack')
	end	
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------		
	-- BANKBUSTER v3
	function bankbuster()
		local depositboxes = {}
		for _,v in pairs(managers.interaction._interactive_units) do
			if v.interaction then
				local id = string.sub(v:interaction()._unit:name():t(), 1, 10)
				if id == "@ID7999172" -- Harvest Bank
				or id == "@IDe4bc870" or id == "@ID51da6d6" or id == "@ID8d8c766" or id == "@ID50aac55" or id == "@ID5dcd177" --Armoured Transport
				or id == "@IDa95e021" -- The Big Bank
				or id == "@IDe93c9b2" then -- GO Bank
					table.insert(depositboxes, v:interaction())
				end	
			end 
		end 	
		for _,v in pairs(depositboxes) do
			v:interact(managers.player:player_unit())
		end
		ChatMessage('Все банковские ячейки открыты', 'P3D Hack')
	end
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------				
	-- OPEN ALL DOORS
	function picklockst()
		if P3DGroup_P3DHack.Classic_Open_Door then
			local locksmith = {}
			local id
			for _,v in pairs(managers.interaction._interactive_units) do
				if v.interaction then
					id = string.sub(v:interaction()._unit:name():t(), 1, 10)
					if id == "@IDe653b95" or id == "@ID18a7cac" or id == "@IDa25106d"
					or id == "@IDb025e83" or id == "@ID08a3353" or id == "@ID851f323"
					or id == "@ID8e70272" or id == "@ID1d283db" or id == "@ID5a95fe8"
					or id == "@ID622b34c" or id == "@ID1e56fe5" or id == "@IDa096513"
					or id == "@IDcfb8d38" or id == "@IDb68beff" or id == "@IDcfb8d38"
					or id == "@ID31ccfa0" or id == "@IDe653b95" or id == "@IDd40d72e" 
					or id == "@IDcffcea3" or id == "@ID559c3e4" or id == "@IDcfffc73"
					or id == "@IDbcd14bd" or id == "@ID5eb73ed" or id == '@IDd98f48a'
					or id == "@ID30a21bb" or id == "@ID6283ee0" or id == '@IDd99d699' then
						table.insert(locksmith, v:interaction())
					end 
				end 
			end
			for _,v in pairs(locksmith) do v:interact(managers.player:player_unit()) end
			ChatMessage('Все окна и двери открыты', 'P3D Hack')
		elseif P3DGroup_P3DHack.New_Open_Door then
			InteractType({'pick_lock_easy_no_skill', 'pick_lock_easy', "pick_lock_hard", "pick_lock_hard_no_skill", "lockpick_locker", "pick_lock_30", "pick_lock_deposit_transport"})
			ChatMessage('Все замки взломаны', 'P3D Hack')
		else
			P3DGroup_P3DHack.Classic_Open_Door = true
			ChatMessage('Все окна и двери открыты', 'P3D Hack')
		end
	end
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------			
	-- INSTANT GRAB DIAMOND (THE DIAMOND ONLY)
	function GrabDiamond()
		InteractType({'mus_hold_open_display', 'mus_take_diamond'})
		ChatMessage('Алмаз получен', 'P3D Hack')
	end
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------			
	-- OPEN ALL CRATES
	function opencrate()
		enableinteract()
		InteractType({'grenade_crate', 'crate_loot', 'crate_loot_crowbar', 'crate_weapon_crowbar'})
		enableinteract()
		ChatMessage('Все ящики открыты', 'P3D Hack')
	end
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------				
	-- USE KEYCARD
	function usekeycardt()
		enableinteract()
		InteractType({'key', 'key_double', 'numpad_keycard', 'timelock_panel', 'hold_close_keycard', 'mcm_panicroom_keycard', 'mcm_panicroom_keycard_2'})
		enableinteract()
		ChatMessage('Двери открыты с помощью ключ-карты ', 'P3D Hack')
	end
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------				
	-- TIE ALL CIVs
	function instanttie()
		enableinteract()
		InteractType({"requires_cable_ties", 'intimidate'})
		enableinteract()
		ChatMessage('Все граждане связаны', 'P3D Hack')
	end
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------		
	-- INSTANT OPEN & HACK VOTES MACHINES
	function instanthackmachines()
		enableinteract()
		InteractType({'votingmachine2', 'votingmachine2_jammed'})
		enableinteract()
		ChatMessage('Все машины для голосования вломаны и открыты', 'P3D Hack')
	end	
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------		
	-- CUT ALL GLASS (THE DIAMOND ONLY)
	function cutglass()
		enableinteract()
		InteractType({'glass_cutter', 'glass_cutter_jammed', 'cut_glass'})
		enableinteract()
		ChatMessage('Все стекла вырезаны', 'P3D Hack')
	end	
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------		
	-- INSTANT HACK PHONES, KEYPADS, COMPUTER, BOXES
	function InstantHackAll()
		enableinteract()
		InteractType({
			'use_computer', 'hospital_phone', 'iphone_answer', 'numpad_keycard', 'pickup_phone', 'timelock_numpad', 'big_computer_hackable', 'big_computer_not_hackable', 'big_computer_server', 'hold_use_computer', 'hack_numpad', 
			'timelock_hack', 'timelock_panel', 'uload_database', 'uload_database_jammed', 'hold_call_captain', 'move_ship_gps_coords', 'hold_hack_comp', 'hack_ipad', 'hack_ipad_jammed', 'hack_suburbia', 'hack_suburbia_jammed', 'hack_electric_box', 
			'hack_ship_control', 'security_station', 'security_station_keyboard', 'security_station_jammed', 'keyboard_no_time', 'keyboard_eday_1', 'keyboard_eday_2', 'keyboard_hox_1', 'use_server_device', 'enter_code', 'hold_download_keys', 
			'requires_ecm_jammer_double', 'rewire_electric_box', 'rewire_timelock', 'invisible_interaction_open', 'mcm_laptop', 'mcm_laptop_code', 'hospital_security_cable', 'enter_code', 'fingerprint_scanner', 'pickup_harddrive', 'place_harddrive', 
			'hack_skylight_barrier', 'disable_lasers', 'use_blueprints', 'cas_connect_power', 'send_blueprints', 'cas_copy_usb', 'cas_use_usb', 'cas_customer_database'
		})
		enableinteract()
		ChatMessage('Вся электронная техника взломана', 'P3D Hack')
	end	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------			
	-- TAKE ALL INTEL
	local function takeintel()
		local instanttakeintel = {}
		local id
		for _,v in pairs(managers.interaction._interactive_units) do
			if v.interaction then
				id = string.sub(v:interaction()._unit:name():t(), 1, 10)
				if id == "@IDcfbdf01" or id == "@IDdd0578d" or id == "@ID54e8d78"
				or id == "@IDbb82cfc" or id == "@ID39a5689" or id == "@ID22c41a3"
				or id == "@ID9140188" or id == "@IDdf59d98" or id == "@IDd2e9092"
				or id == "@IDad6fb7a" or id == "@ID9c5716b" or id == "@ID8834e3a" then
					table.insert(instanttakeintel, v:interaction())
				end 
			end 
		end
		for _,v in pairs(instanttakeintel) do v:interact(managers.player:player_unit()) end
		InteractType({'computer_blueprints', 'cas_take_unknown', 'winning_slip', 'cas_take_usb_key_data'})
		ChatMessage('Все разведывательные данные были защищены', 'Разведывательные данные')
	end---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------		
	-- INSTANT GRAB ALL COURIER PACKAGES
	function grabcourier()
		InteractType({'gage_assignment'})
		ChatMessage('Все Gage пакеты подобраны', 'P3D Hack')
	end	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------		
	-- MISSION MANIPULATOR/CONTINUE MISSON
	function getpatht()
		local ontrack = {} 
		local id
		for _,v in pairs(managers.interaction._interactive_units) do
			if v.interaction then
				id = string.sub(v:interaction()._unit:name():t(), 1, 10)
				if id == "@ID99aa0ad" or id == "@ID51001ab" or id == "@IDca8a8a2"
				or id == "@ID51001ab" or id == "@ID03777a0" or id == "@ID4a6b073"
				or id == "@ID7883aa4" or id == "@IDeee53eb" or id == "@ID1a1c9b0"
				or id == "@IDda87b02" or id == "@ID9140188" or id == "@ID15d846f"
				or id == "@ID4e2b16f" or id == "@IDf1461ef" or id == "@ID7dc5f75"
				or id == "@IDd8b036e" or id == "@ID9140188" or id == "@ID39a5689"
				or id == "@ID22c41a3" or id == "@IDdf59d98" or id == "@ID5a95fe8"
				or id == "@ID6a55816" or id == "@IDf105b35" or id == "@IDd8b036e"
				or id == "@ID64b82ec" or id == "@ID1f6a50d" or id == "@ID077636c"
				or id == "@ID6dbc2f1" or id == "@IDdd16274" or id == "@ID136f21b"
				or id == "@ID2be5897" or id == "@IDc54c876" or id == "@IDdb2e8d0"
				or id == "@ID2a72308" or id == "@IDd5e1a53" or id == "@ID853940b"
				or id == "@IDcfbdf01" or id == "@IDbb82cfc" or id == "@ID54e8d78"
				or id == "@IDd90bf4a" or id == "@ID0275b3e" or id == "@ID08a6323"
				or id == "@IDdd0578d" or id == "@ID4ba585b" or id == "@IDe258187"
				or id == "@ID5422d8b" or id == "@IDe6cb9c8" then 
					table.insert(ontrack, v:interaction())
				end 
			end 
		end
		for _,v in pairs(ontrack) do v:interact(managers.player:player_unit()) end
		ChatMessage('Предмет миссии получен', 'P3D Hack')
	end
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------		
	-- OPEN ALL DOORS WITH ECM
	function ecmopen()
		if isHost() then
			enableinteract()
			InteractType({"requires_ecm_jammer", "requires_ecm_jammer_double"})
			enableinteract()
			ChatMessage('Все двери открыты с помощью ECM', 'P3D Hack')
		end 
	end	
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------		
	-- OPEN ALL PRESENTS (WHITE XMAS)
	function xmaspresent()
		InteractType({"hold_open_xmas_present"})
		ChatMessage('Все подарки открыты', 'P3D Hack')
	end	
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------		
	-- PLACE FLARE (WHITE XMAS)
	function xmasflare()
		InteractType({'place_flare', 'ignite_flare'})
		ChatMessage('Сигнальные ракеты активированы', 'P3D Hack')
	end
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------		
	-- GRAB GEAR (Golden Grin Casino)
	function grabgear()
		InteractType({'cas_open_guitar_case'})
		InteractType({'cas_take_gear'})
		ChatMessage('Механизм схвачен', 'P3D Hack')
	end
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------		
	-- OPEN ALL DOORS WITH C4
	function c4open()
		enableinteract()
		InteractType({'c4_special', 'shaped_sharge', 'c4_diffusible'})
		enableinteract()
		ChatMessage('Все двери открыты с помощью C4', 'P3D Hack')
	end
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------		
	-- COWER ALL CIVS (BY INFORMATIXA)
	function civilsdown(count)
		for _, data in pairs(managers.enemy:all_civilians()) do
			data.unit:brain():on_intimidated(100, managers.player:player_unit())
		end	
	end
	function civil()	
		for i = 1,20,1 do 
			civilsdown(i) 
		end
		ChatMessage('Все граждански напуганы', 'P3D Hack')
	end
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------		
	-- INSTANT WIN
	function jobwin()
		if isHost() then
			if isPlaying() then	
				local num_winners = managers.network:session():amount_of_alive_players()
				managers.network:session():send_to_peers("mission_ended", true, num_winners)
				game_state_machine:change_state_by_name("victoryscreen", {num_winners = num_winners, personal_win = true})
			end
		else
			ChatMessage('Только хост', 'P3D Hack')
		end	
	end
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------		
	-- INSTANT LOSS
	function jobloss()
		if isHost() then
			if isPlaying() then	
				managers.network:session():send_to_peers("mission_ended", false, 0)
				game_state_machine:change_state_by_name("gameoverscreen")
			end
		else
			ChatMessage('Только хост', 'P3D Hack')
		end	
	end
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------		
	-- SPAWN CONFIDANTIAL TRAIN HEIST INFO
	function heistintel()	
		if isHost() and (managers.job:current_level_id() == 'arm_hcm' or managers.job:current_level_id() == 'arm_cro' or managers.job:current_level_id() == 'arm_fac' or managers.job:current_level_id() == 'arm_par' or managers.job:current_level_id() == 'arm_und') then
			local position = managers.player:player_unit():position()
			local rotation = managers.player:player_unit():rotation()
			local unit = "units/payday2/props/gen_prop_loot_confidential_folder_event/gen_prop_loot_confidential_folder_event"
			World:spawn_unit(Idstring(unit), position, rotation)
			ChatMessage('Разведывательные данные о поезеде лежат у вас под ногами', 'P3D Hack')
		end	
	end
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------		
	-- BETTY BOOM MOD (EXPLODING AI)
	local function bettyboom()
		Toggle.BettyBoom = not Toggle.BettyBoom
	
		if not Toggle.BettyBoom then
			backuper:restore('CopActionHurt.on_death_drop')
			ChatMessage('Выключено', 'Взрывающиеся боты')
			return
		end
		
		ChatMessage('Включено', 'Взрывающиеся боты')
		local CopActionHurt_on_death_drop = backuper:backup('CopActionHurt.on_death_drop')
		function CopActionHurt:on_death_drop(unit, stage)
			for i = 1,2 do
				ModBagSpawn('ammo', self._unit:position(), 120)
			end
			return CopActionHurt_on_death_drop(self, unit, stage)
		end
	end
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------		
	-- DIRTY MONEY MOD (SPAWNS GOLD ON AI DEATH)
	local function dirtymoney()
		Toggle.DirtyMoney = not Toggle.DirtyMoney
	
		if not Toggle.DirtyMoney then
			backuper:restore('CopActionHurt.on_death_drop')
			ChatMessage('Выключено', 'Грязные деньги')
			return
		end
		
		ChatMessage('Включено', 'Грязные деньги')
		local CopActionHurt_on_death_drop = backuper:backup('CopActionHurt.on_death_drop')
		function CopActionHurt:on_death_drop(unit, stage)
			for i = 0,1 do
				ModBagSpawn('gold', self._unit:position(), 120)
			end
			return CopActionHurt_on_death_drop(self, unit, stage)
		end
	end
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------		
	-- RATS AUTO COOKER (BALDWIN)
	function autocook()
		Toggle.auto_cooker = not Toggle.auto_cooker

		if not Toggle.auto_cooker then
			backuper:restore('DialogManager.queue_dialog')
			ChatMessage('Выключено', 'Автоматическая плита')
			return
		end

		local cookinteract = function(drugs) --Needed for autocook.
			local coolers = {}
			local player = managers.player:local_player()
			if not player then return end
			for _,unit in pairs(managers.interaction._interactive_units) do
				if unit:interaction().tweak_data == drugs then
					unit:interaction():interact(player)
					break --I'm sure, that here is only 1 interactive object
				end	
			end 
			if drugs == "taking_meth" then
				ServerSpawnRatBag("meth")
				managers.player:clear_carry()
			end	
		end

		ChatMessage('Включено', 'Автоматическая плита')
		backuper:hijack('DialogManager.queue_dialog', function(o, self, id, params)
			if id == "pln_rt1_22" then cookinteract("methlab_caustic_cooler")
			elseif id == "pln_rt1_20" then cookinteract("methlab_bubbling")
			elseif id == "pln_rt1_24" then cookinteract("methlab_gas_to_salt")
			elseif id == "pln_rat_stage1_28" or id == "pln_rat_stage1_29" then cookinteract("taking_meth")
			end
			return o(self, id, params )
		end)
	end
-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------
	MissionMenu = CustomMenuClass:new()
	MissionMenu:addMainMenu('main_menu', {title = 'Редактор миссии', maxRows = 12})
	MissionMenu:addMenu('mod_menu', {title = 'Модификации'})
	MissionMenu:addInformationOption('main_menu', 'Редактировать:', {textColor = Color.red})
	-- Mod Menu Column 1
	MissionMenu:addMenuOption('main_menu', 'Меню модификаций', 'mod_menu', {rectHighlightColor = Color(255, 138, 17, 9) / 255})
	MissionMenu:addInformationOption('mod_menu', 'Переключаемо', {textColor = Color.DodgerBlue})
	MissionMenu:addToggleOption('mod_menu','Бетти Бум', {callback = bettyboom, help = 'Взрывает ботов после смерти'})  
	MissionMenu:addToggleOption('mod_menu','Грязные деньги', {callback = dirtymoney, help = 'Две сумки с золотомпосле смерти ботов'})  
	if managers.job:current_level_id() == 'alex_1' or managers.job:current_level_id() == 'rat' then
		MissionMenu:addToggleOption('mod_menu','Крысы Автоматическая плита', {callback = autocook, help = 'Автоматическая готовка на миссии крысы, Вы должны иметь химические элементы, чтобы это работало'})  
	else
		MissionMenu:addInformationOption('mod_menu', 'Крысы день 1 только', {textColor = Color.yellow})
	end
	for i=1,20 do
		MissionMenu:addGap('mod_menu')
    end
	
	-- Main Menu Column 1
	MissionMenu:addMenuOption('main_menu', '', 'mouse_menu', {rectHighlightColor = Color(255, 138, 17, 9) / 255})
	MissionMenu:addGap('main_menu')
	MissionMenu:addInformationOption('main_menu', 'Манипулировать:', {textColor = Color.DodgerBlue})
	MissionMenu:addOption('main_menu','Запугать гражданских', {callback = civil, help = 'Запугать всех гражданских лиц, нажмите несколько раз, чтобы уложить их на пол'})
	MissionMenu:addOption('main_menu','Заколотить все окна', {callback = instaboardst, help = 'Заколотить всех доступных окна'})
	if isHost() then
		if managers.job:current_level_id() == 'mus' then		
			MissionMenu:addOption('main_menu','Вырезать все стекла', {callback = cutglass})
		else	
			MissionMenu:addInformationOption('main_menu', 'Только Брилиант', {textColor = Color.yellow })
		end		
		if (managers.job:current_level_id() == 'arm_hcm' or managers.job:current_level_id() == 'arm_cro' or managers.job:current_level_id() == 'arm_fac' or managers.job:current_level_id() == 'arm_par' or managers.job:current_level_id() == 'arm_und') then		
			MissionMenu:addOption('main_menu','Заспавнить информацию о поезде', {callback = heistintel, help = 'Можно заспавнить только на транспортных ограблениях'})
		else	
			MissionMenu:addInformationOption('main_menu', 'Только транспортные ограбления', {textColor = Color.yellow })
		end
	else
		MissionMenu:addInformationOption('main_menu', 'Недоступно (Только хост))', {textColor = Color.yellow})
		MissionMenu:addInformationOption('main_menu', 'Недоступно (Только хост))', {textColor = Color.yellow})
	end
	MissionMenu:addOption('main_menu','Получить вещь миссии', {callback = getpatht, help = 'Должно быть включен Переносить болше сумок'})
	if isHost() then
		MissionMenu:addOption('main_menu','Собрать все Gage пакеты', {callback = grabcourier, help = 'Собрать все доступные Gage пакеты'})
	else
		MissionMenu:addOption('main_menu','Собрать все Gage пакеты', {callback = grabcourier, help = 'Собрать все доступные Gage пакеты'})
	end
	if managers.job:current_level_id() == 'kenaz' then		
		MissionMenu:addOption('main_menu','Захват механизм', {callback = grabgear, help = "Нажмите дважды, чтобы захватить механизм"})
	else	
		MissionMenu:addInformationOption('main_menu', 'Только казино Golden Grin', {textColor = Color.yellow })
	end		

	-- Main Menu Column 2
	MissionMenu:addInformationOption('main_menu', 'Анти-Чит', {textColor = Color.DodgerBlue})
	if isHost() then
		if P3DGroup_P3DHack.Anti_Cheat_Disable then
			MissionMenu:addToggleOption('main_menu','Выключить Анти-Чит', {callback = anticheat, toggle = true, help = 'Включить или выключить Анти-Чит для хоста и клиента'})
		else	
			MissionMenu:addToggleOption('main_menu','Выключить Анти-Чит', {callback = anticheat, toggle = false, help = 'Включить или выключить Анти-Чит для хоста и клиента'})
		end
	else
		MissionMenu:addInformationOption('main_menu', 'Недоступно (Только хост))', {textColor = Color.yellow})
	end
	MissionMenu:addGap('main_menu')	
	MissionMenu:addGap('main_menu')
	MissionMenu:addGap('main_menu')
	MissionMenu:addOption('main_menu','Взломать всю электронику', {callback = InstantHackAll , help = 'Взламывает всю доступную технику'})
	if isHost() then
		if managers.job:current_level_id() == "mus" then
			MissionMenu:addOption('main_menu','Подобрать алмаз', {callback = GrabDiamond, help = 'Нажмите дважды, чтобы подобрать'})
		else	
			MissionMenu:addInformationOption('main_menu', 'Только на Брилианте', {textColor = Color.yellow})
		end
	else
		MissionMenu:addInformationOption('main_menu', 'Недоступно (Только хост))', {textColor = Color.yellow})
	end
	if isHost() then
		if managers.job:current_level_id() == "election_day_2" then
			MissionMenu:addOption('main_menu','Взломать и открыть машины для голосования', {callback = instanthackmachines})
		else	
			MissionMenu:addInformationOption('main_menu', 'Только день выборов', {textColor = Color.yellow})
		end
	else
		MissionMenu:addInformationOption('main_menu', 'Недоступно (Только хост))', {textColor = Color.yellow})
	end
	MissionMenu:addOption('main_menu','Открыть все ящики', {callback = opencrate, help = 'Вы также можете их закрыть'})
	MissionMenu:addOption('main_menu','Открыть все банковские ячейки', {callback = bankbuster})
	if P3DGroup_P3DHack.Classic_Open_Door then
		MissionMenu:addOption('main_menu','Открыть все двери и окна', {callback = picklockst, help = 'Не открывает комнату охраны'})
	elseif P3DGroup_P3DHack.New_Open_Door then
		MissionMenu:addOption('main_menu','Открыть все замки', {callback = picklockst, help = 'Открывает все замки в том числе банковские ячейки, но это не открывает комнату охраны'})
	else
		MissionMenu:addOption('main_menu','Открыть все двери и окна', {callback = picklockst, help = 'Не открывает комнату охраны'})
	end
	if isHost() then
		MissionMenu:addOption('main_menu','Открыть все с помощь C4', {callback = c4open})
	else
		MissionMenu:addInformationOption('main_menu', 'Недоступно (Только хост))', {textColor = Color.yellow })
	end
	
	-- Main Menu Column 3
	MissionMenu:addInformationOption('main_menu', 'Победить/Проиграть', {textColor = Color.DodgerBlue}) 
	if isHost() then
		MissionMenu:addOption('main_menu','Проиграть', {callback = jobloss, closeMenu = true})
		MissionMenu:addOption('main_menu','Победить', {callback = jobwin, closeMenu = true})
	else
		MissionMenu:addInformationOption('main_menu', 'Недоступно (Только хост))', {textColor = Color.yellow})
		MissionMenu:addInformationOption('main_menu', 'Недоступно (Только хост))', {textColor = Color.yellow})
	end
	MissionMenu:addGap('main_menu')
	MissionMenu:addGap('main_menu')
	if isHost() then
		MissionMenu:addOption('main_menu', 'Открыть все с помощью ECM', {callback = ecmopen})
	else
		MissionMenu:addInformationOption('main_menu', 'Недоступно (Только хост))', {textColor = Color.yellow})
	end
	MissionMenu:addOption('main_menu','Открыть с помощью ключ-карты', {callback = usekeycardt, help = "Открыть все двери с помощью ключ-карточки"})
	if managers.job:current_level_id() == 'pines' then
		MissionMenu:addOption('main_menu','Открыть все подарки', {callback = xmaspresent})
	else
		MissionMenu:addInformationOption('main_menu', 'Только рождество', {textColor = Color.yellow})
	end
	if managers.job:current_level_id() == 'pines' then	
		MissionMenu:addOption('main_menu','Запустить сигнальную ракету', {callback = xmasflare})
	else
		MissionMenu:addInformationOption('main_menu', 'Только рождество', {textColor = Color.yellow})
	end
	if isHost() then
		MissionMenu:addOption('main_menu','Установка/Перезапуск дрели', {callback = DrillAll, help = 'Установка или перезапуск любой дрели'})
		MissionMenu:addOption('main_menu', 'Взять все данные', {callback = takeintel, help = 'Нажмите дважды, чтобы получить предмет из сейфа'})
	else
		MissionMenu:addInformationOption('main_menu', 'Недоступно (Только хост)', {textColor = Color.yellow })
		MissionMenu:addInformationOption('main_menu', 'Недоступно (Только хост)', {textColor = Color.yellow})
	end
	MissionMenu:addOption('main_menu','Связать всех гражданских лиц', {callback = instanttie, help = 'Все гражданские должны быть испуганы, прежде чем активировать'})
end
-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------
if inGame() and isPlaying() then
	if MissionMenu:isOpen() then
		MissionMenu:close()
	else
		if ChangerMenu then
			if ChangerMenu:isOpen() then
				ChangerMenu:close()
			end	
		end
		if PlayerMenu then
			if PlayerMenu:isOpen() then
				PlayerMenu:close()
		end	end		
		if StealthMenu then
			if StealthMenu:isOpen() then
				StealthMenu:close()
			end	
		end		
		if InventoryMenu then
			if InventoryMenu:isOpen() then
				InventoryMenu:close()
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
		MissionMenu:open()
	end 
end