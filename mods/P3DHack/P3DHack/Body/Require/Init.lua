----------------
--- REQUIRES ---
----------------
-- BACKUP 
dofile(ModPath .."P3DHack/Body/Require/Tools/origbackuper.lua")

-- USER CONFIG
dofile(ModPath .."P3DHack/Head/Config_(P3DGroup).lua")

-- CUSTUM GUI MENU
dofile(ModPath .."P3DHack/Body/Require/Tools/CustomMenuClass.lua")
dofile(ModPath .."P3DHack/Body/Require/Tools/Util.lua")
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------
-- GLOBAL COLORS --
-------------------	
Color.AliceBlue = Color('F0F8FF')	  	
Color.AntiqueWhite = Color('FAEBD7') 	  	
Color.Aqua = Color('00FFFF') 	  	
Color.Aquamarine = Color('7FFFD4') 	  	
Color.Azure = Color('F0FFFF') 	  	
Color.Beige = Color('F5F5DC') 	  	
Color.Bisque = Color('FFE4C4') 	  		  	
Color.BlanchedAlmond = Color('FFEBCD') 	  		  	
Color.BlueViolet = Color('8A2BE2') 	  	
Color.Brown = Color('A52A2A') 	  	
Color.BurlyWood = Color('DEB887') 	  	
Color.CadetBlue = Color('5F9EA0') 	  	
Color.Chartreuse = Color('7FFF00') 	  	
Color.Chocolate = Color('D2691E') 	  	
Color.Coral = Color('FF7F50') 	  	
Color.CornflowerBlue = Color('6495ED') 	  	
Color.Cornsilk = Color('FFF8DC') 	  	
Color.Crimson = Color('DC143C') 	  	
Color.Cyan = Color('00FFFF') 	  	
Color.DarkBlue = Color('00008B') 	  	
Color.DarkCyan = Color('008B8B') 	  	
Color.DarkGoldenRod = Color('B8860B')	  	
Color.DarkGray = Color('A9A9A9') 	  	
Color.DarkGreen = Color('006400') 	  	
Color.DarkKhaki = Color('BDB76B') 	  	
Color.DarkMagenta = Color('8B008B') 	  	
Color.DarkOliveGreen = Color('556B2F') 	  	
Color.DarkOrange = Color('FF8C00') 	  	
Color.DarkOrchid = Color('9932CC') 	  	
Color.DarkRed = Color('8B0000') 	  	
Color.DarkSalmon = Color('E9967A') 	  	
Color.DarkSeaGreen = Color('8FBC8F') 	  	
Color.DarkSlateBlue = Color('483D8B') 	  	
Color.DarkSlateGray = Color('2F4F4F') 	  	
Color.DarkTurquoise = Color('00CED1') 	  	
Color.DarkViolet = Color('9400D3') 	  	
Color.DeepPink = Color('FF1493') 	  	
Color.DeepSkyBlue = Color('00BFFF') 	  	
Color.DimGray = Color('696969') 	  	
Color.DodgerBlue = Color('1E90FF') 	  	
Color.FireBrick = Color('B22222') 	  		  	
Color.ForestGreen = Color('228B22') 	  	
Color.Fuchsia = Color('FF00FF') 	  	
Color.Gainsboro = Color('DCDCDC') 	  		  	
Color.Gold = Color('FFD700') 	  	
Color.GoldenRod = Color('DAA520') 	  	
Color.Gray = Color('808080') 	  	 	  	
Color.GreenYellow = Color('ADFF2F') 	  	
Color.HoneyDew = Color('F0FFF0') 	  	
Color.HotPink = Color('FF69B4') 	  	
Color.IndianRed = Color('CD5C5C') 	  	
Color.Indigo = Color('4B0082') 	  		  	
Color.Khaki = Color('F0E68C') 	  	
Color.Lavender = Color('E6E6FA') 	  	
Color.LavenderBlush = Color('FFF0F5') 	  	
Color.LawnGreen = Color('7CFC00') 	  	
Color.LemonChiffon = Color('FFFACD') 	  	
Color.LightBlue = Color('ADD8E6') 	  	
Color.LightCoral = Color('F08080') 	  	
Color.LightCyan = Color('E0FFFF') 	  	
Color.LightGoldenRodYellow = Color('FAFAD2') 	  	
Color.LightGray = Color('D3D3D3') 	  	
Color.LightGreen = Color('90EE90') 	  	
Color.LightPink = Color('FFB6C1') 	  	
Color.LightSalmon = Color('FFA07A') 	  	
Color.LightSeaGreen = Color('20B2AA') 	  	
Color.LightSkyBlue = Color('87CEFA') 	  	
Color.LightSlateGray = Color('778899') 	  	
Color.LightSteelBlue = Color('B0C4DE') 	  	
Color.LightYellow = Color('FFFFE0') 	  	
Color.Lime = Color('00FF00') 	  	
Color.LimeGreen = Color('32CD32') 	  	
Color.Linen = Color('FAF0E6') 	  	
Color.Magenta = Color('FF00FF') 	  	
Color.Maroon = Color('800000') 	  	
Color.MediumAquaMarine = Color('66CDAA') 	  	
Color.MediumBlue = Color('0000CD') 	  	
Color.MediumOrchid = Color('BA55D3') 	  	
Color.MediumPurple = Color('9370DB') 	  	
Color.MediumSeaGreen = Color('3CB371') 	  	
Color.MediumSlateBlue = Color('7B68EE') 	  	
Color.MediumSpringGreen = Color('00FA9A') 	  	
Color.MediumTurquoise = Color('48D1CC') 	  	
Color.MediumVioletRed = Color('C71585') 	  	
Color.MidnightBlue = Color('191970') 	  	
Color.MintCream = Color('F5FFFA') 	  	
Color.MistyRose = Color('FFE4E1') 	  	
Color.Moccasin = Color('FFE4B5') 	  		  	
Color.Navy = Color('000080') 	  	
Color.OldLace = Color('FDF5E6') 	  	
Color.Olive = Color('808000') 	  	
Color.OliveDrab = Color('6B8E23') 	  	
Color.Orange = Color('FFA500') 	  	
Color.OrangeRed = Color('FF4500') 	  	
Color.Orchid = Color('DA70D6') 	  	
Color.PaleGoldenRod = Color('EEE8AA') 	  	
Color.PaleGreen = Color('98FB98') 	  	
Color.PaleTurquoise = Color('AFEEEE') 	  	
Color.PaleVioletRed = Color('DB7093') 	  	
Color.PapayaWhip = Color('FFEFD5') 	
Color.PeachPuff = Color('FFDAB9')	  	
Color.Peru = Color('CD853F')	  	
Color.Pink = Color('FFC0CB') 	  	
Color.Plum = Color('DDA0DD')  	
Color.PowderBlue = Color('B0E0E6') 	  	
Color.RosyBrown = Color('BC8F8F') 	  	
Color.RoyalBlue = Color('4169E1') 	  	
Color.SaddleBrown = Color('8B4513') 	  	
Color.Salmon = Color('FA8072') 	  	
Color.SandyBrown = Color('F4A460') 	  	
Color.SeaGreen = Color('2E8B57') 	  	
Color.SeaShell = Color('FFF5EE') 	  	
Color.Sienna = Color('A0522D') 	  	
Color.Silver = Color('C0C0C0') 	  	
Color.SkyBlue = Color('87CEEB') 	  	
Color.SlateBlue = Color('6A5ACD') 	  	
Color.SlateGray = Color('708090') 	  		  	
Color.SpringGreen = Color('00FF7F') 	  	
Color.SteelBlue = Color('4682B4') 	  	
Color.Tan = Color('D2B48C') 	  	
Color.Teal = Color('008080')
Color.Thistle = Color('D8BFD8') 	  	
Color.Tomato = Color('FF6347') 	  	
Color.Turquoise = Color('40E0D0') 	  	
Color.Violet = Color('EE82EE') 	  	
Color.Wheat = Color('F5DEB3') 	  		  	 	  	
Color.YellowGreen = Color('9ACD32')
--------------------------------------------------------------------------------------------------------  	
---------------
-- UTILITIES --
---------------
-- TABLE FOR TOGGLE VARIABLES
Toggle = Toggle or {}

