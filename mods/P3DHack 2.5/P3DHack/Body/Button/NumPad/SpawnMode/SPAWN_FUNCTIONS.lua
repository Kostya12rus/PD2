-------------------------------------------------------------------
---------- SPAWN CODES BY PIERREDJAYS & INFORMATIXA ---------------
-------------------------------------------------------------------
local function set_team(unit, team)
	local AIState = managers.groupai:state()
	local team_id = tweak_data.levels:get_default_team_ID(team)
	unit:movement():set_team(AIState:team_data(team_id))
end

if not variant or type(variant) ~= "table" then
	variant = {["enemy"] = ""}
end

-- INFINITE CONVERSIONS
function InfiniteConvert()
	Toggle.inf_convert = not Toggle.inf_convert
		
	if not Toggle.inf_convert then
		backuper:restore('PlayerManager.upgrade_value')
		return
	end
			
	local _upgradeValueIntimidate = backuper:backup('PlayerManager.upgrade_value')
	function PlayerManager:upgrade_value( category, upgrade, default )
		if category == "player" and upgrade == "convert_enemies" then
			return true
		elseif category == "player" and upgrade == "convert_enemies_max_minions" then
			return 99999
		else
			return _upgradeValueIntimidate(self, category, upgrade, default)
		end
	end
end 

-- SPAWN ENEMY ON CROSSHAIR
function spawn_enemy_crosshair(unit_name)
	if alive(managers.player:player_unit()) then	
		local position = get_crosshair_pos_new().hit_position -- SPAWN ON CROSSHAIR
		local rotation = managers.player:player_unit():rotation()
		local unit = World:spawn_unit(Idstring('units/payday2/characters/'.. unit_name ..'/'.. unit_name..''), position, rotation)
		set_team(unit, unit:base():char_tweak().access == "gangster" and "gangster" or "combatant")		
	end
end

-- SPAWN ENEMY ON SELF
function spawn_enemy_self(unit_name)
	if alive(managers.player:player_unit()) then
		local position = managers.player:player_unit():position() -- SPAWN ON SELF
		local rotation = managers.player:player_unit():rotation()
		local unit = World:spawn_unit(Idstring('units/payday2/characters/'.. unit_name ..'/'.. unit_name..''), position, rotation)
		set_team(unit, unit:base():char_tweak().access == "gangster" and "gangster" or "combatant")
	end
end

-- SPAWN ALLIED ON CROSSHAIR
function spawn_allied_crosshair(unit_name)
	if alive(managers.player:player_unit()) then
		InfiniteConvert()
		local position = get_crosshair_pos_new().hit_position
		local rotation = managers.player:player_unit():rotation()
		local unit = World:spawn_unit(Idstring('units/payday2/characters/'.. unit_name ..'/'.. unit_name..''), position, rotation)
		set_team(unit, unit:base():char_tweak().access == "gangster" and "gangster" or "combatant")
		managers.groupai:state():convert_hostage_to_criminal(unit)
		managers.groupai:state():sync_converted_enemy(unit)
		unit:contour():add("friendly")
		InfiniteConvert()
	end
end

-- SPAWN ALLIED ON SELF
function spawn_allied_self(unit_name)
	if alive(managers.player:player_unit()) then
		InfiniteConvert()
		local position = managers.player:player_unit():position() -- SPAWN ON SELF
		local rotation = managers.player:player_unit():rotation()
		local unit = World:spawn_unit(Idstring('units/payday2/characters/'.. unit_name ..'/'.. unit_name..''), position, rotation)
		set_team(unit, unit:base():char_tweak().access == "gangster" and "gangster" or "combatant")
		managers.groupai:state():convert_hostage_to_criminal(unit, peer_unit)
		managers.groupai:state():sync_converted_enemy(unit)
		unit:contour():add("friendly")
		InfiniteConvert()
	end
end