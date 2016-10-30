-- LOAD FUNCTIONS
dofile(ModPath .."P3DHack/Body/Button/NumPad/SpawnMode/SPAWN_FUNCTIONS.lua")

if inGame() and isPlaying() and isHost() then
	if data_se then
		if spawn_crosshair then
			spawn_enemy_crosshair('ene_cop_1')
		else
			spawn_enemy_self('ene_cop_1')
		end
		managers.hud:show_hint( { text = "Полицейский 1" } )
	elseif data_ses then
		if spawn_crosshair then
			spawn_enemy_crosshair('ene_shield_1')
		else
			spawn_enemy_self('ene_shield_1')
		end
		managers.hud:show_hint( { text = "Щит 1" } )
	elseif data_seeg then
		if spawn_crosshair then
			spawn_enemy_crosshair('ene_city_swat_1')
		else
			spawn_enemy_self('ene_city_swat_1')
		end
		managers.hud:show_hint( { text = "Элитный GENSEC 1" } )
	elseif data_sa then
		if spawn_crosshair then
			spawn_allied_crosshair('ene_cop_1')
		else
			spawn_allied_self('ene_cop_1')
		end
		managers.hud:show_hint( { text = "Полицейский 1" } )
	elseif data_sas then
		if spawn_crosshair then
			spawn_allied_crosshair('ene_shield_1')
		else
			spawn_allied_self('ene_shield_1')
		end
		managers.hud:show_hint( { text = "Щит 1" } )
	elseif data_saeg then
		if spawn_crosshair then
			spawn_allied_crosshair('ene_city_swat_1')
		else
			spawn_allied_self('ene_city_swat_1')
		end
		managers.hud:show_hint( { text = "Элитный GENSEC 1" } )
	elseif data_off then
	end
end