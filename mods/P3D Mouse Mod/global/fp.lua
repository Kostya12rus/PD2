if not GlobalScriptInitialized then
GlobalScriptInitialized = true
-----------------------
-- UTILITY FUNCTIONS --
-----------------------
if not _initcheck then
	-- TABLE FOR TOGGLE VARIABLES
	Toggle = Toggle or {}
	-- GLOBAL BACKUP
	Backuper = Backuper or class()
	---------------------------
	-- GENERAL MANAGER CHECK --
	---------------------------
	if not managers then return end
	-------------------------
	-- GAME NETWORK CHECKS --
	-------------------------
	-- TITLESCREEN CHECK
	function inTitlescreen()
		if not game_state_machine then return false end
		return string.find(game_state_machine:current_state_name(), "titlescreen")
	end
	-- LOADING CHECK
	function isLoading()
		if not BaseNetworkHandler then
			return false
		end
		return BaseNetworkHandler._gamestate_filter.waiting_for_players[ game_state_machine:last_queued_state_name() ]
	end
	-- GAME CHECK
	function inGame()
		if not game_state_machine then return false end
		return string.find(game_state_machine:current_state_name(), "game")
	end
	-- CHAT CHECK
	function inChat()
		if managers.hud and managers.hud._chat_focus then
			return true
		end
	end
	-- SINGLEPLAYER CHECK
	function isSinglePlayer()
		return Global.game_settings.single_player or false
	end
	-- PLAYING CHECK
	function isPlaying()
		if not BaseNetworkHandler then
			return false
		end
		return BaseNetworkHandler._gamestate_filter.any_ingame_playing[ game_state_machine:last_queued_state_name() ]
	end
	-- SERVER CHECK
	function isServer()
		if not Network then
			return false
		end
		return Network:is_server()
	end
	-- HOST CHECK
	function isHost()
		if not Network then
			return false
		end
		return not Network:is_client()
	end

	------------------
	-- WEAPON CHECK --
	------------------
	function isPrimary(type)
		local primary = managers.blackmarket:equipped_primary()
		if primary then
			local category = tweak_data.weapon[ primary.weapon_id ].category
			if category == string.lower(type) then
				return true
			end
		end
		return false
	end
	---------------------
	-- GAMEPLAY CHECKS --
	---------------------
	-- HOSTAGE CHECK
	function isHostage(unit)
		if unit and alive(unit) and
		((unit.brain and unit:brain().is_hostage and unit:brain():is_hostage()) or
		(unit.anim_data and (unit:anim_data().tied or unit:anim_data().hands_tied))) then
		return true
		end
	return false
	end
	---------------------
	-- BACKUP INITIATE --
	---------------------
	function Backuper:init(class_name)
		self._name = class_name
		self._originals = {}
		self._hacked = {}
	end
	function Backuper:backup(stuff_string,name) --Original function name!
		if self._originals[name] or self._originals[stuff_string] then
			return self._originals[name] or self._originals[stuff_string]
		end

		local execute, serr = loadstring(self._name..'._originals[\"'..(name or stuff_string)..'\"] = '..stuff_string)

		local success, err = pcall(execute)

		--m_log_vs("Tables:", self._originals[name], self._originals[stuff_string])
		if success then
			return self._originals[name] or self._originals[stuff_string]
		else
		end
	end
	-------------------
	-- BACKUP HIJACK --
	-------------------
	-- This will allow to hijack single function with different multiple functions!
	-- As the 1st argument here will be array containing original function as 1st argument and then array of hijacked functions, 2nd argument reserved for your needs in order to structure calls (by default it passes number 1 as a sign of that function was called first).
	-- NOTE: Avoid using this at all costs! If you see any functions hijacked using this, better find other way of hijacking it!
	function Backuper:hijack_adv(fstr, new_function)
		if not self._hacked[fstr] then
			self:backup(fstr)
			self._hacked[fstr] = {}
			local exec, serr = loadstring(fstr..' = function(...) local tb = { '..self._name..'._originals[\''..fstr..'\'] } \
				for _,func in ipairs('..self._name..'._hacked[\''..fstr..'\']) do table.insert(tb, func) end	\
					return '..self._name..'._hacked[\''..fstr..'\'][1](  tb, 1, ... )  end')
		
		local s,res = pcall(exec)
	end
	table.insert(self._hacked[fstr], new_function)
	return new_function
	--return #self._hacked[fstr]
	end
	-------------------------
	-- BACKUP EXPERIMENTAL --
	-------------------------
	-- Experimental feature! I will not move all functions into this. This will hijack function with new_function. When hacked function being executed, new_function recieve original function as 1st argument, then other arguments. So now when you hijack class function, new_function should look like this: function(orig, self, ...) methods end Personally I suggest to use it only when you need to hijack advanced function, that require original function execution aswell.
	function Backuper:hijack(function_string, new_function)
		if self._hacked[function_string] then
			self:restore(function_string)
		end
		self:backup(function_string)
		self._hacked[function_string] = new_function
		local exec, serr = loadstring(function_string..' = function(...) return '..self._name..'._hacked[\''..function_string..'\']('..self._name..'._originals[\''..function_string..'\'], ... ) end')
		local s,res = pcall(exec)
		if s then
			return self._hacked[function_string]
		else
		end
	end
	
	function Backuper:restore(stuff_string, name)
		local n = self._originals[name] or self._originals[stuff_string]
		if n then
			local exec, serr = loadstring(stuff_string..' = '..self._name..'._originals[\"'..stuff_string..'\"]')
			local success, err = pcall(exec)
			if success then
				self._originals[stuff_string] = nil
				self._hacked[stuff_string] = nil
			else
			end
		end
	end

	function Backuper:restore_all() --Currently works only, if stuff_string was used as key
		for n,_ in pairs(self._originals) do
			local exec, serr = loadstring(n..' = '..self._name..'._originals[\"'..n..'\"]')
		
			local success, err = pcall(exec)
			if success then
				self._originals[n] = nil
				self._hacked[n] = nil
			else
			end
		end
	end

	function Backuper:destroy()
		self:restore_all()
	end
	---------------------
	-- CROSSHAIR CHECK --
	---------------------
	--  XHAIR POS
	function get_crosshair_pos(penetrate, from_pos, mvec_to)
		local ray = get_crosshair_ray(penetrate, from_pos, mvec_to)
		if not ray then return false end
		return ray.hit_position
	end
	-- XHAIR POS V2 (COLLISION HIT)
	function get_crosshair_pos_new()
		local player_unit = managers.player:player_unit()
		local mvec_to = Vector3()
			mvector3.set(mvec_to, player_unit:camera():forward())
			mvector3.multiply(mvec_to, 20000)
			mvector3.add(mvec_to, player_unit:camera():position())
			return World:raycast('ray', player_unit:camera():position(), mvec_to, 'slot_mask', managers.slot:get_mask('bullet_impact_targets'))
	end
	-- XHAIR POS V3 (THROUGH WALL)
	function get_crosshair_ray(penetrate, slotMask)
		if not slotMask then slotMask = "bullet_impact_targets" end
		local player = managers.player:player_unit()
		local fromPos = player:camera():position()
		local mvecTo = Vector3()
		mvector3.set(mvecTo, player:camera():forward())
		mvector3.multiply(mvecTo, 20000)
		mvector3.add(mvecTo, fromPos)
		local colRay = World:raycast("ray", fromPos, mvecTo, "slot_mask", managers.slot:get_mask(slotMask))
		if colRay and penetrate then
				local offset = Vector3()
					mvector3.set(offset, player:camera():forward())
					mvector3.multiply(offset, 100)
				mvector3.add(colRay.hit_position, offset)
		end
		return colRay
	end
_initcheck = true
end -- _initcheck END
end -- GlobalScriptInitialized END