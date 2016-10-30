dofile(ModPath .."P3DHack/Body/Require/Tools/ConfigTools.lua") -- DO NOT REMOVE OR EDIT

--[[
-- Настройки лазера --
-- Список доступных цветов
AliceBlue, AntiqueWhite, Aqua, Aquamarine, Azure, Beige, Bisque, BlanchedAlmond, BlueViolet, Brown, BurlyWood, CadetBlue,
Chartreuse, Chocolate, Coral, CornflowerBlue, Cornsilk, Crimson, Cyan, DarkBlue, DarkCyan, DarkGoldenRod, DarkGray,
DarkGreen, DarkKhaki, DarkMagenta, DarkOliveGreen, DarkOrange, DarkOrchid, DarkRed, DarkSalmon, DarkSeaGreen, DarkSlateBlue,
DarkSlateGray, DarkTurquoise, DarkViolet, DeepPink, DeepSkyBlue, DimGray, DodgerBlue, FireBrick, ForestGreen, Fuchsia, Gainsboro,
Gold, GoldenRod, Gray, GreenYellow, HoneyDew, HotPink, IndianRed, Indigo, Khaki, Lavender, LavenderBlush, LawnGreen, LemonChiffon, LightBlue,
LightCoral, LightCyan, LightGoldenRodYellow, LightGray, LightGreen, LightPink, LightSalmon, LightSeaGreen, LightSkyBlue, LightSlateGray,
LightSteelBlue, LightYellow, Lime, LimeGreen, Linen, Magenta, Maroon, MediumAquaMarine, MediumBlue, MediumOrchid, MediumPurple, MediumSeaGreen,
MediumSlateBlue, MediumSpringGreen, MediumTurquoise, MediumVioletRed, MidnightBlue, MintCream, MistyRose, Moccasin, Navy, OldLace,
Olive, OliveDrab, Orange, OrangeRed, Orchid, PaleGoldenRod, PaleGreen, PaleTurquoise, PaleVioletRed, PapayaWhip, PeachPuff, Peru, Pink, Plum,
PowderBlue, RosyBrown, RoyalBlue, SaddleBrown, Salmon, SandyBrown, SeaGreen, SeaShell, Sienna, Silver, SkyBlue, SlateBlue,
SlateGray, SpringGreen, SteelBlue, Tan, Teal, Thistle, Tomato, Turquoise, Violet, Wheat, YellowGreen
----------------------------------------------------------------------------------------------------
-- Сумки для спавна --
-- Список доступных сумок для спавна NUMPAD
Almirs_Toast
Artifact
Body_Bag
Bomb_Part_1
Bomb_Part_2
Breaching_Charge
Caustic_Soda
Coke
Coke_Pure
Dentist_loot
Diamond
Ephedrine_Pills
Equipment_Bag
Evidence
FBI_Server
Fire_works
Goat
Gold
Hydrogen_Chloride
Jewelry
Lost_Artifact
Masterpiece
Master_Server
Meth
Meth_Half
Money
Muriatic_Acid
Museum_Artifact
Museum_Painting
Painting
Parachute
Pig
Present
Prototype
Safe_Dummy
Safe_OVK
Safe_Weapon
Samurai_Suit
Thermal_Drill
The_Beast 
Tool 
Turret
Turret_Ammo
War_Head
Weapon
Winch_Part
'Random_Loot' -- спавнится случайная вещь из данного списка

-- Нефтяное дело, доступные двигатели
Engine_01, Engine_02, Engine_03, Engine_04, Engine_05, Engine_06, Engine_07, Engine_08, Engine_09, Engine_10, Engine_11, Engine_12
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Настройка клавиш для мыши --
-- Список доступных клавиш для мыши
MiddleMouseButton, SideButton1, SideButton2
]]
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[ 
-- P3DHack CONFIG --
Ниже можно все отредактировать под себя
true = Включить, false = Выключить
]]
P3DGroup_P3DHack = {
	----------------------
	---- Контур меню -----
	----------------------
	Title_Menu_Color = Color.LightGray, -- Цвет контура верхнего меню
	Main_Menu_Color = Color.LightGray, -- Цвет контура основного меню
	Navigation_Menu_Color = Color.LightGray, -- Цвет контура нижнего меню
	---------------------------------------------------------------------
	------------------
	-- Основное --
	------------------
	
	-- Надписи в игре --
	Text = true, -- Убирает надписи в главном меню
	
	-- UNLOCKER -- (Требуется перезагрузка игры, что бы вступило в силу вступили в силу)
	Skin_Unlocker = true, -- Разблокировать все раскраски (В некоторых случаях будет тег ЧИТЕР)

	-- Автоматический выбор случайной карты -- (Требуется перезагрузка игры, что бы вступило в силу вступили в силу)
	Auto_Pick_Card = false, --Выбирает случайную карту в конце ограбления

	-- Нет паузы -- (Требуется перезагрузка игры, что бы вступило в силу вступили в силу)
	Dropin_Pause_Remove = true, -- Удаляет паузу, когда игрок подключается к игре

	-- FORCE ANY SKILL -- (Требуется перезагрузка игры, что бы вступило в силу вступили в силу)
	-- Не дублировать навыки, приведет к аварии
	Force_Skills = false, -- Разблокировка всех навыков без их прокачки
	
	-- Бесплатные покупки -- (Требуется перезагрузка игры, что бы вступило в силу вступили в силу)
	Favors = true, --Бесконечные очки планирования
	Free_Assets = true, -- Бесплатные покупки активов
	Free_Casino = true, -- Бесплатные покупки в казино
	Free_Contracts = true, -- Бесплатные покупки контрактов
	Free_Masks = true, -- Бесплатная покупка масок
	Free_PrePlanning = true, -- Бесплатные предварительно запланированные активы
	Free_Skills = true, -- Бесплатная покупка навыков
	Free_Slots = true, -- Бесплатные слоты оружия/масок
	Free_Weapons = true, -- Бесплатное оружие
	Free_Weapon_Mods = true, -- Бесплатные покупки оружейных модификаций

	-- Здоровье -- (Требуется перезагрузка игры, что бы вступило в силу вступили в силу)
	No_Job_Heat = true, -- Отключите, если не хотите получить бонус к здоровью
	Job_Heat_Amount = 1.20, -- Настройте бонус к здоровью (По умолчанию 1.15 = 15%)

	-- Авто-плита -- (Требуется перезагрузка игры, что бы вступило в силу вступили в силу)
	Rats_Message = true, -- Показывает, что нужно в данный момент положить
	-- Римские цифры для дурной репутации
	Roman = true, -- Класcические римские цифры для Дурной репутации

	-- Стелс функции -- (Требуется перезагрузка игры, что бы вступило в силу вступили в силу)
	Stealth_Mark_Civilians = true, -- Разрешить маркировку гражданских лиц в стелсе
	Stealth_Mark_Civilians_Vocal = false, -- Разрешить крик , отмечая гражданских лиц в стелсе
	Prioritize_Inspire_Shout = true, -- Разрешить подъем криком упавших товарищей
	Stealth_Shout_Inspire = true, -- Разрешить подъем упавших товарищей

	-- Не ждать подсчета опыта после окончания ограбления -- (Требуется перезагрузка игры, что бы вступило в силу вступили в силу)
	Skip_End_Screen = true, -- Не ждать подсчета опыта после окончания ограбления

	-- Стреляете сквозь... -- (Требуется перезагрузка игры, что бы вступило в силу вступили в силу)
	Bullet_Penetration = true, -- Работает на все оружия, кроме ружий (Выберите ниже)
	Bullet_Penetration_Enemy = true, -- Стреляете через врагов
	Bullet_Penetration_Shield = true, -- Стреляете сквозь щиты
	Bullet_Penetration_Wall = true, -- Стреляете сквозь стены
	
	Weapon_Laser = true, -- Желаете изменить цвет лазера?
	Weapon_Laser_Color = Color.SkyBlue, -- Цвет лазера

	-- Оружие/Маски -- (Требуется перезагрузка игры, что бы вступило в силу вступили в силу)
	MaxMaskRows = 100, -- Слоты для масок
	MaxWeaponRows = 100, -- Слоты для оружий

	-- Зиплайн -- (Требуется перезагрузка игры, что бы вступило в силу вступили в силу)
	Zipline_Drop = true, -- Можете бросать сумки, когда вы на Zip-line----------------
	----------------------------
	-- Привязка клавиш/Нумпад --
	----------------------------
	-- Включить автоматически
	Keyboard_Auto_Config = true, -- Автоматический бинд клавиш (Клавиши смотреть ниже)
	X_Ray = false, -- Отмечает всех в игре; По умолчанию на 'X'

	-- Включение/Выключение клавиш здесь. Настройте то, что хотите включить или выключить.
	-- Пополнение здоровья и патронов(Z) --
	Full_Replenish = true, -- Пополняет здоровье и патроны

	-- Пополняет патроны (C) --
	Ammo_Replenish = true, -- Пополняет патроны

	-- Спавн гранат (B) --
	Grenade_Spawn = true, -- Спавн гранат
	Grenade_Spawn_Type = 'Random_Projectile', -- Выберете тип гранаты ("Random_Projectile", "frag", "launcher_frag", "rocket_frag", "molotov", "launcher_incendiary", "launcher_frag_m32", "wpn_prj_four", "wpn_prj_ace", "wpn_prj_jav")

	-- Включение/Выключение Худа (F10) --
	Hud_Toggle = true, -- Включает/выключает Худ в игре

	-- Локатор о котором вы не знали -- (INSERT)
	Locator = true, -- Включить локатор
	Locator_Beep = false, -- Включить/Выключить звуковой сигнал при использовании локатора
	Locator_Show_Crates	= true, -- Показать/Скрыть Crates Waypoints
	Locator_Show_Distance = true, -- Показать/Скрыть расстояние до точки
	Locator_Show_Drills	= true, -- Показать/Скрыть дрели/буры
	Locator_Show_Gage_Packages = false, -- Показать/Скрыть Гейдж пакеты
	Locator_Show_On_Off_Message = false, -- Показывает/Скрывает сообщения в игре
	Locator_Show_Planks	= true, -- Показать/Скрыть доски
	Locator_Show_Security_Doors = true, -- Показать/Скрыть комнату охраны
	Locator_Show_Sewer_Man_Hole	= true, -- Показать/Скрыть канализационные люки
	Locator_Show_Small_Loot = true, -- Показать/Скрыть небольшой лут
	Locator_Show_Thermite =	true, -- Показать/Скрыть термитную пасту

	-- Перезапуск игры (NUMPAD /) --
	Restart_Job = true, -- Перезапуск игры (Только хост)

	-- Спавн Гейдж пакетов (\) --
	Gage_Package = true, -- Спавнить Гейдж пакеты на прицел

	-- Убить всех (NUMPAD *) --
	Ultimate_Kill = true, -- Убивает абсолютно всех

	-- Заспавнить машину (Управляемую) (V)--
	Vehicle_Spawn = true, -- Спавн машинына V (Только Автосалон)

	-- Нумпад --
	-- Здесь вы можете поменять местами нужные вам предметы --
	Numpad_Loot_Spawn = false, -- Включить спавн на нумпад
	Numpad_Loot_Spawn_0 = Bomb_Part_2, -- Numpad 0
	Numpad_Loot_Spawn_1 = Turret_Ammo, -- Numpad 1
	Numpad_Loot_Spawn_2 = Turret, -- Numpad 2
	Numpad_Loot_Spawn_3 = Weapon, -- Numpad 3
	Numpad_Loot_Spawn_4 = Gold, -- Numpad 4
	Numpad_Loot_Spawn_5 = Money, -- Numpad 5
	Numpad_Loot_Spawn_6 = Jewelry, -- Numpad 6
	Numpad_Loot_Spawn_7 = Coke_Pure, -- Numpad 7
	Numpad_Loot_Spawn_8 = Meth, -- Numpad 8
	Numpad_Loot_Spawn_9 = Painting, -- Numpad 9
	-----------------
	-- Перед игрой --
	-----------------
	-- Включается автоматически -- (Требуется перезагрузка игры, что бы вступило в силу вступили в силу)
	Auto_Cheats = true, -- Все нижеперечисленное будет работать если стоит true
	Bag_CoolDown = false, -- У сумок нет кулдауна
	Camera_Bag_Explosion_Multiplier = false, -- Множитель взрыва
	Camera_Bag_Explosion_Multiplier_Amount = 0, -- (По умолчанию 4)
	Dodge_Chance_Buff = false, -- Шанс уклонения
	Dodge_Chance_Buff_Amount = 0.5, -- Шанс уклонения (0.1 = 10%, 1 = 100%)
	Dynamite_Buff = false,  -- Усиление динамита
	Dynamite_Damage_Buff = 1000, -- Усиление урона для динамита (По умолчанию 30)
	Dynamite_Self_Damage = 0, -- Урон наносимый персонажу от динамита (По умолчанию 10)
	Dynamite_Range_Buff = 2000, -- Дистанция броска динамитной шашки (По умолчанию 1000)
	Explosion_Buff = false, -- Включить ниже перечисленные усиления
	Explosion_Buff_Amount = 500, -- Все взрывы получают дополнительный урон
	Fast_Mask = false, -- Быстрая маска
	GL40_Buff = false, -- GL40 Увеличение урона
	GL40_Buff_Damage_Amount = 2000, -- GL40 прибавка к урону (По умолчанию 34)
	GL40_Buff_Player_Damage_Amount = 0, -- GL40 урон наносимый игроку (По умолчанию 8)
	GL40_Buff_Range_Amount = 2000, -- GL40 Дальность запуска гранат(По умолчанию 350)
	GL40_Buff_Time_Amount = 5, -- GL40 Задержка взрыва (По умолчанию 2.5)
	Grenade_Buff = false, -- Усиление гранат
	Grenade_Buff_Damage_Amount = 300, -- Урон от гранаты (По умолчанию 30)
	Grenade_Buff_Player_Damage_Amount = 10, -- урон себе (По умолчанию 10)
	Grenade_Buff_Range_Amount = 1200, -- Дальность гранаты (По умолчанию 1000)
	Incendiary_Grenade_Buff = false, -- Усиление молотова
	Incendiary_Grenade_Buff_Damage_Amount = 2000, -- Урон от молотова врагам(По умолчанию 3)
	Incendiary_Grenade_Buff_Player_Damage_Amount = 0, -- Урон от молотова себе (По умолчанию 2)
	Incediary_Grenade_Buff_Range_Amount = 2000, -- Дальность броска молотова (По умолчанию 75)
	Incendiary_Grenade_Buff_Burn_Duration_Amount = 5, -- Продолжительность (По умолчанию 6)
	Incendiary_Grenade_Buff_Time_Amount = 2.5, -- Задержка взрыва (По умолчанию 2.5)
	Infinite_Hostage_Follow = false, -- Бесконечный захват заложников
	Infinite_Stamina = false, -- Бесконечная выносливость
	Interaction_CoolDown = false, -- Мгновенное взаимодействие
	Jump_Mask_Off = true, -- Прыгать, когда маска выключена
	Lowered_Headbob = false, -- Опущена голова у фигурки бульдозера
	Melee_Buff = false, -- Усиление рукопашной атаки
	Melee_Buff_Amount = 1000, -- Урон с рукопашной атаки, врежь ему хорошенько!!!
	Molotov_Buff = false, -- Усиление молотова
	Molotov_Buff_Damage_Amount = 2000, -- Урон от молотова врагам (По умолчанию 3)
	Molotov_Buff_Player_Damage_Amount = 0, -- Урон от молотова себе(По умолчанию 2)
	Molotov_Buff_Range_Amount = 10000, -- Дальность броска молотова (По умолчанию 75)
	Molotov_Buff_Burn_Duration_Amount = 30, -- Сколько площади горит(По умолчанию 20)
	No_FlashBang = false, -- Нет ослепления
	No_Recoil = false, -- Без отдачи
	No_Spread = false, -- 100% точность (Исключение дробовики)
	RPG7_Buff = false, -- RPG-7 усиление
	RPG7_Buff_Damage_Amount = 2000, -- RPG-7 урон (По умолчанию 1000)
	RPG7_Buff_Player_Damage_Amount = 0, -- RPG-7 урон игроку (По умолчанию 40)
	RPG7_Buff_Range_Amount = 2000, -- RPG-7 Диапазон взрыва(По умолчанию 500)
	RPG7_Buff_Time_Amount = 5, -- RPG-7 задержка перед взрывом (По умолчанию 2.5)
	Sixth_Sense_Reset = false, -- 6 чувство
	Unlimited_BodyBags = false, -- Бесконечные мешки для трупов

	-- Множитель опыта -- (Требуется перезагрузка игры, что бы вступило в силу вступили в силу)
	XP_Multiplier = false, -- Включить множитель урона
	XP_Multiplier_Amount = 2, -- Множитель опыта

	-- Случайный лут -- (Требуется перезагрузка игры, что бы вступило в силу вступили в силу)
	Auto_Loot = false, -- Спавнить случайный лут (Только хост)
	Auto_Equipment = false, -- Спавн оборудования

	-- Мешки для трупов -- (Требуется перезагрузка игры, что бы вступило в силу вступили в силу)
	Secure_BodyBags = false, -- Мешки для трупов (Только хост)
	Secure_BodyBags_Loot_Value = 1000, -- Цена за сумку

	-- Взаимодействие -- (Требуется перезагрузка игры, что бы вступило в силу вступили в силу)
	Toggle_Interact = true, -- Переключить взаимодействие нижних функций

	-- Другие настройки -- (Требуется перезагрузка игры, что бы вступило в силу вступили в силу)
	Grenade_Restrict = false, -- Отключение гранат во время стелса
	Pager_Mod = false, -- Увеличение количества пейджеров (Только хост)
	Upgrade_Tweaks = false, -- Дополнительные настройки (Редактировать в '/Head/UpgradeTweakConfig') (Только хост)
	--------------------------------------------------------------------------------------------------------------------
	----------------
	-- Игрок (F1) --
	----------------
	-- Опции --
	Player_Menu_Config = false, -- Игрок(F1)
	Auto_Drill_Service = false, -- Востонавливает дрель автоматически
	Carry_Mod = false, -- Удалить вес мешков
	Carry_Stacker = false, -- Перенос несколько сумок сразу
	Cloakers_Cuff_Self = false, -- Клокер не нападает на вас
	Friendly_Fire = false, -- Включить огонь по своим
	God_Mode = true, -- Бессмертие
	Infinite_Ammo_Bag = false, -- Бесконечное использование сумок с патронами
	Infinite_Converts = false, -- Бесконечное конвектирование
	Infinite_Doc_Bag_Use = false, -- Бесконечное использование аптечек
	Infinite_ECM_Battery = false, -- Бесконечная ECM батарея
	Infinite_Messiah_Charge = false, -- Бесконечный заряд мессии
	Infinite_Pager_Answers = false,  -- Бесконечные ответы на пейджер
	Infinite_Specials = false, -- Бесконечные способности (Кабельные связки, Доски, и другое)
	Instant_Dominate = false, -- Бесконечное доминирование
	Instant_Drill = false, -- Мгновенная дрель
	Instant_Interact = false, -- Мгновенное взаимодействие
	Instant_Interact_With_Anything = false, -- Увеличить расстояние взаимодействия (По умолчанию 200)
	Interact_Distance_Amount = 600, -- расстояние увеличить на (Должно быть включено в игре)
	Interact_Distance_Increase = false, -- Увеличить расстояниевзаимодействия
	Interact_Thru_Wall = false, -- Взаимодействие через стены
	No_Hit_Disorientation = false, -- Нет тряски при ударе током
	Small_Loot_Multiplier = false, -- Множитель малого лута (Только хост)
	Small_Loot_Multiplier_Amount = 3, -- Множитель малого лута (Должно быть включено в игре)
	Zipline_Transport = false, -- Зип-лайн транспорт
	------------------------------
	-- Оружейное меню (F2) --
	------------------------------
	Weapon_Menu_Config = false, -- Оружейное меню
	Bullet_Explode = false, -- Сделайте все Пули Взрывоопасными
	Bullet_Fire = false, -- Сделайте все Пули Зажигательными
	Sentry_God_Mode = false, -- Турель бессмертна
	Infinite_Ammo = false, -- Бесконечные патроны
	Sentry_Infinite_Ammo = false, -- Турель стреляет без перезарядки и имеет бесконечные патроны
	Weapon_Damage_Multiplier = false, -- Множитель урона для оружия
	Weapon_Damage_Multiplier_Amount = 500, -- Множитель урона (Должно быть включено в игре)
	Weapon_Fire_Rate_Multiplier = false, -- Скорострельность для оружия
	Weapon_Fire_Rate_Multiplier_Amount = 5000, -- Множитель скорострельности (Должно быть включено в игре)
	Weapon_Reload_Speed_Multiplier = false, -- Множитель перезарядки
	Weapon_Reload_Speed_Multiplier_Amount = 10, -- Множитель скорости перезарядки (Должно быть включено в игре)
	Weapon_Swap_Speed_Multiplier = false, -- Быстрая смена оружия
	Weapon_Swap_Speed_Multiplier_Amount = 1.8, -- Множитель скорости (Должно быть включено в игре)
	-----------------------
	-- Стелс меню (F3) --
	-----------------------
	Stealth_Menu_Config = false, -- Стелс меню (F3)
	Cops_Dont_Shoot = false, -- Полиция не стреляет в тебя (Только хост)
	Disable_Cameras = false, -- Сломать все камеры (Только хост)
	Disable_Pagers = false, -- Отключить пейджеры (Только хост)
	Dont_Call_Police = false, -- Никто не звонит в полицию (Только хост)
	Free_Civ_Kills = false, -- Бесплатные убийства гражданских
	Lobotimize_AI = false, -- Лоботомия (Только хост)
	No_Pager_Dominate = false, -- Нет пейджера при доминации (Только хост)
	No_Panic = false, -- Нет кнопки паники(Только хост)
	Random_Pagers = false, -- Некоторые не имеют пейджеров (Только хост)
	Steal_Pagers = false, -- Украсть пейджеры (Только хост)
	----------------------------------------------
	-- Настройки Манипулятор миссии (F4) --
	----------------------------------------------
	Mission_Manipulator_config = false, -- Манипулятор миссий (F4) (Не влияет на анти-чит)
	-- Анти-чит отключен --
	Anti_Cheat_Disable = true, -- Отключить Анти-чит
	-- Открыть все двери
	Classic_Open_Door = true, -- Желаете открыть все двери, сейвы... Все, кроме комнаты охраны
	New_Open_Door = true, -- Желаете открыть все двери, сейфы... Все, кроме комнаты охраны
}