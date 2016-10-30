dofile(ModPath .."P3DHack/Head/Config_(P3DGroup).lua")

if P3DGroup_P3DHack.Rats_Message then	
	local ingredient_dialog = {}
	ingredient_dialog["pln_rt1_20"] = "Соляную кислоту"
	ingredient_dialog["pln_rt1_22"] = "Каустическую соду"
	ingredient_dialog["pln_rt1_24"] = "Хлористый водород"
	ingredient_dialog["pln_rat_stage1_20"] = "Соляную кислоту"
	ingredient_dialog["pln_rat_stage1_22"] = "Каустическую соду"
	ingredient_dialog["pln_rat_stage1_24"] = "Хлористый водород"

	local _queue_dialog_orig = DialogManager.queue_dialog
	function DialogManager:queue_dialog(id, ...)
		if ingredient_dialog[id] then
			managers.chat:feed_system_message(ChatManager.GAME, "Добавить: " .. ingredient_dialog[id])
		end
		return _queue_dialog_orig(self, id, ...)
	end
end