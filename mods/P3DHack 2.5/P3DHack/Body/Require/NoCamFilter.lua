function IngameAccessCamera:at_enter(old_state, ...)
	local player = managers.player:player_unit()
	if player then
		player:base():set_enabled(false)
		player:base():set_visible(false)
		player:character_damage():add_listener("IngameAccessCamera", {"hurt", "death"}, callback(self, self, "_player_damage"))
		SoundDevice:set_rtpc("stamina", 100)
	end
	self._sound_source = self._sound_source or SoundDevice:create_source("IngameAccessCamera")
	self._sound_source:post_event("camera_monitor_engage")
	managers.enemy:set_gfx_lod_enabled(false)
	self._old_state = old_state:name()
	if not managers.hud:exists(self.GUI_SAFERECT) then
		managers.hud:load_hud(self.GUI_FULLSCREEN, false, true, false, {})
		managers.hud:load_hud(self.GUI_SAFERECT, false, true, true, {})
	end
	managers.hud:show(self.GUI_SAFERECT)
	managers.hud:show(self.GUI_FULLSCREEN)
	managers.hud:start_access_camera()
	self._saved_default_color_grading = managers.environment_controller:default_color_grading()
	managers.environment_controller:set_default_color_grading("color_off")
	self._cam_unit = CoreUnit.safe_spawn_unit("units/gui/background_camera_01/access_camera", Vector3(), Rotation())
	self:_get_cameras()
	self._camera_data = {}
	self._camera_data.index = 0
	self._no_feeds = not self:_any_enabled_cameras()
	if self._no_feeds then
		managers.hud:set_access_camera_destroyed(true, true)
	else
		self:_next_camera()
	end
	self:_setup_controller()
end

function IngameAccessCamera:update(t, dt)
	if self._no_feeds then
		return
	end
	t = managers.player:player_timer():time()
	dt = managers.player:player_timer():delta_time()
	local look_d = self._controller:get_input_axis("look")
	local zoomed_value = self._cam_unit:camera():zoomed_value()
	self._target_yaw = self._target_yaw - look_d.x * zoomed_value
	if self._yaw_limit ~= -1 then
		self._target_yaw = math.clamp(self._target_yaw, -self._yaw_limit, self._yaw_limit)
	end
	self._target_pitch = self._target_pitch + look_d.y * zoomed_value
	if self._pitch_limit ~= -1 then
		self._target_pitch = math.clamp(self._target_pitch + look_d.y * zoomed_value, -self._pitch_limit, self._pitch_limit)
	end
	self._yaw = math.step(self._yaw, self._target_yaw, dt * 45)
	self._pitch = math.step(self._pitch, self._target_pitch, dt * 45)
	self._cam_unit:camera():set_offset_rotation(self._yaw, self._pitch)
	local move_d = self._controller:get_input_axis("move")
	self._cam_unit:camera():modify_fov(-move_d.y * (dt * 12))
	if self._do_show_camera then
		self._do_show_camera = false
		local access_camera = self._cameras[self._camera_data.index].access_camera
		managers.hud:set_access_camera_destroyed(access_camera:value("destroyed"))
	end
	local units = World:find_units_quick("all", 3, 16, 21, managers.slot:get_mask("enemies"))
	local amount = 0
	for i, unit in ipairs(units) do
		if World:in_view_with_options(unit:movement():m_head_pos(), 0, 0, 4000) then
			local ray
			if self._last_access_camera and self._last_access_camera:has_camera_unit() then
				ray = self._cam_unit:raycast("ray", unit:movement():m_head_pos(), self._cam_unit:position(), "ray_type", "ai_vision", "slot_mask", managers.slot:get_mask("world_geometry"), "ignore_unit", self._last_access_camera:camera_unit(), "report")
			else
				ray = self._cam_unit:raycast("ray", unit:movement():m_head_pos(), self._cam_unit:position(), "ray_type", "ai_vision", "slot_mask", managers.slot:get_mask("world_geometry"), "report")
			end
			if not ray then
				amount = amount + 1
				managers.hud:access_camera_track(amount, self._cam_unit:camera()._camera, unit:movement():m_head_pos())
				if self._last_access_camera and not self._last_access_camera:value("destroyed") and managers.player:upgrade_value("player", "sec_camera_highlight", false) and unit:base()._tweak_table and (managers.groupai:state():whisper_mode() and tweak_data.character[unit:base()._tweak_table].silent_priority_shout or tweak_data.character[unit:base()._tweak_table].priority_shout) then
					managers.game_play_central:auto_highlight_enemy(unit, true)
				end
			end
		end
	end
	managers.hud:access_camera_track_max_amount(amount)
end