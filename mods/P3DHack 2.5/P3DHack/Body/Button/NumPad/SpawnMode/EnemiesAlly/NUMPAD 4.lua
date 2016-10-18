-- LOAD FUNCTIONS
dofile(ModPath .."P3DHack/Body/Button/NumPad/SpawnMode/SPAWN_FUNCTIONS.lua")

if inGame() and isPlaying() and isHost() then
	if data_se then
		if spawn_crosshair then
			spawn_enemy_crosshair('ene_swat_1')
		else
			spawn_enemy_self('ene_swat_1')
		end
		managers.hud:show_hint( { text = "Спецназ 1" } )
	elseif data_ses then
		if spawn_crosshair then
			spawn_enemy_crosshair('ene_sniper_1')
		else
			spawn_enemy_self('ene_sniper_1')
		end
		managers.hud:show_hint( { text = "Снайпер 1" } )
	elseif data_seeg then
		if spawn_crosshair then
			spawn_enemy_crosshair('ene_bulldozer_3')
		else
			spawn_enemy_self('ene_bulldozer_3')
		end
		managers.hud:show_hint( { text = "LMG Бульдозер" } )
	elseif data_sa then
		if spawn_crosshair then
			spawn_allied_crosshair('ene_swat_1')
		else
			spawn_allied_self('ene_swat_1')
		end
		managers.hud:show_hint( { text = "Спецназ 1" } )
	elseif data_sas then
		if spawn_crosshair then
			spawn_allied_crosshair('ene_sniper_1')
		else
			spawn_allied_self('ene_sniper_1')
		end
		managers.hud:show_hint( { text = "Снайпер 1" } )
	elseif data_saeg then
		if spawn_crosshair then
			spawn_allied_crosshair('ene_bulldozer_3')
		else
			spawn_allied_self('ene_bulldozer_3')
		end
		managers.hud:show_hint( { text = "LMG Бульдозер" } )
	elseif data_off then
	end
end