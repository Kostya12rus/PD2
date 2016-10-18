-- KILL EM ALL
if P3DGroup_P3DHack.Ultimate_Kill then
	if isPlaying() then	
		function nukeunit(pawn)
			local col_ray = { }
			col_ray.ray = Vector3(1, 0, 0)
			col_ray.position = pawn.unit:position()
			local action_data = {}
			action_data.variant = "explosion"
			action_data.damage = 1000
			action_data.attacker_unit = managers.player:player_unit()
			action_data.col_ray = col_ray
			pawn.unit:character_damage():damage_explosion(action_data)
		end
		
		if isHost() then	
			-- DISABLE CAMS
			for _,unit in pairs(GroupAIStateBase._security_cameras) do
				unit:base():set_update_enabled(false)
			end
			
			-- INFINTIE PAGERS
			function GroupAIStateBase:on_successful_alarm_pager_bluff()	end
			
			-- DISABLE PAGERS
			function CopLogicInactive._set_interaction(data, my_data)
				data.unit:unit_data().has_alarm_pager = false
			end 
		end

		-- FREE CIVILIAN KILLS
		function MoneyManager.get_civilian_deduction() return 0 end
		function MoneyManager.civilian_killed() return end

		-- KILL ALL CIVILIANS
		for u_key,u_data in pairs(managers.enemy:all_civilians()) do
			nukeunit(u_data)
		end
		
		--KILL ALL ENEMIES
		for u_key,u_data in pairs(managers.enemy:all_enemies()) do
			u_data.char_tweak.has_alarm_pager = nil
			nukeunit(u_data)		
		end
		
		-- BAG BODIES
		InteractType({'corpse_dispose'})

		-- DROPS BAG IF CARRYING
		if managers.player:is_carrying() then
			managers.player:drop_carry()
		end	
		
		showHint("Все мертвы",1)
	end
end