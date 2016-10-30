function MissionConfig()	
	-- ACTION SETUP
	if P3DGroup_P3DHack.Mouse_Action_Config then
		Toggle.action = not Toggle.action
		if not Toggle.action then	
			UnbindKey(P3DGroup_P3DHack.MouseSlowMo)
			UnbindKey(P3DGroup_P3DHack.MouseTeleport)
		else
			BindKey(P3DGroup_P3DHack.MouseSlowMo, "P3DHack/Main/InGameAssets/Mouse Mod/SLOWMO.lua") 
			BindKey(P3DGroup_P3DHack.MouseTeleport, "P3DHack/Main/InGameAssets/Mouse Mod/PENETRATIVE TELEPORT.lua")
		end 
	end		 

	-- RAISTLIN SETUP
	if P3DGroup_P3DHack.Mouse_Convert_Config then
		Toggle.clone = not Toggle.clone 	
		if not Toggle.clone then	
			UnbindKey(P3DGroup_P3DHack.MouseTeleport1)
			UnbindKey(P3DGroup_P3DHack.MouseConvert)
		else	
			BindKey(P3DGroup_P3DHack.MouseTeleport1, "P3DHack/Main/InGameAssets/Mouse Mod/PENETRATIVE TELEPORT.lua") 
			BindKey(P3DGroup_P3DHack.MouseConvert, "P3DHack/Main/InGameAssets/Mouse Mod/xhairconverter.lua")
		end	
	end
end