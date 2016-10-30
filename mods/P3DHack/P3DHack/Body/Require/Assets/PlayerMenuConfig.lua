function PlayerMenuConfig()
	
	-- FRIENDLY FIRE
	if P3DGroup_P3DHack.Friendly_Fire then	
		Toggle.friendly_fire = not Toggle.friendly_fire
		
		backuper:backup('PlayerDamage.is_friendly_fire')
		function PlayerDamage:is_friendly_fire(unit) end
			
		backuper:backup('VehicleDamage.is_friendly_fire')	
		function VehicleDamage:is_friendly_fire(attacker_unit) end
		
		backuper:backup('NpcVehicleDamage.is_friendly_fire')			
		function NpcVehicleDamage:is_friendly_fire(attacker_unit) end
	end
	
	-- GOD MODE
	if P3DGroup_P3DHack.God_Mode then
		Toggle.godLike = not Toggle.godLike	
		
		managers.player:player_unit():character_damage():set_god_mode(true)
	end
	
	-- AUTO DRILL SERVICE
	if P3DGroup_P3DHack.Auto_Drill_Service then
		Toggle.drill_auto_service = not Toggle.drill_auto_service
		
		backuper:hijack('Drill.set_jammed', function(o, self, jammed, ...)
			local r = o(self, jammed, ...)
			local player = managers.player:local_player()
			if alive(player) and alive(self._unit) and (self._unit.interaction and self._unit:interaction()) and (self._unit:interaction().interact) then
				self._unit:interaction():interact(player)
			end
			return r
		end)
	end
	
	-- NO SPOOC DOWN ONLY CUFF
	if P3DGroup_P3DHack.Cloakers_Cuff_Self then
		Toggle.on_SPOOCed = not Toggle.on_SPOOCed

		backuper:backup('PlayerMovement.on_SPOOCed')
		function PlayerMovement:on_SPOOCed()
			if self._unit:character_damage()._god_mode then
				return
			end
			if self._current_state_name == "standard" or self._current_state_name == "bleed_out" then
				managers.player:set_player_state("arrested")
			end
		end
	end
	
	-- INFINITE AMMO BAG USES
	if P3DGroup_P3DHack.Infinite_Ammo_Bag then
		Toggle.takeammo = not Toggle.takeammo			
		
		backuper:backup('AmmoBagBase._take_ammo')
		function AmmoBagBase:_take_ammo( unit )
			local inventory = unit:inventory()
			if inventory then
				for _,weapon in pairs( inventory:available_selections() ) do
					local took = weapon.unit:base():add_ammo_from_bag(self._ammo_amount)
				end	
			end	
			return 0
		end	
	end
	
	-- INFINITE SPECIALS
	if P3DGroup_P3DHack.Infinite_Specials then
		Toggle.infinite_special = not Toggle.infinite_special
		
		backuper:backup('PlayerManager.remove_special')
		function PlayerManager:remove_special(name) end
	end
	
	-- INFINTE CONVERTS
	if P3DGroup_P3DHack.Infinite_Converts then
		Toggle.inf_converts = not Toggle.inf_converts
		
		tweak_data.upgrades.values.player.convert_enemies = {true}
		tweak_data.upgrades.values.player.convert_enemies_max_minions = {999999,999999}
	end
	
	-- INFINITE DOCTOR BAG USES
	if P3DGroup_P3DHack.Infinite_Doc_Bag_Use then
		Toggle.infdoc = not Toggle.infdoc
		
		backuper:backup('DoctorBagBase._take')
		function DoctorBagBase:_take(unit)
			unit:character_damage():recover_health() -- replenish()
			return 0
		end	
	end
	
	-- INFINTE ECM BATTERY
	if P3DGroup_P3DHack.Infinite_ECM_Battery then
		Toggle.inf_battery_activated = not Toggle.inf_battery_activated
		
		backuper:backup('ECMJammerBase.update')
		function ECMJammerBase:update( unit, t, dt )
			self._battery_life = self._max_battery_life
		end
	end
	
	-- INFINITE MESSIAH CHARGES
	if P3DGroup_P3DHack.Infinite_Messiah_Charge then
		Toggle.consume_messiah_charg = not Toggle.consume_messiah_charg	
		
		backuper:backup('PlayerDamage.consume_messiah_charge')
		function PlayerDamage:consume_messiah_charge() return true end	
	end
	
	-- ALLOW INFINITE PAGERS
	if P3DGroup_P3DHack.Infinite_Pager_Answers then
		Toggle.inf_pager_answers = not Toggle.inf_pager_answers
		
		backuper:backup('GroupAIStateBase.on_successful_alarm_pager_bluff')
		function GroupAIStateBase:on_successful_alarm_pager_bluff()	end
	end
	
	-- INSTANT DOMINATE TOGGLE
	if P3DGroup_P3DHack.Instant_Dominate then		
		Toggle.instant_dominate_convert = not Toggle.instant_dominate_convert
		
		backuper:backup('CopLogicIdle.on_intimidated')
		backuper:backup('CopLogicAttack.on_intimidated')
		backuper:backup('CopLogicArrest.on_intimidated')
		backuper:backup('CopLogicSniper.on_intimidated')
		function CopLogicIdle.on_intimidated( data, amount, aggressor_unit )
			CopLogicIdle._surrender( data, amount )
			return true
		end
		CopLogicAttack.on_intimidated = CopLogicIdle.on_intimidated
		CopLogicArrest.on_intimidated = CopLogicIdle.on_intimidated
		CopLogicSniper.on_intimidated = CopLogicIdle.on_intimidated

		-- Setup logic for shields to be able to be intimidated
		CopBrain._logic_variants.shield.intimidated = CopLogicIntimidated
		CopLogicIntimidated._onIIntimidated = backuper:backup('CopLogicIntimidated.on_intimidated')
		function CopLogicIntimidated.on_intimidated( data, amount, aggressor_unit ) 
			-- If shield we skip animations, go straight to conversion & spawn a new shield since it was destroyed during intimidation
			if data.unit:base()._tweak_table == "shield" then
				CopLogicIntimidated._do_tied( data, aggressor_unit )
				CopInventory._chk_spawn_shield( data.unit:inventory(), nil )
			else
				CopLogicIntimidated._onIIntimidated(data, amount, aggressor_unit)
			end	
		end
		
		-- Setup a proper sniper-rifle for snipers (100% accuracy, no spread)
		CopBrain._logic_variants.sniper = clone( CopBrain._logic_variants.security )
		CopBrain._logic_variants.sniper.attack = CopLogicSniper
		CopLogicSniper._onSniperEnter = backuper:backup('CopLogicSniper.enter')
		function CopLogicSniper.enter( data, new_logic_name, enter_params )
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
	
	-- INSTANT INTERACT TOGGLE
	if P3DGroup_P3DHack.Instant_Interact then		
		Toggle.instant_interact = not Toggle.instant_interact
		
		backuper:backup('BaseInteractionExt._get_timer')
		function BaseInteractionExt:_get_timer() return 0.1 end
		
		backuper:backup('PlayerManager.selected_equipment_deploy_timer')
		function PlayerManager:selected_equipment_deploy_timer(self) return 0.1 end	
	end
	
	-- INTERACT WITH ANYTHING TOGGLE
	if P3DGroup_P3DHack.Instant_Interact_With_Anything then	
		Toggle.interact_with_all = not Toggle.interact_with_all
		
		backuper:backup('BaseInteractionExt._has_required_upgrade')
		function BaseInteractionExt:_has_required_upgrade() return true end
		
		backuper:backup('BaseInteractionExt._has_required_deployable')
		function BaseInteractionExt:_has_required_deployable() return true end
		
		backuper:backup('BaseInteractionExt.can_interact')
		function BaseInteractionExt:can_interact() return true end
		
		backuper:backup('PlayerManager.remove_equipment')
		function PlayerManager:remove_equipment() end
	end
	
	-- INSTANT DRILL TOGGLE
	if P3DGroup_P3DHack.Instant_Drill then
		if isHost() then
			Toggle.timer_gui_instant_hack = not Toggle.timer_gui_instant_hack
			
			backuper:hijack('TimerGui.update',function(o, self, ...)
				self._current_timer = 0
				return o(self, ...)
			end)
		end 
	end
	
	-- INTERACT DISTANCE INCREASE
	if P3DGroup_P3DHack.Interact_Distance_Increase then
		Toggle.interact_distance = not Toggle.interact_distance
		
		backuper:backup('BaseInteractionExt.interact_distance')
		function BaseInteractionExt:interact_distance()
			if self.tweak_data == "access_camera" or self.tweak_data == "shaped_sharge" or tostring(self._unit:name()) == "Idstring(@ID14f05c3d9ebb44b6@)"
			or self.tweak_data == "burning_money" or self.tweak_data == "stn_int_place_camera"  or self.tweak_data == "trip_mine" then
				return self._tweak_data.interact_distance or tweak_data.interaction.INTERACT_DISTANCE
			end
			return P3DGroup_P3DHack.Interact_Distance_Amount or 200 -- DEFAULT IS 200
		end	
	end
	
	-- INTERACT THRU WALL TOGGLE
	if P3DGroup_P3DHack.Interact_Thru_Wall then	
		Toggle.interact_thru_wall = not Toggle.interact_thru_wall
		
		backuper:backup('ObjectInteractionManager._update_targeted')
		function ObjectInteractionManager:interact( player )
			if( alive( self._active_unit ) ) then
				local interacted,timer = self._active_unit:interaction():interact_start( player )
				if timer then
					self._active_object_locked_data = true
				end
				return interacted or interacted == nil or false, timer, self._active_unit
			end
			return false
		end

		backuper:backup('ObjectInteractionManager.interact')
		function ObjectInteractionManager:_update_targeted( player_pos, player_unit )	
			local mvec1 = Vector3()
			local mvec3_dis = mvector3.distance
			if( #self._close_units > 0 ) then
				for k, v in pairs( self._close_units ) do	
					if( alive( v ) and v:interaction():active() ) then
						if mvec3_dis( player_pos, v:interaction():interact_position() ) > v:interaction():interact_distance() then
							table.remove( self._close_units, k )
						end
					else
						table.remove( self._close_units, k )
			end	end	end
			
			for i = 1, self._close_freq, 1 do
				if( self._close_index >= self._interactive_count ) then
					self._close_index = 1
				else
					self._close_index = self._close_index + 1
				end
				local obj = self._interactive_units[ self._close_index ]
				if( alive(obj) and obj:interaction():active() and not self:_in_close_list( obj ) ) then
					if( mvec3_dis(player_pos, obj:interaction():interact_position()) <= obj:interaction():interact_distance()  ) then
						table.insert( self._close_units, obj )
			end	end	end
				
			local locked = false
			if self._active_object_locked_data then
				if not alive( self._active_unit ) or not self._active_unit:interaction():active() then
					self._active_object_locked_data = nil  
				else
					locked = ( mvec3_dis(player_pos, self._active_unit:interaction():interact_position()) <= self._active_unit:interaction():interact_distance() )
			end	end
			
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
				end	end	end
					
				if( active_unit and self._active_unit ~= active_unit ) then
					if alive( self._active_unit ) then
						self._active_unit:interaction():unselect()
					end
					if not active_unit:interaction():selected( player_unit ) then
						active_unit = nil
				end	end
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
	end
		
	-- NO HIT DISORIENTATION
	if P3DGroup_P3DHack.No_Hit_Disorientation then
		Toggle.no_hit_disorient = not Toggle.no_hit_disorient

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
	end
	
	-- SMALL LOOT MULTIPLIER TOGGLE
	if P3DGroup_P3DHack.Small_Loot_Multiplier then	
		Toggle.small_loot = not Toggle.small_loot
		
		tweak_data.upgrades.values.player.small_loot_multiplier = {P3DGroup_P3DHack.Small_Loot_Multiplier_Amount, P3DGroup_P3DHack.Small_Loot_Multiplier_Amount}
	end
	
	-- ZIPLINE BAGS 
	if P3DGroup_P3DHack.Zipline_Transport then	
		Toggle.Zipline_Bags = not Toggle.Zipline_Bags

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
			return on_interacted_original(self, unit)
		end
	end
	
	-- CARRYSTACKER
	if P3DGroup_P3DHack.Carry_Stacker then
		local _debugEnabled = false
		local BagIcon = "pd2_loot"
		
		Toggle.toggle_Carry = not Toggle.toggle_Carry

		if Toggle.toggle_Carry then
			if managers and managers.player and IntimitateInteractionExt and CarryInteractionExt then
				managers.player.carry_stack = {}
				managers.player.carrystack_lastpress = 0
				managers.player.drop_all_bags = false
				local ofuncs = {
				  managers_player_set_carry = managers.player.set_carry,
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
						ofuncs.managers_player_set_carry(self, cdata.carry_id, cdata.multiplier, cdata.dye_initiated, cdata.has_dye_pack, cdata.dye_value_multiplier, cdata.zipline_unit)
					end	
				end
				
				-- POPS AN ITEM FROM THE STACK WHEN THE PLAYER DROPS THEIR CARRIED ITEM
				function managers.player:drop_carry(zipline_unit) 
					ofuncs.managers_player_drop_carry(self, zipline_unit)
					if #self.carry_stack > 0 then
						local cdata = table.remove(self.carry_stack)
						if cdata then
							self:set_carry(cdata.carry_id, cdata.multiplier or 1, cdata.dye_initiated, cdata.has_dye_pack, cdata.dye_value_multiplier, cdata.zipline_unit)
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
				function managers.player:set_carry(carry_id, carry_multiplier, dye_initiated, has_dye_pack, dye_value_multiplier, zipline_unit)
					if self:is_carrying() and self:get_my_carry_data() then
						table.insert(self.carry_stack, self:get_my_carry_data())
					end
					ofuncs.managers_player_set_carry(self, carry_id, carry_multiplier, dye_initiated, has_dye_pack, dye_value_multiplier, zipline_unit)
					self:refresh_stack_counter()
				end

				-- NEW FUNCTION TO DISCARD THE CURRENTLY CARRIED ITEM
				function managers.player:carry_discard()
					managers.hud:remove_teammate_carry_info( HUDManager.PLAYER_PANEL )
					managers.hud:temp_hide_carry_bag()
					self:update_removed_synced_carry_to_peers()
					if self._current_state == "carry" then
						managers.player:set_player_state( "standard" )
					end	
				end
				
				-- OVERRIDDEN TO PREVENT BLOCKING US FROM PICKING UP A DEAD BODY
				function IntimitateInteractionExt:_interact_blocked( player )
					if Toggle.toggle_Carry and self.tweak_data == "corpse_dispose" then
						if not managers.player:has_category_upgrade( "player", "corpse_dispose" ) then
							return true
						end
						return not managers.player:can_carry( "person" )
					end
					-- RUN THE ORIGINAL FUNCTION IF CARRYSTACKER IS OFF OR IF PLAYER ISN'T DISPOSING OF A CORPSE
					return ofuncs.IntimitateInteractionExt__interact_blocked(self, player)
				end

				-- OVERRIDDEN TO ALWAYS ALLOW US TO PICK UP A CARRY ITEM
				function CarryInteractionExt:_interact_blocked( player )
					if Toggle.toggle_Carry then
						return not managers.player:can_carry( self._unit:carry_data():carry_id() )
					end
					-- RUN THE ORIGINAL FUNCTION IF CARRYSTACKER IS OFF
					return ofuncs.CarryInteractionExt__interact_blocked(self, player)
				end

				-- OVERRIDDEN TO ALWAYS ALLOW US TO SELECT A CARRY ITEM
				function CarryInteractionExt:can_select( player )
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
						managers.hud:present_mid_text( { title = "Carry Stack", text = cdata.carry_id .. " Pushed", time = 1 } )
					elseif #self.carry_stack > 0 then
						cdata = table.remove(self.carry_stack)
						self:set_carry(cdata.carry_id, cdata.multiplier, cdata.dye_initiated, cdata.has_dye_pack, cdata.dye_value_multiplier, cdata.zipline_unit)
						managers.hud:present_mid_text( { title = "Carry Stack", text = cdata.carry_id .. " Popped", time = 1 } )
					else
						managers.hud:present_mid_text( { title = "Carry Stack", text = "Empty", time = 1 } )
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
			if managers.player:is_carrying() then
				managers.player:drop_carry()
			end
		end 
	end
	
	-- BAG MOD TOGGLE
	if P3DGroup_P3DHack.Carry_Mod then
		Toggle.toggleBagMods = not Toggle.toggleBagMods
		if Toggle.toggleBagMods then
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
		end 
	end
end