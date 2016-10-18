dofile(ModPath .."P3DHack/Body/Require/Tools/InGameAutoRequire.lua")

IngameWaitingForPlayersState_at_exit = IngameWaitingForPlayersState_at_exit or IngameWaitingForPlayersState.at_exit
function IngameWaitingForPlayersState:at_exit()
	IngameWaitingForPlayersState_at_exit(self)
	
	-- ANTI-CHEAT
	if isHost() then
		if P3DGroup_P3DHack.Anti_Cheat_Disable then
			anticheat()
		end
	end
	-------------------------------------------
	-- AUTO ON CHEATS
	if P3DGroup_P3DHack.Auto_Cheats then
		autocheats()
	end
	-------------------------------------------
	-- AUTOLOOT
	if isHost() then
		if P3DGroup_P3DHack.Auto_Loot then
			autoloot()
		else
			if Toggle.auto_loot then	 
				autoloot()	
			end
		end
	end
	-------------------------------------------
	-- AUTO SPECIAL EQUIPMENT
	if isHost() then	
		if P3DGroup_P3DHack.Auto_Equipment then	
			autoequip()
		else
			if Toggle.auto_equip then
				autoequip()
			end		
		end
	end
	-------------------------------------------	
	-- SECURE BODY BAGS FOR CASH
	if isHost() then
		if P3DGroup_P3DHack.Secure_BodyBags then
			bodybagsecure()
		else
			if Toggle.body_bag_secure then
				bodybagsecure()
				ChatMessage('Enabled', 'BODYBAGSECURE')
			end	
		end
	end
	-------------------------------------------	
	-- PAGER MOD
	if isHost() then
		if P3DGroup_P3DHack.Pager_Mod then
			pagermod()
		else
			if Toggle.pager_mod then
				pagermod()
			end	
		end
	end
	-------------------------------------------
	-- UPGRADE TWEAKS
	if isHost() then		
		if P3DGroup_P3DHack.Upgrade_Tweaks then	
			upgradetweak()
		else
			if Toggle.upgrade_tweak then
				upgradetweak()
			end
		end
	end
	-------------------------------------------	
	-- GRENADE RESTRICT
	if isHost() then
		if P3DGroup_P3DHack.Grenade_Restrict then
			restrictgrenade()
		else
			if Toggle.grenade_restrict then
				restrictgrenade()
				ChatMessage('Enabled', 'GRENADERESTRICT')
			end
		end
	end	
	-------------------------------------------	
	-- XP MULTIPLIER
	if P3DGroup_P3DHack.XP_Multiplier then
		xpmultiplier()
	end
	--------------------------------------------
	-- PLAYER MENU CONFIG
	if P3DGroup_P3DHack.Player_Menu_Config then
		PlayerMenuConfig()
	end
	--------------------------------------------
	-- STEALTH MENU CONFIG
	if P3DGroup_P3DHack.Stealth_Menu_Config then
		StealthMenuConfig()
	end
	--------------------------------------------
	-- WEAPON MENU CONFIG
	if P3DGroup_P3DHack.Weapon_Menu_Config then
		WeaponMenuConfig()
	end	
	--------------------------------------------
	-- MISSION MANIPULATOR MENU CONFIG
	if P3DGroup_P3DHack.Mission_Manipulator_config then
		MissionConfig()
	end	
	--------------------------------------------
	-- KEYBOARD AUTO CONFIG
	if P3DGroup_P3DHack.Keyboard_Auto_Config then
		KeyBoardConfig()
	end
	--------------------------------------------
	-- RE BIND NUMPAD KEYS
	--[[UnbindKey("VK_NUMPAD0")
	UnbindKey("VK_NUMPAD1")
	UnbindKey("VK_NUMPAD2")
	UnbindKey("VK_NUMPAD3")
	UnbindKey("VK_NUMPAD4")
	UnbindKey("VK_NUMPAD5")
	UnbindKey("VK_NUMPAD6")
	UnbindKey("VK_NUMPAD7")
	UnbindKey("VK_NUMPAD8")
	UnbindKey("VK_NUMPAD9")
	BindKey("VK_NUMPAD0", "P3DHack/Main/KeyBinds/NumPad/SpawnMode/LootBag/NUM0.lua")
	BindKey("VK_NUMPAD1", "P3DHack/Main/KeyBinds/NumPad/SpawnMode/LootBag/NUM1.lua") 
	BindKey("VK_NUMPAD2", "P3DHack/Main/KeyBinds/NumPad/SpawnMode/LootBag/NUM2.lua")
	BindKey("VK_NUMPAD3", "P3DHack/Main/KeyBinds/NumPad/SpawnMode/LootBag/NUM3.lua")
	BindKey("VK_NUMPAD4", "P3DHack/Main/KeyBinds/NumPad/SpawnMode/LootBag/NUM4.lua") 
	BindKey("VK_NUMPAD5", "P3DHack/Main/KeyBinds/NumPad/SpawnMode/LootBag/NUM5.lua")
	BindKey("VK_NUMPAD6", "P3DHack/Main/KeyBinds/NumPad/SpawnMode/LootBag/NUM6.lua")
	BindKey("VK_NUMPAD7", "P3DHack/Main/KeyBinds/NumPad/SpawnMode/LootBag/NUM7.lua") 
	BindKey("VK_NUMPAD8", "P3DHack/Main/KeyBinds/NumPad/SpawnMode/LootBag/NUM8.lua")
	BindKey("VK_NUMPAD9", "P3DHack/Main/KeyBinds/NumPad/SpawnMode/LootBag/NUM9.lua")]]
	--------------------------------------------
	-- TURN OFF GOD MODE
	managers.player:player_unit():character_damage():set_god_mode(false)
end