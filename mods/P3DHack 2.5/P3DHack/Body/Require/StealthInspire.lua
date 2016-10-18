dofile(ModPath .."P3DHack/Head/Config_(P3DGroup).lua")

local mark_civilians = P3DGroup_P3DHack.Stealth_Mark_Civilians	-- Allow marking of civilians in stealth
local mark_civilians_vocal = P3DGroup_P3DHack.Stealth_Mark_Civilians_Vocal	-- Allow vocals while marking civilians in stealth
local prioritize_inspire_shout = P3DGroup_P3DHack.Prioritize_Inspire_Shout -- Prioritize inspire revive over other shouts in stealth
local stealth_inspire = P3DGroup_P3DHack.Stealth_Shout_Inspire	-- Allow inspire to be used in stealth

if string.lower(RequiredScript) == "lib/units/beings/player/states/playerstandard" then
	function PlayerStandard:_get_intimidation_action(prime_target, char_table, amount, primary_only, detect_only, ...)
		local voice_type, new_action, plural
		local unit_type_enemy = 0
		local unit_type_civilian = 1
		local unit_type_teammate = 2
		local unit_type_camera = 3
		local is_whisper_mode = managers.groupai:state():whisper_mode()
		if prime_target then
			if prime_target.unit_type == unit_type_teammate then
				local is_human_player, record
				if not detect_only then
					record = managers.groupai:state():all_criminals()[prime_target.unit:key()]
					if record.ai then
						prime_target.unit:movement():set_cool(false)
						prime_target.unit:brain():on_long_dis_interacted(0, self._unit)
					else
						is_human_player = true
					end
				end
				local amount = 0
				local rally_skill_data = self._ext_movement:rally_skill_data()
				if rally_skill_data and rally_skill_data.range_sq > mvector3.distance_sq(self._pos, record.m_pos) then
					local needs_revive, is_arrested
					if prime_target.unit:base().is_husk_player then
						is_arrested = prime_target.unit:movement():current_state_name() == "arrested"
						needs_revive = prime_target.unit:interaction():active() and prime_target.unit:movement():need_revive() and not is_arrested
					else
						is_arrested = prime_target.unit:character_damage():arrested()
						needs_revive = prime_target.unit:character_damage():need_revive()
					end
					if needs_revive and rally_skill_data.long_dis_revive then
						voice_type = "revive"
					elseif not is_arrested and not needs_revive and rally_skill_data.morale_boost_delay_t and managers.player:player_timer():time() > rally_skill_data.morale_boost_delay_t then
						voice_type = "boost"
						amount = 1
					end
				end
				if is_human_player then
					prime_target.unit:network():send_to_unit({
						"long_dis_interaction",
						prime_target.unit,
						amount,
						self._unit
					})
				elseif voice_type == "revive" then
				elseif voice_type == "boost" then
					if Network:is_server() then
						prime_target.unit:brain():on_long_dis_interacted(amount, self._unit)
					else
						managers.network:session():send_to_host("long_dis_interaction", prime_target.unit, amount, self._unit)
					end
				end
				voice_type = voice_type or "come"
				plural = false
			else
				local prime_target_key = prime_target.unit:key()
				if prime_target.unit_type == unit_type_enemy then
					plural = false
					if prime_target.unit:anim_data().hands_back then
						voice_type = "cuff_cop"
					elseif prime_target.unit:anim_data().surrender then
						voice_type = "down_cop"
					elseif is_whisper_mode and prime_target.unit:movement():cool() and prime_target.unit:base():char_tweak().silent_priority_shout then
						voice_type = "mark_cop_quiet"
					elseif prime_target.unit:base():char_tweak().priority_shout then
						voice_type = "mark_cop"
					else
						voice_type = "stop_cop"
					end
				elseif prime_target.unit_type == unit_type_camera then
					plural = false
					voice_type = "mark_camera"
				elseif prime_target.unit:base():char_tweak().is_escort then
					plural = false
					local e_guy = prime_target.unit
					if e_guy:anim_data().move then
						voice_type = "escort_keep"
					elseif e_guy:anim_data().panic then
						voice_type = "escort_go"
					else
						voice_type = "escort"
					end
				else
					if prime_target.unit_type == unit_type_civilian and prime_target.unit:movement():cool() and mark_civilians then
						plural = false
						if mark_civilians_vocal then
							voice_type = "mark_cop_quiet"
						else
							prime_target.unit:contour():add(managers.player:has_category_upgrade("player", "marked_enemy_extra_damage") and "mark_enemy_damage_bonus" or "mark_enemy", true, managers.player:upgrade_value("player", "mark_enemy_time_multiplier", 1))
							voice_type = nil
						end
					elseif prime_target.unit:movement():stance_name() == "cbt" and prime_target.unit:anim_data().stand then
						voice_type = "come"
					elseif prime_target.unit:anim_data().move then
						voice_type = "stop"
					elseif prime_target.unit:anim_data().drop then
						voice_type = "down_stay"
					else
						voice_type = "down"
					end
					local num_affected = 0
					for _, char in pairs(char_table) do
						if char.unit_type == unit_type_civilian then
							if voice_type == "stop" and char.unit:anim_data().move then
								num_affected = num_affected + 1
							elseif voice_type == "down_stay" and char.unit:anim_data().drop then
								num_affected = num_affected + 1
							elseif voice_type == "down" and not char.unit:anim_data().move and not char.unit:anim_data().drop then
								num_affected = num_affected + 1
							end
						end
					end
					plural = num_affected > 1 and true or false
				end
				local max_inv_wgt = 0
				for _, char in pairs(char_table) do
					if max_inv_wgt < char.inv_wgt then
						max_inv_wgt = char.inv_wgt
					end
				end
				if max_inv_wgt < 1 then
					max_inv_wgt = 1
				end
				if detect_only then
					voice_type = "come"
				else
					for _, char in pairs(char_table) do
						if char.unit_type ~= unit_type_camera and char.unit_type ~= unit_type_teammate and (not is_whisper_mode or not char.unit:movement():cool()) then
							if char.unit_type == unit_type_civilian then
								amount = (amount or tweak_data.player.long_dis_interaction.intimidate_strength) * managers.player:upgrade_value("player", "civ_intimidation_mul", 1) * managers.player:team_upgrade_value("player", "civ_intimidation_mul", 1)
							end
							if prime_target_key == char.unit:key() then
								voice_type = char.unit:brain():on_intimidated(amount or tweak_data.player.long_dis_interaction.intimidate_strength, self._unit) or voice_type
							elseif not primary_only and char.unit_type ~= unit_type_enemy then
								char.unit:brain():on_intimidated((amount or tweak_data.player.long_dis_interaction.intimidate_strength) * char.inv_wgt / max_inv_wgt, self._unit)
							end
						end
					end
				end
			end
		end
		return voice_type, plural, prime_target
	end
	
	local _get_unit_intimidation_action_original = PlayerStandard._get_unit_intimidation_action

	function PlayerStandard:_get_unit_intimidation_action(intimidate_enemies, intimidate_civilians, intimidate_teammates, only_special_enemies, intimidate_escorts, intimidation_amount, primary_only, detect_only, ...)
		_get_unit_intimidation_action_original(self, intimidate_enemies, intimidate_civilians, intimidate_teammates, only_special_enemies, intimidate_escorts, intimidation_amount, primary_only, detect_only, ...)
		local char_table = {}
		local unit_type_enemy = 0
		local unit_type_civilian = 1
		local unit_type_teammate = 2
		local unit_type_camera = 3
		local cam_fwd = self._ext_camera:forward()
		local my_head_pos = self._ext_movement:m_head_pos()
		local range_mul = managers.player:upgrade_value("player", "intimidate_range_mul", 1) * managers.player:upgrade_value("player", "passive_intimidate_range_mul", 1)
		local intimidate_range_civ = tweak_data.player.long_dis_interaction.intimidate_range_civilians * range_mul
		local intimidate_range_ene = tweak_data.player.long_dis_interaction.intimidate_range_enemies * range_mul
		local highlight_range = tweak_data.player.long_dis_interaction.highlight_range * range_mul
		if intimidate_enemies then
			local enemies = managers.enemy:all_enemies()
			for u_key, u_data in pairs(enemies) do
				if u_data.unit:movement():team() ~= self._unit:movement():team() and not u_data.unit:anim_data().hands_tied and (u_data.char_tweak.priority_shout or not only_special_enemies) then
					if managers.groupai:state():whisper_mode() then
						if u_data.char_tweak.silent_priority_shout and u_data.unit:movement():cool() then
							self:_add_unit_to_char_table(char_table, u_data.unit, unit_type_enemy, highlight_range, false, false, 0.01, my_head_pos, cam_fwd)
						elseif not u_data.unit:movement():cool() then
							self:_add_unit_to_char_table(char_table, u_data.unit, unit_type_enemy, intimidate_range_ene, false, false, 100, my_head_pos, cam_fwd)
						end
					elseif u_data.char_tweak.priority_shout then
						self:_add_unit_to_char_table(char_table, u_data.unit, unit_type_enemy, highlight_range, false, false, 0.01, my_head_pos, cam_fwd)
					else
						self:_add_unit_to_char_table(char_table, u_data.unit, unit_type_enemy, intimidate_range_ene, false, false, 100, my_head_pos, cam_fwd)
					end
				end
			end
		end
		if intimidate_civilians then
			local civilians = managers.enemy:all_civilians()
			for u_key, u_data in pairs(civilians) do
				if u_data.unit:in_slot(21) and not u_data.unit:movement():cool() then 
					local is_escort = u_data.char_tweak.is_escort
					if not is_escort or intimidate_escorts then
						local dist = is_escort and 300 or intimidate_range_civ
						local prio = is_escort and 100000 or 0.001
						self:_add_unit_to_char_table(char_table, u_data.unit, unit_type_civilian, dist, false, false, prio, my_head_pos, cam_fwd)
					end
				elseif u_data.unit:movement():cool() and mark_civilians then
					self:_add_unit_to_char_table(char_table, u_data.unit, unit_type_civilian, highlight_range, false, false, 0.001, my_head_pos, cam_fwd)
				end
			end
		end
		if intimidate_teammates then
			if not managers.groupai:state():whisper_mode() then
				local criminals = managers.groupai:state():all_char_criminals()
				for u_key, u_data in pairs(criminals) do
					local added
					if u_key ~= self._unit:key() then
						local rally_skill_data = self._ext_movement:rally_skill_data()
						if rally_skill_data and rally_skill_data.long_dis_revive and rally_skill_data.range_sq > mvector3.distance_sq(self._pos, u_data.m_pos) then
							local needs_revive
							if u_data.unit:base().is_husk_player then
								needs_revive = u_data.unit:interaction():active() and u_data.unit:movement():need_revive() and u_data.unit:movement():current_state_name() ~= "arrested"
							else
								needs_revive = u_data.unit:character_damage():need_revive()
							end
							if needs_revive then
								if prioritize_inspire_shout then
									intimidate_enemies = false
									intimidate_civilians = false
								end
								added = true
								self:_add_unit_to_char_table(char_table, u_data.unit, unit_type_teammate, 100000, true, true, 5000, my_head_pos, cam_fwd)
							end
						end
					end
					if not added and not u_data.is_deployable and not u_data.unit:movement():downed() and not u_data.unit:base().is_local_player then
						self:_add_unit_to_char_table(char_table, u_data.unit, unit_type_teammate, 100000, true, true, 0.01, my_head_pos, cam_fwd)
					end
				end
			elseif stealth_inspire then
				local criminals = managers.groupai:state():all_player_criminals()
				for u_key, u_data in pairs(criminals) do
					local added
					if u_key ~= self._unit:key() then
						local rally_skill_data = self._ext_movement:rally_skill_data()
						if rally_skill_data and rally_skill_data.long_dis_revive and rally_skill_data.range_sq > mvector3.distance_sq(self._pos, u_data.m_pos) then
							local needs_revive
							if u_data.unit:base().is_husk_player then
								needs_revive = u_data.unit:interaction():active() and u_data.unit:movement():need_revive() and u_data.unit:movement():current_state_name() ~= "arrested"
							else
								needs_revive = u_data.unit:character_damage():need_revive()
							end
							if needs_revive then
								if prioritize_inspire_shout then
									intimidate_enemies = false
									intimidate_civilians = false
								end
								added = true
								self:_add_unit_to_char_table(char_table, u_data.unit, unit_type_teammate, 100000, true, true, 5000, my_head_pos, cam_fwd)
							end
						end
					end
					if not added and not u_data.is_deployable and not u_data.unit:movement():downed() and not u_data.unit:base().is_local_player then
						self:_add_unit_to_char_table(char_table, u_data.unit, unit_type_teammate, 100000, true, true, 0.01, my_head_pos, cam_fwd)
					end
				end
			end
		end
		if managers.groupai:state():whisper_mode() then
			for _, unit in ipairs(SecurityCamera.cameras) do
				if alive(unit) and unit:enabled() and not unit:base():destroyed() then
					local dist = 2000
					local prio = 0.001
					self:_add_unit_to_char_table(char_table, unit, unit_type_camera, dist, false, false, prio, my_head_pos, cam_fwd, {unit})
				end
			end
		end
		local prime_target = self:_get_interaction_target(char_table, my_head_pos, cam_fwd)
		return self:_get_intimidation_action(prime_target, char_table, intimidation_amount, primary_only, detect_only)
	end

