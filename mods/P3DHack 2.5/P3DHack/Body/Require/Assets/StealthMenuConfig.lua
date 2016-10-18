function StealthMenuConfig()
	-- COPS DONT SHOOT
	if P3DGroup_P3DHack.Cops_Dont_Shoot then
		if isHost() then
			Toggle.copsdontshoot = not Toggle.copsdontshoot

			local _setAllowFire = backuper:backup('CopMovement.set_allow_fire')
			function CopMovement:set_allow_fire(state)
				if state == false then _setAllowFire(self, state) end
			end
			
			local _setAllowFireClient = backuper:backup('CopMovement.set_allow_fire_on_client')
			function CopMovement:set_allow_fire_on_client(state, unit)
				if state == false then _setAllowFireClient(self, state, unit) end
			end
		end
	end
	
	-- DISABLE CAMS 
	if P3DGroup_P3DHack.Disable_Cameras then
		if isHost() then	
			Toggle.disablecams = not Toggle.disablecams
		
			for _,unit in pairs( GroupAIStateBase._security_cameras ) do
				unit:base():set_update_enabled(false)
			end
		end
	end

	-- PAGERS DISABLE
	if P3DGroup_P3DHack.Disable_Pagers then		
		if isHost() then	
			Toggle.disablepagers = not Toggle.disablepagers
				
			backuper:backup('CopBrain.begin_alarm_pager')
			function CopBrain:begin_alarm_pager(reset)
				if not reset and self._alarm_pager_has_run then
					return
				end
				self._alarm_pager_has_run = true
			end
		end
	end
	
	-- NO CASH PENALTY FOR KILLING CIVILLIANS
	if P3DGroup_P3DHack.Free_Civ_Kills then		
		Toggle.free_kill = not Toggle.free_kill

		backuper:backup('MoneyManager.get_civilian_deduction')
		function MoneyManager.get_civilian_deduction() return 0 end
		
		backuper:backup('MoneyManager.civilian_killed')
		function MoneyManager.civilian_killed() return end
		
		backuper:backup('UnitNetworkHandler.sync_hostage_killed_warning')
		function UnitNetworkHandler:sync_hostage_killed_warning( warning ) return 0 end	
	end
	
	-- NO PAGER ON DOMINATE
	if P3DGroup_P3DHack.No_Pager_Dominate then	
		if isHost() then	
			Toggle.no_pager_dom = not Toggle.no_pager_dom
			
			backuper:backup('CopLogicIntimidated._chk_begin_alarm_pager')
			function CopLogicIntimidated._chk_begin_alarm_pager(data) 
				if managers.groupai:state():whisper_mode() and data.unit:unit_data().has_alarm_pager then
				end
			end
		end
	end
	
	-- NO PANIC BUTTON
	if P3DGroup_P3DHack.No_Panic then	
		if isHost() then	
			Toggle.preventpanicbuttons = not Toggle.preventpanicbuttons

			local _actionRequest = backuper:backup('CopMovement.action_request')
			function CopMovement:action_request( action_desc )
				if action_desc.variant == "run" then return false end
				if action_desc.variant == "e_so_alarm_under_table" then return false end
				if action_desc.variant == "cmf_so_press_alarm_wall" then return false end
				if action_desc.variant == "cmf_so_press_alarm_table" then return false end
				if action_desc.variant == "cmf_so_call_police" then return false end
				if action_desc.variant == "arrest_call" then return false end
				return _actionRequest(self, action_desc)
			end	
		end
	end
	
	-- NO CALL POLICE
	if P3DGroup_P3DHack.Dont_Call_Police then		
		if isHost() then	
			Toggle.dont_call_police = not Toggle.dont_call_police

			backuper:backup('GroupAIStateBase.on_police_called')
			function GroupAIStateBase:on_police_called(called_reason) end
			
			backuper:backup('CivilianLogicFlee.clbk_chk_call_the_police')
			function CivilianLogicFlee.clbk_chk_call_the_police(ignore_this, data) end
		end
	end


	-- LOBOTOMIZE ALL AI by voodoo
	if P3DGroup_P3DHack.Lobotimize_AI then
		if isHost() then	
			Toggle.lobotomize_ai = not Toggle.lobotomize_ai
				
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
			end	end
			
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
	
	-- STEAL PAGERS By Harfatus
	if P3DGroup_P3DHack.Steal_Pagers then 				
		if isHost() then
			Toggle.steal_pagers = not Toggle.steal_pagers

			PlayerManager.___upgrade_value = backuper:backup('PlayerManager.upgrade_value')
			function PlayerManager:upgrade_value(cat, upg, ...) 
				if cat == "player" and upg == "melee_kill_snatch_pager_chance" then 
					return 1
				end 
				return PlayerManager.___upgrade_value(self, cat, upg, ...) 
			end	
		end
	end
	
	-- RANDOM PAGER
	if P3DGroup_P3DHack.Random_Pagers then
		Toggle.randompage = not Toggle.randompage

		local _CopBrain_clbk_alarm_pager = backuper:backup('CopBrain.clbk_alarm_pager')
		function CopBrain:clbk_alarm_pager(ignore_this, data)
			-- Create a random number
			local rand = math.rand(1)
			-- 50% / 25% / 12.5% / 0% incrementing chances of no pager in a table
			local chance_table = { 0.5, 0.25, 0.125, 0 }
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
			_CopBrain_clbk_alarm_pager(self, ignore_this, data )
		end 
	end
end