dofile(ModPath .."P3DHack/Head/Config_(P3DGroup).lua")

local look_while_interacting = P3DGroup_P3DHack.Interact_Look_Around
local toggle_interaction = P3DGroup_P3DHack.Toggle_Interact
local no_cooldown = P3DGroup_P3DHack.Interaction_CoolDown

if string.lower(RequiredScript) == "lib/units/beings/player/states/playerstandard" then 
	function PlayerStandard:_check_action_interact(t, input)
		local new_action, timer, interact_object
		local action_forbidden
		local interaction_wanted = input.btn_interact_press
		if toggle_interaction then
			if input.btn_interact_press and self:_interacting() then
				self:_interupt_action_interact()
				return false
			elseif input.btn_interact_release then
				return false
			end
		end
		if interaction_wanted then
			if no_cooldown then
				action_forbidden = self:chk_action_forbidden("interact")
				or self._unit:base():stats_screen_visible()
				or self._ext_movement:has_carry_restriction()
				or self:_is_throwing_grenade()
				or self:_on_zipline()			
			else	
				action_forbidden = self:chk_action_forbidden("interact") or self._unit:base():stats_screen_visible() or self:_interacting() or self._ext_movement:has_carry_restriction() or self:is_deploying() or self:_changing_weapon() or self:_is_throwing_projectile() or self:_is_meleeing() or self:_on_zipline()
			end
			if not action_forbidden then
				new_action, timer, interact_object = managers.interaction:interact(self._unit)
				if new_action then
					self:_play_interact_redirect(t, input)
				end
				if timer then
					new_action = true
						if not look_while_interacting then
							self._ext_camera:camera_unit():base():set_limits(80, 50)
						end
					self:_start_action_interact(t, input, timer, interact_object)
				end
				new_action = new_action or self:_start_action_intimidate(t)
			end
		end
		if input.btn_interact_release then
			self:_interupt_action_interact()
		end
		return new_action
	end

	if no_cooldown then
		local _check_use_item_original = PlayerStandard._check_use_item 
		function PlayerStandard:_check_use_item(t, input, ...)
			_check_use_item_original(self, t, input, ...)
			local new_action
			local action_wanted = input.btn_use_item_press
			if action_wanted then
				local action_forbidden = self._use_item_expire_t
				or self:_interacting()
				or self:_is_throwing_grenade()
				or self:_is_meleeing()
				if not action_forbidden and managers.player:can_use_selected_equipment(self._unit) then
					self:_start_action_use_item(t)
					new_action = true
				end
			end
		end
	end
end

if string.lower(RequiredScript) == "lib/units/beings/player/states/playercivilian" then 
	local _PlayerCivilian__check_action_interact = PlayerCivilian._check_action_interact
	function PlayerCivilian:_check_action_interact(t, input)
		if toggle_interaction then	
			if input.btn_interact_press and self:_interacting() then
				self:_interupt_action_interact()
				return false
			elseif input.btn_interact_release then
				return false
			end
		end
		return _PlayerCivilian__check_action_interact(self, t, input)
	end
end

if string.lower(RequiredScript) == "lib/units/beings/player/states/playerdriving" then 
	local _PlayerDriving_check_action_exit_vehicle = PlayerDriving._check_action_exit_vehicle
	function PlayerDriving:_check_action_exit_vehicle(t, input)
		if toggle_interaction then	
			if input.btn_interact_press and self:_interacting() then
				self:_interupt_action_interact()
				return false
			elseif input.btn_interact_release then
				return false
			end
		end
		return _PlayerDriving_check_action_exit_vehicle(self, t, input)
	end
end