end

if string.lower(RequiredScript) == "lib/units/beings/player/states/playermaskoff" then
	
	function PlayerMaskOff:mark_units(line, t, no_gesture, skip_alert)
		local mark_sec_camera = managers.player:has_category_upgrade("player", "sec_camera_highlight_mask_off")
		local mark_special_enemies = managers.player:has_category_upgrade("player", "special_enemy_highlight_mask_off")
		local voice_type, plural, prime_target = self:_get_unit_intimidation_action(mark_special_enemies, mark_special_enemies, false, false, false)
		local interact_type, sound_name
		if voice_type == "mark_cop" or voice_type == "mark_cop_quiet" then
			interact_type = "cmd_point"
			if voice_type == "mark_cop_quiet" then
				sound_name = tweak_data.character[prime_target.unit:base()._tweak_table].silent_priority_shout .. "_any"
			else
				sound_name = tweak_data.character[prime_target.unit:base()._tweak_table].priority_shout .. "x_any"
			end
			if managers.player:has_category_upgrade("player", "special_enemy_highlight") then
				prime_target.unit:contour():add(managers.player:has_category_upgrade("player", "marked_enemy_extra_damage") and "mark_enemy_damage_bonus" or "mark_enemy", true, managers.player:upgrade_value("player", "mark_enemy_time_multiplier", 1))
			end
		elseif voice_type == "mark_camera" and mark_sec_camera then
			sound_name = "f39_any"
			interact_type = "cmd_point"
			prime_target.unit:contour():add("mark_unit", true)
		end
		if interact_type then
			if not no_gesture then
			else
			end
			self:_do_action_intimidate(t, nil, sound_name, skip_alert)
			return true
		end
		return mark_sec_camera or mark_special_enemies
	end

end

if string.lower(RequiredScript) == "lib/tweak_data/charactertweakdata" then

	local _init_civilian_original = CharacterTweakData._init_civilian

	function CharacterTweakData:_init_civilian(...)
		_init_civilian_original(self, ...)
		self.civilian.silent_priority_shout = "f37"
		self.civilian_female.silent_priority_shout = "f37"
	end
	
end
