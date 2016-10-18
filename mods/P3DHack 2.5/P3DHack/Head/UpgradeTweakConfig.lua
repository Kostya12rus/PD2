-----------------------
--- UPGRADES TWEAKS ---
-----------------------
-- ADD ALL UPGRADE TWEAKS HERE --
-- EXAMPLES ARE SETUP TO GET AN IDEA OF THE PURPOSE OF THIS FILE
function upgradetweak()
	-- PLAYER UPGRADES TWEAKS 
	-- tweak_data.upgrades.ecm_jammer_base_range = 4000 -- DEFAULT 2500
	-- tweak_data.upgrades.morale_boost_speed_bonus = 1.7 -- DEFAULT 1.2
	-- tweak_data.upgrades.morale_boost_time = 20 -- DEFAULT 10
	-- tweak_data.upgrades.revive_health_multiplier = {1.7} -- DEFAULT {1.3}
	-- tweak_data.upgrades.values.player.pick_up_ammo_multiplier = {4.00, 4.75} -- DEFAULT {1.35, 1.75}
	-- tweak_data.upgrades.values.player.tape_loop_duration = {20, 40} -- DEFAULT {10, 20}
	
	-- EXPLOSIVE BULLETS/BAG TWEAKS
	-- tweak_data.upgrades.explosive_bullet.range = 300 -- DEFAULT 200
	-- tweak_data.upgrades.explosive_bullet.camera_shake_max_mul = 2
	-- tweak_data.upgrades.explosive_bullet.player_dmg_mul = 1.0 
	-- CarryData.EXPLOSION_CUSTOM_PARAMS.camera_shake_mul = 0 -- DEFAULT 4
	-- CarryData.EXPLOSION_SETTINGS.range = 1000 -- DEFAULT 100
	-- CarryData.EXPLOSION_SETTINGS.player_damage = 20 -- DEFAULT 20
	-- CarryData.EXPLOSION_SETTINGS.damage = 40 -- DEFAULT 40
	-- CarryData.EXPLOSION_SETTINGS.curve_pow = 3 -- DEFAULT 3
	
	-- SENTRY TWEAKS
	-- tweak_data.upgrades.sentry_gun_base_ammo = 350 -- DEFAULT 150
	-- tweak_data.upgrades.sentry_gun_base_armor = 15 -- DEFAULT 10
	-- tweak_data.upgrades.values.sentry_gun.rot_speed_multiplier = {5.0} -- DEFAULT {2.5}
	-- tweak_data.upgrades.values.sentry_gun.spread_multiplier = {1.0} -- DEFAULT {0.5}
	-- tweak_data.upgrades.values.sentry_gun.damage_multiplier = {30} -- DEFAULT {4}
	-- tweak_data.upgrades.values.sentry_gun.armor_piercing_chance = {0.70} -- DEFAULT {0.15}
	-- tweak_data.upgrades.values.sentry_gun.armor_piercing_chance_2 = {0.70} -- DEFAULT {0.05}
	
	-- DRILL TWEAKS
	-- tweak_data.upgrades.values.player.drill_autorepair = {0.7} -- DEFAULT {0.3}
	-- tweak_data.upgrades.values.player.drill_speed_multiplier = {0.85, 0.7} -- DEFAULT {0.85, 0.7}
	ChatMessage('P3D Hack', 'Включено')
end