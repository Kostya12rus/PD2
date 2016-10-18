function pagermod()	
	if isHost() then
		local level = managers.job:current_level_id()

		if level == 'gallery' then -- GALLERY
			tweak_data.player.alarm_pager.call_duration = {{8, 8},{8, 8}} -- 16 SECONDS
			tweak_data.player.alarm_pager.bluff_success_chance = {1, 1, 1, 1, 1, 1, 0} -- 6 PAGERS
			ChatMessage('6 активных пейджеров', 'Пейджер')
		elseif level == 'kosugi' then -- SHADOW RAID
			tweak_data.player.alarm_pager.call_duration = {{10, 10},{10, 10}} -- 20 SECONDS
			tweak_data.player.alarm_pager.bluff_success_chance = {1, 1, 1, 1, 1, 1, 1, 1, 0} -- 8 PAGERS
			ChatMessage('8 активных пейджеров', 'Пейджер')
		elseif level == 'firestarter_2' then -- FIRESTARTER DAY 2
			tweak_data.player.alarm_pager.call_duration = {{8, 8},{8, 8}} -- 16 SECONDS
			tweak_data.player.alarm_pager.bluff_success_chance = {1, 1, 1, 1, 1, 1, 0} -- 6 PAGERS
			ChatMessage('6 активных пейджеров', 'Пейджер')
		elseif level == 'big' then -- BIG BANK
			tweak_data.player.alarm_pager.call_duration = {{8, 8},{8, 8}} -- 16 SECONDS
			tweak_data.player.alarm_pager.bluff_success_chance = {1, 1, 1, 1, 1, 1, 0} -- 6 PAGERS
			ChatMessage('6 активных пейджеров', 'Пейджер')
		elseif level == 'welcome_to_the_jungle_2' then -- BIG OIL DAY 2
			tweak_data.player.alarm_pager.call_duration = {{8, 8},{8, 8}} -- 16 SECONDS
			tweak_data.player.alarm_pager.bluff_success_chance = {1, 1, 1, 1, 1, 1, 0} -- 6 PAGERS
			ChatMessage('6 активных пейджеров', 'Пейджер')
		elseif level == 'election_day_1' then -- ELECTION DAY 1
			tweak_data.player.alarm_pager.call_duration = {{10, 10},{10, 10}} -- 20 SECONDS
			tweak_data.player.alarm_pager.bluff_success_chance = {1, 1, 1, 1, 1, 1, 1, 0} -- 7 PAGERS
			ChatMessage('7 активных пейджеров', 'Пейджер')
		elseif level == 'election_day_2' then -- ELECTION DAY 2 (WAREHOUSE)
			tweak_data.player.alarm_pager.call_duration = {{10, 10},{10, 10}} -- 20 SECONDS
			tweak_data.player.alarm_pager.bluff_success_chance = {1, 1, 1, 1, 1, 1, 0} -- 6 PAGERS
			ChatMessage('6 активных пейджеров', 'Пейджер')
		elseif level == 'election_day_3_skip1' then -- ELECTION DAY 'PAGERMOD' (BANK)
			tweak_data.player.alarm_pager.call_duration = {{8, 8},{8, 8}} -- 16 SECONDS
			tweak_data.player.alarm_pager.bluff_success_chance = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0} -- 11 PAGERS
			ChatMessage('11 активных пейджеров', 'Пейджер')
		elseif level == 'framing_frame_1' then -- FRAMING FRAME DAY 1
			tweak_data.player.alarm_pager.call_duration = {{8, 8},{8, 8}} -- 16 SECONDS
			tweak_data.player.alarm_pager.bluff_success_chance = {1, 1, 1, 1, 1, 1, 1, 0} -- 7 PAGERS
			ChatMessage('7 активных пейджеров', 'Пейджер')
		elseif level == 'framing_frame_3' then -- FRAMING FRAME DAY 'PAGERMOD'
			tweak_data.player.alarm_pager.call_duration = {{8, 8},{8, 8}} -- 16 SECONDS
			tweak_data.player.alarm_pager.bluff_success_chance = {1, 1, 1, 1, 1, 0} -- 5 PAGERS
			ChatMessage('5 активных пейджеров', 'Пейджер')
		elseif level == 'mallcrasher' then -- MALL CRASHER
			tweak_data.player.alarm_pager.call_duration = {{8, 8},{8, 8}} -- 16 SECONDS
			tweak_data.player.alarm_pager.bluff_success_chance = {1, 1, 1, 1, 1, 0} -- 5 PAGERS
			ChatMessage('5 активных пейджеров', 'Пейджер')
		end
	end
end