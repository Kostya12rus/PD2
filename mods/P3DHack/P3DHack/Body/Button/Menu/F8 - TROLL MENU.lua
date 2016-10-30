if not TrollMenu then
	----------------------------
	-- PLAYER STATE FUNCTIONS --
	----------------------------
	-- CUFF SELF
	function statecuffs()
		managers.player:set_player_state("arrested")
	end
	
	-- TAZE SELF
	function statetased()
		managers.player:set_player_state("tased")
	end
	
	-- BLEED OUT SELF
	function stateblood()
		managers.player:set_player_state("bleed_out")
	end
	
	-- INCAPACITATE SELF
	function stateinca()
		managers.player:set_player_state("incapacitated")
	end
	
	-- CUFF TEAM-MATE
	function syncstatecuffs(id)
		for pl_key, pl_record in pairs(managers.groupai:state():all_player_criminals()) do
			if pl_record.status ~= "dead" then
				local unit = managers.groupai:state():all_player_criminals()[pl_key].unit
				if unit:network():peer():id() == id then
					unit:network():send_to_unit({"sync_player_movement_state", unit, "arrested", 0, unit:id()})
				end 
			end	
		end	
	end
	
	-- TAZE TEAM-MATE	
	function syncstatetased(id)
		for pl_key, pl_record in pairs( managers.groupai:state():all_player_criminals() ) do
			if pl_record.status ~= "dead" then
				local unit = managers.groupai:state():all_player_criminals()[ pl_key ].unit
				if unit:network():peer():id() == id then
					unit:network():send_to_unit( { "sync_player_movement_state", unit, "tased", 0, unit:id() } ) --electified? changed?
				end 
			end	
		end	
	end
	
			
	-- BLEEDOUT TEAM-MATE
	function syncstatebleed_out(id)
		for pl_key, pl_record in pairs( managers.groupai:state():all_player_criminals() ) do
			if pl_record.status ~= "dead" then
				local unit = managers.groupai:state():all_player_criminals()[ pl_key ].unit
				if unit:network():peer():id() == id then
					unit:network():send_to_unit({"sync_player_movement_state", unit, "bleed_out", 0, unit:id() } )
				end 
			end	
		end	
	end
			
	-- FORCE CARRY ENGINE TEAM-MATE
	function syncforceengine(id)
		local name = "engine_10"
		local carry_data = tweak_data.carry[name]
		local dye_initiated = carry_data.dye_initiated
		local has_dye_pack = carry_data.has_dye_pack
		local dye_value_multiplier = carry_data.dye_value_multiplier
		for pl_key, pl_record in pairs( managers.groupai:state():all_player_criminals() ) do
			if pl_record.status ~= "dead" then
				local unit = managers.groupai:state():all_player_criminals()[ pl_key ].unit
				if unit:network():peer():id() == id then
					managers.network:session():send_to_peers_synched("sync_carry", name, carry_data.multiplier, dye_initiated, has_dye_pack, dye_value_multiplier)
					managers.player:set_synced_carry(id, name, carry_data.multiplier, dye_initiated, has_dye_pack, dye_value_multiplier)
				end
			end
		end
	end

	-- INCAPACITATE TEAM-MATE
	function syncstateincapacitated(id)
		for pl_key, pl_record in pairs( managers.groupai:state():all_player_criminals() ) do
			if pl_record.status ~= "dead" then
				local unit = managers.groupai:state():all_player_criminals()[ pl_key ].unit
				if unit:network():peer():id() == id then
					unit:network():send_to_unit( { "sync_player_movement_state", unit, "incapacitated", 0, unit:id() } )
				end 
			end	
		end	
	end
			
	-- TEAM TROLLING --	
	-- CUFF ALL TEAM-MATES
	function synccuffall()
		for pl_key, pl_record in pairs( managers.groupai:state():all_player_criminals() ) do
			if pl_record.status ~= "dead" then
				local unit = managers.groupai:state():all_player_criminals()[ pl_key ].unit
				unit:network():send_to_unit( { "sync_player_movement_state", unit, "arrested", 0, unit:id() } )
			end	
		end	
	end
			

	-- TASE ALL TEAM-MATES
	function synctaseall()
		for pl_key, pl_record in pairs( managers.groupai:state():all_player_criminals() ) do
			if pl_record.status ~= "dead" then
				local unit = managers.groupai:state():all_player_criminals()[ pl_key ].unit
				unit:network():send_to_unit( { "sync_player_movement_state", unit, "tased", 0, unit:id() } )
			end	
		end	
	end
			
	-- BLEEDOUT ALL TEAM-MATES
	function syncbleedall()
		for pl_key, pl_record in pairs( managers.groupai:state():all_player_criminals() ) do
			if pl_record.status ~= "dead" then
				local unit = managers.groupai:state():all_player_criminals()[ pl_key ].unit
				unit:network():send_to_unit( { "sync_player_movement_state", unit, "bleed_out", 0, unit:id() } )
			end	
		end	
	end
			
	-- INCAPACITATE ALL TEAM-MATES
	function syncincaall()
		for pl_key, pl_record in pairs( managers.groupai:state():all_player_criminals() ) do
			if pl_record.status ~= "dead" then
				local unit = managers.groupai:state():all_player_criminals()[ pl_key ].unit
				unit:network():send_to_unit( { "sync_player_movement_state", unit, "incapacitated", 0, unit:id() } )
			end	
		end	
	end
			
	-- TELEPORT SELF TO PLAYER
	function teleporttoply(id)
		local pos
		for pl_key, pl_record in pairs( managers.groupai:state():all_player_criminals() ) do
			if pl_record.status ~= "dead" then
				local unit = managers.groupai:state():all_player_criminals()[ pl_key ].unit
				if unit:network():peer():id() == id then
					pos = unit:position()
				end	
			end	
		end
		if pos then
			managers.player:warp_to(pos, managers.player:player_unit():rotation())
		end	
	end

	-- SPAWN AMMO ON PLAYER
	function giveammoto(id)
		local ammo_upgrade_lvl = managers.player:upgrade_level( "ammo_bag", "ammo_increase" )
		for pl_key, pl_record in pairs( managers.groupai:state():all_player_criminals() ) do
			if pl_record.status ~= "dead" then
				local unit = managers.groupai:state():all_player_criminals()[ pl_key ].unit
				if unit:network():peer():id() == id then
					local rot = managers.player:player_unit():rotation()
					if Network:is_client() then
						managers.network:session():send_to_host( "place_deployable_bag", "AmmoBagBase", unit:position(), rot, ammo_upgrade_lvl )
					else 
						AmmoBagBase.spawn( unit:position(), rot, ammo_upgrade_lvl )
					end	
				end	
			end
		end
	end
				
	-- SPAWN MEDIKIT ON PLAYER
	function givemedikito(id)
		local amount_upgrade_lvl = managers.player:upgrade_level( "doctor_bag", "amount_increase" )
		for pl_key, pl_record in pairs( managers.groupai:state():all_player_criminals() ) do
			if pl_record.status ~= "dead" then
			local unit = managers.groupai:state():all_player_criminals()[ pl_key ].unit
				if unit:network():peer():id() == id then
					local rot = managers.player:player_unit():rotation()
					if Network:is_client() then
						managers.network:session():send_to_host( "place_deployable_bag", "DoctorBagBase", unit:position(), rot, amount_upgrade_lvl )
					else
						DoctorBagBase.spawn( unit:position(), rot, amount_upgrade_lvl )
					end	
				end	
			end
		end
	end
	------------------
	-- JAIL OPTIONS --
	------------------
	-- RELEASE PLAYER 1
	function syncreleaseply1()
		local peer = managers.network:session():peer(1)
		if peer and peer:id() ~= managers.network:session():local_peer():id() then 
			if Network:is_client() then
				managers.network:session():server_peer():send("request_spawn_member")
			else	
				IngameWaitingForRespawnState.request_player_spawn(1)
			end	
		end	
	end
	
	-- RELEASE PLAYER 2
	function syncreleaseply2()
		local peer = managers.network:session():peer(2)
		if peer and peer:id() ~= managers.network:session():local_peer():id() then 
			if Network:is_client() then
				managers.network:session():server_peer():send("request_spawn_member")
			else	
				IngameWaitingForRespawnState.request_player_spawn(2)
			end	
		end	
	end
	
	-- RELEASE PLAYER 3
	function syncreleaseply3()	
		local peer = managers.network:session():peer(3)
		if peer and peer:id() ~= managers.network:session():local_peer():id() then 
			if Network:is_client() then
				managers.network:session():server_peer():send("request_spawn_member")
			else	
				IngameWaitingForRespawnState.request_player_spawn(3)
			end	
		end	
	end
	
	-- RELEASE PLAYER 4	
	function syncreleaseply4()
		local peer = managers.network:session():peer(4)
		if peer and peer:id() ~= managers.network:session():local_peer():id() then 
			if Network:is_client() then
				managers.network:session():server_peer():send("request_spawn_member")
			else	
				IngameWaitingForRespawnState.request_player_spawn(4)
			end	
		end	
	end	
	
	-- RELEASE ALL TEAM-MATES
	function releaseteam()
		syncreleaseply1()
		syncreleaseply2()
		syncreleaseply3()
		syncreleaseply4()
	end

	-- RELEASE SELF
	function releaseme()
		if game_state_machine:current_state_name() == "ingame_waiting_for_respawn" and not alive(managers.player:player_unit()) then
			IngameWaitingForRespawnState:_begin_game_enter_transition()
		end	
	end
	
	-- SEND ALL TEAM-MATES TO JAIL
	function sendalltojail(id)
		for _,u_data in pairs(managers.groupai:state():all_player_criminals()) do
			local player = u_data.unit
			local player_id = player:network():peer():id()
			if id == player_id or id == -1 then
				player:network():send("sync_player_movement_state", "dead", 0, player:id())
				player:network():send_to_unit({"spawn_dropin_penalty", true, nil, 0, nil, nil})
				managers.groupai:state():on_player_criminal_death(player:network():peer():id())
			end	
		end	
	end

	-- PUT SELF IN JAIL
	function lockmeup()
		local player = managers.player:local_player()
		managers.player:force_drop_carry()
		managers.statistics:downed({death = true})
		IngameFatalState.on_local_player_dead()
		game_state_machine:change_state_by_name("ingame_waiting_for_respawn")
		player:character_damage():set_invulnerable(true)
		player:character_damage():set_health(0)
		player:base():_unregister() -- remove from GroupAI criminals list
		player:base():set_slot(player, 0)
	end
