if not JobSelectMenu then
    -- CUSTOM LOBBY CREATOR by harfatus
    function CreateLobby(job, difficulty, permission, min_rep, drop_in, kicking_allowed, team_ai, level_id, auto_kick)
        Global.game_settings.permission = permission == nil and "private" or permission
        Global.game_settings.reputation_permission = type(min_rep) == "number" and min_rep or 0
        Global.game_settings.drop_in_allowed = drop_in == nil and true or drop_in
        Global.game_settings.kicking_allowed = kicking_allowed == nil and true or kicking_allowed
        Global.game_settings.team_ai = team_ai == nil and true or team_ai
        Global.game_settings.auto_kick = auto_kick == nil and true or auto_kick
        MenuCallbackHandler:start_job({job_id = job, difficulty = difficulty})
        if level_id then
            Global.game_settings.level_id = level_id
            Global.game_settings.mission = managers.job:current_mission()
        end
    end
 
    function add_job(data)
        CreateLobby(data.job_id, data.difficulty, managers.network.matchmake.lobby_handler and Global.game_settings.permission or "friends_only")
    end
    
    DifficultyMenu = CustomMenuClass:new()    
    PreGameMenu = PreGameMenu
    function mission(job)
        local job_id = job[1]
        local job_name = job[2]
        io.write("jobid:" .. job_id .. "\n")
        io.write("name: " .. job_name .. "\n")    
        DifficultyMenu:addMainMenu('main_menu', {title = 'Выберите сложность', maxRows = 11})
        DifficultyMenu:addInformationOption('main_menu', 'Сложность:', {textColor = Color.DodgerBlue})
        DifficultyMenu:addOption('main_menu', 'Нормально', {callback = add_job, callbackData = {difficulty = "normal", job_id = job_id}, closeMenu = true})
        DifficultyMenu:addOption('main_menu', 'Сложно', {callback = add_job, callbackData = {difficulty = "hard", job_id = job_id}, closeMenu = true})
        DifficultyMenu:addOption('main_menu', 'Очень сложно', {callback = add_job, callbackData = {difficulty = "overkill", job_id = job_id}, closeMenu = true})
        DifficultyMenu:addOption('main_menu', 'Overkill', {callback = add_job, callbackData = {difficulty = "overkill_145", job_id = job_id}, closeMenu = true})
        DifficultyMenu:addOption('main_menu', 'Mayhem', {callback = add_job, callbackData = {difficulty = "easy_wish", job_id = job_id}, closeMenu = true})
        DifficultyMenu:addOption('main_menu', 'DeathWish', {callback = add_job, callbackData = {difficulty = "overkill_290", job_id = job_id}, closeMenu = true})
        DifficultyMenu:addOption('main_menu', 'One Down', {callback = add_job, callbackData = {difficulty = "sm_wish", job_id = job_id}, closeMenu = true})
        if DifficultyMenu:isOpen() then
            DifficultyMenu:close()
        else
            if JobSelectMenu then
                if JobSelectMenu:isOpen() then
                    JobSelectMenu:close()
                end
            end
            if PreGameMenu then
                if PreGameMenu:isOpen() then
                    PreGameMenu:close()
                end
            end
            DifficultyMenu:open()
        end
    end    
    ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    -- MAIN MENU
    JobSelectMenu = CustomMenuClass:new()
    JobSelectMenu:addMainMenu('main_menu', {title = 'Выберите контракт'})
    JobSelectMenu:addMenu('bain_menu', {title = 'Бэйн'})
    JobSelectMenu:addMenu('hector_menu', {title = 'Гектор'})
    JobSelectMenu:addMenu('elephant_menu', {title = 'Слон'})
    JobSelectMenu:addMenu('dentist_menu', {title = 'Дантист'})
    JobSelectMenu:addMenu('vlad_menu', {title = 'Влад'})
    JobSelectMenu:addMenu('butcher_menu', {title = 'Мясник'})
    JobSelectMenu:addMenu('classic_menu', {title = 'Классика'})
    JobSelectMenu:addMenu('event_menu', {title = 'События'})
    JobSelectMenu:addMenu('locke_menu', {title = 'Лок'})
	JobSelectMenu:addMenu('jimmy_menu', {title = 'Джимми'})
    
    -- CONTACT OPTIONS
    JobSelectMenu:addInformationOption('main_menu', 'Заказчик', {textColor = Color.red})
    JobSelectMenu:addMenuOption('main_menu', 'Бэйн', 'bain_menu', {rectHighlightColor = Color(255, 138, 17, 9) / 255})
    JobSelectMenu:addMenuOption('main_menu', 'Классика', 'classic_menu', {rectHighlightColor = Color(255, 138, 17, 9) / 255})
    JobSelectMenu:addMenuOption('main_menu', 'События', 'event_menu', {rectHighlightColor = Color(255, 138, 17, 9) / 255})
    JobSelectMenu:addMenuOption('main_menu', 'Гектор', 'hector_menu', {rectHighlightColor = Color(255, 138, 17, 9) / 255})
    JobSelectMenu:addMenuOption('main_menu', 'Лок', 'locke_menu', {rectHighlightColor = Color(255, 138, 17, 9) / 255})
    for i=5,9 do
         JobSelectMenu:addGap('main_menu')
    end
	JobSelectMenu:addMenuOption('main_menu', 'Джиммм', 'jimmy_menu', {rectHighlightColor = Color(255, 138, 17, 9) / 255})
    JobSelectMenu:addMenuOption('main_menu', 'Мясник', 'butcher_menu', {rectHighlightColor = Color(255, 138, 17, 9) / 255})
    JobSelectMenu:addMenuOption('main_menu', 'Дантист', 'dentist_menu', {rectHighlightColor = Color(255, 138, 17, 9) / 255})
    JobSelectMenu:addMenuOption('main_menu', 'Слон', 'elephant_menu', {rectHighlightColor = Color(255, 138, 17, 9) / 255})
    JobSelectMenu:addMenuOption('main_menu', 'Влад', 'vlad_menu', {rectHighlightColor = Color(255, 138, 17, 9) / 255})
 
    -- BAIN JOB MENU
    JobSelectMenu:addInformationOption('bain_menu', 'Бэйн', {textColor = Color.DodgerBlue})
	JobSelectMenu:addOption('bain_menu', 'Художественная галерея', {callback = mission, callbackData = {"gallery", "Art Gallery"}, closeMenu = true}) 
	JobSelectMenu:addOption('bain_menu', 'Ограбление банка PRO', {callback = mission, callbackData = {"branchbank_prof", "Bank Heist PRO"}, closeMenu = true})
    JobSelectMenu:addOption('bain_menu', 'Ограбление банка: наличные', {callback = mission, callbackData = {"branchbank_cash", "Bank Heist:Cash"}, closeMenu = true})
    JobSelectMenu:addOption('bain_menu', 'Ограбление банка: ячейки', {callback = mission, callbackData = {"branchbank_deposit", "Bank Heist:Deposit"}, closeMenu = true})
    JobSelectMenu:addOption('bain_menu', 'Ограбление банка: золото PRO', {callback = mission, callbackData = {"branchbank_gold_prof", "Bank Heist:Gold PRO"}, closeMenu = true})
    JobSelectMenu:addOption('bain_menu', 'Автосалон', {callback = mission, callbackData = {"cage", "Car Shop"}, closeMenu = true})
	JobSelectMenu:addOption('bain_menu', 'Варка мета', {callback = mission, callbackData = {"rat", "Cook Off"}, closeMenu = true})
    JobSelectMenu:addOption('bain_menu', 'Магазин бриллиантов', {callback = mission, callbackData = {"family", "Diamond Store"}, closeMenu = true})
	JobSelectMenu:addOption('bain_menu', 'Банк GO', {callback = mission, callbackData = {"roberts", "GO Bank"}, closeMenu = true})
    JobSelectMenu:addGap('bain_menu')
	JobSelectMenu:addOption('bain_menu', 'Ювелирный магазин', {callback = mission, callbackData = {"jewelry_store", "Jewelry Store"}, closeMenu = true})
    JobSelectMenu:addOption('bain_menu', 'Теневой рейд', {callback = mission, callbackData = {"kosugi", "Shadow Raid"}, closeMenu = true})
	JobSelectMenu:addGap('bain_menu')
	JobSelectMenu:addGap('bain_menu')
	JobSelectMenu:addGap('bain_menu')
	JobSelectMenu:addGap('bain_menu')
	JobSelectMenu:addGap('bain_menu')
	JobSelectMenu:addGap('bain_menu')
	JobSelectMenu:addGap('bain_menu')
    
    -- BAIN JOB MENU COLUMN 2
    JobSelectMenu:addInformationOption('bain_menu', 'Бэйн DLC', {textColor = Color.yellow})
    JobSelectMenu:addOption('bain_menu', 'Алессо DLC', {callback = mission, callbackData = {"arena", "The Alesso Job"}, closeMenu = true, textHighlightColor = Color.black, rectHighlightColor = Color.yellow})
    JobSelectMenu:addOption('bain_menu', 'Транспорт: Центр города', {callback = mission, callbackData = {"arm_hcm", "Transport:Downtown"}, closeMenu = true, textHighlightColor = Color.black, rectHighlightColor = Color.yellow})
    JobSelectMenu:addOption('bain_menu', 'Транспорт: Гавань', {callback = mission, callbackData = {"arm_fac", "Transport:Harbor"}, closeMenu = true, textHighlightColor = Color.black, rectHighlightColor = Color.yellow})
    JobSelectMenu:addOption('bain_menu', 'Транспорт: Перекресток', {callback = mission, callbackData = {"arm_cro", "Transport:Crossroads"}, closeMenu = true, textHighlightColor = Color.black, rectHighlightColor = Color.yellow})
    JobSelectMenu:addOption('bain_menu', 'Транспорт: Проезд', {callback = mission, callbackData = {"arm_und", "Transport:Underpass"}, closeMenu = true, textHighlightColor = Color.black, rectHighlightColor = Color.yellow})
    JobSelectMenu:addOption('bain_menu', 'Транспорт: Парк', {callback = mission, callbackData = {"arm_par", "Transport:Park"}, closeMenu = true, textHighlightColor = Color.black, rectHighlightColor = Color.yellow})
    JobSelectMenu:addOption('bain_menu', 'Транспорт: Поезд', {callback = mission, callbackData = {"arm_for", "Transport: Train Heist"}, closeMenu = true, textHighlightColor = Color.black, rectHighlightColor = Color.yellow})
    
    -- HECTOR JOB MENU
    JobSelectMenu:addInformationOption('hector_menu', 'Гектор', {textColor = Color.DodgerBlue})
    JobSelectMenu:addOption('hector_menu', 'Поджигатель', {callback = mission, callbackData = {"firestarter", "Firestarter"}, closeMenu = true})
    JobSelectMenu:addOption('hector_menu', 'Поджигатель PRO', {callback = mission, callbackData = {"firestarter_prof", "Firestarter PRO"}, closeMenu = true})
    JobSelectMenu:addOption('hector_menu', 'Крысы', {callback = mission, callbackData = {"alex", "Rats"}, closeMenu = true})
    JobSelectMenu:addOption('hector_menu', 'Крысы PRO', {callback = mission, callbackData = {"alex_prof", "Rats PRO"}, closeMenu = true})
    JobSelectMenu:addOption('hector_menu', 'Сторожевые Псы', {callback = mission, callbackData = {"watchdogs", "Watchdogs"}, closeMenu = true})
    JobSelectMenu:addOption('hector_menu', 'Сторожевые Псы (Ночь)', {callback = mission, callbackData = {"watchdogs_night", "Watchdogs Night"}, closeMenu = true})
    JobSelectMenu:addOption('hector_menu', 'Сторожевые Псы PRO', {callback = mission, callbackData = {"watchdogs_prof", "Watchdogs PRO"}, closeMenu = true})
    JobSelectMenu:addOption('hector_menu', 'Сторожевые Псы PRO (Ночь)', {callback = mission, callbackData = {"watchdogs_night_prof", "Watchdogs PRO Night"}, closeMenu = true})
    
    -- ELEPHANT JOB MENU
    JobSelectMenu:addInformationOption('elephant_menu', 'Слон', {textColor = Color.DodgerBlue})
    JobSelectMenu:addOption('elephant_menu', 'Нефтяное дело PRO (Ночь)', {callback = mission, callbackData = {"welcome_to_the_jungle_night_prof", "Big Oil PRO Night"}, closeMenu = true})
    JobSelectMenu:addOption('elephant_menu', 'Нефтяное дело PRO', {callback = mission, callbackData = {"welcome_to_the_jungle_prof", "Big Oil PRO"}, closeMenu = true})
    JobSelectMenu:addOption('elephant_menu', 'День выборов PRO', {callback = mission, callbackData = {"election_day_prof", "Election Day PRO"}, closeMenu = true})
    JobSelectMenu:addOption('elephant_menu', 'День выборов', {callback = mission, callbackData = {"election_day", "Election Day"}, closeMenu = true})
    JobSelectMenu:addOption('elephant_menu', 'Подстава с картинами PRO', {callback = mission, callbackData = {"framing_frame_prof", "Framing Frame PRO"}, closeMenu = true})
    JobSelectMenu:addOption('elephant_menu', 'Подстава с картинами', {callback = mission, callbackData = {"framing_frame", "Framing Frame"}, closeMenu = true})
    
    -- DENTIST JOB MENU
    JobSelectMenu:addInformationOption('dentist_menu', 'Дантист', {textColor = Color.DodgerBlue})
    JobSelectMenu:addOption('dentist_menu', 'Спасение Хокстона', {callback = mission, callbackData = {"hox", "Hoxton Breakout"}, closeMenu = true})
    JobSelectMenu:addOption('dentist_menu', 'Спасение Хокстона PRO', {callback = mission, callbackData = {"hox_prof", "Hoxton Breakout PRO"}, closeMenu = true})
    JobSelectMenu:addOption('dentist_menu', 'Месть Хокстона', {callback = mission, callbackData = {"hox_3", "Hoxtons Revenge"}, closeMenu = true})
    for i=5,10 do
         JobSelectMenu:addGap('dentist_menu')
    end
    JobSelectMenu:addInformationOption('dentist_menu', 'Дантист DLC', {textColor = Color.yellow})
    JobSelectMenu:addOption('dentist_menu', 'Казино Golden Grin DLC', {callback = mission, callbackData = {"kenaz", "Golden Grin Casino DLC"}, closeMenu = true, textHighlightColor = Color.black, rectHighlightColor = Color.yellow})
    JobSelectMenu:addOption('dentist_menu', 'Hotline Miami DLC', {callback = mission, callbackData = {"mia", "Hotline Miami DLC"}, closeMenu = true, textHighlightColor = Color.black, rectHighlightColor = Color.yellow})
    JobSelectMenu:addOption('dentist_menu', 'Hotline Miami PRO DLC', {callback = mission, callbackData = {"mia_prof", "Hotline Miami PRO DLC"}, closeMenu = true, textHighlightColor = Color.black, rectHighlightColor = Color.yellow})    
    JobSelectMenu:addOption('dentist_menu', 'Большой банк DLC', {callback = mission, callbackData = {"big", "The Big Bank"}, closeMenu = true, textHighlightColor = Color.black, rectHighlightColor = Color.yellow})
    JobSelectMenu:addOption('dentist_menu', 'Бриллиант DLC', {callback = mission, callbackData = {"mus", "The Diamond"}, closeMenu = true, textHighlightColor = Color.black, rectHighlightColor = Color.yellow})
    
    -- BUTCHER JOB MENU
    JobSelectMenu:addInformationOption('butcher_menu', 'Мясник DLC', {textColor = Color.yellow})
    JobSelectMenu:addOption('butcher_menu', 'Бомба: Лес DLC', {callback = mission, callbackData = {"crojob2", "The Bomb: FOREST DLC"}, closeMenu = true, textHighlightColor = Color.black, rectHighlightColor = Color.yellow})
    JobSelectMenu:addOption('butcher_menu', 'Бомба: Лес DLC (Ночь)', {callback = mission, callbackData = {"crojob2_night", "The Bomb: FOREST DLC (Night)"}, closeMenu = true, textHighlightColor = Color.black, rectHighlightColor = Color.yellow})
    JobSelectMenu:addOption('butcher_menu', 'Бомба: Доки DLC', {callback = mission, callbackData = {"crojob1", "The Bomb: DOCKYARD DLC"}, closeMenu = true, textHighlightColor = Color.black, rectHighlightColor = Color.yellow})
     
    -- VLAD JOB MENU
    JobSelectMenu:addInformationOption('vlad_menu', 'Влад', {textColor = Color.DodgerBlue})
    JobSelectMenu:addOption('vlad_menu', 'Последствия', {callback = mission, callbackData = {"jolly", "Aftershock"}, closeMenu = true})
    JobSelectMenu:addOption('vlad_menu', 'Четыре магазина', {callback = mission, callbackData = {"four_stores", "Four Stores"}, closeMenu = true})
    JobSelectMenu:addOption('vlad_menu', 'Крушитель', {callback = mission, callbackData = {"mallcrasher", "Mallcrasher"}, closeMenu = true})
    JobSelectMenu:addOption('vlad_menu', 'Ядерная угроза', {callback = mission, callbackData = {"shoutout_raid", "Meltdown"}, closeMenu = true})
    JobSelectMenu:addOption('vlad_menu', 'Ночной клуб', {callback = mission, callbackData = {"nightclub", "Nightclub"}, closeMenu = true})
    JobSelectMenu:addOption('vlad_menu', "Мастерская санты", {callback = mission, callbackData = {"cane", "Santa's Workshop"}, closeMenu = true})
	JobSelectMenu:addOption('vlad_menu', 'Украинское дело PRO', {callback = mission, callbackData = {"ukrainian_job_prof", "Ukrainian Job PRO"}, closeMenu = true})
    JobSelectMenu:addOption('vlad_menu', 'Снежное рождество', {callback = mission, callbackData = {"pines", "White XMAS"}, closeMenu = true})
	JobSelectMenu:addGap('vlad_menu')
	JobSelectMenu:addInformationOption('vlad_menu', 'Влад DLC', {textColor = Color.yellow})
	JobSelectMenu:addOption('vlad_menu', 'Goat Simulator DLC', {callback = mission, callbackData = {"peta", "Goat Simulator DLC"}, closeMenu = true, textHighlightColor = Color.black, rectHighlightColor = Color.yellow})
	JobSelectMenu:addOption('vlad_menu', 'Goat Simulator DLC PRO', {callback = mission, callbackData = {"peta_prof", "Goat Simulator DLC PRO JOB"}, closeMenu = true, textHighlightColor = Color.black, rectHighlightColor = Color.yellow})

    
   -- CLASSICS JOB MENU
    JobSelectMenu:addInformationOption('classic_menu', 'Классика', {textColor = Color.DodgerBlue})
    JobSelectMenu:addOption('classic_menu', 'Первый мировой банк', {callback = mission, callbackData = {"red2", "First World Bank"}, closeMenu = true})
    JobSelectMenu:addOption('classic_menu', 'Скотобойня', {callback = mission, callbackData = {"dinner", "Slaughterhouse"}, closeMenu = true})
	for i=1,7 do
         JobSelectMenu:addGap('classic_menu')
    end
	JobSelectMenu:addInformationOption('classic_menu', 'Классика DLC', {textColor = Color.yellow})
	JobSelectMenu:addOption('classic_menu', 'Подделка', {callback = mission, callbackData = {"pal", "Counterfeit"}, closeMenu = true})
	JobSelectMenu:addOption('classic_menu', 'Под прикрытием', {callback = mission, callbackData = {"man", "Undercover"}, closeMenu = true})
	
    -- EVENTS JOB MENU
    JobSelectMenu:addOption('event_menu', 'Лабораторные крысы', {callback = mission, callbackData = {"nail", "Lab Rats"}, closeMenu = true})
    
    -- LOCKE JOB MENU
    JobSelectMenu:addInformationOption('locke_menu', 'Лок DLC', {textColor = Color.yellow})
    JobSelectMenu:addOption('locke_menu', 'У подножия горы DLC', {callback = mission, callbackData = {"pbr", "Beneath The Mountain DLC"}, closeMenu = true, textHighlightColor = Color.black, rectHighlightColor = Color.yellow})
    JobSelectMenu:addOption('locke_menu', 'Рождение небес DLC', {callback = mission, callbackData = {"pbr2", "Birth of Sky DLC"}, closeMenu = true, textHighlightColor = Color.black, rectHighlightColor = Color.yellow})
	-- JIMMY Menu
	JobSelectMenu:addInformationOption('jimmy_menu', 'Джимми', {textColor = Color.DodgerBlue})
	JobSelectMenu:addOption('jimmy_menu', 'Точка кипения', {callback = mission, callbackData = {"mad", "Birth of Sky DLC"}, closeMenu = true})
	JobSelectMenu:addOption('jimmy_menu', 'Станция Murkywater', {callback = mission, callbackData = {"dark", "Birth of Sky DLC"}, closeMenu = true})
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
if not inGame() and not isPlaying() then
    if JobSelectMenu:isOpen() then
        JobSelectMenu:close()
    else
        if PreGameMenu then
            if PreGameMenu:isOpen() then
                PreGameMenu:close()
            end
        end
        if DifficultyMenu then
            if DifficultyMenu:isOpen() then
                DifficultyMenu:close()
            end
        end
        JobSelectMenu:open()
    end
end