function KeyBoardConfig()
	-- XRAY
	if P3DGroup_P3DHack.X_Ray then
		if managers.job:current_level_id() == "cane" then
		else
			dofile(ModPath .."P3DHack/Body/Button/Keyboard/XRAY VISION TOGGLE.lua")
		end
	end
end