--------------------------------------------------------------------------------------------------------------------	
	-- MISC OPTIONS	
	-- OPEN VAULT DOOR
	function openvault()		
		for _,unit in pairs(World:find_units_quick("all")) do
			if unit:damage() and unit:damage():has_sequence('timer_done') then		
				unit:damage():run_sequence_simple('timer_done')		
			elseif unit:damage() and unit:damage():has_sequence('open_door') then
				unit:damage():run_sequence_simple('open_door')
			end
			
			if unit:damage() and unit:damage():has_sequence('timer_done') then
				managers.network:session():send_to_peers_synched("run_mission_door_device_sequence", unit, 'timer_done')
			elseif unit:damage() and unit:damage():has_sequence('open_door') then
				managers.network:session():send_to_peers_synched("run_mission_door_device_sequence", unit, 'open_door')
			end
		end
		ChatMessage('Дверь хранилища открыта', 'P3D Hack')
	end
	
	-- FILL DEPOSIT BOXES
	function depositfill()
		for _,unit in pairs(World:find_units_quick("all")) do
			if unit:damage() and unit:damage():has_sequence('enable_special') then
				unit:damage():run_sequence_simple('enable_special') 
				managers.network:session():send_to_peers_synched("run_mission_door_device_sequence", unit, 'enable_special')
			end	
		end
		ChatMessage('Все ячейки заполнены', 'P3D Hack')
	end
	
	-- FIRST WORLD BANK
	function overdrill()
		if isHost() and Global.level_data.level_id == "red2" then
			for _, script in pairs(managers.mission:scripts()) do
				for id, element in pairs(script:elements()) do
					for _, trigger in pairs(element:values().trigger_list or {}) do
						if trigger.notify_unit_sequence == "light_on" then
							element:on_executed()
						end
					end
				end
			end
		end
	end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	local players = managers.groupai:state():all_player_criminals()

	TrollMenu = CustomMenuClass:new()
	TrollMenu:addMainMenu('main_menu', { title = 'Тролль меню'})
	TrollMenu:addMenu('troll_menu', { title = 'Выберите опцию', maxRows = 11})
	TrollMenu:addMenu('self_menu', { title = 'Издеваться над собой'})
	TrollMenu:addMenu('player_2', { title = "Издеваться над "..PlayerName(2)..""})
	TrollMenu:addMenu('player_2', { title = "Издеваться над "..PlayerName(2)..""})
	TrollMenu:addMenu('player_3', { title = "Издеваться над "..PlayerName(3)..""})
	TrollMenu:addMenu('player_4', { title = "Издеваться над "..PlayerName(4)..""})

	
	-- TEAM TROLL MENU
	TrollMenu:addInformationOption('main_menu', 'Издеваться над игроками', {textColor = Color.red})
	TrollMenu:addMenuOption('main_menu', 'Беспорядок с другими игроками', 'troll_menu', { rectHighlightColor = Color(255, 138, 17, 9) / 255 })
	TrollMenu:addInformationOption('troll_menu', 'Издеваться над всеми', {textColor = Color.DodgerBlue})
	TrollMenu:addOption('troll_menu', 'Кровотечение у всех игроков', {callback = syncbleedall})
	TrollMenu:addOption('troll_menu', 'Наручники на всех игроках', {callback = synccuffall})
	TrollMenu:addOption('troll_menu', 'Уронить всех игроков', {callback = syncincaall})
	TrollMenu:addOption('troll_menu', 'Ударить током всех игроков', {callback = synctaseall})
	TrollMenu:addGap('troll_menu')
	TrollMenu:addInformationOption('troll_menu', 'Издеваться над отдельным игроком', {textColor = Color.DodgerBlue})
	TrollMenu:addMenuOption('troll_menu', "Издеватся над "..PlayerName(2).."", 'player_2', {textColor = Color.DeepSkyBlue})
	TrollMenu:addMenuOption('troll_menu', "Издеватся над "..PlayerName(3).."", 'player_3', {textColor = Color.Coral})
	TrollMenu:addMenuOption('troll_menu', "Издеватся над "..PlayerName(4).."", 'player_4', {textColor = Color.LightCoral})
	TrollMenu:addGap('troll_menu')	
	TrollMenu:addInformationOption('troll_menu', "Другое", {textColor = Color.DodgerBlue})
	TrollMenu:addOption('troll_menu', 'Освободить всех товарищей по команде из тюрьмы', {callback = releaseteam})
	TrollMenu:addOption('troll_menu', 'Бросить все товарищи по команде в тюрьму', {callback = sendalltojail, callbackData = -1})

	-- MESS WITH SELF
	TrollMenu:addMenuOption('main_menu', 'Издеватся над собой', 'self_menu', { rectHighlightColor = Color(255, 138, 17, 9) / 255 })
	TrollMenu:addInformationOption('self_menu', "Издеватся над собой:", {textColor = Color.DodgerBlue})
	TrollMenu:addOption('self_menu', 'Истекать кровью', {callback = stateblood})
	TrollMenu:addOption('self_menu', 'Наручники', {callback = statecuffs})
	TrollMenu:addOption('self_menu', 'Упасть', {callback = stateinca})
	TrollMenu:addOption('self_menu', 'Ударить током', {callback = statetased})
	TrollMenu:addGap('self_menu')
	TrollMenu:addInformationOption('self_menu', "Другое", {textColor = Color.DodgerBlue})
	if isHost() then
		TrollMenu:addOption('self_menu', 'Освободить себя из тюрьмы', {callback = releaseme})
		TrollMenu:addOption('self_menu', 'Бросить себя за решетку', {callback = lockmeup})
		TrollMenu:addGap('self_menu')
		TrollMenu:addInformationOption('self_menu', "Выдать оборудование", {textColor = Color.DodgerBlue})
		TrollMenu:addOption('self_menu', 'Выдать сумку с патронами', {callback = giveammoto, callbackData = 1})
		TrollMenu:addOption('self_menu', 'Выдать аптечку', {callback = givemedikito, callbackData = 1})
	else
		TrollMenu:addInformationOption('main_menu', 'Недоступно (Только хост)', {textColor = Color.yellow})
	end
	
	-- MESS WITH PLAYER 2
	TrollMenu:addInformationOption('player_2', "Издеваться над игроком", {textColor = Color.DodgerBlue})
	TrollMenu:addOption('player_2', 'Истекать кровью', {callback = syncstatebleed_out, callbackData = 2})
	TrollMenu:addOption('player_2', 'Наручники', {callback = syncstatecuffs, callbackData = 2})
	TrollMenu:addOption('player_2', 'Уронить', {callback = syncstateincapacitated, callbackData = 2})
	TrollMenu:addOption('player_2', 'Ударить током', {callback = syncstatetased, callbackData = 2})
	TrollMenu:addGap('player_2')
	TrollMenu:addInformationOption('player_2', "Тюрьма/Телепорт", {textColor = Color.DodgerBlue})	
	if isHost() then
		TrollMenu:addOption('player_2', 'Освободить из тюрьмы', {callback = syncreleaseply2})
		TrollMenu:addOption('player_2', 'Бросить за решетку', {callback = sendalltojail, callbackData = 2})
		TrollMenu:addOption('player_2', 'Телепортироваться к игроку', {callback = teleporttoply, callbackData = 2})
		TrollMenu:addInformationOption('player_2', "Другое", {textColor = Color.DodgerBlue})	
		TrollMenu:addOption('player_2', 'Увеличить грузоподъемность', {callback = syncforceengine, callbackData = 2})
		TrollMenu:addOption('player_2', 'Выдать сумку с патронами', {callback = giveammoto, callbackData = 2})
		TrollMenu:addOption('player_2', 'Выдать аптечку', {callback = givemedikito, callbackData = 2})
	else
		TrollMenu:addOption('player_2', 'Телепортироваться к игроку', {callback = teleporttoply, callbackData = 2})
	end
	-- MESS WITH PLAYER 3
	TrollMenu:addInformationOption('player_3', "Издеваться над игроком", {textColor = Color.DodgerBlue})
	TrollMenu:addOption('player_3', 'Истекать кровью', {callback = syncstatebleed_out, callbackData = 3})
	TrollMenu:addOption('player_3', 'Наручники', {callback = syncstatecuffs, callbackData = 3})
	TrollMenu:addOption('player_3', 'Уронить', {callback = syncstateincapacitated, callbackData = 3})
	TrollMenu:addOption('player_3', 'Ударить током', {callback = syncstatetased, callbackData = 3})
	TrollMenu:addGap('player_3')
	TrollMenu:addInformationOption('player_3', "Тюрьма/Телепорт", {textColor = Color.DodgerBlue})
	if isHost() then
		TrollMenu:addOption('player_3', 'Освободить из тюрьмы', {callback = syncreleaseply3})
		TrollMenu:addOption('player_3', 'Бросить за решетку', {callback = sendalltojail, callbackData = 3})
		TrollMenu:addOption('player_3', 'Телепортироваться к игроку', {callback = teleporttoply, callbackData = 3})
		TrollMenu:addInformationOption('player_3', "Другое", {textColor = Color.DodgerBlue})	
		TrollMenu:addOption('player_3', 'Увеличить грузоподъемность', {callback = syncforceengine, callbackData = 3})
		TrollMenu:addOption('player_3', 'Выдать сумку с патронами', {callback = giveammoto, callbackData = 3})
		TrollMenu:addOption('player_3', 'Выдать аптечку', {callback = givemedikito, callbackData = 3})
	else
		TrollMenu:addOption('player_3', 'Телепортироваться к игроку', {callback = teleporttoply, callbackData = 3})
	end
	-- MESS WITH PLAYER 4
	TrollMenu:addInformationOption('player_4', "Издеваться над игроком", {textColor = Color.DodgerBlue})
	TrollMenu:addOption('player_4', 'Истекать кровью', {callback = syncstatebleed_out, callbackData = 4})
	TrollMenu:addOption('player_4', 'Наручники', {callback = syncstatecuffs, callbackData = 4})
	TrollMenu:addOption('player_4', 'Уронить', {callback = syncstateincapacitated, callbackData = 4})
	TrollMenu:addOption('player_4', 'Ударить током', {callback = syncstatetased, callbackData = 4})
	TrollMenu:addGap('player_4')
	TrollMenu:addInformationOption('player_4', "Тюрьма/Телепорт", {textColor = Color.DodgerBlue})	
	if isHost() then
		TrollMenu:addOption('player_4', 'Освободить из тюрьмы', {callback = syncreleaseply4})
		TrollMenu:addOption('player_4', 'Бросить за решетку', {callback = sendalltojail, callbackData = 4})
		TrollMenu:addOption('player_4', 'Телепортироваться к игроку', {callback = teleporttoply, callbackData = 4})
		TrollMenu:addInformationOption('player_4', "Другое", {textColor = Color.DodgerBlue})	
		TrollMenu:addOption('player_4', 'Увеличить грузоподъемность', {callback = syncforceengine, callbackData = 4})
		TrollMenu:addOption('player_4', 'Выдать сумку с патронами', {callback = giveammoto, callbackData = 4})
		TrollMenu:addOption('player_4', 'Выдать аптечку', {callback = givemedikito, callbackData = 4})
	else
		TrollMenu:addOption('player_4', 'Телепортироваться к игроку', {callback = teleporttoply, callbackData = 4})
	end
	if isHost() then
	-- MAIN MENU OPTIONS
	TrollMenu:addGap('main_menu')
	TrollMenu:addInformationOption('main_menu', 'Дополнительно', {textColor = Color.DodgerBlue})
	TrollMenu:addOption('main_menu','Заполнить все ячейки золотом и деньгами', {callback = depositfill, help = 'Заполнить все ячейки золотом и деньгами'})
	TrollMenu:addOption('main_menu','Открыть дверь хранилища', {callback = openvault, help = 'Может иметь побочный эффект'})
	if Global.level_data.level_id == "red2" then
		TrollMenu:addOption('main_menu','Активировать Overdrill хранилище', {callback = overdrill, help = 'Позволяет открыть хронилище OVERDRILL'})
	else
		TrollMenu:addInformationOption('main_menu','Только первый мировой банк', {textColor = Color.yellow})
	end
	end
end
-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------
	if isPlaying() then
		if TrollMenu:isOpen() then
			TrollMenu:close()
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
			if InteractTimerMenu then	
				if InteractTimerMenu:isOpen() then
					InteractTimerMenu:close()
				end	
			end
			TrollMenu:open()
		end 
	end