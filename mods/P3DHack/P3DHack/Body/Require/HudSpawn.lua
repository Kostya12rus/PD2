if string.lower(RequiredScript) == "lib/managers/hudmanagerpd2" then
	function HUDManager:temp_show_spawn_bag(carry_id, value)
		self._hud_temp:show_spawn_bag(carry_id, value)
	end
end

if string.lower(RequiredScript) == "lib/managers/hud/hudtemp" then	
	function HUDTemp:_animate_spawn_bag_panel(bag_panel)
		local w, h = self._bag_panel_w, self._bag_panel_h
		local scx = self._temp_panel:w() / 2
		local ecx = self._temp_panel:w() - w / 2
		local scy = self._temp_panel:h() / 2
		local ecy = self:_bag_panel_bottom() - self._bag_panel_h / 2
		local bottom = bag_panel:bottom()
		local center_y = bag_panel:center_y()
		local bag_text = self._bg_box:child("bag_text")
		local function open_done()
			bag_text:stop()
			bag_text:set_visible(true)
			bag_text:animate(callback(self, self, "_animate_show_text"))
		end
		self._bg_box:stop()
		self._bg_box:animate(callback(nil, _G, "HUDBGBox_animate_open_center"), nil, w, open_done)
		bag_panel:set_size(w, h)
		bag_panel:set_center_x(scx)
		bag_panel:set_center_y(scy)
		wait(1)
		local TOTAL_T = 0.5
		local t = TOTAL_T
		while t > 0 do
			local dt = coroutine.yield()
			t = t - dt
			bag_panel:set_center_x(math.lerp(scx, ecx, 1 - t / TOTAL_T))
			bag_panel:set_center_y(math.lerp(scy, ecy, 1 - t / TOTAL_T))
		end
		bag_panel:set_size(w, h)
		bag_panel:set_center_x(ecx)
		bag_panel:set_center_y(ecy)
		bag_text:stop()	
		wait(2)
		bag_text:animate(callback(self, self, "_animate_hide_text"))
		local function close_done()
			bag_panel:set_visible(false)
		end
		self._bg_box:animate(callback(nil, _G, "HUDBGBox_animate_close_left"), close_done)
	end
	
	function HUDTemp:show_spawn_bag(carry_id, value)
		local bag_panel = self._temp_panel:child("bag_panel")
		local carry_data = tweak_data.carry[carry_id]
		local type_text = carry_data.name_id and managers.localization:text(carry_data.name_id)
		local bag_text = bag_panel:child("bag_text")
		bag_text:set_text(utf8.to_upper(type_text .. [[]] .. managers.experience:cash_string(value)))
		bag_panel:set_x(self._temp_panel:parent():w() / 2)
		bag_panel:set_visible(true)
		self._bg_box:child("bag_text"):set_visible(false)
		local carrying_text = "Spawning:"
		self._bg_box:child("bag_text"):set_text(utf8.to_upper(carrying_text .. "\n" .. type_text))
		self._bg_box:set_w(self._bag_panel_w, self._bag_panel_h)
		self._bg_box:set_position(0, 0)
		bag_panel:stop()
		bag_panel:animate(callback(self, self, "_animate_spawn_bag_panel"))
	end
end