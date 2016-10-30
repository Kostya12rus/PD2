dofile(ModPath .."P3DHack/Head/Config_(P3DGroup).lua")

if P3DGroup_P3DHack.Zipline_Drop then
	function PlayerCarry:_check_use_item(t, input)
		local new_action
		local action_wanted = input.btn_use_item_press
		if action_wanted then
			local action_forbidden = self._use_item_expire_t or self:_changing_weapon() or self:_interacting() or self._ext_movement:has_carry_restriction() or self:_is_throwing_grenade()
			if not action_forbidden then
				managers.player:drop_carry()
				new_action = true
			end
		end
		return new_action
	end
end