------------------------------------------------------
-- OPEN ONLY IN NOTEPAD++ OR OTHERS CUSTOM NOTEPADS --
------------------------------------------------------
--[[
--------------------
-- P3DHack Config --
--------------------
Here you can change everything for yourself
true = on, false = off
]]
P3DGroup_P3DHack = {
	------------------
	-- Main options --
	------------------
	---------------------------
	-- Auto pick random card --
	---------------------------
	Auto_Pick_Card = false, -- Auto Select Random Card In Loot Drop Screen
	--------------------------
	-- Drop-In pause remove --
	--------------------------
	Dropin_Pause_Remove = true, -- Remove Drop-In pause when players are joining
	--------------------
	-- Free purchases --
	--------------------
	Favors = true, --Free preplaning points
	Free_Assets = true,  -- Free asset purchases
	Free_Casino = true, -- Free casino purchases
	Free_Contracts = true, -- Free contract purchases
	Free_Masks = true, -- Free mask purchases
	Free_PrePlanning = true, -- Free preplanning purchases
	Free_Slots = true, -- Free weapon/mask slot purchases
	Free_Weapons = true, -- Free weapon purchases
	Free_Weapon_Mods = true, -- Free weapon mod purchases
	-----------------
	-- No job heat --
	-----------------
	No_Job_Heat = true, -- Disable repeated job penalties
	Job_Heat_Amount = 1.20, -- Set job heat bonus amount (Default 1.15 = 15%)
	--------------------------
	-- Rats message display --
	--------------------------
	Rats_Message = true, -- Display correct chemical in chat message
	---------------------
	-- Skip end screen --
	---------------------
	Skip_End_Screen = true, -- Allows you to skip end screen
	------------------------
	-- Bullet Penetration --
	------------------------
	Bullet_Penetration = true, -- Do you want enable bullet penetration?
	Bullet_Penetration_Enemy = true, -- Shoot through enemies
	Bullet_Penetration_Shield = true, -- Shoot through shields
	Bullet_Penetration_Wall = true, -- Shoot through walls
	------------------------
	-- Zipline carry drop --
	------------------------
	Zipline_Drop = true, -- Drop bags that you are carrying while on zip-line
	-------------------------------------------------------------------------
	-- Locator --
	showDistance = true,
	showGagePickups = true,
	showPlanks = true,
	showSmallLoot = true,
	showCrates = true,
	showDoors = true,
	showCameraComputers = true,
	showDrills = true,
	showThermite = true,
	showSewerManhole = true,
	showHUDMessages = true,
	makeNoise = true,
	iterativeToggle = true,
	sheaterNewb = true,
	---------------------
	-- Keybind options --
	---------------------
	----------
	-- Auto --
	----------
	Keyboard_Auto_Config = true, -- Auto run key binds
	X_Ray = false, -- Outline enemies, civilians and cams; Bound To 'X' in default
	---------------------
	-- On/Off keybinds --
	---------------------
	-----------------------------------
	-- Ammo and health replenish (Z) --
	-----------------------------------
	Full_Replenish = true, -- Ammo and health replenish
	---------------
	-- X-Ray (X) --
	---------------
	XRay = true, -- X-Ray
	------------------------
	-- Ammo replenish (C) --
	------------------------
	Ammo_Replenish = true, -- Ammo replenish
	-----------------------
	-- GRENADE SPAWN (B) --
	-----------------------
	Grenade_Spawn = true, -- Spawn grenades
	Grenade_Spawn_Type = 'Random_Projectile', -- Select grenade type ("Random_Projectile", "frag", "launcher_frag", "rocket_frag", "molotov", "launcher_incendiary", "launcher_frag_m32", "wpn_prj_four", "wpn_prj_ace", "wpn_prj_jav")
	----------------------
	-- HUD toggle (F10) --
	----------------------
	Hud_Toggle = true, -- Toggle to hide/show InGame HUD
	----------------------------
	-- Restart job (NUMPAD /) --
	----------------------------
	Restart_Job = true, -- Restart job (Host Only)
	----------------------------
	-- Spawn Gage package (\) --
	----------------------------
	Gage_Package = true, -- Spawn random Gage package on Cross-hair
	-------------------------
	-- Kill all (NUMPAD *) --
	-------------------------
	Ultimate_Kill = true, -- Kill all AI
	----------------------
	-- Vehicle spawn (V)--
	----------------------
	Vehicle_Spawn = true, -- Spawn drivable vehicles on Cross-hair
	---------------------
	-- Pregame options --
	---------------------
	--------------------
	-- Auto on cheats --
	--------------------
	Auto_Cheats = true, -- Auto on cheats
	No_FlashBang = false, -- No FlashBangs
	No_Recoil = false, -- No weapon recoil
	No_Spread = false, -- No weapon spread (Excludes Shotguns)
	Bag_CoolDown = false, -- No bag CoolDown
	Infinite_Hostage_Follow = false, -- Infinite amount of following hostages
	Infinite_Stamina = false, -- Infinite stamina
	Interaction_CoolDown = false, -- No interaction cooldown
	Jump_Mask_Off = true, -- Jump with mask off
	Lowered_Headbob = false, -- Lowered Head-bob
	Melee_Buff = false, -- Melee damage buff
	Melee_Buff_Amount = 1000, -- Melee damage buff multiplier amount
	Fast_Mask = false, -- Fast mask
	Camera_Bag_Explosion_Multiplier = false, -- Explosive bag camera effect multiplier
	Camera_Bag_Explosion_Multiplier_Amount = 0, -- Explosive bag camera effect multiplier (Default 4)
	Dodge_Chance_Buff = false, -- Dodge chance
	Dodge_Chance_Buff_Amount = 0.5, -- Dodge chance amount (0.1 = 10%, 1 = 100%)
	Dynamite_Buff = false, -- Dynamite buff
	Dynamite_Damage_Buff = 1000, -- Dynamite damage buff (Default 30)
	Dynamite_Self_Damage = 0, -- Dynamite self damage buff (Default 10)
	Dynamite_Range_Buff = 2000, -- Dynamite range buff (Default 1000)
	Explosion_Buff = false, -- All explosions damage buff
	Explosion_Buff_Amount = 500, -- All explosions damage buff amount
	GL40_Buff = false, -- GL40 Launcher buff
	GL40_Buff_Damage_Amount = 2000, -- GL40 Launcher damage buff amount (Default 34)
	GL40_Buff_Player_Damage_Amount = 0, -- GL40 Launcher self damage buff amount (Default 8)
	GL40_Buff_Range_Amount = 2000, -- GL40 Launcher explosion range buff amount (Default 350)
	GL40_Buff_Time_Amount = 5, -- GL40 Launcher explosion timer before impact buff amount (Default 2.5)
	Grenade_Buff = false, -- Grenade buff
	Grenade_Buff_Damage_Amount = 300, -- Grenade damage buff amount (Default 30)
	Grenade_Buff_Player_Damage_Amount = 10, -- Grenade self damage amount (Default 10)
	Grenade_Buff_Range_Amount = 1200, -- Grenade damage buff range amount (Default 1000)
	Incendiary_Grenade_Buff = false, -- Incendiary grenade buff
	Incendiary_Grenade_Buff_Damage_Amount = 2000, -- Incendiary grenade damage buff amount (Default 3)
	Incendiary_Grenade_Buff_Player_Damage_Amount = 0, -- Incendiary grenade self damage buff amount (Default 2)
	Incediary_Grenade_Buff_Range_Amount = 2000, -- Incendiary grenade range buff amount (Default 75)
	Incendiary_Grenade_Buff_Burn_Duration_Amount = 5, -- Incendiary grenade burn duration buff (Default 6)
	Incendiary_Grenade_Buff_Time_Amount = 2.5, -- Incendiary grenade explosion timer before impact buff amount (Default 2.5)
	Molotov_Buff = false, -- Molotov buff
	Molotov_Buff_Damage_Amount = 2000, -- Molotov damage buff amount (Default 3)
	Molotov_Buff_Player_Damage_Amount = 0, -- Molotov self damage buff amount (Default 2)
	Molotov_Buff_Range_Amount = 10000, -- Molotov range buff amount (Default 75)
	Molotov_Buff_Burn_Duration_Amount = 30, -- Molotov burn duration buff (Default 20)
	RPG7_Buff = false, -- RPG-7 Buff
	RPG7_Buff_Damage_Amount = 2000, -- RPG-7 damage buff amount (Default 1000)
	RPG7_Buff_Player_Damage_Amount = 0, -- RPG-7 self damage buff amount (Default 40)
	RPG7_Buff_Range_Amount = 2000, -- RPG-7 explosion range buff amount (Default 500)
	RPG7_Buff_Time_Amount = 5, -- RPG-7 explosion timer before impact buff amount (Default 2.5)
	Sixth_Sense_Reset = false, -- 6th sense only resets when you moving
	Unlimited_BodyBags = false, -- Unlimited BodyBags
	-------------------
	-- XP Multiplier --
	-------------------
	XP_Multiplier = false, -- XP Multiplier
	XP_Multiplier_Amount = 2, -- XP Multiplier amount
	-------------------------------
	-- Secure body bags for cash --
	-------------------------------
	Secure_BodyBags = false, -- Secure body bags for cash (Host Only)
	Secure_BodyBags_Loot_Value = 1000, -- Secure body bags for cash value amount
	---------------------
	-- Toggle interact --
	---------------------
	Toggle_Interact = true, -- Interact toggle
	---------------------------
	-- Other pregame options --
	---------------------------
	Grenade_Restrict = false, -- Restrict grenades being thrown while in stealth
	Pager_Mod = false, -- Increase pager count on available maps (Host Only)
	------------------------------------------------------------------------
	-------------------------------
	-- Weapon settings menu (F2) --
	-------------------------------
	Weapon_Damage_Multiplier_Amount = 500, -- Weapon damage multiplier amount
	Weapon_Fire_Rate_Multiplier_Amount = 5000, -- Weapon fire rate amount
	Weapon_Reload_Speed_Multiplier_Amount = 10, -- Weapon reload speed amount
	Weapon_Swap_Speed_Multiplier_Amount = 1.8, -- Weapon swap speed amount
	-----------------------------------
	-- Mission manipulator menu (F4) --
	-----------------------------------
	Mission_Manipulator_config = false, -- Mission manipulator menu
	------------------------
	-- Disable Anti-Cheat --
	------------------------
	Anti_Cheat_Disable = true, -- Disable Anti-Cheat
	--------------------
	-- Open all doors --
	--------------------
	Classic_Open_Door = true, -- Classic option of open all doors may not work everywhere, but is more limited to specific doors
	New_Open_Door = true, -- New option of open all doors, opens all pick locakable doors, safes, deposit boxes and etc. Which classic option does not do
	-----------
	-- Other --
	-----------
	------------------
	-- P3DHack_text --
	------------------
	P3DHack_text = true, -- P3DHack text in main menu
	-------------
	-- hints_1 --
	-------------
	hints_1 = true, -- Show hints_1
}