-- GLOBAL BACKUP
backuper = backuper or Backuper:new('backuper')

-- INREASE ROW AMOUNT
tweak_data.gui.MAX_MASK_ROWS = math.round(P3DGroup_P3DHack.MaxMaskRows)
tweak_data.gui.MAX_WEAPON_ROWS = math.round(P3DGroup_P3DHack.MaxWeaponRows)

-- INTERACT SELECTION (LazyOzzy)
function InteractType(interact_types)
	local objects = {}
	
	for _,v in pairs(managers.interaction._interactive_units) do
		if table.contains(interact_types, v:interaction().tweak_data) then
			table.insert(objects, v:interaction())
		end  
	end
	
	for _,v in ipairs(objects) do 
		v:interact(managers.player:player_unit()) 
	end 
end

-- SECURE LOOT (gir489)
function SecureBag(info)
	if (managers.player:player_unit()) then
		managers.loot:secure(info, managers.money:get_bag_value(info), true) --[[When you are the host, other people won't know that you secured these extra bags. When not the host, everyone will see it, but they won't know who's doing it. Blame the host. Always blame the host. Then crash the server for extra super kek supremes. ]]
	end
end

-- SPAWN BAG FUNCTION v4
function ServerSpawnBag(name, zipline_unit)
	local bags = { 
		'cro_loot1',
		'cro_loot2',
		'breaching_charges',
		'nail_caustic_soda',
		'coke',
		'coke_pure',
		'unknown',
		'hope_diamond',
		'nail_euphadrine_pills',
		'equipment_bag_global_event',
		'evidence_bag',
		'circuit',
		"fireworks",
		'goat',
		'gold',
		'nail_hydrogen_chloride',
		'diamonds',
		'lost_artifact',
		'masterpiece_painting',
		'master_server',
		'meth',
		'meth_half',
		'money',
		'nail_muriatic_acid',
		'mus_artifact',
		'mus_artifact_paint',
		'painting',
		'parachute',
		'din_pig',
		'present',
		'prototype',
		'safe_secure_dummy',
		'safe_ovk',
		'safe_wpn',
		'samurai_suit',
		'lance_bag',
		'lance_bag_large',
		'equipment_bag',
		'turret',
		'ammo',
		'warhead',
		'weapon',
		'winch_part',
		'engine_01',
		'engine_02',
		'engine_03',
		'engine_04',
		'engine_05',
		'engine_06',
		'engine_07',
		'engine_08',
		'engine_09',
		'engine_10',
		'engine_11',
		'engine_12'
	}
	local carry_data
	if (name == 'Random_Loot') then
		name = bags[math.random(#bags)]
		carry_data = tweak_data.carry[name]
	else
		carry_data = tweak_data.carry[name]
	end
	local player = managers.player:player_unit()
	if player then
		player:sound():play("Play_bag_generic_throw", nil, false)
	end	
	local camera_ext = player:camera()
	local dye_initiated = carry_data.dye_initiated
	local has_dye_pack = carry_data.has_dye_pack
	local dye_value_multiplier = carry_data.dye_value_multiplier
	local throw_distance_multiplier_upgrade_level = managers.player:upgrade_level("carry", "throw_distance_multiplier", 0)
	if Network:is_client() then
		managers.network:session():send_to_host("server_drop_carry", name, carry_data.multiplier, dye_initiated, has_dye_pack, dye_value_multiplier, camera_ext:position(), camera_ext:rotation(), player:camera():forward(), throw_distance_multiplier_upgrade_level, zipline_unit)
	else
		managers.player:server_drop_carry(name, carry_data.multiplier, dye_initiated, has_dye_pack, dye_value_multiplier, camera_ext:position(), camera_ext:rotation(), player:camera():forward(), throw_distance_multiplier_upgrade_level, zipline_unit, managers.network:session():local_peer())
	end
	managers.hud:temp_show_spawn_bag(name, managers.loot:get_real_value(name, carry_data.multiplier or 1))
end

-- GIVE YOURSELF A BAG TO CARRY v4
function GiveBag(name, zipline_unit)
	local bags = { 
		'cro_loot1',
		'cro_loot2',
		'breaching_charges',
		'nail_caustic_soda',
		'coke',
		'coke_pure',
		'unknown',
		'hope_diamond',
		'nail_euphadrine_pills',
		'equipment_bag_global_event',
		'evidence_bag',
		'circuit',
		"fireworks",
		'goat',
		'gold',
		'nail_hydrogen_chloride',
		'diamonds',
		'lost_artifact',
		'masterpiece_painting',
		'master_server',
		'meth',
		'meth_half',
		'money',
		'nail_muriatic_acid',
		'mus_artifact',
		'mus_artifact_paint',
		'painting',
		'parachute',
		'din_pig',
		'present',
		'prototype',
		'safe_secure_dummy',
		'safe_ovk',
		'safe_wpn',
		'samurai_suit',
		'lance_bag',
		'lance_bag_large',
		'equipment_bag',
		'turret',
		'ammo',
		'warhead',
		'weapon',
		'winch_part',
		'engine_01',
		'engine_02',
		'engine_03',
		'engine_04',
		'engine_05',
		'engine_06',
		'engine_07',
		'engine_08',
		'engine_09',
		'engine_10',
		'engine_11',
		'engine_12'
	}
	local carry_data
	if (name == 'Random_Loot') then
		name = bags[math.random(#bags)]
		carry_data = tweak_data.carry[name]
	else
		carry_data = tweak_data.carry[name]
	end
	
	local carry_type = carry_data.type
	local player = managers.player:player_unit()
	if not player then
		return
	end
	local dye_initiated = carry_data.dye_initiated
	local has_dye_pack = carry_data.has_dye_pack
	local dye_value_multiplier = carry_data.dye_value_multiplier
	if Network:is_client() then
		managers.network:session():send_to_host("set_carry", name, carry_data.multiplier, dye_initiated, has_dye_pack, dye_value_multiplier, zipline_unit)
	else
		managers.player:set_carry(name, carry_data.multiplier, dye_initiated, has_dye_pack, dye_value_multiplier, zipline_unit, managers.network:session():local_peer())
	end
	player:movement():current_state():set_tweak_data(carry_type)
	player:sound():play("Play_bag_generic_pickup", nil, false)
end

-- SPAWN BAG ON CROSSHAIR
function ServerSpawnBagCrossHair(name, zipline_unit)
	local bags = { 
		'cro_loot1',
		'cro_loot2',
		'breaching_charges',
		'nail_caustic_soda',
		'coke',
		'coke_pure',
		'unknown',
		'hope_diamond',
		'nail_euphadrine_pills',
		'equipment_bag_global_event',
		'evidence_bag',
		'circuit',
		"fireworks",
		'goat',
		'gold',
		'nail_hydrogen_chloride',
		'diamonds',
		'lost_artifact',
		'masterpiece_painting',
		'master_server',
		'meth',
		'meth_half',
		'money',
		'nail_muriatic_acid',
		'mus_artifact',
		'mus_artifact_paint',
		'painting',
		'parachute',
		'din_pig',
		'present',
		'prototype',
		'safe_secure_dummy',
		'safe_ovk',
		'safe_wpn',
		'samurai_suit',
		'lance_bag',
		'lance_bag_large',
		'equipment_bag',
		'turret',
		'ammo',
		'warhead',
		'weapon',
		'winch_part',
		'engine_01',
		'engine_02',
		'engine_03',
		'engine_04',
		'engine_05',
		'engine_06',
		'engine_07',
		'engine_08',
		'engine_09',
		'engine_10',
		'engine_11',
		'engine_12'
	}
	local carry_data
	if (name == 'Random_Loot') then
		name = bags[math.random(#bags)]
		carry_data = tweak_data.carry[name]
	else
		carry_data = tweak_data.carry[name]
	end
	
	local position = get_crosshair_pos_new().hit_position -- SPAWN ON CROSSHAIR
	local rotation = managers.player:player_unit():rotation()
	local camera_ext = managers.player:player_unit():camera()
	local dye_initiated = carry_data.dye_initiated
	local has_dye_pack = carry_data.has_dye_pack
	local dye_value_multiplier = carry_data.dye_value_multiplier
	if Network:is_client() then
		managers.network:session():send_to_host("server_drop_carry", name, carry_data.multiplier, dye_initiated, has_dye_pack, dye_value_multiplier, position, rotation, camera_ext:forward(), Vector3(0, 0, 0), zipline_unit)
	else
		managers.player:server_drop_carry(name, carry_data.multiplier, dye_initiated, has_dye_pack, dye_value_multiplier, position, rotation, camera_ext:forward(), Vector3(0, 0, 0), zipline_unit, managers.network:session():local_peer())
	end
	managers.hud:temp_show_spawn_bag(name, managers.loot:get_real_value(name, carry_data.multiplier or 1))
end

-- VARIOUS MOD BAG SPAWN 
function ModBagSpawn(name, _position, z_offset, zipline_unit)
	local position = mvector3.copy(_position)
	local carry_data = tweak_data.carry[ name ]
	local dye_initiated = carry_data.dye_initiated
	local has_dye_pack = carry_data.has_dye_pack
	local dye_value_multiplier = carry_data.dye_value_multiplier
	if z_offset then mvector3.set_z(position, position.z + z_offset) end
	if Network:is_client() then
		managers.network:session():send_to_host( "server_drop_carry", name, carry_data.multiplier, carry_data.dye_initiated,  carry_data.has_dye_pack, carry_data.dye_value_multiplier, position,  Rotation( math.UP, math.random() * 360 ), Vector3( 0,0,-70 ), 0,  zipline_unit )
	else 
		managers.player:server_drop_carry(name, carry_data.multiplier, carry_data.dye_initiated, carry_data.has_dye_pack,  carry_data.dye_value_multiplier, position, Rotation( math.UP,  math.random() * 360 ), Vector3( 0,0,-70 ), 0, zipline_unit, managers.network:session():local_peer())
	end
end

-- RATS BAG SPAWN
function ServerSpawnRatBag(name, zipline_unit)
	local carry_data = tweak_data.carry[name]
	local camera_ext = managers.player:player_unit():camera()
	local meth_pos = Vector3(1930.49, 610, 1845)
	if Network:is_client() then
		managers.network:session():send_to_host("server_drop_carry", name, carry_data.multiplier, carry_data.dye_initiated, carry_data.has_dye_pack, carry_data.dye_value_multiplier, meth_pos, Vector3(90,90,0), Vector3(0,0,0), 50, zipline_unit)
	else
		managers.player:server_drop_carry(name, carry_data.multiplier, carry_data.dye_initiated, carry_data.has_dye_pack, carry_data.dye_value_multiplier, meth_pos, Vector3(90,90,0), Vector3(0,0,1), 50, zipline_unit, managers.network:session():local_peer())
	end 
end

-- PLAYER ID
function PlayerName(id)
	if managers.platform:presence() ~= "Playing" then
		return ""
	end
	local players = managers.groupai:state():all_player_criminals()
	for _,data in pairs(players) do
		local unit = data.unit
		if unit:network():peer():id() == id then
			return unit:base():nick_name()
		end	
	end
	return ""
end

-- SHOW HINT
function showHint(msg, duration)
	if managers and managers.hud then 
		managers.hud:show_hint({text = msg, time = duration})
	end	
end

-- MIDTEXT	
function MidText(msg, msg_title, show_secs)
	if managers and managers.hud then
		managers.hud:present_mid_text({text = msg, title = msg_title, time = show_secs})
	end	
end

-- SHOW CHATMSG	
function ChatMessage(message, username)
	if not managers or not managers.chat or not message then return end
	if not username then username = managers.network.account:username() end
	managers.chat:receive_message_by_name(1, username, message)
end

-- SHOW SYSTEMMSG
function SystemMessage(message)
	if not managers or not managers.chat or not message then return end
	managers.chat:_receive_message(1, managers.localization:to_upper_text( "menu_system_message" ), message, tweak_data.system_chat_color)
end

-- MSG USER
function SendMessage(message, username)
	if not managers or not managers.chat or not message then return end
	if not username then username = managers.network.account:username() end
	managers.chat:send_message(1, username, message)
end

-- CONSOLE TEXT
function Console(text)
	io.stderr:write(text .. "\n")
end

-- BEEP
function beep()
	if managers and managers.menu_component then
		managers.menu_component:post_event("menu_enter")
	end	
end

-- INGAME CHECK
function inGame()
	if not game_state_machine then return false end
	return string.find(game_state_machine:current_state_name(), "game")
end

-- IN CHAT CHECK
function inChat()
	if managers.hud._chat_focus == true then
		return true
	end	
end

-- IS PLAYING CHECK
function isPlaying()
	if not BaseNetworkHandler then return false end
	return BaseNetworkHandler._gamestate_filter.any_ingame_playing[ game_state_machine:last_queued_state_name() ]
end

-- SERVER CHECK	
function isServer()
	if not Network then return false end
	return Network:is_server()
end

-- CLIENT CHECK
function isClient()
	if not Network then return false end
	return Network:is_client()
end

-- HOST CHECK
function isHost()
	if not Network then return false end
	return not Network:is_client()
end

-- IS SINGLEPLAYER
function isSinglePlayer()
	return Global.game_settings.single_player or false
end
		
-- IN TABLE
function in_table(table, value)
	if table ~= nil then 
		for i,x in pairs(table) do 
			if x == value then 
				return true 
			end	
		end	
	end
	return false
end

-- GET XHAIR POS
function get_crosshair_pos(penetrate, from_pos, mvec_to)
	local ray = get_crosshair_ray(penetrate, from_pos, mvec_to)
	if not ray then return false end
	return ray.hit_position
end

-- GET XHAIR POS v2
function get_crosshair_pos_new()
	local player_unit = managers.player:player_unit()
	local mvec_to = Vector3()
	mvector3.set(mvec_to, player_unit:camera():forward())
	mvector3.multiply(mvec_to, 20000)
	mvector3.add(mvec_to, player_unit:camera():position())
	return World:raycast('ray', player_unit:camera():position(), mvec_to, 'slot_mask', managers.slot:get_mask('bullet_impact_targets'))
end

-- IN CROSSHAIR	
function get_crosshair_ray(penetrate, slotMask)
	if not slotMask then slotMask = "bullet_impact_targets" end
	local player = managers.player:player_unit()
	local fromPos = player:camera():position()
	local mvecTo = Vector3()
	mvector3.set(mvecTo, player:camera():forward())
	mvector3.multiply(mvecTo, 20000)
	mvector3.add(mvecTo, fromPos)
	local colRay = World:raycast("ray", fromPos, mvecTo, "slot_mask", managers.slot:get_mask(slotMask))
	if colRay and penetrate then
		local offset = Vector3()
		mvector3.set(offset, player:camera():forward())
		mvector3.multiply(offset, 100)
		mvector3.add(colRay.hit_position, offset)
	end
	return colRay
end

-- SAFER VERSION OF DOFILE
if not orig__dofile then
	orig__dofile = dofile

	function dofile(...)
		local name = select(1, ...)
		if name then
			local check
			local exts = { '', '.lua', '.luac' }
			local i = 0
			repeat
				i = i + 1	
				check = io.open(name..exts[i], 'r')
			until check or i >= #exts
			if not check then
				return
			end
			check:close()
			return orig__dofile( name..exts[i] )
		end	
	end	
end