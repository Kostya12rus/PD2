if inGame() and isPlaying() and not inChat() then

	-- ANSWER INFINITE PAGERS (HOST)
	function infpager()
		Toggle.inf_pager_answers = not Toggle.inf_pager_answers
			
		if not Toggle.inf_pager_answers then
			backuper:restore('GroupAIStateBase.on_successful_alarm_pager_bluff')
			return
		end
		
		backuper:backup('GroupAIStateBase.on_successful_alarm_pager_bluff')	
		function GroupAIStateBase:on_successful_alarm_pager_bluff()	end
	end

	-- INSTANT PAGER + MAKE BODYBAGS
	infpager()
	InteractType({'corpse_alarm_pager'})
	InteractType({'corpse_dispose'})
	infpager()
	showHint("На все пейджеры был получен ответ",2)
end