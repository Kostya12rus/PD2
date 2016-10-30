----------------------
--- AUTO ON CHEATS ---
----------------------
function autocheats()
    -- 6TH SENSE ONLY RESETS WHEN MOVING (MAELFORM)
    if P3DGroup_P3DHack.Sixth_Sense_Reset then
        local _update_omniscience_original = PlayerStandard._update_omniscience
        function PlayerStandard:_update_omniscience(t, dt, ...)         
            local action_forbidden = not managers.player:has_category_upgrade("player", "standstill_omniscience") or self._ext_movement:has_carry_restriction() or self:_on_zipline() or self._moving or self:running() or self:in_air() or not managers.groupai:state():whisper_mode() or not tweak_data.player.omniscience
            if action_forbidden then
                if self._state_data.omniscience_t then
                    self._state_data.omniscience_t = nil
                end
                return  _update_omniscience_original(self, t, dt, ...)
            end
            self._state_data.omniscience_t = self._state_data.omniscience_t or t + tweak_data.player.omniscience.start_t        
            if t >= self._state_data.omniscience_t then
                local sensed_targets = World:find_units_quick("sphere", self._unit:movement():m_pos(), tweak_data.player.omniscience.sense_radius, managers.slot:get_mask("trip_mine_targets"))
                self._state_data.omniscience_units_detected = self._state_data.omniscience_units_detected or {}
                for _, unit in ipairs(sensed_targets) do
                    if alive(unit) and not tweak_data.character[unit:base()._tweak_table].is_escort and not unit:anim_data().tied and not unit:anim_data().surrender then
                        if not self._state_data.omniscience_units_detected[unit:key()] or t >= self._state_data.omniscience_units_detected[unit:key()] then
                            self._state_data.omniscience_units_detected[unit:key()] = t + tweak_data.player.omniscience.target_resense_t
                            managers.game_play_central:auto_highlight_enemy(unit, true)
                            break
                        end
                    end
                end
                self._state_data.omniscience_t = t + tweak_data.player.omniscience.interval_t
            end    
        end
    end
    
    -- DODGE CHANCE BUFF
    if P3DGroup_P3DHack.Dodge_Chance_Buff then
        tweak_data.player.damage.DODGE_INIT = P3DGroup_P3DHack.Dodge_Chance_Buff_Amount
    end
    
    -- BAG EXPLOSION CAM MULIPLIER
    if P3DGroup_P3DHack.Camera_Bag_Explosion_Multiplier then
        CarryData.EXPLOSION_CUSTOM_PARAMS.camera_shake_mul = P3DGroup_P3DHack.Camera_Bag_Explosion_Multiplier_Amount 
    end
    
    -- JUMP WITH MASK OFF    
    if P3DGroup_P3DHack.Jump_Mask_Off then    
        function PlayerMaskOff:_check_action_jump(t, input)
            if input.btn_jump_press then
                return PlayerMaskOff.super._check_action_jump(self, t, input)
            end    
        end
        
        function PlayerMaskOff:_check_action_duck(t, input)
            if input.btn_duck_press then
                return PlayerMaskOff.super._check_action_duck(self, t, input)
            end    
        end
		
		function PlayerCivilian:_check_action_jump(t, input)
			if input.btn_jump_press then
				return PlayerCivilian.super._check_action_jump(self, t, input)
			end
		end
		function PlayerCivilian:_check_action_duck(t, input)
			if input.btn_duck_press then
				managers.hint:show_hint("clean_block_interact")
			end
		end
    end
    
    -- NO BAG COOLDOWN
    if P3DGroup_P3DHack.Bag_CoolDown then
        function PlayerManager:carry_blocked_by_cooldown() return false end
    end    
    
    -- NO FLASHBANGS 
    if P3DGroup_P3DHack.No_FlashBang then
        function CoreEnvironmentControllerManager:set_flashbang(flashbang_pos, line_of_sight, travel_dis, linear_dis, duration) end
    end
    
    -- NO WEAPON RECOIL
    if P3DGroup_P3DHack.No_Recoil then
        function NewRaycastWeaponBase:recoil_multiplier() return 0 end
        function RaycastWeaponBase:recoil_multiplier() return 0 end
    end
    
    -- NO WEAPON SPREAD
    if P3DGroup_P3DHack.No_Spread then    
        local get_spread_original = NewRaycastWeaponBase._get_spread
        function NewRaycastWeaponBase:_get_spread(...) 
            if self:weapon_tweak_data().category == "shotgun" then
                return get_spread_original(self, ...)
            else 
                return 0
            end
        end
    end
    
    -- INFINITE STAMINA
    if P3DGroup_P3DHack.Infinite_Stamina then
        function PlayerMovement:_change_stamina(value) end
        function PlayerMovement:is_stamina_drained() return false end
    end
    
    -- MOVE INFINITE NUMBER OF HOSTAGES - B1313
    if P3DGroup_P3DHack.Infinite_Hostage_Follow then 
        tweak_data.player.max_nr_following_hostages = 500
    end
    
    -- HEADBOB LOWERED
    if P3DGroup_P3DHack.Lowered_Headbob then
        function PlayerStandard:_get_walk_headbob()
            if self._state_data.in_steelsight then
                return 0
            elseif self._state_data.in_air then
                return 0
            elseif self._state_data.ducking then
                return 0.0125
            elseif self._running then
                return 0.02
            end
            return 0.025
        end
    end
    
    -- UNLIMITED BODYBAGS
    if P3DGroup_P3DHack.Unlimited_BodyBags then 
        function PlayerManager:on_used_body_bag() end
    end

    -- FAST MASK ON
    if P3DGroup_P3DHack.Fast_Mask then    
        tweak_data.player.put_on_mask_time = 0.5
    end
    
    -- GRENADE BUFF
    if P3DGroup_P3DHack.Grenade_Buff then
        tweak_data.projectiles.frag.damage = P3DGroup_P3DHack.Grenade_Buff_Damage_Amount
        tweak_data.projectiles.frag.player_damage = P3DGroup_P3DHack.Grenade_Buff_Player_Damage_Amount
        tweak_data.projectiles.frag.range = P3DGroup_P3DHack.Grenade_Buff_Range_Amount
    end        
    
    -- MOLOTOV BUFF
    if P3DGroup_P3DHack.Molotov_Buff then
        tweak_data.projectiles.molotov.damage = P3DGroup_P3DHack.Molotov_Buff_Damage_Amount
        tweak_data.projectiles.molotov.player_damage = P3DGroup_P3DHack.Molotov_Buff_Player_Damage_Amount
        tweak_data.projectiles.molotov.range = P3DGroup_P3DHack.Molotov_Buff_Range_Amount
        tweak_data.projectiles.molotov.burn_duration = P3DGroup_P3DHack.Molotov_Buff_Burn_Duration_Amount
    end            
    
    -- INCENDIARY GRENADE BUFF
    if P3DGroup_P3DHack.Incendiary_Grenade_Buff then
        tweak_data.projectiles.launcher_incendiary.damage = P3DGroup_P3DHack.Incendiary_Grenade_Buff_Damage_Amount
        tweak_data.projectiles.launcher_incendiary.player_damage = P3DGroup_P3DHack.Incendiary_Grenade_Buff_Player_Damage_Amount
        tweak_data.projectiles.launcher_incendiary.range = P3DGroup_P3DHack.Incendiary_Grenade_Buff_Range_Amount
        tweak_data.projectiles.launcher_incendiary.burn_duration = P3DGroup_P3DHack.Incendiary_Grenade_Buff_Burn_Duration_Amount
        tweak_data.projectiles.launcher_incendiary.init_timer = P3DGroup_P3DHack.Incendiary_Grenade_Buff_Time_Amount
    end        
    
    -- RPG BUFF
    if P3DGroup_P3DHack.RPG7_Buff then
        tweak_data.projectiles.launcher_rocket.damage = P3DGroup_P3DHack.RPG7_Buff_Damage_Amount
        tweak_data.projectiles.launcher_rocket.player_damage = P3DGroup_P3DHack.RPG7_Buff_Player_Damage_Amount
        tweak_data.projectiles.launcher_rocket.range = P3DGroup_P3DHack.RPG7_Buff_Range_Amount
        tweak_data.projectiles.launcher_rocket.init_timer = P3DGroup_P3DHack.RPG7_Buff_Time_Amount
    end        
    
    -- M79 BUFF
    if P3DGroup_P3DHack.GL40_Buff then
        tweak_data.projectiles.launcher_frag.damage = P3DGroup_P3DHack.GL40_Buff_Damage_Amount
        tweak_data.projectiles.launcher_frag.player_damage = P3DGroup_P3DHack.GL40_Buff_Player_Damage_Amount
        tweak_data.projectiles.launcher_frag.range = P3DGroup_P3DHack.GL40_Buff_Range_Amount
        tweak_data.projectiles.launcher_frag.init_timer = P3DGroup_P3DHack.GL40_Buff_Time_Amount
    end
	
	-- DYNAMITE BUFF
	if P3DGroup_P3DHack.Dynamite_Buff then 	
		tweak_data.projectiles.dynamite.damage = P3DGroup_P3DHack.Dynamite_Damage_Buff
		tweak_data.projectiles.dynamite.player_damage = P3DGroup_P3DHack.Dynamite_Self_Damage
		tweak_data.projectiles.dynamite.range = P3DGroup_P3DHack.Dynamite_Range_Buff
    end
    
    -- MR BOMBASTIC MOD
    if P3DGroup_P3DHack.Explosion_Buff then
        if not CopDamage.damage_explosion_original then CopDamage.damage_explosion_original = CopDamage.damage_explosion end
        function CopDamage:damage_explosion(attack_data)
            attack_data.damage = attack_data.damage * P3DGroup_P3DHack.Explosion_Buff_Amount
            return self:damage_explosion_original( attack_data )
        end
    end
    
    -- PUGILIST MOD v1.0
    -- ENABLE MELEE DAMAGE MULTIPLIER BY ELECTRONVOLTS
    if P3DGroup_P3DHack.Melee_Buff then
        if not CopDamage.damage_melee_original then CopDamage.damage_melee_original = CopDamage.damage_melee end
        function CopDamage:damage_melee(attack_data)
          attack_data.damage = attack_data.damage * P3DGroup_P3DHack.Melee_Buff_Amount
          return self:damage_melee_original( attack_data )
        end
    end
end