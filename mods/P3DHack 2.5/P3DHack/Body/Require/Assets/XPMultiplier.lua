function xpmultiplier()
	Toggle.xpmulti = not Toggle.xpmulti
	
	if not Toggle.xpmulti then
		backuper:restore('ExperienceManager.give_experience')
		ChatMessage('Выключено','Множитель опыта')
		return
	end
	
	ChatMessage('Включено','Множитель опыта')
	backuper:backup('ExperienceManager.give_experience')
	function ExperienceManager:give_experience(xp)
		xp = xp * P3DGroup_P3DHack.XP_Multiplier_Amount
		self._experience_progress_data = {}
		self._experience_progress_data.gained = xp
		self._experience_progress_data.start_t = {}
		self._experience_progress_data.start_t.level = self:current_level()
		self._experience_progress_data.start_t.current = self._global.next_level_data and self:next_level_data_current_points() or 0
		self._experience_progress_data.start_t.total = self._global.next_level_data and self:next_level_data_points() or 1
		self._experience_progress_data.start_t.xp = self:xp_gained()
		table.insert(self._experience_progress_data, {
			level = self:current_level() + 1,
			current = self:next_level_data_current_points(),
			total = self:next_level_data_points()
		})
		local level_cap_xp_leftover = self:add_points(xp, true, false)
		if level_cap_xp_leftover then
			self._experience_progress_data.gained = self._experience_progress_data.gained - level_cap_xp_leftover
		end
		self._experience_progress_data.end_t = {}
		self._experience_progress_data.end_t.level = self:current_level()
		self._experience_progress_data.end_t.current = self._global.next_level_data and self:next_level_data_current_points() or 0
		self._experience_progress_data.end_t.total = self._global.next_level_data and self:next_level_data_points() or 1
		self._experience_progress_data.end_t.xp = self:xp_gained()
		table.remove(self._experience_progress_data, #self._experience_progress_data)
		local return_data = deep_clone(self._experience_progress_data)
		self._experience_progress_data = nil
		managers.skilltree:give_specialization_points(xp)
		return return_data
	end
end	