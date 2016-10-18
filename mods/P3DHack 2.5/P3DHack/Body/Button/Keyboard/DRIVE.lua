-- GLOBAL
local rr = math.random(-360,360)
local randvrot = Rotation(rr)
local pos = get_crosshair_pos()
if not pos or not randvrot then
	return
end

if P3DGroup_P3DHack.Vehicle_Spawn then	
	if isHost() then
		if isPlaying() and not inChat() then			
			-- Spawn Vehicle
			if managers.job:current_level_id() == "cage" then -- CAR SHOP	
				World:spawn_unit(Idstring("units/pd2_dlc_cage/vehicles/fps_vehicle_falcogini_1/fps_vehicle_falcogini_1"), pos, randvrot)
			elseif managers.job:current_level_id() == "shoutout_raid" then	-- MELTDOWN
				local Vehicles = {Idstring("units/pd2_dlc_shoutout_raid/vehicles/fps_vehicle_muscle_1/fps_vehicle_muscle_1"), Idstring("units/pd2_dlc_shoutout_raid/vehicles/fps_vehicle_forklift_1/fps_vehicle_forklift_1")}
				local Random_Vehicles = Vehicles[math.random(#Vehicles)]
				World:spawn_unit(Random_Vehicles, pos, randvrot)
			elseif managers.job:current_level_id() == "arena" then -- ALESSO	
				World:spawn_unit(Idstring("units/pd2_dlc_arena/vehicles/fps_vehicle_forklift_2/fps_vehicle_forklift_2"), pos, randvrot)			
			elseif managers.job:current_level_id() == "peta" or managers.job:current_level_id() == "peta2" then	-- GOAT SIMULATOR
				World:spawn_unit(Idstring("units/pd2_dlc_shoutout_raid/vehicles/fps_vehicle_muscle_1/fps_vehicle_muscle_1"), pos, randvrot)			
			elseif managers.job:current_level_id() == "peta_prof" then -- GOAT SIMULATOR PRO
				World:spawn_unit(Idstring("units/pd2_dlc_shoutout_raid/vehicles/fps_vehicle_muscle_1/fps_vehicle_muscle_1"), pos, randvrot)			
			end	
		end
	else
		showHint('Только хост', 2)
	end
end