-- LOAD FUNCTIONS
dofile(ModPath .."P3DHack/Body/Button/NumPad/SpawnMode/SPAWN_FUNCTIONS.lua")

if inGame() and isPlaying() and isHost() then
	if data_se then
		if spawn_crosshair then
			spawn_enemy_crosshair('ene_swat_heavy_1')
		else
			spawn_enemy_self('ene_swat_heavy_1')
		end
		managers.hud:show_hint( { text = "Спецназ бронированный" } )
	elseif data_ses then
		if spawn_crosshair then
			spawn_enemy_crosshair('ene_tazer_1')
		else
			spawn_enemy_self('ene_tazer_1')
		end
		managers.hud:show_hint( { text = "Тайзер" } )
	elseif data_seeg then
		managers.hud:show_hint( { text = "Недоступно" } )
	elseif data_sa then
		if spawn_crosshair then
			spawn_allied_crosshair('ene_swat_heavy_1')
		else
			spawn_allied_self('ene_swat_heavy_1')
		end
		managers.hud:show_hint( { text = "Спецназ бронированный" } )
	elseif data_sas then
		if spawn_crosshair then
			spawn_allied_crosshair('ene_tazer_1')
		else
			spawn_allied_self('ene_tazer_1')
		end
		managers.hud:show_hint( { text = "Тайзер" } )
	elseif data_saeg then
		managers.hud:show_hint( { text = "Недоступно" } )
	elseif data_sbs then
		managers.hud:show_hint( { text = "UНедоступно" } )
	elseif data_srs then
		managers.hud:show_hint( { text = "Недоступно" } )
	elseif data_off then
	end
end