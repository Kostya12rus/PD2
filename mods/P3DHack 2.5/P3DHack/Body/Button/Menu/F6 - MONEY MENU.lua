if not MoneyMenu then
	-- ENABLE INTERACTION WITH ANYTHING
	local function enableinteract1()
		Toggle.interact_with_all = not Toggle.interact_with_all
			
		-- DISABLE
		if not Toggle.interact_with_all then
			backuper:restore('BaseInteractionExt._has_required_upgrade')
			backuper:restore('BaseInteractionExt._has_required_deployable')
			backuper:restore('BaseInteractionExt.can_interact')
			backuper:restore('PlayerManager.remove_equipment')
			return
		end
		
		-- ENABLE
		backuper:backup('BaseInteractionExt._has_required_upgrade')
		function BaseInteractionExt:_has_required_upgrade(movement_state) return true end
		
		backuper:backup('BaseInteractionExt._has_required_deployable')
		function BaseInteractionExt:_has_required_deployable() return true end
		
		backuper:backup('BaseInteractionExt.can_interact')
		function BaseInteractionExt:can_interact(player) return true end
		
		backuper:backup('PlayerManager.remove_equipment')
		function PlayerManager:remove_equipment(equipment_id) end
	end
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------		
	-- OPEN WEAPON CRATES/PRESENTS 
	function pickweap()
		local openbox = {}
		local id
		for _,v in pairs(managers.interaction._interactive_units) do
			if v.interaction then
				id = string.sub(v:interaction()._unit:name():t(), 1, 10)
				if id =="@IDd40d72e" or id == "@IDa096513" or id == "@IDc0c4c07" then
					table.insert(openbox, v:interaction())
				end 
			end 
		end
		for _,v in pairs(openbox) do v:interact(managers.player:player_unit()) end 
	end
	
	-- BAG LOOT/JEWELRY
	function takeloot()
		pickweap()
		InteractType({
			"gold_pile", "money_wrap", "hold_take_painting", "gen_pku_jewelry", "tiara_pickup", "take_weapons", "take_weapons_not_active", "diamond_pickup", 
			"safe_loot_pickup", "mus_pku_artifact", "samurai_armor", "gen_pku_cocaine", "gen_pku_artifact_statue", "gen_pku_artifact_painting", "gen_pku_artifact",
			"taking_meth", "gen_pku_cocaine_pure", "gen_pku_sandwich", "gen_pku_evidence_bag", "gen_pku_warhead", "pku_safe", "taking_meth_huge", "hold_take_server",
			"stash_server_pickup", "gen_pku_fusion_reactor", "pku_pig", "pku_pills", "hold_pku_present", "hold_grab_goat"
		})
		ChatMessage('Весь лут упакован', 'P3D Hack')
	end
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------			
	function OpenAtm()
		enableinteract1()
		InteractType({'requires_ecm_jammer_atm', 'invisible_interaction_open'})
		enableinteract1()
	end
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------			
	function OpenAllLoot()
		enableinteract1()
		InteractType({'requires_ecm_jammer_atm', 'cash_register', 'pick_lock_hard'})
		enableinteract1()
	end
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------			
	-- SECURE SMALL LOOT
	function securesmloot()
		for i = 1,20 do
			managers.loot:secure_small_loot("gen_atm", 3)
		end	
		ChatMessage('Небольшой лут защищен', 'P3D Hack')
	end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	MoneyMenu = CustomMenuClass:new()
	MoneyMenu:addMainMenu('main_menu', {title = 'Деньги'})
	MoneyMenu:addMainMenu('secure_menu', {title = 'Супер выдача лута 69000'})
	
	MoneyMenu:addInformationOption('main_menu', 'Деньги и лут', {textColor = Color.DodgerBlue})
	if isHost() then
		MoneyMenu:addOption('main_menu', 'Собрать весь лут', {callback = takeloot, help = 'Должно быть включено Переносить больше сумок, на снежном рождестве нажмите дважды', closeMenu = true})
	else
		MoneyMenu:addInformationOption('main_menu', 'Недоступно (Только хост)', {textColor = Color.yellow})
	end
	MoneyMenu:addOption('main_menu', 'Взять весь небольшой лут', {callback = InteractType, callbackData = {"safe_loot_pickup", "diamond_pickup", "tiara_pickup", "money_wrap_single_bundle", "invisible_interaction_open"}, closeMenu = true})
	MoneyMenu:addOption('main_menu', 'Открыть все банкоматы и взять деньги', {callback = OpenAtm, help = 'Нажмите дважды, чтоьы забрать деньги'})
	MoneyMenu:addOption('main_menu', 'Открыть все банкоматы, сейфы, ящики с деньгами', {callback = OpenAllLoot})
	for i = 6,10 do	
		MoneyMenu:addGap('main_menu')
	end
	MoneyMenu:addInformationOption('main_menu', 'Меню защиты', {textColor = Color.DodgerBlue})
	MoneyMenu:addMenuOption('main_menu', 'Защита лута', 'secure_menu', {rectHighlightColor = Color(255, 138, 17, 9) / 255})
	for i,carry in pairs(tweak_data.carry) do
		if (carry) then
			if (carry.name_id and carry.bag_value) then
				MoneyMenu:addOption('secure_menu', managers.localization:text(carry.name_id), {callback = SecureBag, callbackData = carry.bag_value})
			end
		end
	end	
	MoneyMenu:addOption('main_menu', 'Защитить небольшой лут', {callback = securesmloot, closeMenu = true, help = 'vk.com/P3DHack_new'})
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
if inGame() and isPlaying() then
	if MoneyMenu:isOpen() then
		MoneyMenu:close()
	else
		if ChangerMenu then
			if ChangerMenu:isOpen() then
				ChangerMenu:close()
			end	
		end
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
		MoneyMenu:open()
	end 
end