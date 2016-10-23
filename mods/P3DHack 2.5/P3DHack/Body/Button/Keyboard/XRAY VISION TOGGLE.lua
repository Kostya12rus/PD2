local ColorList = {
	civpickup       = 'FFFF00', -- YELLOW
	enepickup       = '660066', -- PURPLE
	default         = '1A851A', -- LIGHTBLUE
	friendly        = 'A3FFA3', -- LIGHT GREEN
	camera          = 'CC0000', -- DARK RED
	hostage         = '009933', -- DARK GREEN
	civilian        = 'FFFFFF', -- WHITE
	civilian_female = 'E0A3C2', -- LIGHT PINK
	spooc           = '0000FF', -- NAVY BLUE
	taser           = 'FF66FF', -- PINK
	security        = 'CC0000', -- RED
	shield          = 'CC0000', -- RED
	tank            = 'FFFF00', -- YELLOW
	sniper          = 'FF9933', -- GOLD
	gangster        = '660066',  -- PURPLE
	medic           = 'E00AB9',  -- DARK PINK
}
 
function getUnitColor(unit)
	local unitType = unit:base()._tweak_table
	if unit:base().security_camera then unitType = 'camera' end
	if unit:base().is_converted then unitType = 'friendly' end
	if unit:base().is_hostage then unitType = 'hostage' end
	if unit:base().has_civpickup then 
		unitType = 'civpickup'
	elseif unit:base().has_enepickup then 
		unitType = 'enepickup'
	end
	if not unitType then return nil end
	return Color(ColorList[unitType] or ColorList['default'])
end
 
if inGame() and isPlaying() and not inChat() then
	--Contour Overrides
	if ContourExt then
		if not _nhUpdateColor then _nhUpdateColor = ContourExt._upd_color end
		function ContourExt:_upd_color(is_retry)
			if toggleMark then
				local color = getUnitColor(self._unit)
				if color then
					self._materials = self._materials or self._unit:get_objects_by_type(Idstring("material"))
					for _, material in ipairs(self._materials) do
						material:set_variable(Idstring("contour_color"), color)
					end
					return
				end
			end
			_nhUpdateColor(self)
		end
		
		function ContourExt:setData(data)
			if not data or not type(data) == 'table' then return end
			for k, v in pairs(data) do self._unit:base()[k] = v end
		end
		
		if not _nremove then _nremove = ContourExt.remove end
		function ContourExt:remove()
			while self._contour_list ~= nil do
				self:_remove(1)
			end
			_nremove(self)
		end

		--Remove contours on death for host
		if not _dieBase then _dieBase = CopDamage.die end
		function CopDamage:die(attack_data)
			if self._unit:contour() then
				self._unit:contour():remove()
			end
			_dieBase(self, attack_data)
		end

		--Remove contours on death for client
		if not _huskDieBase then _huskDieBase = HuskCopDamage.die end
		function HuskCopDamage:die(variant)
			if self._unit:contour() then
				self._unit:contour():remove()
			end
			_huskDieBase(self, variant)
		end

		--Remove contours for camera destruction, only works for host?
		if not _camDieBase then _camDieBase = ElementSecurityCamera.on_destroyed end
		function ElementSecurityCamera:on_destroyed()
			local camera_unit = self:_fetch_unit_by_unit_id( self._values.camera_u_id )
			if camera_unit:contour() then
				camera_unit:contour():remove()
			end
			_camDieBase(self)
		end
	end
	
	function markEnemies()
		if not toggleMark then return end
		for u_key,u_data in pairs(managers.enemy:all_civilians()) do
			if u_data.unit.contour and alive(u_data.unit) then
				if isHost() and u_data.unit:character_damage():pickup() then
					u_data.unit:contour():setData({has_civpickup = true})
				end
				u_data.unit:contour():add("mark_enemy", syncMark, 0)
			end
		end  
		for u_key,u_data in pairs(managers.enemy:all_enemies()) do
			if u_data.unit.contour and alive(u_data.unit) then
				if isHost() and u_data.unit:character_damage():pickup() and u_data.unit:character_damage():pickup() ~= "ammo" then
					u_data.unit:contour():setData({has_enepickup = true})
				end
				u_data.unit:contour():add("mark_enemy", syncMark, 0)
			end
		end
		if isHost() then
			for u_key, u_data in pairs( managers.groupai:state()._security_cameras ) do
				if u_data.contour then 
					u_data:contour():add("mark_unit", syncMark, 0)
				end
			end 
		else
			for _, unit in ipairs( SecurityCamera.cameras ) do
				if unit and unit:contour() and unit:enabled() and unit:base() and not unit:base():destroyed() then
					unit:contour():add("mark_unit", syncMark, 0)
				end
			end
		end
	end
      
	if GameSetup then
		if not _gameUpdate then _gameUpdate = GameSetup.update end
		local _gameUpdateLastMark
		function GameSetup:update(t, dt)
			_gameUpdate(self, t, dt)
			if not _gameUpdateLastMark or t - _gameUpdateLastMark > 4 then
				_gameUpdateLastMark = t
				markData()
			end
		end
	end
   
	function markData()
		markEnemies()
	end
   
	function markClear()
		if not inGame() then return end
		if isHost() then
			for u_key, u_data in pairs(managers.groupai:state()._security_cameras) do
				if u_data.contour then 
					u_data:contour():remove( "mark_unit", syncMark ) 
				end
			end
		else
			for _, unit in ipairs(SecurityCamera.cameras) do
				unit:contour():remove("mark_unit", syncMark)
			end
		end
		for u_key,u_data in pairs(managers.enemy:all_civilians()) do
			if u_data.unit.contour then 
				u_data.unit:contour():remove("mark_enemy", syncMark) 
			end
		end
		for u_key,u_data in pairs(managers.enemy:all_enemies()) do
			if u_data.unit.contour then u_data.unit:contour():remove("mark_enemy", syncMark) end
		end
	end
   
	function markToggle(toggleSync)
		if not inGame() then return end
		if toggleSync then
			syncMark = not syncMark
		else
			toggleMark = not toggleMark
			if not toggleMark then markClear() end
		end
		markData()
	end
 
	if not toggleMark then toggleMark = false end
	if not syncMark then syncMark = false end
	markToggle()
end