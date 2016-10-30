if not ChangerMenu then
	--------------
	---- GAME ----
	--------------
	-- WEAPON RELOAD SPEED BUFF
	local function freload()
		Toggle.reload_speed_multiplier = not Toggle.reload_speed_multiplier

		if not Toggle.reload_speed_multiplier then
			backuper:restore('NewRaycastWeaponBase.reload_speed_multiplier')
			ChatMessage('Выключено', 'Быстрая перезарядка')
			return
		end
		
		backuper:backup('NewRaycastWeaponBase.reload_speed_multiplier')
		function NewRaycastWeaponBase:reload_speed_multiplier()
			return P3DGroup_P3DHack.Weapon_Reload_Speed_Multiplier_Amount
		end
		ChatMessage('Включено', 'Быстрая перезарядка')
	end
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
	-- WEAPON FIRE RATE BUFF
	local function fireratebuff()
		Toggle.fire_rate_multiplier = not Toggle.fire_rate_multiplier

		if not Toggle.fire_rate_multiplier then
			backuper:restore('NewRaycastWeaponBase.fire_rate_multiplier')
			ChatMessage('Выключено', 'Скорострельность')
			return
		end
		
		backuper:backup('NewRaycastWeaponBase.fire_rate_multiplier')
		function NewRaycastWeaponBase:fire_rate_multiplier()
			return P3DGroup_P3DHack.Weapon_Fire_Rate_Multiplier_Amount
		end
		ChatMessage('Включено', 'Скорострельность')	
	end 
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
	-- WEAPON SWAP SPEED BUFF
	local function swapspeed()
		Toggle._get_swap_speed_multiplier = not Toggle._get_swap_speed_multiplier

		if not Toggle._get_swap_speed_multiplier then
			backuper:restore('PlayerStandard._get_swap_speed_multiplier')
			ChatMessage('Выключено', 'Быстрая смена оружия')
			return
		end
		
		backuper:backup('PlayerStandard._get_swap_speed_multiplier')
		function PlayerStandard:_get_swap_speed_multiplier()
			return P3DGroup_P3DHack.Weapon_Swap_Speed_Multiplier_Amount or 1
		end
		ChatMessage('Включено', 'Быстрая смена оружия')
	end	
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
	-- WEAPON DAMAGE BUFF
	local function damagebuff()
		Toggle.damage_buff = not Toggle.damage_buff
		
		if not Toggle.damage_buff then
			backuper:restore('CopDamage.damage_bullet')
			ChatMessage('Выключено', 'Увеличение урона')
			return
		end
				
		local damage_bullet_original = backuper:backup('CopDamage.damage_bullet')
		function CopDamage:damage_bullet(attack_data)
			attack_data.damage = attack_data.damage * P3DGroup_P3DHack.Weapon_Damage_Multiplier_Amount
			return damage_bullet_original(self, attack_data)
		end
		ChatMessage('Включено', 'Увеличение урона')
	end
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------		
	-- SENTRY GUN INDESTRUCTIBLE
	local function godsentry()
		Toggle.damage_bullet = not Toggle.damage_bullet

		if not Toggle.damage_bullet then
			backuper:restore("SentryGunDamage.damage_bullet")
			ChatMessage('Выключено', 'Турель - бессмертие')
			return
		end	
		
		backuper:backup("SentryGunDamage.damage_bullet")
		function SentryGunDamage:damage_bullet(attack_data) end
		ChatMessage('Включено', 'Турель - бессмертие')
	end
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------		
	-- INFINITE SENTRY AMMO, NO RECOIL
	local function infsentry()
		Toggle.fire = not Toggle.fire

		if not Toggle.fire then
			backuper:restore("SentryGunWeapon.fire")
			ChatMessage('Выключено', 'Турель - бесконечные патроны')
			return
		end	
		
		backuper:backup("SentryGunWeapon.fire")
		function SentryGunWeapon:fire(blanks, expend_ammo, shoot_player, target_unit)
			local fire_obj = self._effect_align[self._interleaving_fire]
			local from_pos = fire_obj:position()
			local direction = fire_obj:rotation():y()
			mvector3.spread(direction, tweak_data.weapon[self._name_id].SPREAD * self._spread_mul)
			World:effect_manager():spawn(self._muzzle_effect_table[self._interleaving_fire ]) -- , normal = col_ray.normal})
			if self._use_shell_ejection_effect then
				World:effect_manager():spawn(self._shell_ejection_effect_table) 
			end
			local ray_res = self:_fire_raycast(from_pos, direction, shoot_player, target_unit)
			if self._alert_events and ray_res.rays then
				RaycastWeaponBase._check_alert(self, ray_res.rays, from_pos, direction, self._unit)
			end
			return ray_res
		end
		ChatMessage('Включено', 'Турель - бесконечные патроны')	
	end
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------			
	-- BULLET EXPLODE TOGGLE
	function BulletExplode()
		Toggle.bullet_explode = not Toggle.bullet_explode
			
		-- DISABLE BULLET EXPLODE
		if not Toggle.bullet_explode then
			backuper:restore('InstantBulletBase.on_collision')
			backuper:restore('InstantExplosiveBulletBase.on_collision')
			backuper:restore('InstantExplosiveBulletBase.on_collision_server')
			ChatMessage('Выключено', 'Взрывные пули')
			return
		end

		-- BULLET EXPLODE
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
		InstantBulletBase.old_on_collision = backuper:backup('InstantBulletBase.on_collision')
		InstantBulletBase.new_on_collision = backuper:backup('InstantExplosiveBulletBase.on_collision')
		InstantBulletBase.on_collision_server = backuper:backup('InstantExplosiveBulletBase.on_collision_server')
		function InstantBulletBase:on_collision(col_ray, weapon_unit, user_unit, damage, blank, no_sound)
			if user_unit == managers.player:player_unit() then
				return self:new_on_collision(col_ray, weapon_unit, user_unit, damage * 8, blank, no_sound)
			end
			return self:old_on_collision(col_ray, weapon_unit, user_unit, damage, blank, no_sound)
		end
		ChatMessage('Включено', 'Взрывные пули')
	end	
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------			
	-- BULLET FIRE	
	local function BulletFire()	
		Toggle.Fire_Bullet = not Toggle.Fire_Bullet
		
		if not Toggle.Fire_Bullet then
			backuper:restore('InstantBulletBase.on_collision')
			backuper:restore('FlameBulletBase.on_collision')
			backuper:restore('FlameBulletBase.give_fire_damage')
			ChatMessage('Выключено', 'Зажигательные пули')
			return
		end
		
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
			
		InstantBulletBase.old_on_collision_fire = backuper:backup("InstantBulletBase.on_collision")
		InstantBulletBase.new_on_collision_fire = backuper:backup("FlameBulletBase.on_collision_P3DHack")
		InstantBulletBase.new_give_fire_damage = backuper:backup("FlameBulletBase.give_new_fire_damage")
		function InstantBulletBase:on_collision(col_ray, weapon_unit, user_unit, damage, blank, no_sound)		
			if user_unit == managers.player:player_unit() then
				return self:new_on_collision_fire(col_ray, weapon_unit, user_unit, damage * 8, blank, no_sound)
			end
			return self:old_on_collision_fire(col_ray, weapon_unit, user_unit, damage, blank, no_sound)
		end
		ChatMessage('Включено', 'Зажигательные пули')
	end
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------			
	-- INFINITE AMMO TOGGLE
	local function infammo()
		Toggle.infinite_ammo = not Toggle.infinite_ammo
			
		-- DISABLE INFINTE AMMO
		if not Toggle.infinite_ammo then
			backuper:restore('NewRaycastWeaponBase.fire')
			backuper:restore('SawWeaponBase.fire')
			ChatMessage('Выключено', 'Бесконечные боеприпасы')
			return
		end

		-- ENABLE INFINITE AMMO
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
		ChatMessage('Включено', 'Бесконечные боеприпасы')
	end
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------			
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------			
	---------------------
	--- CHANGER MENUS ---
	---------------------
	-- ARMOR CHANGER
	function ChangeArmor(info)
		if (managers.player:player_unit()) then
			if info then
				managers.blackmarket:equip_armor(info)
				managers.network:session():send_to_peers_synched("set_unit", managers.player:player_unit(), managers.network:session():local_peer():character(), managers.blackmarket:outfit_string(), managers.network:session():local_peer():outfit_version(), managers.network:session():local_peer():id())
				managers.player:player_unit():_reload_outfit()
			end 
		end
		ChatMessage(info ..' Экипировано', 'Броня')
	end
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------		
	-- EQUIPMENT CHANGER
	function giveitem(info)
		if managers.hud then
			managers.player:clear_equipment()
			managers.player._equipment.selections = {}
			managers.player:add_equipment({equipment = info})
		end
		ChatMessage(info ..' Экипировано', 'Оборудование')
    end
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------		
	-- GRENADE CHANGER
	function changegrenadecallback(grenades)
		if (managers.player:player_unit()) then			
			if grenades then
				local amount = 3
				managers.blackmarket:equip_grenade(grenades)
				managers.network:session():send_to_peers_synched("set_unit", managers.player:player_unit(), managers.network:session():local_peer():character(), managers.blackmarket:outfit_string(), managers.network:session():local_peer():outfit_version(), managers.network:session():local_peer():id())
				managers.player:player_unit():_reload_outfit()
				managers.hud:set_teammate_grenades(HUDManager.PLAYER_PANEL, {amount = amount, icon = tweak_data.blackmarket.projectiles[grenades].icon})
				managers.player:set_synced_grenades(managers.network:session():local_peer():id(), grenades, amount)
			end
		end
		ChatMessage('Слот '.. grenades ..' Экипировано', 'Маска')
	end
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------		
	-- MASK CHANGER
	function changemaskcallback(info)
		if (managers.player:player_unit()) then			
			if info then
				managers.blackmarket:equip_mask(info)
				managers.network:session():send_to_peers_synched("set_unit", managers.player:player_unit(), managers.network:session():local_peer():character(), managers.blackmarket:outfit_string(), managers.network:session():local_peer():outfit_version(), managers.network:session():local_peer():id())
				managers.player:player_unit():_reload_outfit()
			end
		end
		ChatMessage('Слот '.. info ..' Экипировано', 'Маска')
	end
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------		
	-- MELEE WEAPON CHANGER
	function ChangeMelee(info)
		if (managers.player:player_unit()) then
			if info then
				managers.blackmarket:equip_melee_weapon(info)
				managers.network:session():send_to_peers_synched("set_unit", managers.player:player_unit(), managers.network:session():local_peer():character(), managers.blackmarket:outfit_string(), managers.network:session():local_peer():outfit_version(), managers.network:session():local_peer():id())
				managers.player:player_unit():_reload_outfit()
				managers.player:player_unit():inventory():set_melee_weapon(managers.blackmarket:equipped_melee_weapon())
			end
		end
		ChatMessage('Экипировано', 'Оружие ближнего боя')
	end
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------		
	-- PRIMARY WEAPON CHANGER
    local function spawnprimarycallback(info)
		function NewRaycastWeaponBase:set_timer(timer, ...)
			if (alive(self._unit)) then 
				NewRaycastWeaponBase.super.set_timer(self, timer)
				for _,data in ipairs(self._parts) do
					local unit = data.unit
					if (alive(unit)) then
						unit:set_timer(timer)
						unit:set_animation_timer(timer)
					end 
				end 
			end 
		end 
		if (managers.player:player_unit()) then
            local weapon = Global.blackmarket_manager.crafted_items.primaries[info]
            if weapon then
                managers.blackmarket:equip_weapon("primaries", info)
				local primary = weapon
				local primary_slot = managers.blackmarket:equipped_weapon_slot("primaries")
				local texture_switches = managers.blackmarket:get_weapon_texture_switches("primaries", primary_slot, primary)               
			    managers.network:session():send_to_peers_synched("set_unit", managers.player:player_unit(), managers.network:session():local_peer():character(), managers.blackmarket:outfit_string(), managers.network:session():local_peer():outfit_version(), managers.network:session():local_peer():id())
                managers.dyn_resource:load(Idstring("unit"), Idstring(tweak_data.weapon.factory[weapon.factory_id].unit), "packages/dyn_resources", false)
                managers.player:player_unit():inventory():add_unit_by_factory_name(weapon.factory_id, false, false, weapon.blueprint, weapon.cosmetics, weapon.texture_switches )
			end 
		end 
		ChatMessage('Slot '.. info ..' Экипировано', 'Основное оружие')
	end
 	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	       
    -- SECONDARY WEAPON CHANGER
    local function spawnsecondarycallback(info)
		function NewRaycastWeaponBase:set_timer(timer, ...)
			if (alive(self._unit)) then 
				NewRaycastWeaponBase.super.set_timer(self, timer)
				for _,data in ipairs(self._parts) do
					local unit = data.unit
					if (alive(unit)) then
						unit:set_timer(timer)
						unit:set_animation_timer(timer)
					end 
				end 
			end 
		end 
		if (managers.player:player_unit()) then
            local weapon = Global.blackmarket_manager.crafted_items.secondaries[info]
            if weapon then
                managers.blackmarket:equip_weapon("secondaries", info)
                local secondary = weapon
				local secondary_slot = managers.blackmarket:equipped_weapon_slot("secondaries")
				local texture_switches = managers.blackmarket:get_weapon_texture_switches("secondaries", secondary_slot, secondary)
				managers.network:session():send_to_peers_synched("set_unit", managers.player:player_unit(), managers.network:session():local_peer():character(), managers.blackmarket:outfit_string(), managers.network:session():local_peer():outfit_version(), managers.network:session():local_peer():id())
                managers.dyn_resource:load(Idstring("unit"), Idstring(tweak_data.weapon.factory[weapon.factory_id].unit), "packages/dyn_resources", false)
                managers.player:player_unit():inventory():add_unit_by_factory_name( weapon.factory_id, false, false, weapon.blueprint, weapon.cosmetics, weapon.texture_switches )
			end 
		end 
		ChatMessage('Slot '.. info ..' Экипировано', 'Второстепенное оружие')
	end
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------		
	-- CUSTOM LASER COLOR CHANGER
	function lasercolor(lcolor)
		for _,weapon in pairs(managers.player:player_unit():inventory():available_selections()) do
			if weapon.unit.base and weapon.unit:base()._parts then
				for k,v in pairs(weapon.unit:base()._parts) do
					if k:find("laser") or k:find("peqbox") or k:find("peq15") 
					or k:find("crimson") or k:find("x400v") and not k:find("peq15_flashlight") then
						v.unit:base():set_color((lcolor):with_alpha(0.43))		
					end	
				end	
			end	
		end	
	end
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------		
	--CUSTOM FLASHLIGHT COLOR
	function flashcolor(fcolor)
		for _,weapon in pairs(managers.player:player_unit():inventory():available_selections()) do
			if weapon.unit.base and weapon.unit:base()._parts then
				for k,v in pairs(weapon.unit:base()._parts) do
					if k:find("surefire") or k:find("tlr1") or k:find("peq15_flashlight")
					or k:find("x400v") then
						v.unit:base()._light:set_color((fcolor):with_alpha(0.45))					
					end	
				end	
			end	
		end	
	end
