function WeaponMenuConfig()
	-- BULLET FIRE	
	if P3DGroup_P3DHack.Bullet_Fire then
		Toggle.Fire_Bullet = not Toggle.Fire_Bullet
		
		InstantBulletBase.EFFECT_PARAMS = {
			sound_event = "round_explode",
			feedback_range = tweak_data.upgrades.flame_bullet.feedback_range,
			camera_shake_max_mul = tweak_data.upgrades.flame_bullet.camera_shake_max_mul,
			sound_muffle_effect = true,
			on_unit = true,
			idstr_decal = Idstring("explosion_round"),
			idstr_effect = Idstring(""),
			pushunits = tweak_data.upgrades
		}
		InstantBulletBase.old_on_collision_fire = InstantBulletBase.old_on_collision_fire or backuper:backup("InstantBulletBase.on_collision")
		InstantBulletBase.new_on_collision_fire = InstantBulletBase.new_on_collision_fire or backuper:backup("FlameBulletBase.on_collision")
		InstantBulletBase.give_fire_damage = InstantBulletBase.give_fire_damage or backuper:backup("FlameBulletBase.give_fire_damage")
		function InstantBulletBase:on_collision(col_ray, weapon_unit, user_unit, damage, blank, no_sound)		
			if user_unit == managers.player:player_unit() then
				return self:new_on_collision_fire(col_ray, weapon_unit, user_unit, damage * 8, blank, no_sound)
			end
			return self:old_on_collision_fire(col_ray, weapon_unit, user_unit, damage, blank, no_sound)
		end
	end
	
	-- BULLET EXPLODE (Courtesy Of Hejoro)
	if P3DGroup_P3DHack.Bullet_Explode then
		Toggle.bullet_explode = not Toggle.bullet_explode

		InstantBulletBase.CURVE_POW = tweak_data.upgrades.explosive_bullet.curve_pow
		InstantBulletBase.PLAYER_DMG_MUL = tweak_data.upgrades.explosive_bullet.player_dmg_mul
		InstantBulletBase.RANGE = tweak_data.upgrades.explosive_bullet.range
		InstantBulletBase.EFFECT_PARAMS = {
			effect = "effects/payday2/particles/impacts/shotgun_explosive_round",
			sound_event = "round_explode",
			feedback_range = tweak_data.upgrades.explosive_bullet.feedback_range,
			camera_shake_max_mul = tweak_data.upgrades.explosive_bullet.camera_shake_max_mul,
			sound_muffle_effect = true,
			on_unit = true,
			idstr_decal = Idstring("explosion_round"),
			idstr_effect = Idstring("")
		}
		InstantBulletBase.old_on_collision = InstantBulletBase.old_on_collision or backuper:backup('InstantBulletBase.on_collision')
		InstantBulletBase.new_on_collision = InstantBulletBase.new_on_collision or backuper:backup('InstantExplosiveBulletBase.on_collision')
		InstantBulletBase.on_collision_server = InstantBulletBase.on_collision_server or backuper:backup('InstantExplosiveBulletBase.on_collision_server')
		function InstantBulletBase:on_collision(col_ray, weapon_unit, user_unit, damage, blank, no_sound)
			if user_unit == managers.player:player_unit() then
				return self:new_on_collision(col_ray, weapon_unit, user_unit, damage * 8, blank, no_sound)
			end
			return self:old_on_collision(col_ray, weapon_unit, user_unit, damage, blank, no_sound)
		end
	end
	
	-- WEAPON RELOAD SPEED BUFF
	if P3DGroup_P3DHack.Weapon_Reload_Speed_Multiplier then
		Toggle.reload_speed_multiplier = not Toggle.reload_speed_multiplier
		
		backuper:backup('NewRaycastWeaponBase.reload_speed_multiplier')
		function NewRaycastWeaponBase:reload_speed_multiplier()
			return P3DGroup_P3DHack.Weapon_Reload_Speed_Multiplier_Amount
		end
	end
	
	-- WEAPON SWAP SPEED BUFF
	if P3DGroup_P3DHack.Weapon_Swap_Speed_Multiplier then
		Toggle._get_swap_speed_multiplier = not Toggle._get_swap_speed_multiplier
		
		backuper:backup('PlayerStandard._get_swap_speed_multiplier')
		function PlayerStandard:_get_swap_speed_multiplier()
			return P3DGroup_P3DHack.Weapon_Swap_Speed_Multiplier_Amount or 1
		end
	end	
	
	-- WEAPON FIRE RATE BUFF
	if P3DGroup_P3DHack.Weapon_Fire_Rate_Multiplier then
		Toggle.fire_rate_multiplier = not Toggle.fire_rate_multiplier
		
		backuper:backup('NewRaycastWeaponBase.fire_rate_multiplier')
		function NewRaycastWeaponBase:fire_rate_multiplier()
			return P3DGroup_P3DHack.Weapon_Fire_Rate_Multiplier_Amount
		end
	end 
	
	-- WEAPON DAMAGE BUFF
	if P3DGroup_P3DHack.Weapon_Damage_Multiplier then
		Toggle.damage_buff = not Toggle.damage_buff
				
		local damage_bullet_original = backuper:backup('CopDamage.damage_bullet')
		function CopDamage:damage_bullet(attack_data)
			attack_data.damage = attack_data.damage * P3DGroup_P3DHack.Weapon_Damage_Multiplier_Amount
			return damage_bullet_original(self, attack_data)
		end
	end
	
	-- SENTRY GUN GOD MODE
	if P3DGroup_P3DHack.Sentry_God_Mode then
		Toggle.damage_bullet = not Toggle.damage_bullet
		
		backuper:backup("SentryGunDamage.damage_bullet")
		function SentryGunDamage:damage_bullet(attack_data) end
	end
	
	-- INFINITE SENTRY AMMO, NO RECOIL
	if P3DGroup_P3DHack.Sentry_Infinite_Ammo then
		Toggle.fire = not Toggle.fire
		
		backuper:backup("SentryGunWeapon.fire")
		function SentryGunWeapon:fire(blanks, expend_ammo)
			local fire_obj = self._effect_align[self._interleaving_fire]
			local from_pos = fire_obj:position()
			local direction = fire_obj:rotation():y()
			mvector3.spread(direction, tweak_data.weapon[self._name_id].SPREAD * self._spread_mul)
			World:effect_manager():spawn(self._muzzle_effect_table[self._interleaving_fire ]) -- , normal = col_ray.normal})
			if self._use_shell_ejection_effect then
				World:effect_manager():spawn(self._shell_ejection_effect_table) 
			end
				local ray_res = self:_fire_raycast(from_pos, direction, blanks)
				if self._alert_events and ray_res.rays then
					RaycastWeaponBase._check_alert(self, ray_res.rays, from_pos, direction, self._unit)
				end
			return ray_res
		end
	end
	
	-- INFINITE AMMO TOGGLE
	if P3DGroup_P3DHack.Infinite_Ammo then
		Toggle.infinite_ammo = not Toggle.infinite_ammo
        
        local _fireWep = backuper:backup('NewRaycastWeaponBase.fire')
		function NewRaycastWeaponBase:fire(from_pos, direction, dmg_mul, shoot_player, spread_mul, autohit_mul, suppr_mul, target_unit)
            local result = _fireWep( self, from_pos, direction, dmg_mul, shoot_player, spread_mul, autohit_mul, suppr_mul, target_unit )
            if managers.player:player_unit() == self._setup.user_unit then
                self.set_ammo(self, 1.0)
            end
            return result
        end
		
		local _fireSaw = backuper:backup('SawWeaponBase.fire')
		function SawWeaponBase:fire( from_pos, direction, dmg_mul, shoot_player, spread_mul, autohit_mul, suppr_mul, target_unit )
			local result = _fireSaw( self, from_pos, direction, dmg_mul, shoot_player, spread_mul, autohit_mul, suppr_mul, target_unit )
			if managers.player:player_unit() == self._setup.user_unit then
				self.set_ammo(self, 1.0)
			end
			return result
		end
	end
end

