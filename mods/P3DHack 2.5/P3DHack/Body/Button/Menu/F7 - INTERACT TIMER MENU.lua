if not InteractTimerMenu then
	
	-- PICKLOCK TIMER
	local function InteractPickLock()
		Toggle.picklock = not Toggle.picklock
		
		if not Toggle.picklock then
			tweak_data.interaction.pick_lock_easy.timer = 10
			tweak_data.interaction.pick_lock_easy_no_skill.timer = 7
			tweak_data.interaction.pick_lock_hard.timer = 45
			tweak_data.interaction.pick_lock_hard_no_skill.timer = 20
			tweak_data.interaction.pick_lock_deposit_transport.timer = 15
			ChatMessage('Отключен', 'Таймер взлома')
			return
		end
		
		tweak_data.interaction.pick_lock_easy.timer = 3
		tweak_data.interaction.pick_lock_easy_no_skill.timer = 3
		tweak_data.interaction.pick_lock_hard.timer = 3
		tweak_data.interaction.pick_lock_hard_no_skill.timer = 3
		tweak_data.interaction.pick_lock_deposit_transport.timer = 3
		ChatMessage('Включено', 'Таймер взлома')
	end	
	--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------			
	-- ECM JAMMER OPEN TIMER
	local function InteractECMJam()
		Toggle.ecmjam = not Toggle.ecmjam
		
		if not Toggle.ecmjam then
			tweak_data.interaction.requires_ecm_jammer.timer = 4 
			tweak_data.interaction.requires_ecm_jammer_atm.timer = 8
			ChatMessage('Отключен', 'ECM таймер')
			return
		end
		
		tweak_data.interaction.requires_ecm_jammer.timer = 3 
		tweak_data.interaction.requires_ecm_jammer_atm.timer = 3
		ChatMessage('Включено', 'ECM таймер')
	end	
	--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------			
	-- DRILL JAM/UPGRADE TIMER
	local function InteractDrillJam()
		Toggle.drilljam = not Toggle.drilljam
		
		if not Toggle.drilljam then
			tweak_data.interaction.drill_upgrade.timer = 10 
			tweak_data.interaction.drill_jammed.timer = 10
			tweak_data.interaction.lance_jammed.timer = 10
			tweak_data.interaction.lance_upgrade.timer = 10
			tweak_data.interaction.huge_lance_jammed.timer = 10
			ChatMessage('Отключен', 'Таймер улучшения/восстановления дрели')
			return
		end
		
		tweak_data.interaction.drill_upgrade.timer = 3 
		tweak_data.interaction.drill_jammed.timer = 3
		tweak_data.interaction.lance_jammed.timer = 3
		tweak_data.interaction.lance_upgrade.timer = 3
		tweak_data.interaction.huge_lance_jammed.timer = 3
		ChatMessage('Включено', 'Таймер улучшения/восстановления дрели')
	end	
	--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------			
	-- REVIVE PLAYER TIMER
	local function InteractRevive()
		Toggle.revivetime = not Toggle.revivetime
		
		if not Toggle.revivetime then
			tweak_data.interaction.revive.timer = 6 
			ChatMessage('Отключен', 'Таймер поднятия игрока')
			return
		end
		
		tweak_data.interaction.revive.timer = 3
		ChatMessage('Включено', 'Таймер поднятия игрока')
	end	
	--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------		
	-- PAGER TIMER
	local function InteractPager()
		Toggle.pager = not Toggle.pager
		
		if not Toggle.pager then
			tweak_data.interaction.corpse_alarm_pager.timer = 10 
			ChatMessage('Отключен', 'Таймер пейджера')
			return
		end
		
		tweak_data.interaction.corpse_alarm_pager.timer = 3
		ChatMessage('Включено', 'Таймер пейджера')
	end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
	InteractTimerMenu = CustomMenuClass:new()
	InteractTimerMenu:addMainMenu('main_menu', { title = 'Таймер взаимодействия'})
	
	InteractTimerMenu:addInformationOption('main_menu', 'Настройки таймера (Уменьшит время до 3 секунд)', {textColor = Color.DodgerBlue})
	InteractTimerMenu:addToggleOption('main_menu', 'Улучшение/восстановление дрели', {callback = InteractDrillJam})
	InteractTimerMenu:addToggleOption('main_menu', 'ECM взлом', {callback = InteractECMJam})
	InteractTimerMenu:addToggleOption('main_menu', 'Ответ на пейджер', {callback = InteractPager})
	InteractTimerMenu:addToggleOption('main_menu', 'Взлом', {callback = InteractPickLock})
	InteractTimerMenu:addToggleOption('main_menu', 'Поднятие игрока', {callback = InteractRevive})
end

if inGame() and isPlaying() then
	if InteractTimerMenu:isOpen() then
		InteractTimerMenu:close()
	else
		if MoneyMenu then	
			if MoneyMenu:isOpen() then
				MoneyMenu:close()
		end end
		if ChangerMenu then
			if ChangerMenu:isOpen() then
				ChangerMenu:close()
		end	end
		if PlayerMenu then
			if PlayerMenu:isOpen() then
				PlayerMenu:close()
		end	end		
		if StealthMenu then
			if StealthMenu:isOpen() then
				StealthMenu:close()
		end	end		
		if MissionMenu then
			if MissionMenu:isOpen() then
				MissionMenu:close()
		end	end
		if InventoryMenu then
			if InventoryMenu:isOpen() then
				InventoryMenu:close()
		end	end
		if TrollMenu then
			if TrollMenu:isOpen() then
				TrollMenu:close()
		end	end		
		if NumpadMenu then
			if NumpadMenu:isOpen() then
				NumpadMenu:close()
		end	end
		InteractTimerMenu:open()
end end