-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------
	ChangerMenu = CustomMenuClass:new()
	ChangerMenu:addMainMenu('main_menu', {title = 'Модификация оружия'})
	ChangerMenu:addMenu('laser_menu', {title = 'Изменить цвет лазера', maxColumns = 4, maxRows = 11})
	ChangerMenu:addMenu('flash_menu', {title = 'Изменить цвет фонарика ', maxColumns = 4, maxRows = 11})
	ChangerMenu:addMenu('armor_menu', {title = 'Изменить броню'})
	ChangerMenu:addMenu('equipment_menu', {title = 'Изменить оборудование'})
	ChangerMenu:addMenu('grenade_menu', {title = 'Изменить гранаты'})
	ChangerMenu:addMenu('mask_menu', {title = 'Изменить маску'})
	ChangerMenu:addMenu('melee_menu', {title = 'Изменить оружие ближнего боя'})
	ChangerMenu:addMenu('primary_wep_menu', {title = 'Изменить основное оружие'})
	ChangerMenu:addMenu('secondary_wep_menu', {title = 'Изменить второстепенное оружие'})
	ChangerMenu:addMenu('weapon_settings', {title = 'Модификация оружия'})
	
	-- Weapon Settings
	ChangerMenu:addInformationOption('main_menu', 'Модификация оружия', {textColor = Color.red})
	ChangerMenu:addMenuOption('main_menu', 'Настройка оружия', 'weapon_settings', {rectHighlightColor = Color(255, 138, 17, 9) / 255})
	ChangerMenu:addInformationOption('weapon_settings', 'Турель', {textColor = Color.DodgerBlue})
	if isHost() then
		if P3DGroup_P3DHack.Weapon_Menu_Config and P3DGroup_P3DHack.Sentry_Infinite_Ammo then
			ChangerMenu:addToggleOption('weapon_settings', 'Турель - бесконечные патроны', {callback = infsentry, toggle = true})
		else
			ChangerMenu:addToggleOption('weapon_settings', 'Турель - бесконечные патроны', {callback = infsentry})
		end
		if P3DGroup_P3DHack.Weapon_Menu_Config and P3DGroup_P3DHack.Sentry_God_Mode then
			ChangerMenu:addToggleOption('weapon_settings', 'Турель - бессмертие', {callback = godsentry, toggle = true})
		else
			ChangerMenu:addToggleOption('weapon_settings', 'Турель - бессмертие', {callback = godsentry})
		end
	else
		ChangerMenu:addInformationOption('weapon_settings', 'Недоступно (Только Хост)', {textColor = Color.yellow})
		ChangerMenu:addInformationOption('weapon_settings', 'Недоступно (Только Хост)', {textColor = Color.yellow})
	end
	ChangerMenu:addGap('weapon_settings')
	ChangerMenu:addInformationOption('weapon_settings', ' Настройка оружия', {textColor = Color.DodgerBlue})
	if P3DGroup_P3DHack.Weapon_Menu_Config and P3DGroup_P3DHack.Bullet_Explode then
		ChangerMenu:addToggleOption('weapon_settings', 'Взрывные пули', {callback = BulletExplode, toggle = true, help = "Теперь все пули взрывные"})
	else
		ChangerMenu:addToggleOption('weapon_settings', 'Взрывные пули', {callback = BulletExplode, help = "Теперь все пули взрывные"})
	end	
	if P3DGroup_P3DHack.Weapon_Menu_Config and P3DGroup_P3DHack.Bullet_Fire then
		ChangerMenu:addToggleOption('weapon_settings', 'Зажигательные пули', {callback = BulletFire, toggle = true, help = " Теперь все пули зажигательные"})
	else
		ChangerMenu:addToggleOption('weapon_settings', 'Зажигательные пули', {callback = BulletFire, help = "Теперь все пули зажигательные"})
	end		
	if P3DGroup_P3DHack.Weapon_Menu_Config and P3DGroup_P3DHack.Weapon_Damage_Multiplier then
		ChangerMenu:addToggleOption('weapon_settings', 'Улучшение урона', {callback = damagebuff, toggle = true})
	else
		ChangerMenu:addToggleOption('weapon_settings', 'Улучшение урона', {callback = damagebuff})
	end	
	if P3DGroup_P3DHack.Weapon_Menu_Config and P3DGroup_P3DHack.Weapon_Fire_Rate_Multiplier then
		ChangerMenu:addToggleOption('weapon_settings', 'Скорострельность', {callback = fireratebuff, toggle = true})
	else
		ChangerMenu:addToggleOption('weapon_settings', 'Скорострельность', {callback = fireratebuff})
	end
	if P3DGroup_P3DHack.Weapon_Menu_Config and P3DGroup_P3DHack.Infinite_Ammo then	
		ChangerMenu:addToggleOption('weapon_settings', 'Бесконечные боеприпасы', {callback = infammo, toggle = true})
	else
		ChangerMenu:addToggleOption('weapon_settings', 'Бесконечные боеприпасы', {callback = infammo})
	end
	for i=1,5 do
		ChangerMenu:addGap('weapon_settings')
    end
	if P3DGroup_P3DHack.Weapon_Menu_Config and P3DGroup_P3DHack.Weapon_Reload_Speed_Multiplier then
		ChangerMenu:addToggleOption('weapon_settings', 'Быстрая перезарядка', {callback = freload, toggle = true})
	else
		ChangerMenu:addToggleOption('weapon_settings', 'Быстрая перезарядка', {callback = freload})
	end
	if P3DGroup_P3DHack.Weapon_Menu_Config and P3DGroup_P3DHack.Weapon_Swap_Speed_Multiplier then
		ChangerMenu:addToggleOption('weapon_settings', 'Быстрая смена оружия', {callback = swapspeed, toggle = true})
	else	
		ChangerMenu:addToggleOption('weapon_settings', 'Быстрая смена оружия', {callback = swapspeed})
	end
	
	-- Armor Menu
	ChangerMenu:addGap('main_menu')
	ChangerMenu:addInformationOption('main_menu', 'Изменить', {textColor = Color.red})
	ChangerMenu:addMenuOption('main_menu', 'Броню', 'armor_menu', {rectHighlightColor = Color(255, 138, 17, 9) / 255})
	for i,armor in pairs(Global.blackmarket_manager.armors) do
		if (armor) then
			ChangerMenu:addOption('armor_menu', managers.localization:text(tweak_data.blackmarket.armors[i].name_id):gsub("\"", ""), {callback = ChangeArmor, callbackData = i, closeMenu = true})
		end
	end
	
	-- Mask menu
	ChangerMenu:addMenuOption('main_menu', 'Маску', 'mask_menu', {rectHighlightColor = Color(255, 138, 17, 9) / 255})
	for i,maskspwn in pairs(Global.blackmarket_manager.crafted_items.masks) do
		if (maskspwn) then
			ChangerMenu:addOption('mask_menu', managers.blackmarket:get_mask_name_by_category_slot("masks", i):gsub("\"", ""), {callback = changemaskcallback, callbackData  = i, closeMenu = true})
		end	
	end
	
	-- Primary Weapon Menu
	ChangerMenu:addGap('main_menu')
	ChangerMenu:addMenuOption('main_menu', 'Основное оружие', 'primary_wep_menu', {rectHighlightColor = Color(255, 138, 17, 9) / 255})
	for i,weapon in pairs(Global.blackmarket_manager.crafted_items.primaries) do
        if (weapon) then
			ChangerMenu:addOption('primary_wep_menu', managers.blackmarket:get_weapon_name_by_category_slot("primaries",i):gsub("\"", ""), {callback = spawnprimarycallback, callbackData = i, help = 'Используйте второстепенное оружие, иначе вылет'})
		end 
	end
    
    -- Secondary Weapon Menu
    ChangerMenu:addMenuOption('main_menu', 'Второстепенное оружие', 'secondary_wep_menu', {rectHighlightColor = Color(255, 138, 17, 9) / 255})
    for i,weapon in pairs(Global.blackmarket_manager.crafted_items.secondaries) do
        if (weapon) then
            ChangerMenu:addOption( 'secondary_wep_menu', managers.blackmarket:get_weapon_name_by_category_slot("secondaries",i):gsub("\"", ""), {callback = spawnsecondarycallback, callbackData = i, help = 'Используйте основное оружие, иначе вылет'})
		end 
	end
	
	-- FlashLight Menu
	ChangerMenu:addGap('main_menu')
	ChangerMenu:addGap('main_menu')
	ChangerMenu:addGap('main_menu')
	ChangerMenu:addGap('main_menu')
	ChangerMenu:addGap('main_menu')
	ChangerMenu:addMenuOption('main_menu', 'Цвет фонарика', 'flash_menu', {rectHighlightColor = Color(255, 138, 17, 9) / 255})
	ChangerMenu:addOption('flash_menu', 'Alice Blue', {callback = flashcolor, callbackData = Color.AliceBlue, rectHighlightColor = Color.AliceBlue, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Antique White', {callback = flashcolor, callbackData = Color.AntiqueWhite, rectHighlightColor  = Color.AntiqueWhite, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Aqua', {callback = flashcolor, callbackData = Color.Aqua, rectHighlightColor = Color.Aqua, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Aqua Marine', {callback = flashcolor, callbackData = Color.Aquamarine, rectHighlightColor = Color.Aquamarine, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Azure', {callback = flashcolor, callbackData = Color.Azure, rectHighlightColor = Color.Azure, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Beige', {callback = flashcolor, callbackData = Color.Beige, rectHighlightColor = Color.Beige, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Bisque', {callback = flashcolor, callbackData = Color.Bisque, rectHighlightColor = Color.Bisque, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Blanched Almond', { callback = flashcolor, callbackData = Color.BlanchedAlmond, rectHighlightColor = Color.BlanchedAlmond, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Blue', { callback = flashcolor, callbackData = Color.blue, rectHighlightColor = Color.blue, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Blue Violet', { callback = flashcolor, callbackData = Color.BlueViolet, rectHighlightColor = Color.BlueViolet, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Brown', { callback = flashcolor, callbackData = Color.Brown, rectHighlightColor = Color.Brown, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Burly Wood', { callback = flashcolor, callbackData = Color.BurlyWood, rectHighlightColor = Color.BurlyWood, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Cadet Blue', { callback = flashcolor, callbackData = Color.CadetBlue, rectHighlightColor = Color.CadetBlue, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Chartreuse', { callback = flashcolor, callbackData = Color.Chartreuse, rectHighlightColor = Color.Chartreuse, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Chocolate', { callback = flashcolor, callbackData = Color.Chocolate, rectHighlightColor = Color.Chocolate, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Coral', { callback = flashcolor, callbackData = Color.Coral, rectHighlightColor = Color.Coral, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Cornflower Blue', { callback = flashcolor, callbackData = Color.CornflowerBlue, rectHighlightColor = Color.CornflowerBlue, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Crimson', { callback = flashcolor, callbackData = Color.Crimson, rectHighlightColor = Color.Crimson, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Cyan', { callback = flashcolor, callbackData = Color.Cyan, rectHighlightColor = Color.Cyan, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Dark Blue', { callback = flashcolor, callbackData = Color.DarkBlue, rectHighlightColor = Color.DarkBlue, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Dark Cyan', { callback = flashcolor, callbackData = Color.DarkCyan, rectHighlightColor = Color.DarkCyan, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Dark Golden Rod', { callback = flashcolor, callbackData = Color.DarkGoldenRod, rectHighlightColor = Color.DarkGoldenRod, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Dark Gray', { callback = flashcolor, callbackData = Color.DarkGray, rectHighlightColor = Color.DarkGray, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Dark Green', { callback = flashcolor, callbackData = Color.DarkGreen, rectHighlightColor = Color.DarkGreen, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Dark Khaki', { callback = flashcolor, callbackData = Color.DarkKhaki, rectHighlightColor = Color.DarkKhaki, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Dark Magenta', { callback = flashcolor, callbackData = Color.DarkMagenta, rectHighlightColor = Color.DarkMagenta, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Dark Olive Green', { callback = flashcolor, callbackData = Color.DarkOliveGreen, rectHighlightColor = Color.DarkOliveGreen, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Dark Orange', { callback = flashcolor, callbackData = Color.DarkOrange, rectHighlightColor = Color.DarkOrange, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Dark Orchid', { callback = flashcolor, callbackData = Color.DarkOrchid, rectHighlightColor = Color.DarkOrchid, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Dark Red', { callback = flashcolor, callbackData = Color.DarkRed, rectHighlightColor = Color.DarkRed, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Dark Salmon', { callback = flashcolor, callbackData = Color.DarkSalmon, rectHighlightColor = Color.DarkSalmon, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Dark Sea Green', { callback = flashcolor, callbackData = Color.DarkSeaGreen, rectHighlightColor = Color.DarkSeaGreen, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Dark Slate Blue', { callback = flashcolor, callbackData = Color.DarkSlateBlue, rectHighlightColor = Color.DarkSlateBlue, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Dark Slate Gray', { callback = flashcolor, callbackData = Color.DarkSlateGray, rectHighlightColor = Color.DarkSlateGray, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Dark Torquise', { callback = flashcolor, callbackData = Color.DarkTurquoise, rectHighlightColor = Color.DarkTurquoise, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Dark Violet', { callback = flashcolor, callbackData = Color.DarkViolet, rectHighlightColor = Color.DarkViolet, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Deep Pink', { callback = flashcolor, callbackData = Color.DeepPink, rectHighlightColor = Color.DeepPink, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Deep Sky Blue', { callback = flashcolor, Color.DeepSkyBlue, rectHighlightColor = Color.DeepSkyBlue, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Default', { callback = flashcolor, callbackData = Color.white, rectHighlightColor = Color.white, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Dim Gray', { callback = flashcolor, callbackData = Color.DimGray, rectHighlightColor = Color.DimGray, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Dodger Blue', { callback = flashcolor, callbackData = Color.DodgerBlue, rectHighlightColor = Color.DodgerBlue, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Fire Brick', { callback = flashcolor, callbackData = Color.FireBrick, rectHighlightColor = Color.FireBrick, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Forest Green', { callback = flashcolor, callbackData = Color.ForestGreen, rectHighlightColor = Color.ForestGreen, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Fuchsia', { callback = flashcolor, callbackData = Color.Fuchsia, rectHighlightColor = Color.Fuchsia, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Gainsboro', { callback = flashcolor, callbackData = Color.Gainsboro, rectHighlightColor = Color.Gainsboro, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Gold', { callback = flashcolor, callbackData = Color.Gold, rectHighlightColor = Color.Gold, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Golden Rod', { callback = flashcolor, callbackData = Color.GoldenRod, rectHighlightColor = Color.GoldenRod, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Gray', { callback = flashcolor, callbackData = Color.Gray, rectHighlightColor = Color.Gray, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Green Yellow', { callback = flashcolor, callbackData = Color.GreenYellow, rectHighlightColor = Color.GreenYellow, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Honey Dew', { callback = flashcolor, callbackData = Color.HoneyDew, rectHighlightColor = Color.HoneyDew, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Hot Pink', { callback = flashcolor, callbackData = Color.HotPink, rectHighlightColor = Color.HotPink, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Indian Red', { callback = flashcolor, callbackData = Color.IndianRed, rectHighlightColor = Color.IndianRed, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Indigo', { callback = flashcolor, callbackData = Color.Indigo, rectHighlightColor = Color.Indigo, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Khaki', { callback = flashcolor, callbackData = Color.Khaki, rectHighlightColor = Color.Khaki, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Lavender', { callback = flashcolor, callbackData = Color.Lavender, rectHighlightColor = Color.Lavender, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Lavender Blush', { callback = flashcolor, callbackData = Color.LavenderBlush, rectHighlightColor  = Color.LavenderBlush, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Lawn Green', { callback = flashcolor, callbackData = Color.LawnGreen, rectHighlightColor = Color.LawnGreen, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Lemon Chiffon', { callback = flashcolor, callbackData = Color.LemonChiffon, rectHighlightColor = Color.LemonChiffon, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Light Blue', { callback = flashcolor, callbackData = Color.LightBlue, rectHighlightColor = Color.LightBlue, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Light Coral', { callback = flashcolor, callbackData = Color.LightCoral, rectHighlightColor = Color.LightCoral, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Light Cyan', { callback = flashcolor, callbackData = Color.LightCyan, rectHighlightColor = Color.LightCyan, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Light Golden Rod Yellow', { callback = flashcolor, callbackData = Color.LightGoldenRodYellow, rectHighlightColor  = Color.LightGoldenRodYellow, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Light Gray', { callback = flashcolor, callbackData = Color.LightGray, rectHighlightColor = Color.LightGray, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Light Green', { callback = flashcolor, callbackData = Color.LightGreen, rectHighlightColor = Color.LightGreen, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Light Pink', { callback = flashcolor, callbackData = Color.LightPink, rectHighlightColor = Color.LightPink, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Light Salmon', { callback = flashcolor, callbackData = Color.LightSalmon, rectHighlightColor = Color.LightSalmon, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Light Sea Green', { callback = flashcolor, callbackData = Color.LightSeaGreen, rectHighlightColor = Color.LightSeaGreen, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Light Sky Blue', { callback = flashcolor, callbackData = Color.LightSkyBlue, rectHighlightColor = Color.LightSkyBlue, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Light Slate Gray', { callback = flashcolor, callbackData = Color.LightSlateGray, rectHighlightColor = Color.LightSlateGray, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Light Steel Blue', { callback = flashcolor, callbackData = Color.LightSteelBlue, rectHighlightColor = Color.LightSteelBlue, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Light Yellow', { callback = flashcolor, callbackData = Color.LightYellow, rectHighlightColor = Color.LightYellow, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Lime', { callback = flashcolor, callbackData = Color.Lime, rectHighlightColor = Color.Lime, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Lime Green', { callback = flashcolor, callbackData = Color.LimeGreen, rectHighlightColor = Color.LimeGreen, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Linen', { callback = flashcolor, callbackData = Color.Linen, rectHighlightColor = Color.Linen, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Magenta', { callback = flashcolor, callbackData = Color.Magenta, rectHighlightColor = Color.Magenta, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Maroon', { callback = flashcolor, callbackData = Color.Maroon, rectHighlightColor = Color.Maroon, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Medium Aqua Marine', { callback = flashcolor, callbackData = Color.MediumAquaMarine, rectHighlightColor = Color.MediumAquaMarine, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Medium Blue', { callback = flashcolor, callbackData = Color.MediumBlue, rectHighlightColor = Color.MediumBlue, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Medium Orchid', { callback = flashcolor, callbackData = Color.MediumOrchid, rectHighlightColor = Color.MediumOrchid, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Medium Purple', { callback = flashcolor, callbackData = Color.MediumPurple, rectHighlightColor = Color.MediumPurple, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Medium Sea Grean', { callback = flashcolor, callbackData = Color.MediumSeaGreen, rectHighlightColor = Color.MediumSeaGreen, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Medium Slate Blue', { callback = flashcolor, callbackData = Color.MediumSlateBlue, rectHighlightColor = Color.MediumSlateBlue, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Medium Spring Green', { callback = flashcolor, callbackData = Color.MediumSpringGreen, rectHighlightColor = Color.MediumSpringGreen, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Medium Torquise', { callback = flashcolor, callbackData = Color.MediumTurquoise, rectHighlightColor = Color.MediumTurquoise, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Medium Violet Red', { callback = flashcolor, callbackData = Color.MediumVioletRed, rectHighlightColor = Color.MediumVioletRed, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Midnight Blue', { callback = flashcolor, callbackData = Color.MidnightBlue, rectHighlightColor = Color.MidnightBlue, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Mint Cream', { callback = flashcolor, callbackData = Color.MintCream, rectHighlightColor = Color.MintCream, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Misty Rose', { callback = flashcolor, callbackData = Color.MistyRose, rectHighlightColor = Color.MistyRose, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Moccasin', { callback = flashcolor, callbackData = Color.Moccasin, rectHighlightColor = Color.Moccasin, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Navy', { callback = flashcolor, callbackData = Color.Navy, rectHighlightColor = Color.Navy, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Old Lace', { callback = flashcolor, callbackData = Color.OldLace, rectHighlightColor = Color.OldLace, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Olive', { callback = flashcolor, callbackData = Color.Olive, rectHighlightColor = Color.Olive, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Olive Drab', { callback = flashcolor, callbackData = Color.OliveDrab, rectHighlightColor = Color.OliveDrab, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Orange', { callback = flashcolor, callbackData = Color.Orange, rectHighlightColor = Color.Orange, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Orange Red', { callback = flashcolor, callbackData = Color.OrangeRed, rectHighlightColor = Color.OrangeRed, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Orchid', { callback = flashcolor, callbackData = Color.Orchid, rectHighlightColor = Color.Orchid, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Pale Golden Rod', { callback = flashcolor, callbackData = Color.PaleGoldenRod, rectHighlightColor = Color.PaleGoldenRod, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Pale Green', { callback = flashcolor, callbackData = Color.PaleGreen, rectHighlightColor = Color.PaleGreen, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Pale Torquise', { callback = flashcolor, callbackData = Color.PaleTurquoise, rectHighlightColor = Color.PaleTurquoise, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Pale Violet Red', { callback = flashcolor, callbackData = Color.PaleVioletRed, rectHighlightColor = Color.PaleVioletRed, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Papaya Whip', { callback = flashcolor, callbackData = Color.PapayaWhip, rectHighlightColor = Color.PapayaWhip, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Peach Puff', { callback = flashcolor, callbackData = Color.PeachPuff, rectHighlightColor = Color.PeachPuff, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Peru', { callback = flashcolor, callbackData = Color.Peru, rectHighlightColor = Color.Peru, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Pink', { callback = flashcolor, callbackData = Color.Pink, rectHighlightColor = Color.Pink, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Plum', { callback = flashcolor, callbackData = Color.Plum, rectHighlightColor = Color.Plum, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Powder Blue', { callback = flashcolor, callbackData = Color.PowderBlue, rectHighlightColor = Color.PowderBlue, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Red', { callback = flashcolor, callbackData = Color.red, rectHighlightColor = Color(255, 138, 17, 9) / 255, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Rosy Brown', { callback = flashcolor, callbackData = Color.RosyBrown, rectHighlightColor = Color.RosyBrown, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Royal Blue', { callback = flashcolor, callbackData = Color.RoyalBlue, rectHighlightColor = Color.RoyalBlue, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Saddle Brown', { callback = flashcolor, callbackData = Color.SaddleBrown, rectHighlightColor = Color.SaddleBrown, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Salmon', { callback = flashcolor, callbackData = Color.Salmon, rectHighlightColor = Color.Salmon, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Sandy Brown', { callback = flashcolor, callbackData = Color.SandyBrown, rectHighlightColor = Color.SandyBrown, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Sea Green', { callback = flashcolor, callbackData = Color.SeaGreen, rectHighlightColor = Color.SeaGreen, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Sea Shell', { callback = flashcolor, callbackData = Color.SeaShell, rectHighlightColor = Color.SeaShell, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Sienna', { callback = flashcolor, callbackData = Color.Sienna, rectHighlightColor = Color.Sienna, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Silver', { callback = flashcolor, callbackData = Color.Silver, rectHighlightColor = Color.Silver, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Sky Blue', { callback = flashcolor, callbackData = Color.SkyBlue, rectHighlightColor = Color.SkyBlue, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Slate Blue', { callback = flashcolor, callbackData = Color.SlateBlue, rectHighlightColor = Color.SlateBlue, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Slate Gray', { callback = flashcolor, callbackData = Color.SlateGray, rectHighlightColor = Color.SlateGray, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Spring Green', { callback = flashcolor, callbackData = Color.SpringGreen, rectHighlightColor = Color.SpringGreen, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Steel Blue', { callback = flashcolor, callbackData = Color.SteelBlue, rectHighlightColor = Color.SteelBlue, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Tan', { callback = flashcolor, callbackData = Color.Tan, rectHighlightColor = Color.Tan, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Teal', { callback = flashcolor, callbackData = Color.Teal, rectHighlightColor = Color.Teal, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Thistle', { callback = flashcolor, callbackData = Color.Thistle, rectHighlightColor = Color.Thistle, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Tomato', { callback = flashcolor, callbackData = Color.Tomato, rectHighlightColor = Color.Tomato, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Torquise', { callback = flashcolor, callbackData = Color.Turquoise, rectHighlightColor = Color.Turquoise, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Violet', { callback = flashcolor, callbackData = Color.Violet, rectHighlightColor = Color.Violet, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Wheat', { callback = flashcolor, callbackData = Color.Wheat, rectHighlightColor = Color.Wheat, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Yellow Green', { callback = flashcolor, callbackData = Color.YellowGreen, rectHighlightColor = Color.YellowGreen, closeMenu = true})
	ChangerMenu:addOption('flash_menu', 'Yellow', { callback = flashcolor, callbackData =  Color.yellow, rectHighlightColor = Color.yellow, closeMenu = true})
	
	-- Laser Menu
	ChangerMenu:addMenuOption('main_menu', 'Цвет лазера', 'laser_menu', {rectHighlightColor = Color(255, 138, 17, 9) / 255})
	ChangerMenu:addOption('laser_menu', 'Alice Blue', { callback = lasercolor, callbackData = Color.AliceBlue, rectHighlightColor = Color.AliceBlue, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Antique White', { callback = lasercolor, callbackData = Color.AntiqueWhite, rectHighlightColor  = Color.AntiqueWhite, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Aqua', { callback = lasercolor, callbackData = Color.Aqua, rectHighlightColor = Color.Aqua, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Aqua Marine', { callback = lasercolor, callbackData = Color.Aquamarine, rectHighlightColor = Color.Aquamarine, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Azure', { callback = lasercolor, callbackData = Color.Azure, rectHighlightColor = Color.Azure, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Beige', { callback = lasercolor, callbackData = Color.Beige, rectHighlightColor = Color.Beige, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Bisque', { callback = lasercolor, callbackData = Color.Bisque, rectHighlightColor = Color.Bisque, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Blanched Almond', { callback = lasercolor, callbackData = Color.BlanchedAlmond, rectHighlightColor = Color.BlanchedAlmond, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Blue', { callback = lasercolor, callbackData = Color.blue, rectHighlightColor = Color.blue, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Blue Violet', { callback = lasercolor, callbackData = Color.BlueViolet, rectHighlightColor = Color.BlueViolet, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Brown', { callback = lasercolor, callbackData = Color.Brown, rectHighlightColor = Color.Brown, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Burly Wood', { callback = lasercolor, callbackData = Color.BurlyWood, rectHighlightColor = Color.BurlyWood, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Cadet Blue', { callback = lasercolor, callbackData = Color.CadetBlue, rectHighlightColor = Color.CadetBlue, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Chartreuse', { callback = lasercolor, callbackData = Color.Chartreuse, rectHighlightColor = Color.Chartreuse, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Chocolate', { callback = lasercolor, callbackData = Color.Chocolate, rectHighlightColor = Color.Chocolate, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Coral', { callback = lasercolor, callbackData = Color.Coral, rectHighlightColor = Color.Coral, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Cornflower Blue', { callback = lasercolor, callbackData = Color.CornflowerBlue, rectHighlightColor = Color.CornflowerBlue, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Crimson', { callback = lasercolor, callbackData = Color.Crimson, rectHighlightColor = Color.Crimson, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Cyan', { callback = lasercolor, callbackData = Color.Cyan, rectHighlightColor = Color.Cyan, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Dark Blue', { callback = lasercolor, callbackData = Color.DarkBlue, rectHighlightColor = Color.DarkBlue, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Dark Cyan', { callback = lasercolor, callbackData = Color.DarkCyan, rectHighlightColor = Color.DarkCyan, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Dark Golden Rod', { callback = lasercolor, callbackData = Color.DarkGoldenRod, rectHighlightColor = Color.DarkGoldenRod, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Dark Gray', { callback = lasercolor, callbackData = Color.DarkGray, rectHighlightColor = Color.DarkGray, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Dark Green', { callback = lasercolor, callbackData = Color.DarkGreen, rectHighlightColor = Color.DarkGreen, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Dark Khaki', { callback = lasercolor, callbackData = Color.DarkKhaki, rectHighlightColor = Color.DarkKhaki, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Dark Magenta', { callback = lasercolor, callbackData = Color.DarkMagenta, rectHighlightColor = Color.DarkMagenta, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Dark Olive Green', { callback = lasercolor, callbackData = Color.DarkOliveGreen, rectHighlightColor = Color.DarkOliveGreen, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Dark Orange', { callback = lasercolor, callbackData = Color.DarkOrange, rectHighlightColor = Color.DarkOrange, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Dark Orchid', { callback = lasercolor, callbackData = Color.DarkOrchid, rectHighlightColor = Color.DarkOrchid, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Dark Red', { callback = lasercolor, callbackData = Color.DarkRed, rectHighlightColor = Color.DarkRed, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Dark Salmon', { callback = lasercolor, callbackData = Color.DarkSalmon, rectHighlightColor = Color.DarkSalmon, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Dark Sea Green', { callback = lasercolor, callbackData = Color.DarkSeaGreen, rectHighlightColor = Color.DarkSeaGreen, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Dark Slate Blue', { callback = lasercolor, callbackData = Color.DarkSlateBlue, rectHighlightColor = Color.DarkSlateBlue, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Dark Slate Gray', { callback = lasercolor, callbackData = Color.DarkSlateGray, rectHighlightColor = Color.DarkSlateGray, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Dark Torquise', { callback = lasercolor, callbackData = Color.DarkTurquoise, rectHighlightColor = Color.DarkTurquoise, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Dark Violet', { callback = lasercolor, callbackData = Color.DarkViolet, rectHighlightColor = Color.DarkViolet, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Deep Pink', { callback = lasercolor, callbackData = Color.DeepPink, rectHighlightColor = Color.DeepPink, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Deep Sky Blue', { callback = lasercolor, Color.DeepSkyBlue, rectHighlightColor = Color.DeepSkyBlue, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Default', { callback = lasercolor, callbackData = Color.green, rectHighlightColor = Color.green, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Dim Gray', { callback = lasercolor, callbackData = Color.DimGray, rectHighlightColor = Color.DimGray, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Dodger Blue', { callback = lasercolor, callbackData = Color.DodgerBlue, rectHighlightColor = Color.DodgerBlue, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Fire Brick', { callback = lasercolor, callbackData = Color.FireBrick, rectHighlightColor = Color.FireBrick, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Forest Green', { callback = lasercolor, callbackData = Color.ForestGreen, rectHighlightColor = Color.ForestGreen, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Fuchsia', { callback = lasercolor, callbackData = Color.Fuchsia, rectHighlightColor = Color.Fuchsia, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Gainsboro', { callback = lasercolor, callbackData = Color.Gainsboro, rectHighlightColor = Color.Gainsboro, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Gold', { callback = lasercolor, callbackData = Color.Gold, rectHighlightColor = Color.Gold, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Golden Rod', { callback = lasercolor, callbackData = Color.GoldenRod, rectHighlightColor = Color.GoldenRod, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Gray', { callback = lasercolor, callbackData = Color.Gray, rectHighlightColor = Color.Gray, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Green Yellow', { callback = lasercolor, callbackData = Color.GreenYellow, rectHighlightColor = Color.GreenYellow, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Honey Dew', { callback = lasercolor, callbackData = Color.HoneyDew, rectHighlightColor = Color.HoneyDew, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Hot Pink', { callback = lasercolor, callbackData = Color.HotPink, rectHighlightColor = Color.HotPink, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Indian Red', { callback = lasercolor, callbackData = Color.IndianRed, rectHighlightColor = Color.IndianRed, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Indigo', { callback = lasercolor, callbackData = Color.Indigo, rectHighlightColor = Color.Indigo, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Khaki', { callback = lasercolor, callbackData = Color.Khaki, rectHighlightColor = Color.Khaki, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Lavender', { callback = lasercolor, callbackData = Color.Lavender, rectHighlightColor = Color.Lavender, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Lavender Blush', { callback = lasercolor, callbackData = Color.LavenderBlush, rectHighlightColor  = Color.LavenderBlush, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Lawn Green', { callback = lasercolor, callbackData = Color.LawnGreen, rectHighlightColor = Color.LawnGreen, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Lemon Chiffon', { callback = lasercolor, callbackData = Color.LemonChiffon, rectHighlightColor = Color.LemonChiffon, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Light Blue', { callback = lasercolor, callbackData = Color.LightBlue, rectHighlightColor = Color.LightBlue, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Light Coral', { callback = lasercolor, callbackData = Color.LightCoral, rectHighlightColor = Color.LightCoral, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Light Cyan', { callback = lasercolor, callbackData = Color.LightCyan, rectHighlightColor = Color.LightCyan, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Light Golden Rod Yellow', { callback = lasercolor, callbackData = Color.LightGoldenRodYellow, rectHighlightColor  = Color.LightGoldenRodYellow, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Light Gray', { callback = lasercolor, callbackData = Color.LightGray, rectHighlightColor = Color.LightGray, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Light Green', { callback = lasercolor, callbackData = Color.LightGreen, rectHighlightColor = Color.LightGreen, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Light Pink', { callback = lasercolor, callbackData = Color.LightPink, rectHighlightColor = Color.LightPink, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Light Salmon', { callback = lasercolor, callbackData = Color.LightSalmon, rectHighlightColor = Color.LightSalmon, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Light Sea Green', { callback = lasercolor, callbackData = Color.LightSeaGreen, rectHighlightColor = Color.LightSeaGreen, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Light Sky Blue', { callback = lasercolor, callbackData = Color.LightSkyBlue, rectHighlightColor = Color.LightSkyBlue, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Light Slate Gray', { callback = lasercolor, callbackData = Color.LightSlateGray, rectHighlightColor = Color.LightSlateGray, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Light Steel Blue', { callback = lasercolor, callbackData = Color.LightSteelBlue, rectHighlightColor = Color.LightSteelBlue, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Light Yellow', { callback = lasercolor, callbackData = Color.LightYellow, rectHighlightColor = Color.LightYellow, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Lime', { callback = lasercolor, callbackData = Color.Lime, rectHighlightColor = Color.Lime, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Lime Green', { callback = lasercolor, callbackData = Color.LimeGreen, rectHighlightColor = Color.LimeGreen, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Linen', { callback = lasercolor, callbackData = Color.Linen, rectHighlightColor = Color.Linen, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Magenta', { callback = lasercolor, callbackData = Color.Magenta, rectHighlightColor = Color.Magenta, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Maroon', { callback = lasercolor, callbackData = Color.Maroon, rectHighlightColor = Color.Maroon, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Medium Aqua Marine', { callback = lasercolor, callbackData = Color.MediumAquaMarine, rectHighlightColor = Color.MediumAquaMarine, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Medium Blue', { callback = lasercolor, callbackData = Color.MediumBlue, rectHighlightColor = Color.MediumBlue, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Medium Orchid', { callback = lasercolor, callbackData = Color.MediumOrchid, rectHighlightColor = Color.MediumOrchid, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Medium Purple', { callback = lasercolor, callbackData = Color.MediumPurple, rectHighlightColor = Color.MediumPurple, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Medium Sea Grean', { callback = lasercolor, callbackData = Color.MediumSeaGreen, rectHighlightColor = Color.MediumSeaGreen, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Medium Slate Blue', { callback = lasercolor, callbackData = Color.MediumSlateBlue, rectHighlightColor = Color.MediumSlateBlue, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Medium Spring Green', { callback = lasercolor, callbackData = Color.MediumSpringGreen, rectHighlightColor = Color.MediumSpringGreen, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Medium Torquise', { callback = lasercolor, callbackData = Color.MediumTurquoise, rectHighlightColor = Color.MediumTurquoise, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Medium Violet Red', { callback = lasercolor, callbackData = Color.MediumVioletRed, rectHighlightColor = Color.MediumVioletRed, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Midnight Blue', { callback = lasercolor, callbackData = Color.MidnightBlue, rectHighlightColor = Color.MidnightBlue, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Mint Cream', { callback = lasercolor, callbackData = Color.MintCream, rectHighlightColor = Color.MintCream, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Misty Rose', { callback = lasercolor, callbackData = Color.MistyRose, rectHighlightColor = Color.MistyRose, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Moccasin', { callback = lasercolor, callbackData = Color.Moccasin, rectHighlightColor = Color.Moccasin, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Navy', { callback = lasercolor, callbackData = Color.Navy, rectHighlightColor = Color.Navy, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Old Lace', { callback = lasercolor, callbackData = Color.OldLace, rectHighlightColor = Color.OldLace, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Olive', { callback = lasercolor, callbackData = Color.Olive, rectHighlightColor = Color.Olive, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Olive Drab', { callback = lasercolor, callbackData = Color.OliveDrab, rectHighlightColor = Color.OliveDrab, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Orange', { callback = lasercolor, callbackData = Color.Orange, rectHighlightColor = Color.Orange, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Orange Red', { callback = lasercolor, callbackData = Color.OrangeRed, rectHighlightColor = Color.OrangeRed, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Orchid', { callback = lasercolor, callbackData = Color.Orchid, rectHighlightColor = Color.Orchid, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Pale Golden Rod', { callback = lasercolor, callbackData = Color.PaleGoldenRod, rectHighlightColor = Color.PaleGoldenRod, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Pale Green', { callback = lasercolor, callbackData = Color.PaleGreen, rectHighlightColor = Color.PaleGreen, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Pale Torquise', { callback = lasercolor, callbackData = Color.PaleTurquoise, rectHighlightColor = Color.PaleTurquoise, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Pale Violet Red', { callback = lasercolor, callbackData = Color.PaleVioletRed, rectHighlightColor = Color.PaleVioletRed, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Papaya Whip', { callback = lasercolor, callbackData = Color.PapayaWhip, rectHighlightColor = Color.PapayaWhip, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Peach Puff', { callback = lasercolor, callbackData = Color.PeachPuff, rectHighlightColor = Color.PeachPuff, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Peru', { callback = lasercolor, callbackData = Color.Peru, rectHighlightColor = Color.Peru, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Pink', { callback = lasercolor, callbackData = Color.Pink, rectHighlightColor = Color.Pink, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Plum', { callback = lasercolor, callbackData = Color.Plum, rectHighlightColor = Color.Plum, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Powder Blue', { callback = lasercolor, callbackData = Color.PowderBlue, rectHighlightColor = Color.PowderBlue, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Red', { callback = lasercolor, callbackData = Color.red, rectHighlightColor = Color(255, 138, 17, 9) / 255, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Rosy Brown', { callback = lasercolor, callbackData = Color.RosyBrown, rectHighlightColor = Color.RosyBrown, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Royal Blue', { callback = lasercolor, callbackData = Color.RoyalBlue, rectHighlightColor = Color.RoyalBlue, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Saddle Brown', { callback = lasercolor, callbackData = Color.SaddleBrown, rectHighlightColor = Color.SaddleBrown, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Salmon', { callback = lasercolor, callbackData = Color.Salmon, rectHighlightColor = Color.Salmon, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Sandy Brown', { callback = lasercolor, callbackData = Color.SandyBrown, rectHighlightColor = Color.SandyBrown, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Sea Green', { callback = lasercolor, callbackData = Color.SeaGreen, rectHighlightColor = Color.SeaGreen, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Sea Shell', { callback = lasercolor, callbackData = Color.SeaShell, rectHighlightColor = Color.SeaShell, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Sienna', { callback = lasercolor, callbackData = Color.Sienna, rectHighlightColor = Color.Sienna, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Silver', { callback = lasercolor, callbackData = Color.Silver, rectHighlightColor = Color.Silver, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Sky Blue', { callback = lasercolor, callbackData = Color.SkyBlue, rectHighlightColor = Color.SkyBlue, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Slate Blue', { callback = lasercolor, callbackData = Color.SlateBlue, rectHighlightColor = Color.SlateBlue, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Slate Gray', { callback = lasercolor, callbackData = Color.SlateGray, rectHighlightColor = Color.SlateGray, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Spring Green', { callback = lasercolor, callbackData = Color.SpringGreen, rectHighlightColor = Color.SpringGreen, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Steel Blue', { callback = lasercolor, callbackData = Color.SteelBlue, rectHighlightColor = Color.SteelBlue, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Tan', { callback = lasercolor, callbackData = Color.Tan, rectHighlightColor = Color.Tan, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Teal', { callback = lasercolor, callbackData = Color.Teal, rectHighlightColor = Color.Teal, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Thistle', { callback = lasercolor, callbackData = Color.Thistle, rectHighlightColor = Color.Thistle, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Tomato', { callback = lasercolor, callbackData = Color.Tomato, rectHighlightColor = Color.Tomato, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Torquise', { callback = lasercolor, callbackData = Color.Turquoise, rectHighlightColor = Color.Turquoise, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Violet', { callback = lasercolor, callbackData = Color.Violet, rectHighlightColor = Color.Violet, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Wheat', { callback = lasercolor, callbackData = Color.Wheat, rectHighlightColor = Color.Wheat, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Yellow Green', { callback = lasercolor, callbackData = Color.YellowGreen, rectHighlightColor = Color.YellowGreen, closeMenu = true})
	ChangerMenu:addOption('laser_menu', 'Yellow', { callback = lasercolor, callbackData =  Color.yellow, rectHighlightColor = Color.yellow, closeMenu = true})
	
	-- Equipment Menu
	ChangerMenu:addGap('main_menu')
	ChangerMenu:addMenuOption('main_menu', 'Оборудование', 'equipment_menu', {rectHighlightColor = Color(255, 138, 17, 9) / 255})
	ChangerMenu:addInformationOption('equipment_menu', 'Выберете необходимое', {textColor = Color.DodgerBlue})
	ChangerMenu:addOption('equipment_menu', 'убрать оборудование', {callback = giveitem, callbackData = {}})
	ChangerMenu:addGap('equipment_menu')
	ChangerMenu:addInformationOption('equipment_menu', 'Оборудование', {textColor = Color.DodgerBlue})
	for i,equipment in pairs(tweak_data.blackmarket.deployables) do
		if (equipment) then
			ChangerMenu:addOption('equipment_menu', managers.localization:text(tweak_data.blackmarket.deployables[i].name_id):gsub("\"", ""), {callback = giveitem, callbackData = i, closeMenu = true})
		end
	end
	
	-- Grenade Menu
	ChangerMenu:addMenuOption('main_menu', 'Гранаты', 'grenade_menu', {rectHighlightColor = Color(255, 138, 17, 9) / 255})
	for i,grenades in pairs(Global.blackmarket_manager.grenades) do
		if (grenades) then
			ChangerMenu:addOption('grenade_menu', managers.localization:text(tweak_data.blackmarket.projectiles[i].name_id):gsub("\"", ""), {callback = changegrenadecallback, callbackData = i, closeMenu = true})
		end
	end
	
	-- Melee Weapon Menu
	ChangerMenu:addGap('main_menu')
	ChangerMenu:addGap('main_menu')
	ChangerMenu:addGap('main_menu')
	ChangerMenu:addGap('main_menu')
	ChangerMenu:addGap('main_menu')
	ChangerMenu:addMenuOption('main_menu', 'Оружие ближнего боя', 'melee_menu', {rectHighlightColor = Color(255, 138, 17, 9) / 255})
	for i,melee in pairs(Global.blackmarket_manager.melee_weapons) do
		if (melee) then
			ChangerMenu:addOption('melee_menu', managers.localization:text(tweak_data.blackmarket.melee_weapons[i].name_id):gsub("\"", ""), {callback = ChangeMelee, callbackData = i, closeMenu = true})
		end
	end
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
if inGame() and isPlaying() then
    if ChangerMenu:isOpen() then
        ChangerMenu:close()
    else
	    if PlayerMenu then
			if PlayerMenu:isOpen() then
				PlayerMenu:close()
			end	
		end
		if StealthMenu then
			if StealthMenu:isOpen() then
				StealthMenu:close()
			end	
		end
		if MissionMenu then
			if MissionMenu:isOpen() then
				MissionMenu:close()
			end	
		end		
		if InventoryMenu then
			if InventoryMenu:isOpen() then
				InventoryMenu:close()
			end	
		end
		if MoneyMenu then
			if MoneyMenu:isOpen() then
				MoneyMenu:close()
			end	
		end
		if NumpadMenu then
			if NumpadMenu:isOpen() then
				NumpadMenu:close()
			end	
		end
		if TrollMenu then
			if TrollMenu:isOpen() then
				TrollMenu:close()
			end	
		end
		if InteractTimerMenu then	
			if InteractTimerMenu:isOpen() then
				InteractTimerMenu:close()
			end	
		end
        ChangerMenu:open()
	end	
end