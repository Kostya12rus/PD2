if not HelpMenu then

	-- Open group
	local function open_group()
	Steam:overlay_activate("url", "http://vk.com/p3dhack_payday")
	end

	-- Open PD2stats
	local function open_PD2Stats()
	Steam:overlay_activate("url", "http://pd2stats.com/?l=ru")
	end
	
	-- Open weapon
	local function open_weapon()
	Steam:overlay_activate("url", "http://vk.com/p3dhack_payday")
	end
	
	-- Open haveProblem
	local function open_haveProblem()
	Steam:overlay_activate("url", "http://vk.com/p3dhack_payday")
	end

---------------------------------------------------------------------------------------------------------------------------------
	HelpMenu = CustomMenuClass:new()
	HelpMenu:addMainMenu('main_menu', {title = 'Меню помощи', maxRows = 11})
	HelpMenu:addMenu('teg_menu', {title = 'Из-за чего может быть тег'})
	HelpMenu:addMenu('teg2_menu', {title = 'Из-за чего может быть тег'})
	HelpMenu:addMenu('teg_reset', {title = 'Как убрать тег ЧИТЕР'})
	HelpMenu:addMenu('premium_menu', {title = 'Что входит в Premium версию', maxRows = 11})
	HelpMenu:addMenu('ingame_menu', {title = 'Кнопки в игре'})
	HelpMenu:addMenu('inmain_menu', {title = 'Кнопки в главном меню'})
   
	HelpMenu:addInformationOption('main_menu', 'МЕНЮ', {textColor = Color.red})
	HelpMenu:addMenuOption('main_menu', 'Из-за чего может быть тег ЧИТЕР', 'teg_menu', {rectHighlightColor = Color.red})
	
	HelpMenu:addInformationOption('teg_menu', 'В надежде, что кто-то это прочтет', {textColor = Color.DodgerBlue})
	HelpMenu:addInformationOption('teg_menu', 'Тег возникает, только при использоваании определенных функций, таких как:')
	HelpMenu:addInformationOption('teg_menu', '      Dlc Unocker и использование предметов, которые доступны за достижение')
	HelpMenu:addInformationOption('teg_menu', '      Смена оборудования в игре')
	HelpMenu:addInformationOption('teg_menu', '      Спавн сумок с добычей')
	HelpMenu:addInformationOption('teg_menu', '      Переносить больше сумок, когда не хост')
	HelpMenu:addInformationOption('teg_menu', '      Пополнение гранат')
	HelpMenu:addInformationOption('teg_menu', '      Использовать больше навыков, чем вам доступно')
	HelpMenu:addInformationOption('teg_menu', '      Skin Unocker, если камуфляж содержит Dlc, которе вы не купили')
	HelpMenu:addInformationOption('teg_menu', '      Сильную накрутку уровня через F10 /Постоянно/')
	
	HelpMenu:addMenuOption('main_menu', 'Из-за чего может быть тег ЧИТЕ /Продолжение/', 'teg2_menu', {rectHighlightColor = Color.red})
	
	HelpMenu:addInformationOption('teg2_menu', 'В надежде, что кто-то это прочтет', {textColor = Color.DodgerBlue})
	HelpMenu:addInformationOption('teg2_menu', 'Тег возникает, только при использоваании определенных функций, таких как:')
	HelpMenu:addInformationOption('teg2_menu', '      Используете больше навыков, чем вам доступно')
	HelpMenu:addInformationOption('teg2_menu', '      Если вы перескочили, например, с I сразу на III /Постоянно/')
	HelpMenu:addInformationOption('teg2_menu', '      Если вы умудрились получить дурную репутацию не пройдя ни одного ограбления /Постоянно/')
	
	
	HelpMenu:addMenuOption('main_menu', 'Как убрать тег ЧИТЕР', 'teg_reset', {rectHighlightColor = Color.red})
	HelpMenu:addInformationOption('teg_reset', 'В надежде, что кто-то это прочтет', {textColor = Color.DodgerBlue})
	HelpMenu:addInformationOption('teg_reset', 'Тег бывает временный и трудноснимаемым', {textColor = Color.yellow})
	HelpMenu:addInformationOption('teg_reset', 'Зайдите на PD2Stats, введите ссылку на ваш профиль, красным цветом будет тег')
	HelpMenu:addInformationOption('teg_reset', 'Если тег временный, то снять его достаточно просто')
	HelpMenu:addInformationOption('teg_reset', 'Исправить нарушение и тег исчезнет')
	HelpMenu:addInformationOption('teg_reset', 'Трудноснимаемый', {textColor = Color.red})
	HelpMenu:addInformationOption('teg_reset', 'Попытайтесь исправить нарушение, используя F10, и подождите некоторое время')
	HelpMenu:addInformationOption('teg_reset', 'Если ничего не выходит, то Настройки/Обнулить прогресс')

	HelpMenu:addMenuOption('main_menu', 'Что входит в Premium версию', 'premium_menu', {rectHighlightColor = Color.red})
   
	
	HelpMenu:addInformationOption('premium_menu', 'Premium', {textColor = Color.DodgerBlue})
	HelpMenu:addInformationOption('premium_menu', 'Полностью настраиваемый Config на русском языке')
	HelpMenu:addInformationOption('premium_menu', 'Автоматическое включение функций')
	HelpMenu:addInformationOption('premium_menu', 'Skin unlocker')
	HelpMenu:addInformationOption('premium_menu', 'Совместимость с HoxHud , PocoHud и другими модами')
	HelpMenu:addInformationOption('premium_menu', 'Скидка на "Контрабандное оружие"-50%')
	HelpMenu:addInformationOption('premium_menu', 'И многое другое')

   
	HelpMenu:addMenuOption('main_menu', 'Кнопки в игре', 'ingame_menu', {rectHighlightColor = Color.red})
	
	HelpMenu:addInformationOption('ingame_menu', 'F1 - Модификаци игрока')
	HelpMenu:addInformationOption('ingame_menu', 'F2 - Модификация оружия')
	HelpMenu:addInformationOption('ingame_menu', 'F3 - Стелс меню')
	HelpMenu:addInformationOption('ingame_menu', 'F4 - Редактор миссии')
	HelpMenu:addInformationOption('ingame_menu', 'F5 - Добавить предметов в инвентарь')
	HelpMenu:addInformationOption('ingame_menu', 'F6 - Деньги')
	HelpMenu:addInformationOption('ingame_menu', 'F7 - Таймер взаимодействия')
	HelpMenu:addInformationOption('ingame_menu', 'F8 - Тролль меню')
	HelpMenu:addInformationOption('ingame_menu', '~ /Premium/ - Тролль меню /Если вы не хост/')
	HelpMenu:addInformationOption('ingame_menu', 'F10- Отключить худ')
   
	HelpMenu:addMenuOption('main_menu', 'Кнопки в главном меню', 'inmain_menu', {rectHighlightColor = Color.red})
	
	HelpMenu:addInformationOption('inmain_menu', 'Кнопки в главном меню', {textColor = Color.DodgerBlue})
	HelpMenu:addInformationOption('inmain_menu', 'F11- Меню помощи /Помоги себе сам/')
	HelpMenu:addInformationOption('inmain_menu', 'F9- Выбор контрактов')
	HelpMenu:addInformationOption('inmain_menu', 'F10- Редактор персонажа')
   
	-- Options
	HelpMenu:addGap('main_menu')
	HelpMenu:addInformationOption('main_menu', 'Дополнительно', {textColor = Color.DodgerBlue})
	HelpMenu:addOption('main_menu', 'Открыть группу', {callback = open_group, closeMenu = true})
	HelpMenu:addOption('main_menu', 'Открыть PD2Stats', {callback = open_PD2Stats, closeMenu = true})
	for i=1,9 do
		HelpMenu:addGap('main_menu')
	end
	HelpMenu:addOption('main_menu', 'Заказать контрабандное оружие', {callback = open_weapon, closeMenu = true})
	HelpMenu:addOption('main_menu', 'Задать вопрос', {callback = open_haveProblem, closeMenu = true})
end

if not inGame() and not isPlaying() then       
	if HelpMenu:isOpen() then
		HelpMenu:close()
	else
		if JobSelectMenu then
			if JobSelectMenu:isOpen() then
				JobSelectMenu:close()
			end
		end
		if DifficultyMenu then
			if DifficultyMenu:isOpen() then
				DifficultyMenu:close()
			end
		end
		HelpMenu:open()
	end    
end
-------------------------------------------------------------------------------------------------------------------------------
if not HelpMenu then   
end
------------------------------------------------------------------------------------------------------------------------

