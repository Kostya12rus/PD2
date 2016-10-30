if not StealthMenu then
	-- UNLOCK MESSIAH CHARGES SKILL
	local function unlmessiah()		
		Toggle.got_messiah_charges = not Toggle.got_messiah_charges

		if not Toggle.got_messiah_charges then
			backuper:restore("PlayerDamage.got_messiah_charges")
			ChatMessage('Выключено', 'Бесконечный шанс мессии')
			return
		end
		
		backuper:backup("PlayerDamage.got_messiah_charges")
		function PlayerDamage:got_messiah_charges() 
			return managers.player:upgrade_value("player", "pistol_revive_from_bleed_out", 0) 
		end	
		ChatMessage('Включено', 'Бесконечный шанс мессии')
	end
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------		
	-- REMOTE CAMERA ACCESS
	function remote_camera()
		game_state_machine:change_state_by_name("ingame_access_camera")
	end
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------		
	-- COPS DONT SHOOT
	local function cops_dont_shoot()			
		Toggle.copsdontshoot = not Toggle.copsdontshoot

		if not Toggle.copsdontshoot then
			backuper:restore('CopMovement.set_allow_fire')
			backuper:restore('CopMovement.set_allow_fire_on_client')
			ChatMessage('Выключено', 'Полиция не стреляет')
			return
		end
		
		local _setAllowFire = backuper:backup('CopMovement.set_allow_fire')
		function CopMovement:set_allow_fire(state)
			if state == false then 
				_setAllowFire(self, state) 
			end
		end
		
		local _setAllowFireClient = backuper:backup('CopMovement.set_allow_fire_on_client')
		function CopMovement:set_allow_fire_on_client(state, unit)
			if state == false then 
				_setAllowFireClient(self, state, unit) 
			end
		end
		ChatMessage('Включено', 'Полиция не стреляет')
	end
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------		
	-- NO CALL POLICE
	local function people_dont_call_police()		
		Toggle.dont_call_police = not Toggle.dont_call_police

		if not Toggle.dont_call_police then
			backuper:restore('GroupAIStateBase.on_police_called')
			backuper:restore('CivilianLogicFlee.clbk_chk_call_the_police')
			ChatMessage('Выключено', 'Гражданские не звонят в полицию')
			return
		end

		backuper:backup('GroupAIStateBase.on_police_called')
		function GroupAIStateBase:on_police_called(called_reason) end
		
		backuper:backup('CivilianLogicFlee.clbk_chk_call_the_police')
		function CivilianLogicFlee.clbk_chk_call_the_police(ignore_this, data) end
		ChatMessage('Включено', 'Гражданские не звонят в полицию')
	end
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------		
	-- NO PANIC BUTTON
	local function prevent_panic_buttons()	
		Toggle.preventpanicbuttons = not Toggle.preventpanicbuttons

		if not Toggle.preventpanicbuttons then 
			backuper:restore('CopMovement.action_request')
			ChatMessage('Выключено', 'Нет кнопки паники')
			return
		end

		local _actionRequest = backuper:backup('CopMovement.action_request')
		function CopMovement:action_request(action_desc)
			if action_desc.variant == "run" or action_desc.variant == "e_so_alarm_under_table" or action_desc.variant == "cmf_so_press_alarm_wall" 
			or action_desc.variant == "cmf_so_press_alarm_table" or action_desc.variant == "cmf_so_call_police" or action_desc.variant == "arrest_call" then 
				return false 
			end
			return _actionRequest(self, action_desc)
		end
		ChatMessage('Включено', 'Нет кнопки паники')	
	end
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------		
	-- NO CASH PENALTY FOR KILLING CIVILLIANS
	local function free_kill()		
		Toggle.free_kill = not Toggle.free_kill
		
		-- DISABLE FREE KILL
		if not Toggle.free_kill then
			backuper:restore('MoneyManager.get_civilian_deduction')
			backuper:restore('MoneyManager.civilian_killed')
			backuper:restore('UnitNetworkHandler.sync_hostage_killed_warning')
			ChatMessage('Выключено', 'Бесплатное убийство гражданских')
			return
		end

		-- ENABLE FREE KILL
		backuper:backup('MoneyManager.get_civilian_deduction')
		function MoneyManager.get_civilian_deduction() return 0 end
		
		backuper:backup('MoneyManager.civilian_killed')
		function MoneyManager.civilian_killed() return end
		
		backuper:backup('UnitNetworkHandler.sync_hostage_killed_warning')
		function UnitNetworkHandler:sync_hostage_killed_warning(warning) return end	
		ChatMessage('Включено', 'Бесплатное убийство гражданских')
	end
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------		
	-- DISABLE CAMS 
	function disable_cams()
		Toggle.disablecams = not Toggle.disablecams
	
		if not Toggle.disablecams then
			for _,unit in pairs(GroupAIStateBase._security_cameras) do
				unit:base():set_update_enabled(true)
			end	
			ChatMessage('Выключено', 'Отключить камеры')
			return
		end
			
		-- DISABLE CAMS
		for _,unit in pairs(GroupAIStateBase._security_cameras) do
			unit:base():set_update_enabled(false)
		end
		ChatMessage('Включено', 'Отключить камеры')
	end
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------		
	-- PAGERS DISABLE
	local function disable_pagers()		
		Toggle.disablepagers = not Toggle.disablepagers
			
		-- ENABLE PAGERS
		if not Toggle.disablepagers then
			backuper:restore('CopBrain.begin_alarm_pager')
			ChatMessage('Выключено', 'Отключить пейджеры')
			return
		end
			
		backuper:backup('CopBrain.begin_alarm_pager')
		function CopBrain:begin_alarm_pager(reset)
			if not reset and self._alarm_pager_has_run then
				return
			end
			self._alarm_pager_has_run = true
		end
		
		ChatMessage('Включено', 'Отключить пейджеры')
	end
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------		
	-- LOBOTOMIZE ALL AI by voodoo
	local function lobai()
		Toggle.lobotomize_ai = not Toggle.lobotomize_ai

		if not Toggle.lobotomize_ai then -- Enable AI
			-- Restore spawn AI function
			backuper:restore('CopBrain.set_spawn_ai')
			ChatMessage('Выключена', 'Лоботомия')
			for u_key, u_data in pairs( managers.enemy:all_enemies() ) do
				u_data.unit:brain():set_active( true )
			end
			for u_key, u_data in pairs( managers.enemy:all_civilians() ) do
				u_data.unit:brain():set_active( true )
			end
			for u_key, unit in pairs( SecurityCamera.cameras ) do
				unit:base()._detection_interval = 0.1
			end
		else -- Disable AI
			ChatMessage('Включена', 'Лоботомия')
			for u_key, u_data in pairs( managers.enemy:all_enemies() ) do
				u_data.unit:brain():set_active( false )
			end
			for u_key, u_data in pairs( managers.enemy:all_civilians() ) do
				u_data.unit:brain():set_active( false )
			end
			for u_key, unit in pairs( SecurityCamera.cameras ) do
				unit:base():_destroy_all_detected_attention_object_data()
				unit:base():_send_net_event( 1 )
				unit:base()._detection_interval = 1000000
			end
			
			-- Backup spawn AI function
			backuper:backup('CopBrain.set_spawn_ai')
			
			-- Set default spawn AI to inactive
			function CopBrain:set_spawn_ai( spawn_ai )
				spawn_ai.init_state = "inactive"
				self._spawn_ai = spawn_ai
				self:set_update_enabled_state( true )
				self:set_logic( "inactive" )
				if spawn_ai.stance then
					self._unit:movement():set_stance( spawn_ai.stance )
				end
				if spawn_ai.objective then
					self:set_objective( spawn_ai.objective )
				end	
			end
			
			-- BUGFIX: if objective == nil, abort (Do not undo this function)
			function CopBrain:set_followup_objective( followup_objective )
				if not self._logic_data.objective then
					return
				end
				local old_followup = self._logic_data.objective.followup_objective
				self._logic_data.objective.followup_objective = followup_objective
				
				if followup_objective and followup_objective.interaction_voice then
					self._unit:network():send( "set_interaction_voice", followup_objective.interaction_voice )
				elseif old_followup and old_followup.interaction_voice then
					self._unit:network():send( "set_interaction_voice", "" )
				end	
			end	
		end	
	end
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------		
	-- STEAL PAGERS By Harfatus
	local function steal_pagers_on_melee() 				
		Toggle.steal_pagers = not Toggle.steal_pagers
		
		if not Toggle.steal_pagers then
			backuper:restore('PlayerManager.upgrade_value')
			ChatMessage('Выключено', 'Украсть пейджеры')
			return
		end

		PlayerManager.___upgrade_value = backuper:backup('PlayerManager.upgrade_value')
		function PlayerManager:upgrade_value(cat, upg, ...) 
			if cat == "player" and upg == "melee_kill_snatch_pager_chance" then 
				return 1
			end 
			return PlayerManager.___upgrade_value(self, cat, upg, ...) 
		end	
		ChatMessage('Включено', 'Украсть пейджеры')
	end
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------			
	-- NO PAGER ON DOMINATE
	local function pagedom()	
		Toggle.no_pager_dom = not Toggle.no_pager_dom
			
		if not Toggle.no_pager_dom then
			backuper:restore('CopLogicIntimidated._chk_begin_alarm_pager')
			ChatMessage('Выключено', 'Нет пейджера при доминации')
			return
		end
		
		backuper:backup('CopLogicIntimidated._chk_begin_alarm_pager')
		function CopLogicIntimidated._chk_begin_alarm_pager(data) 
			if managers.groupai:state():whisper_mode() and data.unit:unit_data().has_alarm_pager then
			end
		end
		ChatMessage('Включено', 'Нет пейджера при доминации')
	end	
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------			
	-- CONVERT ALL ENEMIES
	local function convertall()
		if isHost() then
			tweak_data.upgrades.values.player.convert_enemies = {true}
			tweak_data.upgrades.values.player.convert_enemies_max_minions = {999999,999999}

			for _, data in pairs(managers.enemy:all_enemies()) do
				if Network:is_server() then
					managers.groupai:state():convert_hostage_to_criminal(data.unit)
				else
					managers.network:session():send_to_host("sync_interacted", data.unit, data.unit:id(), data.tweak_data, 1)
				end	
			end	
		end		
		ChatMessage('Все враги задоминированы', 'P3D Hack')
	end 
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------		
	-- RANDOM PAGER
	local function randompage()
		Toggle.randompage = not Toggle.randompage

		if not Toggle.randompage then
			backuper:restore('CopBrain.clbk_alarm_pager')
			ChatMessage('Выключено', 'Случайные пейджеры')
			return
		end

		ChatMessage('Включено', 'Случайные пейджеры')
		local _CopBrain_clbk_alarm_pager = backuper:backup('CopBrain.clbk_alarm_pager')
		function CopBrain:clbk_alarm_pager(ignore_this, data)
			-- Create a random number
			local rand = math.rand(1)
			-- 50% / 25% / 12.5% / 0% incrementing chances of no pager in a table
			local chance_table = {0.5, 0.25, 0.125, 0}
			-- Initalise table index as 1 if not defined
			self._cTableIndex = self._cTableIndex or 1
			-- Clamp the index so that it's never out of bounds
			self._cTableIndex = math.clamp(self._cTableIndex, 1, #chance_table)
			-- Establish the chance only if the guard is unalerted, by fetching the table value using the current index
			local chance = self._unit:movement():cool() and chance_table[self._cTableIndex] or 0
			-- If the random number is less than our current chance
			if self._alarm_pager_data.nr_calls_made == 0 and rand < chance then
				-- Increment the index
				self._cTableIndex = self._cTableIndex + 1
				-- Prevent the pager from going off
				self:end_alarm_pager()
				-- Enable bodybag interaction
				self:_chk_enable_bodybag_interaction()
				return
			end
			-- Otherwise run the original function
			_CopBrain_clbk_alarm_pager(self, ignore_this, data)
		end 
	end
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------		
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------		
	-- ENEMY MIND CONTROL --
	-- MAKE PIGS FLY
	local function pigsfly()
		if isHost() then
			local poses = {"e_sp_repel_into_window"}

			for k,v in pairs(managers.enemy:all_enemies()) do
				local act = {type = "act", variant = poses[math.random(1, #poses)], body_part = 1, align_sync = true}
				v.unit:movement():action_request(act)
			end
		end	
	end
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------		
	-- QUITTER COPS	
	local function copsquit()
		if isHost() then
			local poses = {"hands_up" , "tied", "hands_back"}

			for k,v in pairs(managers.enemy:all_enemies()) do
				local act = {type = "act", variant = poses[math.random(3)], body_part = 1, align_sync = true}
				v.unit:movement():action_request(act)
			end	
		end	
	end
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------			
	-- DRUNK PIGS	
	local function drunkpigs()	
		if isHost() then
			local poses = {"e_sp_dizzy_stand", "e_sp_dizzy_get_up"}

			for k,v in pairs(managers.enemy:all_enemies()) do
				local act = {type = "act", variant = poses[math.random(2)], body_part = 1, align_sync = true}
				v.unit:movement():action_request(act)
			end	
		end	
	end
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------		
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------		
	-- CIVILIAN MIND CONTROL --
	-- MAKE CIVS DANCE SEXY
	local function civdance()	
		if isHost() then
			local poses = {"cf_sp_dance_slow", "cf_sp_dance_sexy", "cf_sp_pole_dancer_expert", "cf_sp_pole_dancer_basic"}

			for k,v in pairs(managers.enemy:all_civilians()) do
				local act = {type = "act", variant = poses[math.random(4)], body_part = 1, align_sync = true}
				v.unit:movement():action_request(act)		
			end	
		end 
	end
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------		
	-- MAKE CIVS SMOKE UP
	local function civsmoke()
		if isHost() then
			local poses = {"cm_sp_smoking_left1", "cf_sp_smoking_var1", "cm_sp_smoking_right1", "cmf_so_smoke"}

			for k,v in pairs(managers.enemy:all_civilians()) do
				local act = {type = "act", variant = poses[math.random(4)], body_part = 1, align_sync = true}
				v.unit:movement():action_request(act)
			end	
		end 
	end
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------		
	
	-- MAKE CIVS COVER AT YOUR FEET
	local function civcower()	
		if isHost() then
			local poses = {"cm_sp_recieving_cpr", "cm_sp_wounded_lying2", "cm_sp_wounded_lying", "cf_sp_lying_hurt"}

			for k,v in pairs(managers.enemy:all_civilians()) do
				local act = {type = "act", variant = poses[math.random(4)], body_part = 1, align_sync = true}
				v.unit:movement():action_request(act)
			end	
		end 
	end
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------			
	-- MAKE CIVS TALK ON PHONE
	local function phonycivs()
		if isHost() then
			local poses = {"cmf_so_answer_phone", "cmf_so_call_police", "cf_sp_sms_phone_var1", "cm_sp_phone1", "cm_sp_phone2"}

			for k,v in pairs(managers.enemy:all_civilians()) do
				local act = {type = "act", variant = poses[math.random(5)], body_part = 1, align_sync = true}
				v.unit:movement():action_request(act)
			end	
		end	
	end
-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------
	StealthMenu = CustomMenuClass:new({ hasLoading = false })
	StealthMenu:addMainMenu('main_menu', {title = 'Стелс меню'})
	StealthMenu:addMenu('mind_enemies_menu', {title = 'Контролировать разум врагов'})
	StealthMenu:addMenu('mind_civs_menu', {title = 'Контролировать разум гражданских'})
	
	StealthMenu:addInformationOption('main_menu', 'Контроль разумом', {textColor = Color.red})
	-- Enemy Mind Control Menu
	if isHost() then
		StealthMenu:addMenuOption('main_menu', 'Контроль над разумом врагов', 'mind_enemies_menu', {rectHighlightColor = Color(255, 138, 17, 9) / 255})
	else
		StealthMenu:addInformationOption('main_menu', 'Недоступно (Только хост)', {textColor = Color.yellow})
	end
	StealthMenu:addOption('mind_enemies_menu', 'Летающие свиньи', {callback = pigsfly, closeMenu = true})
	StealthMenu:addOption('mind_enemies_menu', 'Полицейские лодыри', {callback = copsquit, closeMenu = true})
	StealthMenu:addOption('mind_enemies_menu', 'Пьяные свиньи', {callback = drunkpigs, closeMenu = true})
	
	-- Civilian Mind Control Menu
	if isHost() then
		StealthMenu:addMenuOption('main_menu', 'Контроль над разумом гражданских', 'mind_civs_menu', {rectHighlightColor = Color(255, 138, 17, 9) / 255})
	else
		StealthMenu:addInformationOption('main_menu', 'Недоступно (Только хост)', {textColor = Color.yellow})
	end
	StealthMenu:addOption('mind_civs_menu', 'Танцующие марионетки', {callback = civdance, closeMenu = true})
	StealthMenu:addOption('mind_civs_menu', 'Курение убивает', {callback = civsmoke, closeMenu = true})
	StealthMenu:addOption('mind_civs_menu', 'Покрытие Овцы', {callback = civcower, closeMenu = true})
	StealthMenu:addOption('mind_civs_menu', 'Фальшивые Яппи', {callback = phonycivs, closeMenu = true})
	
	-- Toggles Column 1
	StealthMenu:addGap('main_menu')
	StealthMenu:addInformationOption('main_menu', 'Стелс меню:', {textColor = Color.DodgerBlue})
	if isHost() then
		if P3DGroup_P3DHack.Stealth_Menu_Config and P3DGroup_P3DHack.Cops_Dont_Shoot then	
			StealthMenu:addToggleOption('main_menu', 'Полиция не стреляет', {callback = cops_dont_shoot, help = 'Полиция не будет в вас стрелять', toggle = true})
		else	
			StealthMenu:addToggleOption('main_menu', 'Полиция не стреляет', {callback = cops_dont_shoot, help = 'Полиция не будет в вас стрелять'})
		end
		if P3DGroup_P3DHack.Stealth_Menu_Config and P3DGroup_P3DHack.Disable_Cameras then	
			StealthMenu:addToggleOption('main_menu', 'Отключить камеры', {callback = disable_cams, toggle = true})
		else	
			StealthMenu:addToggleOption('main_menu', 'Отключить камеры', {callback = disable_cams})
		end
		if P3DGroup_P3DHack.Stealth_Menu_Config and P3DGroup_P3DHack.Disable_Pagers then	
			StealthMenu:addToggleOption('main_menu', 'Отключить Пейджеры', {callback = disable_pagers, toggle = true})
		else	
			StealthMenu:addToggleOption('main_menu', 'Отключить Пейджеры', {callback = disable_pagers})
		end
	else
		StealthMenu:addInformationOption('main_menu', 'Недоступно (Только хост)', {textColor = Color.yellow})
		StealthMenu:addInformationOption('main_menu', 'Недоступно (Только хост)', {textColor = Color.yellow})
		StealthMenu:addInformationOption('main_menu', 'Недоступно (Только хост)', {textColor = Color.yellow})
	end
	if P3DGroup_P3DHack.Stealth_Menu_Config and P3DGroup_P3DHack.Free_Civ_Kills then
		StealthMenu:addToggleOption('main_menu', 'Бесплатное убийство граждан', {callback = free_kill, toggle = true})
	else
		StealthMenu:addToggleOption('main_menu', 'Бесплатное убийство граждан', {callback = free_kill})
	end
	if isHost() then
		if P3DGroup_P3DHack.Stealth_Menu_Config and P3DGroup_P3DHack.No_Pager_Dominate then	
			StealthMenu:addToggleOption('main_menu', 'Нет пейджера при доминиров.', {callback = pagedom, toggle = true, help = 'Если вы используете мгновенное доминирование, то данная функция должен быть включена первой'})
		else
			StealthMenu:addToggleOption('main_menu', 'Нет пейджера при доминиров.', {callback = pagedom, help = 'Если вы используете мгновенное доминирование, то данная функция должен быть включена'})
		end
	else
		StealthMenu:addInformationOption('main_menu', 'Недоступно (Только хост)', {textColor = Color.yellow })
	end
	
	-- Toggles Column 2
	StealthMenu:addGap('main_menu')
	StealthMenu:addGap('main_menu')
	StealthMenu:addGap('main_menu')
	StealthMenu:addGap('main_menu')
	StealthMenu:addGap('main_menu')
	if isHost() then
		if P3DGroup_P3DHack.Stealth_Menu_Config and P3DGroup_P3DHack.No_Panic then	
			StealthMenu:addToggleOption('main_menu', 'Нет тревожной кнопки', {callback = prevent_panic_buttons, toggle = true})
		else	
			StealthMenu:addToggleOption('main_menu', 'Нет тревожной кнопки', {callback = prevent_panic_buttons})
		end	
		if P3DGroup_P3DHack.Stealth_Menu_Config and P3DGroup_P3DHack.Dont_Call_Police then		
			StealthMenu:addToggleOption('main_menu', 'Люди не вызвают полицию', {callback = people_dont_call_police, toggle = true})
		else	
			StealthMenu:addToggleOption('main_menu', 'Люди не вызвают полицию', {callback = people_dont_call_police})
		end	
		if P3DGroup_P3DHack.Stealth_Menu_Config and P3DGroup_P3DHack.Lobotimize_AI then		
			StealthMenu:addToggleOption('main_menu', 'Лоботомия(Отключене ИИ)', {callback = lobai, toggle = true})
		else	
			StealthMenu:addToggleOption('main_menu', 'Лоботомия(Отключене ИИ)', {callback = lobai})
		end	
		if P3DGroup_P3DHack.Stealth_Menu_Config and P3DGroup_P3DHack.Random_Pagers then
			StealthMenu:addToggleOption('main_menu', 'Случайные пейджеры', {callback = randompage, help = 'Теперь у некоторых врагов не будет пейджера', toggle = true})
		else	
			StealthMenu:addToggleOption('main_menu', 'Случайные пейджеры', {callback = randompage, help = 'Теперь у некоторых врагов не будет пейджера'})
		end
		if P3DGroup_P3DHack.Stealth_Menu_Config and P3DGroup_P3DHack.Steal_Pagers then		
			StealthMenu:addToggleOption('main_menu', 'Кража пейджеров', {callback = steal_pagers_on_melee, help = 'Отключение пейджера, когда Вы убили рукопашной атакой охранника', toggle = true})
		else	
			StealthMenu:addToggleOption('main_menu', 'Кража пейджеров', {callback = steal_pagers_on_melee, help = 'Отключение пейджера, когда Вы убили рукопашной атакой охранника'})
		end
	else
		StealthMenu:addInformationOption('main_menu', 'Недоступно (Только хост)', {textColor = Color.yellow})
		StealthMenu:addInformationOption('main_menu', 'Недоступно (Только хост)', {textColor = Color.yellow})
		StealthMenu:addInformationOption('main_menu', 'Недоступно (Только хост)', {textColor = Color.yellow})
		StealthMenu:addInformationOption('main_menu', 'Недоступно (Только хост)', {textColor = Color.yellow})
		StealthMenu:addToggleOption('main_menu', 'Кража пейджеров', {callback = steal_pagers_on_melee, help = 'Отключение пейджера, когда Вы убили рукопашной атакой охранника'})
	end

	-- Column 3
	StealthMenu:addGap('main_menu')
	StealthMenu:addGap('main_menu')
	StealthMenu:addGap('main_menu')
	StealthMenu:addGap('main_menu')
	StealthMenu:addGap('main_menu')
	StealthMenu:addToggleOption('main_menu', 'Бесконечная мессия', {callback = unlmessiah})
	StealthMenu:addGap('main_menu')
	if isHost() then
		StealthMenu:addOption('main_menu', 'Конвектировать всех врагов', {callback = convertall, closeMenu = true })
	else
		StealthMenu:addInformationOption('main_menu', 'Недоступно (Только хост)', {textColor = Color.yellow})
	end
	StealthMenu:addOption('main_menu', 'Удаленный доступ к камерам', {callback = remote_camera, closeMenu = true})
end
---------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------
if inGame() and isPlaying() then
	if StealthMenu:isOpen() then
		StealthMenu:close()
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
		if MissionMenu then
			if MissionMenu:isOpen() then
				MissionMenu:close()
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
		end	end		
		if InteractTimerMenu then	
			if InteractTimerMenu:isOpen() then
				InteractTimerMenu:close()
			end	
		end		
		StealthMenu:open()
	end	
end