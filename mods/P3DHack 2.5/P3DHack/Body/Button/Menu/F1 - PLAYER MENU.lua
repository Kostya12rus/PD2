if not PlayerMenu then	
	--------------
	---- GAME ----
	--------------
	-- NO HIT DISORIENTATION
	local function nohitdis()
		Toggle.no_hit_disorient = not Toggle.no_hit_disorient

		if not Toggle.no_hit_disorient then
			backuper:restore("CoreEnvironmentControllerManager.hit_feedback_front")
			backuper:restore("CoreEnvironmentControllerManager.hit_feedback_back")
			backuper:restore("CoreEnvironmentControllerManager.hit_feedback_right")
			backuper:restore("CoreEnvironmentControllerManager.hit_feedback_left")
			backuper:restore("CoreEnvironmentControllerManager.hit_feedback_up")
			backuper:restore("CoreEnvironmentControllerManager.hit_feedback_down")
			ChatMessage('Выключено', 'Нет дезориентации')
			return
		end
		
		backuper:backup("CoreEnvironmentControllerManager.hit_feedback_front")
		function CoreEnvironmentControllerManager:hit_feedback_front() end
		
		backuper:backup("CoreEnvironmentControllerManager.hit_feedback_back")
		function CoreEnvironmentControllerManager:hit_feedback_back() end
		
		backuper:backup("CoreEnvironmentControllerManager.hit_feedback_right")
		function CoreEnvironmentControllerManager:hit_feedback_right() end
		
		backuper:backup("CoreEnvironmentControllerManager.hit_feedback_left")
		function CoreEnvironmentControllerManager:hit_feedback_left() end
		
		backuper:backup("CoreEnvironmentControllerManager.hit_feedback_up")
		function CoreEnvironmentControllerManager:hit_feedback_up() end
		
		backuper:backup("CoreEnvironmentControllerManager.hit_feedback_down")
		function CoreEnvironmentControllerManager:hit_feedback_down() end
		ChatMessage('Включено', 'Нет дезориентации')
	end
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- INTERACT DISTANCE INCREASE
	local function intdist()
		Toggle.interact_distance = not Toggle.interact_distance

		if not Toggle.interact_distance then
			backuper:restore('BaseInteractionExt.interact_distance')
			ChatMessage('Выключено', 'Взаимодействие-осмотреться')
			return
		end
		
		backuper:backup('BaseInteractionExt.interact_distance')
		function BaseInteractionExt:interact_distance()
			if self.tweak_data == "access_camera" or self.tweak_data == "shaped_sharge" or tostring(self._unit:name()) == "Idstring(@ID14f05c3d9ebb44b6@)"
			or self.tweak_data == "burning_money" or self.tweak_data == "stn_int_place_camera"  or self.tweak_data == "trip_mine" then
				return self._tweak_data.interact_distance or tweak_data.interaction.INTERACT_DISTANCE
			end
			return P3DGroup_P3DHack.Interact_Distance_Amount or 200 -- DEFAULT IS 200
		end
		ChatMessage('Включено', 'Взаимодействие-осмотреться')	
	end
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- NO SPOOC DOWN SELF ONLY CUFF
	function spooccuffselfon()
		Toggle.on_SPOOCed = not Toggle.on_SPOOCed

		if not Toggle.on_SPOOCed then
			backuper:restore('PlayerMovement.on_SPOOCed')
			ChatMessage('Выключено', 'Клокер одевает на вас наручники')
			return
		end

		backuper:backup('PlayerMovement.on_SPOOCed')
		function PlayerMovement:on_SPOOCed(enemy_unit)
			if self._unit:character_damage()._god_mode then
				return
			end
			if self._current_state_name == "standard" or self._current_state_name == "bleed_out" then
				managers.player:set_player_state( "arrested" )
			end	
		end
		ChatMessage('Включено', 'Клокер одевает на вас наручники')	
	end
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
	-- GOD MODE TOGGLE
	function godmode()
		Toggle.godLike = not Toggle.godLike
			
		-- GOD MODE OFF
		if not Toggle.godLike then
			managers.player:player_unit():character_damage():set_god_mode(false)
			ChatMessage('Выключено', 'Бессмертие')
			return
		end
		-- GOD MODE ON
		managers.player:player_unit():character_damage():set_god_mode(true)
		ChatMessage('Включено', 'Бессмертие')
	end
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
	-- INSTANT INTERACT TOGGLE
	local function instantinteract()		
		Toggle.instant_interact = not Toggle.instant_interact
			
		-- DISABLE INSTANT INTERACTION/DEPLOY
		if not Toggle.instant_interact then
			backuper:restore('BaseInteractionExt._get_timer')
			backuper:restore('PlayerManager.selected_equipment_deploy_timer')
			ChatMessage('Выключено', 'Мгновенное взаимодействие')
			return
		end
	
		-- ENABLE INSTANT INTERACTION/DEPLOY
		backuper:backup('BaseInteractionExt._get_timer')
		function BaseInteractionExt:_get_timer() return 0.1 end
		
		backuper:backup('PlayerManager.selected_equipment_deploy_timer')
		function PlayerManager:selected_equipment_deploy_timer() return 0.1 end	
		ChatMessage('Включено', 'Мгновенное взаимодействие')
	end
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
	-- INSTANT DRILL TOGGLE
	local function instantdrill()
		if isHost() then
			Toggle.timer_gui_instant_hack = not Toggle.timer_gui_instant_hack
			
			-- DISABLE
			if not Toggle.timer_gui_instant_hack then			
				backuper:restore('TimerGui.update')
				backuper:restore('SecurityLockGui.update')
				ChatMessage('Выключено', 'Мгновенная дрель/компьютер')
				return
			end

			-- ENABLE			
			backuper:backup('TimerGui.update')
			function TimerGui:update(unit, t, dt)
				if self._jammed then
					self._unit:set_extension_update_enabled(Idstring("timer_gui"), false)
					self._update_enabled = false
					self:done()
					return
				end
				if not self._powered then
					return
				end
				self._current_timer = 1
				self._time_left = self._current_timer
				self._gui_script.time_text:set_text(math.floor(self._time_left or self._current_timer) .. " " .. managers.localization:text("prop_timer_gui_seconds"))
				self._gui_script.timer:set_w(self._timer_lenght * (1 - self._current_timer / self._timer))
				if self._current_timer then
					self._unit:set_extension_update_enabled(Idstring("timer_gui"), false)
					self._update_enabled = false
					self:done()
				else
					self._gui_script.working_text:set_color(self._gui_script.working_text:color():with_alpha(0.5 + (math.sin(t * 750) + 1) / 4))
				end
			end
			
			backuper:backup('SecurityLockGui.update')
			function SecurityLockGui:update(unit, t, dt)
				if not self._powered then
					return
				end
				self._current_timer = 1
				self._gui_script.time_text:set_text(math.floor(self._current_timer) .. " " .. managers.localization:text("prop_timer_gui_seconds"))
				self._gui_script["timer" .. self._current_bar]:set_w(self._timer_lenght * (1 - self._current_timer / self._timer))
				if self._current_timer then
					self._unit:set_extension_update_enabled(Idstring("timer_gui"), false)
					self._update_enabled = false
					self:done()
				else
					self._gui_script.working_text:set_color(self._gui_script.working_text:color():with_alpha(0.5 + (math.sin(t * 750) + 1) / 4))
				end
			end
			ChatMessage('Включено', 'Мгновенная дрель/компьютер')
		end 
	end 
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
	-- INTERACT WITH ANYTHING TOGGLE
	local function interactanyhting()
		Toggle.interact_with_all = not Toggle.interact_with_all
			
		-- DISABLE
		if not Toggle.interact_with_all then
			backuper:restore('BaseInteractionExt._has_required_upgrade')
			backuper:restore('BaseInteractionExt._has_required_deployable')
			backuper:restore('BaseInteractionExt.can_interact')
			backuper:restore('PlayerManager.remove_equipment')
			ChatMessage('Выключено', 'Взаимодействовать с чем-либо')
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
		
		ChatMessage('Включено', 'Взаимодействовать с чем-либо')
	end
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
	-- SMALL LOOT MULTIPLIER TOGGLE
	function smlootmulti()
		Toggle.small_loot = not Toggle.small_loot
			
		-- DISABLE SMALL LOOT MODIFIER
		if not Toggle.small_loot then
			tweak_data.upgrades.values.player.small_loot_multiplier = {1.1, 1.3}
			ChatMessage('Выключено', 'Множитель малого лута')
			return
		end
		
		-- ENABLE SMALL LOOT MODIFIER
		tweak_data.upgrades.values.player.small_loot_multiplier = {P3DGroup_P3DHack.Small_Loot_Multiplier_Amount, P3DGroup_P3DHack.Small_Loot_Multiplier_Amount}
		ChatMessage('Включено', 'Множитель малого лута')
	end
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
	-- INSTANT DOMINATE TOGGLE
	local function instantdom()		
		Toggle.instant_dominate_convert = not Toggle.instant_dominate_convert
		
		if not Toggle.instant_dominate_convert then
			backuper:restore('CopLogicIdle.on_intimidated')
			backuper:restore('CopLogicIntimidated.on_intimidated')
			backuper:restore('CopLogicSniper.enter')
			tweak_data.upgrades.values.player.convert_enemies_max_minions = {1,2}
			ChatMessage('Выключено', 'Бесконечная конвертация врагов')
			return
		end
		
		ChatMessage('Enabled', 'Бесконечная конвертация врагов')
		tweak_data.upgrades.values.player.convert_enemies = {true}
		tweak_data.upgrades.values.player.convert_enemies_max_minions = {999999,999999}

		CopLogicAttack.on_intimidated = CopLogicIdle.on_intimidated
		CopLogicArrest.on_intimidated = CopLogicIdle.on_intimidated
		CopLogicSniper.on_intimidated = CopLogicIdle.on_intimidated
		backuper:backup('CopLogicIdle.on_intimidated')
		function CopLogicIdle.on_intimidated(data, amount, aggressor_unit)
			CopLogicIdle._surrender(data, amount)
			return true
		end

		-- Setup logic for shields to be able to be intimidated
		CopBrain._logic_variants.shield.intimidated = CopLogicIntimidated
		CopLogicIntimidated._onIIntimidated = backuper:backup('CopLogicIntimidated.on_intimidated')
		function CopLogicIntimidated.on_intimidated(data, amount, aggressor_unit) 
			-- If shield we skip animations, go straight to conversion & spawn a new shield since it was destroyed during intimidation
			if data.unit:base()._tweak_table == "shield" then
				CopLogicIntimidated._do_tied(data, aggressor_unit)
				CopInventory._chk_spawn_shield( data.unit:inventory(), nil )
			else
				CopLogicIntimidated._onIIntimidated(data, amount, aggressor_unit)
			end	
		end
		
		-- Setup a proper sniper-rifle for snipers (100% accuracy, no spread)
		CopBrain._logic_variants.sniper = clone(CopBrain._logic_variants.security)
		CopBrain._logic_variants.sniper.attack = CopLogicSniper
		CopLogicSniper._onSniperEnter = backuper:backup('CopLogicSniper.enter')
		function CopLogicSniper.enter(data, new_logic_name, enter_params)
			if data.unit:brain()._logic_data and data.unit:brain()._logic_data.objective and data.unit:brain()._logic_data.objective.type == "follow" then
				data.char_tweak.weapon[ data.unit:inventory():equipped_unit():base():weapon_tweak_data().usage ] = tweak_data.character.presets.weapon.sniper.m4
				data.char_tweak.weapon[ data.unit:inventory():equipped_unit():base():weapon_tweak_data().usage ].spread = 0
				-- Get dat 100% accuracy
				for distance=1, 3 do
					for interpolate=1,2 do
						data.char_tweak.weapon[ data.unit:inventory():equipped_unit():base():weapon_tweak_data().usage ].FALLOFF[distance].acc[interpolate] = 1
					end	
				end	
			end
			CopLogicSniper._onSniperEnter(data, new_logic_name, enter_params)
		end	
	end			
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------		
	-- INTERACT THRU WALL TOGGLE
	local function interactwall()	
		Toggle.interact_thru_wall = not Toggle.interact_thru_wall
		
		-- DISABLE INTERACT THRU WALL
		if not Toggle.interact_thru_wall then
			backuper:restore('ObjectInteractionManager._update_targeted')
			backuper:restore('ObjectInteractionManager.interact')
			ChatMessage('Выключено', 'Взаимодействовать через стены')
			return
		end

		-- ENABLE INTERACT THROUGH WALLS 
		backuper:backup('ObjectInteractionManager._update_targeted')
		function ObjectInteractionManager:interact(player)
			if(alive(self._active_unit)) then
				local interacted,timer = self._active_unit:interaction():interact_start(player)
				if timer then
					self._active_object_locked_data = true
				end
				return interacted or interacted == nil or false, timer, self._active_unit
			end
			return false
		end

		backuper:backup('ObjectInteractionManager.interact')
		function ObjectInteractionManager:_update_targeted(player_pos, player_unit)	
			local mvec1 = Vector3()
			local mvec3_dis = mvector3.distance
			if(#self._close_units > 0) then
				for k, v in pairs(self._close_units ) do	
					if(alive(v) and v:interaction():active()) then
						if mvec3_dis(player_pos, v:interaction():interact_position()) > v:interaction():interact_distance() then
							table.remove(self._close_units, k)
						end
					else
						table.remove(self._close_units, k)
					end	
				end	
			end
			
			for i = 1, self._close_freq, 1 do
				if(self._close_index >= self._interactive_count) then
					self._close_index = 1
				else
					self._close_index = self._close_index + 1
				end
				local obj = self._interactive_units[ self._close_index ]
				if( alive(obj) and obj:interaction():active() and not self:_in_close_list( obj ) ) then
					if( mvec3_dis(player_pos, obj:interaction():interact_position()) <= obj:interaction():interact_distance()  ) then
						table.insert( self._close_units, obj )
					end	
				end	
			end
				
			local locked = false
			if self._active_object_locked_data then
				if not alive( self._active_unit ) or not self._active_unit:interaction():active() then
					self._active_object_locked_data = nil  
				else
					locked = ( mvec3_dis(player_pos, self._active_unit:interaction():interact_position()) <= self._active_unit:interaction():interact_distance() )
				end	
			end
			
			if locked then
				return
			end
			local last_active = self._active_unit
			local blocked = player_unit:movement():object_interaction_blocked()
			if( #self._close_units > 0 ) and not blocked then
				--find the one the player is looking at
				local active_unit = nil
				local current_dot = 0.9
				local player_fwd = player_unit:camera():forward()
				local camera_pos = player_unit:camera():position()
				tweak_data.interaction.open_from_inside.interact_distance = 0
				for k, v in pairs( self._close_units ) do
					if( alive( v ) ) then
						mvector3.set( mvec1, v:interaction():interact_position() )
						mvector3.subtract( mvec1, camera_pos )
						mvector3.normalize( mvec1 )
						local dot = mvector3.dot( player_fwd, mvec1 )
						if( dot > current_dot ) then
							current_dot = dot
							active_unit = v
						end	
					end	
				end
					
				if( active_unit and self._active_unit ~= active_unit ) then
					if alive( self._active_unit ) then
						self._active_unit:interaction():unselect()
					end
					if not active_unit:interaction():selected( player_unit ) then
						active_unit = nil
					end	
				end
				self._active_unit = active_unit
			else
				self._active_unit = nil
			end
			if( alive( last_active ) ) then
				if( not self._active_unit ) then
					self._active_unit = nil
					last_active:interaction():unselect()
				end	
			end	
		end
		ChatMessage('Включено', 'Взаимодействовать через стены')
	end
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
	-- BAG MOD TOGGLE
	local function carrymod()
		Toggle.toggleBagMods = not Toggle.toggleBagMods
		if Toggle.toggleBagMods then
			ChatMessage('Включено', 'Модификатор сумок')
			local car_arr = {'being', 'mega_heavy', 'heavy', 'medium', 'light', 'coke_light', 'very_heavy', 'explosives'}
			for i, name in ipairs(car_arr) do
				if not tweak_data.carry.types["__" .. name] then
					tweak_data.carry.types["__" .. name] = clone(tweak_data.carry.types[name])
				end
				tweak_data.carry.types[name].throw_distance_multiplier = 1.5
				tweak_data.carry.types[name].move_speed_modifier = 1
				tweak_data.carry.types[name].jump_modifier = 1
				tweak_data.carry.types[name].can_run = true
				tweak_data.carry.types.explosives.can_explode = false					
			end
			function PlayerManager:carry_blocked_by_cooldown() return false end
		else   
			local car_arr = {'being', 'mega_heavy', 'heavy', 'medium', 'light', 'coke_light', 'very_heavy', 'explosives'}
			for i, name in ipairs(car_arr) do
				tweak_data.carry.types[name].can_run = false
				tweak_data.carry.types.being.move_speed_modifier = 0.5
				tweak_data.carry.types.being.jump_modifier = 0.5
				tweak_data.carry.types.being.throw_distance_multiplier = 0.5
				tweak_data.carry.types.mega_heavy.move_speed_modifier = 0.25
				tweak_data.carry.types.mega_heavy.jump_modifier = 0.25
				tweak_data.carry.types.mega_heavy.throw_distance_multiplier = 0.125
				tweak_data.carry.types.very_heavy.move_speed_modifier = 0.25
				tweak_data.carry.types.very_heavy.jump_modifier = 0.25
				tweak_data.carry.types.very_heavy.throw_distance_multiplier = 0.3
				tweak_data.carry.types.heavy.move_speed_modifier = 0.5
				tweak_data.carry.types.heavy.jump_modifier = 0.5
				tweak_data.carry.types.heavy.throw_distance_multiplier = 0.5
				tweak_data.carry.types.medium.move_speed_modifier = 0.75
				tweak_data.carry.types.medium.jump_modifier = 1
				tweak_data.carry.types.medium.throw_distance_multiplier = 1
				tweak_data.carry.types.light.move_speed_modifier = 1
				tweak_data.carry.types.light.jump_modifier = 1
				tweak_data.carry.types.light.can_run = true
				tweak_data.carry.types.light.throw_distance_multiplier = 1
				tweak_data.carry.types.coke_light.move_speed_modifier = tweak_data.carry.types.light.move_speed_modifier
				tweak_data.carry.types.coke_light.jump_modifier = tweak_data.carry.types.light.jump_modifier
				tweak_data.carry.types.coke_light.can_run = tweak_data.carry.types.light.can_run
				tweak_data.carry.types.coke_light.throw_distance_multiplier = tweak_data.carry.types.light.throw_distance_multiplier
				tweak_data.carry.types.explosives.can_explode = true
			end
			ChatMessage('Выключено', 'Модификатор сумок')
		end 
	end
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------		
	-- AUTO DRILL SERVICE
	local function drillservice()
		Toggle.drill_auto_service = not Toggle.drill_auto_service
			
		if not Toggle.drill_auto_service then
			backuper:restore('Drill.set_jammed')
			ChatMessage('Выключено', 'Авто дрель')
			return
		end
		
		ChatMessage('Включено', 'Авто дрель')
		backuper:hijack('Drill.set_jammed', function(o, self, jammed, ...)
			local r = o(self, jammed, ...)
			local player = managers.player:local_player()
			if alive(player) and alive(self._unit) and (self._unit.interaction and self._unit:interaction()) and (self._unit:interaction().interact) then
				self._unit:interaction():interact(player)
			end
			return r
		end)
	end
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------		
	-- INFINTE ECM BATTERY
	local function inf_ecm()
		Toggle.inf_battery_activated = not Toggle.inf_battery_activated
			
		if not Toggle.inf_battery_activated then
			backuper:restore('ECMJammerBase.update')
			ChatMessage('Выключено', 'Бесконечная ECM батарея')
			return
		end
		
		backuper:backup('ECMJammerBase.update')
		function ECMJammerBase:update(unit, t, dt)
			self._battery_life = self._max_battery_life
		end
		ChatMessage('Включено', 'Бесконечная ECM батарея')
	end
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------				
	-- INFINITE SPECIALS
	local function InfiniteSpecial()
		Toggle.infinite_special = not Toggle.infinite_special
			
		if not Toggle.infinite_special then
			backuper:restore('PlayerManager.remove_special')
			ChatMessage('Выключено', 'Бесконечные вещи')
			return
		end
		
		backuper:backup('PlayerManager.remove_special')
		function PlayerManager:remove_special(name) end
		ChatMessage('Включено', 'Бесконечные вещи')
	end
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
	-- INFINITE MESSIAH CHARGES
	local function infmessiah()
		Toggle.consume_messiah_charge = not Toggle.consume_messiah_charge
			
		if not Toggle.consume_messiah_charge then
			backuper:restore('PlayerDamage.consume_messiah_charge')
			ChatMessage('Выключено', 'Бесконечный шанс мессии')
			return
		end
		
		backuper:backup('PlayerDamage.consume_messiah_charge')
		function PlayerDamage:consume_messiah_charge() return true end	
		ChatMessage('Включено', 'Бесконечный шанс мессии')
	end
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
	-- INFINITE DOCTOR BAG USES
	local function infdocbag()
		Toggle.infdoc = not Toggle.infdoc
			
		if not Toggle.infdoc then
			backuper:restore('DoctorBagBase._take')
			ChatMessage('Выключено', 'Бесконечное использование аптечек')
			return
		end
		
		backuper:backup('DoctorBagBase._take')
		function DoctorBagBase:_take(unit)
			unit:character_damage():recover_health() -- replenish()
			return 0
		end	
		ChatMessage('Включено', 'Бесконечное использование аптечек')
	end
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
	-- INFINITE AMMO BAG USES
	local function infammobag()
		Toggle.takeammo = not Toggle.takeammo
			
		if not Toggle.takeammo then
			backuper:restore('AmmoBagBase._take_ammo')
			ChatMessage('Выключено', 'Бесконечное использование сумки с патронами')
			return
		end
	
		backuper:backup('AmmoBagBase._take_ammo')
		function AmmoBagBase:_take_ammo(unit)
			local inventory = unit:inventory()
			if inventory then
				for _,weapon in pairs( inventory:available_selections() ) do
					local took = weapon.unit:base():add_ammo_from_bag( self._ammo_amount )
				end	
			end	
			return 0
		end	
		ChatMessage('Включено', 'Бесконечное использование сумки с патронами')
	end
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------		
	-- ALLOW INFINITE PAGERS
	local function inf_pager_answers()
		Toggle.inf_pager_answers = not Toggle.inf_pager_answers
			
		if not Toggle.inf_pager_answers then
			backuper:restore('GroupAIStateBase.on_successful_alarm_pager_bluff')
			ChatMessage('Выключено', 'Бесконечные ответы на пейджер')
			return
		end
		
		backuper:backup('GroupAIStateBase.on_successful_alarm_pager_bluff')
		function GroupAIStateBase:on_successful_alarm_pager_bluff()	end
		ChatMessage('Включено', 'Бесконечные ответы на пейджер')
	end
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
	-- INFINTE CONVERTS
	function inf_converts()
		Toggle.inf_converts = not Toggle.inf_converts
			
		if not Toggle.inf_converts then
			tweak_data.upgrades.values.player.convert_enemies_max_minions = {1,2}
			ChatMessage('Выключено', 'Бесконечная конвертация врагов')
			return
		end
				
		tweak_data.upgrades.values.player.convert_enemies = {true}
		tweak_data.upgrades.values.player.convert_enemies_max_minions = {999999,999999}
		ChatMessage('Включено', 'Бесконечная конвертация врагов')
	end 
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------		
	-- CARRYSTACKER
	local function carrystack()
		local _debugEnabled = false
		local BagIcon = "pd2_loot"
		
		Toggle.toggle_Carry = not Toggle.toggle_Carry

		if Toggle.toggle_Carry then
			ChatMessage('Включено', 'Переносить больше сумок')
			if managers and managers.player and IntimitateInteractionExt and CarryInteractionExt then
				managers.player.carry_stack = {}
				managers.player.carrystack_lastpress = 0
				managers.player.drop_all_bags = false
				local ofuncs = {
				  managers_player_set_carry = PlayerManager.set_carry,
				  managers_player_drop_carry = PlayerManager.drop_carry,
				  IntimitateInteractionExt__interact_blocked = IntimitateInteractionExt._interact_blocked,
				  CarryInteractionExt__interact_blocked = CarryInteractionExt._interact_blocked,
				  CarryInteractionExt_can_select = CarryInteractionExt.can_select,
				}
				
				function managers.player:refresh_stack_counter()
					local count = #self.carry_stack + (self:is_carrying() and 1 or 0)
					managers.hud:remove_special_equipment("carrystacker")
					if count > 0 then
						managers.hud:add_special_equipment({id = "carrystacker", icon = BagIcon, amount = count})
					end	
				end
			
				function managers.player:rotate_stack(dir)
					if #managers.player.carry_stack < 1 or (#managers.player.carry_stack < 2 and not self:is_carrying()) then
						return
					end
					if self:is_carrying() then
						table.insert(self.carry_stack, self:get_my_carry_data())
					end
					if dir == "up" then
						table.insert(self.carry_stack, 1, table.remove(self.carry_stack))
					else
						table.insert(self.carry_stack, table.remove(self.carry_stack, 1))
					end
					local cdata = table.remove(self.carry_stack)
					if cdata then
						if self:is_carrying() then self:carry_discard() end
						ofuncs.managers_player_set_carry(self, cdata.carry_id, cdata.carry_multiplier, cdata.dye_initiated, cdata.has_dye_pack, cdata.dye_value_multiplier)
					end	
				end
				
				-- POPS AN ITEM FROM THE STACK WHEN THE PLAYER DROPS THEIR CARRIED ITEM
				function managers.player:drop_carry(zipline_unit) 
					ofuncs.managers_player_drop_carry(self, zipline_unit)
					if #self.carry_stack > 0 then
						local cdata = table.remove(self.carry_stack)
						if cdata then
							self:set_carry(cdata.carry_id, cdata.carry_multiplier, cdata.dye_initiated, cdata.has_dye_pack, cdata.dye_value_multiplier)
						end	
					end
					self:refresh_stack_counter()
					if self.drop_all_bags then
						if #self.carry_stack > 0 or self:is_carrying() then
							self:drop_carry()
						end
						self.drop_all_bags = false
					end
					-- IF CARRYSTACKER IS OFF, THEN DROP ALL BUT ONE BAG IF THIS IS RUN
					if not Toggle.toggle_Carry then
						if #self.carry_stack > 0 then
							self:drop_carry()
						end	
					end
				end
					
				-- SAVES THE CURRENT ITEM TO THE STACK IF WE'RE ALREADY CARRYING SOMETHING
				function managers.player:set_carry(carry_id, carry_multiplier, dye_initiated, has_dye_pack, dye_value_multiplier)
					if self:is_carrying() and self:get_my_carry_data() then
						table.insert(self.carry_stack, self:get_my_carry_data())
					end
					ofuncs.managers_player_set_carry(self, carry_id, carry_multiplier, dye_initiated, has_dye_pack, dye_value_multiplier)
					self:refresh_stack_counter()
				end

				-- NEW FUNCTION TO DISCARD THE CURRENTLY CARRIED ITEM
				function managers.player:carry_discard()
					managers.hud:remove_teammate_carry_info(HUDManager.PLAYER_PANEL)
					managers.hud:temp_hide_carry_bag()
					self:update_removed_synced_carry_to_peers()
					if self._current_state == "carry" then
						managers.player:set_player_state("standard")
					end	
				end
				
				-- OVERRIDDEN TO PREVENT BLOCKING US FROM PICKING UP A DEAD BODY
				function IntimitateInteractionExt:_interact_blocked(player)
					if Toggle.toggle_Carry and self.tweak_data == "corpse_dispose" then
						if not managers.player:has_category_upgrade("player", "corpse_dispose") then
							return true
						end
						return not managers.player:can_carry("person")
					end
					-- RUN THE ORIGINAL FUNCTION IF CARRYSTACKER IS OFF OR IF PLAYER ISN'T DISPOSING OF A CORPSE
					return ofuncs.IntimitateInteractionExt__interact_blocked(self, player)
				end

				-- OVERRIDDEN TO ALWAYS ALLOW US TO PICK UP A CARRY ITEM
				function CarryInteractionExt:_interact_blocked(player)
					if Toggle.toggle_Carry then
						return not managers.player:can_carry(self._unit:carry_data():carry_id())
					end
					-- RUN THE ORIGINAL FUNCTION IF CARRYSTACKER IS OFF
					return ofuncs.CarryInteractionExt__interact_blocked(self, player)
				end

				-- OVERRIDDEN TO ALWAYS ALLOW US TO SELECT A CARRY ITEM
				function CarryInteractionExt:can_select(player)
					if Toggle.toggle_Carry then
						return CarryInteractionExt.super.can_select( self, player )
					end
					-- RUN THE ORIGINAL FUNCTION IF CARRYSTACKER IS OFF
					return ofuncs.CarryInteractionExt_can_select(self, player)
				end

				-- CUSTOM FUNCTION. PUSHES A CARRIED ITEM TO STACK AND DISCARDS IT OR POPS ONE IF WE'RE NOT CARRYING ANYTHING.
				-- THIS FUNCTION IS CALLED EVERY TIME THE SCRIPT GETS RUN.
				function managers.player:carry_stacker()
					if _debugEnabled then
						io.stderr:write("current stack size: ".. tostring(#managers.player.carry_stack) .. "\n")
						if #managers.player.carry_stack > 0 then
							for _,v in pffairs(managers.player.carry_stack) do
								io.stderr:write("item: ".. v.carry_id .. "\n")
							end	
						end	
					end
				
					local cdata = self:get_my_carry_data()
					if self:is_carrying() and cdata then
						table.insert(self.carry_stack, self:get_my_carry_data())
						self:carry_discard()
						managers.hud:present_mid_text({title = "Carry Stack", text = cdata.carry_id .. " Pushed", time = 1})
					elseif #self.carry_stack > 0 then
						cdata = table.remove(self.carry_stack)
						self:set_carry(cdata.carry_id, cdata.carry_multiplier, cdata.dye_initiated, cdata.has_dye_pack, cdata.dye_value_multiplier)
						managers.hud:present_mid_text({title = "Carry Stack", text = cdata.carry_id .. " Popped", time = 1})
					else
						managers.hud:present_mid_text({title = "Carry Stack", text = "Empty", time = 1})
					end
					
					if (Application:time() - self.carrystack_lastpress) < 0.3 and (self:is_carrying() or #self.carry_stack > 0) then
						self.drop_all_bags = true
						self:drop_carry()
					end
					self.carrystack_lastpress = Application:time()
					self:refresh_stack_counter()
				end	
			end
		else
			ChatMessage('Выключено', 'Переносить больше сумок') 
			if managers.player:is_carrying() then
				managers.player:drop_carry()
			end
		end 
	end
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------		
	-- CARRY LIMITS
	local function carrylimit()
		local carry_limits = {
		-- modifer_power 	--> How much additional bags affect on this modifier (bigger - slower)
		-- min_val			--> Minimal value of that modifier
		move_speed_modifier	=	{	modifer_power = 0.35,	min_val = 0.15	},
		jump_modifier		=	{	modifer_power = 0.2,	min_val = 0.35	},		
		}
		
		Toggle.carr_limit = not Toggle.carr_limit
		
		if not Toggle.carr_limit then
			backuper:restore('PlayerCarry._get_max_walk_speed')
			backuper:restore('PlayerCarry._get_walk_headbob')
			backuper:restore('PlayerCarry._perform_jump')
			backuper:restore('PlayerCarry._check_action_run')
			tweak_data.carry.types.light.move_speed_modifier = 1.0
			tweak_data.carry.types.coke_light.move_speed_modifier = tweak_data.carry.types.coke_light.move_speed_modifier
			ChatMessage('Выключено', 'Удалить вес сумок')
			return
		end
		
		local function append_carry_limits(in_value, modifer_type)
			local out_value = in_value
				
			if managers.player.carry_stack ~= nil and #managers.player.carry_stack > 0 then
				for _,v in pairs(managers.player.carry_stack) do
					if type(v) == "table" then
						if tweak_data.carry[v.carry_id] ~= nil then
							local carry_type = tweak_data.carry[v.carry_id].type

							if tweak_data.carry.types[carry_type] ~= nil then
								local add_mul = (1 - tweak_data.carry.types[carry_type][modifer_type]) * carry_limits[modifer_type].modifer_power
								if add_mul < 0 then add_mul = 0 end							
								out_value = out_value - add_mul
								if out_value < 0 then out_value = carry_limits[modifer_type].min_val end	
								if out_value > 1 then out_value = 1 end
							end	
						end	
					end	
				end	
			end		
			return out_value
		end
		tweak_data.carry.types.light.move_speed_modifier = 0.9	-- 1.0 in orig game (Diamonds and jewelry)
		tweak_data.carry.types.coke_light.move_speed_modifier = 0.9	-- types.light

		-- Walk Speed
		backuper:backup('PlayerCarry._get_max_walk_speed')
		function PlayerCarry:_get_max_walk_speed(...)
			local multiplier = tweak_data.carry.types[self._tweak_data_name].move_speed_modifier		
			if managers.player:has_category_upgrade("carry", "movement_penalty_nullifier") then
				multiplier = 1
			else
				multiplier = append_carry_limits(multiplier, "move_speed_modifier")	-- new
				multiplier = math.clamp(multiplier * managers.player:upgrade_value("carry", "movement_speed_multiplier", 1), 0, 1)
			end	
			return PlayerCarry.super._get_max_walk_speed(self, ...) * multiplier	
		end	
			
		-- Bobbing effect
		backuper:backup('PlayerCarry._get_walk_headbob')
		function PlayerCarry:_get_walk_headbob(...)
			local multiplier = append_carry_limits(tweak_data.carry.types[self._tweak_data_name].move_speed_modifier, "move_speed_modifier")	
			--new
			return PlayerCarry.super._get_walk_headbob(self, ...) * multiplier
		end	

		-- Jump power
		backuper:backup('PlayerCarry._perform_jump')
		function PlayerCarry:_perform_jump(jump_vec)
			if managers.player:has_category_upgrade("carry", "movement_penalty_nullifier") then
			else
				local multiplier = append_carry_limits(tweak_data.carry.types[self._tweak_data_name].jump_modifier, "jump_modifier")	-- new
				mvector3.multiply(jump_vec, multiplier)
			end
			PlayerCarry.super._perform_jump(self, jump_vec)
		end	
				
		-- Can Run
		backuper:backup('PlayerCarry._check_action_run')
		function PlayerCarry:_check_action_run(...)	-- new
			local bCanRun = tweak_data.carry.types[self._tweak_data_name].can_run	
			if bCanRun == true then
				if managers.player.carry_stack ~= nil and #managers.player.carry_stack > 0 then
					for _,v in pairs(managers.player.carry_stack) do
						if type(v) == "table" then
							if tweak_data.carry[v.carry_id] ~= nil then
								local carry_type = tweak_data.carry[v.carry_id].type
								if tweak_data.carry.types[carry_type] ~= nil then
									if tweak_data.carry.types[carry_type].can_run == false then
										bCanRun = false
										break
									end	
								end	
							end	
						end	
					end	
				end	
			end			
			if bCanRun or managers.player:has_category_upgrade("carry", "movement_penalty_nullifier") then
				PlayerCarry.super._check_action_run(self, ...)
			end	
		end
		ChatMessage('Включено', 'Удалить вес сумок')
	end
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
	-- CARRY CROSSHAIR MOD
	local function carrycross()
		Toggle.carry_cross = not Toggle.carry_cross
		
		if not Toggle.carry_cross then
			backuper:restore('PlayerManager.drop_carry')
			ChatMessage('Выключено', 'Керри мод - прицел')
			return
		end
		
		backuper:backup('PlayerManager.drop_carry')
		function PlayerManager:drop_carry(zipline_unit)
			local carry_data = self:get_my_carry_data()
			local camera_ext = managers.player:player_unit():camera()
			local position = get_crosshair_pos()
			local dye_initiated = carry_data.dye_initiated
			local has_dye_pack = carry_data.has_dye_pack
			local dye_value_multiplier = carry_data.dye_value_multiplier
			local throw_distance_multiplier_upgrade_level = managers.player:upgrade_level("carry", "throw_distance_multiplier", 0)
			if Network:is_client() then
				if position then
					managers.network:session():send_to_host("server_drop_carry", carry_data.carry_id, carry_data.multiplier, dye_initiated, has_dye_pack, dye_value_multiplier, position, camera_ext:rotation(), managers.player:player_unit():camera():forward(), throw_distance_multiplier_upgrade_level, zipline_unit)
				else
					managers.network:session():send_to_host("server_drop_carry", carry_data.carry_id, carry_data.multiplier, dye_initiated, has_dye_pack, dye_value_multiplier, camera_ext:position(), camera_ext:rotation(),managers.player:player_unit():camera():forward(), throw_distance_multiplier_upgrade_level, zipline_unit)
				end
			else
				if position then
					self:server_drop_carry(carry_data.carry_id, carry_data.multiplier, dye_initiated, has_dye_pack, dye_value_multiplier, position, camera_ext:rotation(), managers.player:player_unit():camera():forward(), throw_distance_multiplier_upgrade_level, zipline_unit, managers.network:session():local_peer())
				else	
					self:server_drop_carry(carry_data.carry_id, carry_data.multiplier, dye_initiated, has_dye_pack, dye_value_multiplier, camera_ext:position(), camera_ext:rotation(), managers.player:player_unit():camera():forward(), throw_distance_multiplier_upgrade_level, zipline_unit, managers.network:session():local_peer())
				end	
			end
			managers.hud:remove_teammate_carry_info(HUDManager.PLAYER_PANEL)
			managers.hud:temp_hide_carry_bag()
			self:update_removed_synced_carry_to_peers()
			if self._current_state == "carry" then
				managers.player:set_player_state("standard")
			end
		end
		ChatMessage('Включено', 'Керри мод - прицел')
	end
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
	-- ENABLE FRIENDLY FIRE
	local function friendfire()
		Toggle.friendly_fire = not Toggle.friendly_fire
		
		if not Toggle.friendly_fire then
			backuper:restore('PlayerDamage.is_friendly_fire')
			backuper:restore('VehicleDamage.is_friendly_fire')
			backuper:restore('NpcVehicleDamage.is_friendly_fire')
			ChatMessage('Выключено', 'Огонь по своим')
			return 
		end
		
		backuper:backup('PlayerDamage.is_friendly_fire')
		function PlayerDamage:is_friendly_fire(unit) end
			
		backuper:backup('VehicleDamage.is_friendly_fire')	
		function VehicleDamage:is_friendly_fire(attacker_unit) end
		
		backuper:backup('NpcVehicleDamage.is_friendly_fire')			
		function NpcVehicleDamage:is_friendly_fire(attacker_unit) end
		ChatMessage('Включено', 'Огонь по своим')
	end
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------		
	-- ZIPLINE BAGS 
	local function ZiplineBag()	
		Toggle.Zipline_Bags = not Toggle.Zipline_Bags

		if not Toggle.Zipline_Bags then
			backuper:restore('ZipLine.on_interacted')
			ChatMessage('Выключено', 'Канатная дорога')
			return
		end

		local on_interacted_original = backuper:backup('ZipLine.on_interacted')
		function ZipLine:on_interacted(unit)
			if self:is_usage_type_person() then
				if managers.player:is_carrying() then
					if Network:is_server() then
						managers.player:drop_carry(self._unit)
					else
						self:_client_request_attach_bag(unit)
					end
					return
				end
				if Network:is_server() then
					if not alive(self._user_unit) then
						self:set_user(unit)
					end
				else
					self:_client_request_access(unit)
				end
			end
			on_interacted_original(self, unit)
		end
		ChatMessage('Включено', 'Канатная дорога')
	end
-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------
	PlayerMenu = CustomMenuClass:new()
	PlayerMenu:addMainMenu('main_menu', {title = 'Модификаци игрока', maxRows = 12})
	
	-- PLAYER MENU COLUMN 1
	PlayerMenu:addInformationOption('main_menu', 'Быстрый выбор', {textColor = Color.DodgerBlue})
	if P3DGroup_P3DHack.Player_Menu_Config and P3DGroup_P3DHack.God_Mode then	
		PlayerMenu:addToggleOption('main_menu', 'Бессмертие', {callback = godmode, help = 'Стань непобедимым', toggle = true})
	else	
		PlayerMenu:addToggleOption('main_menu', 'Бессмертие', {callback = godmode, help = 'Стань непобедимым'})
	end
	if P3DGroup_P3DHack.Player_Menu_Config and P3DGroup_P3DHack.Friendly_Fire then	
		PlayerMenu:addToggleOption('main_menu', 'Огонь по своим', {callback = friendfire, help = 'Теперь вы можете убивать своих союзников', toggle = true})
	else
		PlayerMenu:addToggleOption('main_menu', 'Огонь по своим', {callback = friendfire, help = 'Теперь вы можете убивать своих союзников'})
	end
	PlayerMenu:addGap('main_menu')
	PlayerMenu:addInformationOption('main_menu', 'Модификаци игрока', {textColor = Color.DodgerBlue})
	if P3DGroup_P3DHack.Player_Menu_Config and P3DGroup_P3DHack.Auto_Drill_Service then
		PlayerMenu:addToggleOption('main_menu', 'Авто дрель', {callback = drillservice, help = 'Автоматически восстанавливает дрель при поломке', toggle = true})
	else	
		PlayerMenu:addToggleOption('main_menu', 'Авто дрель', {callback = drillservice, help = 'Автоматически восстанавливает дрель при поломке'})
	end
	if P3DGroup_P3DHack.Player_Menu_Config and P3DGroup_P3DHack.Carry_Mod then
		PlayerMenu:addToggleOption('main_menu', 'Керри мод', {callback = carrymod, toggle = true, help = 'Удаляет вес всех сумок и взрывоопасных боеприпасов'})
	else
		PlayerMenu:addToggleOption('main_menu', 'Керри мод', {callback = carrymod, help = 'Удаляет вес всех сумок и взрывоопасных боеприпасов'})
	end
	PlayerMenu:addToggleOption('main_menu', 'Керри мод - прицел', {callback = carrycross, help = 'Спавн сумок на прицел, включить это в первую очередь, если вы хотите использовать с Удалить вес сумок'})
	if P3DGroup_P3DHack.Player_Menu_Config and P3DGroup_P3DHack.Cloakers_Cuff_Self then
		PlayerMenu:addToggleOption('main_menu', 'Клокер одевает на вас наручники', {callback = spooccuffselfon, help = 'Клокер не роняет вас, а только одевает наручники', toggle = true})
	else
		PlayerMenu:addToggleOption('main_menu', 'Клокер одевает на вас наручники', {callback = spooccuffselfon, help = 'Клокер не роняет вас, а только одевает наручники'})
	end
	if P3DGroup_P3DHack.Player_Menu_Config and P3DGroup_P3DHack.Infinite_Ammo_Bag then
		PlayerMenu:addToggleOption('main_menu', 'Беск. использ. сумки с патронами', {callback = infammobag, toggle = true})
	else
		PlayerMenu:addToggleOption('main_menu', 'Беск. использ. сумки с патронами', {callback = infammobag})
	end
	if P3DGroup_P3DHack.Player_Menu_Config and P3DGroup_P3DHack.Infinite_Specials then
		PlayerMenu:addToggleOption('main_menu', 'Бесконечные вещи', {callback = InfiniteSpecial, help = "Например стяжки, доски, и другое.", toggle = true})
	else
		PlayerMenu:addToggleOption('main_menu', 'Бесконечные вещи', {callback = InfiniteSpecial, help = "Например стяжки, доски, и другое."})
	end
	if isHost() then
		if P3DGroup_P3DHack.Player_Menu_Config and P3DGroup_P3DHack.Infinite_Converts then
			PlayerMenu:addToggleOption('main_menu', 'Бесконечная конвертация врагов', {callback = inf_converts, toggle = true})
		else	
			PlayerMenu:addToggleOption('main_menu', 'Бесконечная конвертация врагов', {callback = inf_converts})
		end
	else
		PlayerMenu:addInformationOption('main_menu', 'Недоступно (Только хост)', {textColor = Color.yellow})
	end
	
	-- PLAYER MENU COLUMN 2
	PlayerMenu:addGap('main_menu')
	if P3DGroup_P3DHack.Player_Menu_Config and P3DGroup_P3DHack.Carry_Stacker then
		PlayerMenu:addToggleOption('main_menu', 'Переносить больше сумок', {callback = carrystack, toggle = true, help = 'Если не хост, то дадут временный тег'})
	else
		PlayerMenu:addToggleOption('main_menu', 'Переносить больше сумок', {callback = carrystack, help = 'Если не хост, то дадут временный тег'})
	end
	PlayerMenu:addToggleOption('main_menu', 'Удалить вес сумок', {callback = carrylimit, help = 'Сумки становятся легче, а бросать их вы можете дальше'})
	PlayerMenu:addGap('main_menu')
	PlayerMenu:addGap('main_menu')
	if P3DGroup_P3DHack.Player_Menu_Config and P3DGroup_P3DHack.Infinite_Doc_Bag_Use then
		PlayerMenu:addToggleOption('main_menu', 'Беск. использование аптечек', {callback = infdocbag, toggle = true})
	else
		PlayerMenu:addToggleOption('main_menu', 'Беск. использование аптечек', {callback = infdocbag})
	end
	if P3DGroup_P3DHack.Player_Menu_Config and P3DGroup_P3DHack.Infinite_ECM_Battery then	
		PlayerMenu:addToggleOption('main_menu', 'Бесконечная ECM батарея', {callback = inf_ecm, toggle = true})
	else	
		PlayerMenu:addToggleOption('main_menu', 'Бесконечная ECM батарея', {callback = inf_ecm})
	end
	if P3DGroup_P3DHack.Player_Menu_Config and P3DGroup_P3DHack.Infinite_Messiah_Charge then	
		PlayerMenu:addToggleOption('main_menu', 'Бесконечный шанс мессии', {callback = infmessiah, toggle = true})	
	else
		PlayerMenu:addToggleOption('main_menu', 'Бесконечный шанс мессии', {callback = infmessiah})
	end
	if isHost() then
		if P3DGroup_P3DHack.Player_Menu_Config and P3DGroup_P3DHack.Infinite_Pager_Answers then	
			PlayerMenu:addToggleOption('main_menu', 'Бесконечные ответы на пейджер', {callback = inf_pager_answers, toggle = true})
		else
			PlayerMenu:addToggleOption('main_menu', 'Бесконечные ответы на пейджер', {callback = inf_pager_answers})
		end
		if P3DGroup_P3DHack.Player_Menu_Config and P3DGroup_P3DHack.Instant_Dominate then
			PlayerMenu:addToggleOption('main_menu', 'Мгновенное доминирование', {callback = instantdom, toggle = true})
		else	
			PlayerMenu:addToggleOption('main_menu', 'Мгновенное доминирование', {callback = instantdom})
		end
	else
		PlayerMenu:addInformationOption('main_menu', 'Недоступно (Только хост)', {textColor = Color.yellow})
		PlayerMenu:addInformationOption('main_menu', 'Недоступно (Только хост)', {textColor = Color.yellow})
	end
	if isHost() then
		if P3DGroup_P3DHack.Player_Menu_Config and P3DGroup_P3DHack.Instant_Drill then	
			PlayerMenu:addToggleOption('main_menu', 'Мгновенная дрель/компьютер', {callback = instantdrill, help = 'Мгновенно сверление или мгновенный взлом', toggle = true})
		else	
			PlayerMenu:addToggleOption('main_menu', 'Мгновенная дрель/компьютер', {callback = instantdrill, help = 'Мгновенно сверление или мгновенный взлом'})
		end
	else
		PlayerMenu:addInformationOption('main_menu', 'Недоступно (Только хост)', {textColor = Color.yellow })
	end
	if P3DGroup_P3DHack.Player_Menu_Config and P3DGroup_P3DHack.Interact_Distance_Increase then		
		PlayerMenu:addToggleOption('main_menu', 'Увелич. растояние взаимодействия', {callback = intdist, toggle = true})
	else	
		PlayerMenu:addToggleOption('main_menu', 'Увелич. растояние взаимодействия', {callback = intdist})
	end
	
	-- PLAYER MENU COLUMN 3
	PlayerMenu:addGap('main_menu')
	if P3DGroup_P3DHack.Player_Menu_Config and P3DGroup_P3DHack.Instant_Interact then	
		PlayerMenu:addToggleOption('main_menu', 'Мгновенное взаимодействие', {callback = instantinteract, help = 'Включает в себя моментальный ответ на пейджер', toggle = true})
	else	
		PlayerMenu:addToggleOption('main_menu', 'Мгновенное взаимодействие', {callback = instantinteract, help = 'Включает в себя моментальный ответ на пейджер'})
	end
	if P3DGroup_P3DHack.Player_Menu_Config and P3DGroup_P3DHack.Instant_Interact_With_Anything then
		PlayerMenu:addToggleOption('main_menu', 'Взаимодействовать с чем-либо', {callback = interactanyhting, toggle = true})
	else	
		PlayerMenu:addToggleOption('main_menu', 'Взаимодействовать с чем-либо', {callback = interactanyhting})
	end
	PlayerMenu:addGap('main_menu')
	PlayerMenu:addGap('main_menu')
	if P3DGroup_P3DHack.Player_Menu_Config and P3DGroup_P3DHack.Interact_Thru_Wall then	
		PlayerMenu:addToggleOption('main_menu', 'Взаимодействовать через стены', {callback = interactwall, toggle = true})
	else	
		PlayerMenu:addToggleOption('main_menu', 'Взаимодействовать через стены', {callback = interactwall})
	end
	if P3DGroup_P3DHack.Player_Menu_Config and P3DGroup_P3DHack.No_Hit_Disorientation then	
		PlayerMenu:addToggleOption('main_menu', 'Нет дезориентации', {callback = nohitdis, toggle = true})
	else
		PlayerMenu:addToggleOption('main_menu', 'Нет дезориентации', {callback = nohitdis})
	end
	if isHost() then
		if P3DGroup_P3DHack.Player_Menu_Config and P3DGroup_P3DHack.Small_Loot_Multiplier then	
			PlayerMenu:addToggleOption('main_menu', 'Множитель малого лута', {callback = smlootmulti, help = 'Множитель 3x, Максимальный лут $ 2,800,000', toggle = true})
		else	
			PlayerMenu:addToggleOption('main_menu', 'Множитель малого лута', {callback = smlootmulti, help = 'Множитель 3x, Максимальный лут $ 2,800,000'})
		end
	else
		PlayerMenu:addInformationOption('main_menu', 'Недоступно (Только хост)', { textColor = Color.yellow })
	end
	if P3DGroup_P3DHack.Player_Menu_Config and P3DGroup_P3DHack.Zipline_Transport then
		PlayerMenu:addToggleOption('main_menu', 'Канатная дорога', {callback = ZiplineBag, help = 'Позволяет транспортировать сумки на всех канатных дорогах', toggle = true})
	else
		PlayerMenu:addToggleOption('main_menu', 'Канатная дорога', {callback = ZiplineBag, help = 'Позволяет транспортировать сумки на всех канатных дорогах'})
	end
end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
if inGame() and isPlaying() then
    if PlayerMenu:isOpen() then
        PlayerMenu:close()
    else
	    if ChangerMenu then
			if ChangerMenu:isOpen() then
				ChangerMenu:close()
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
		PlayerMenu:open()
	end 
end 