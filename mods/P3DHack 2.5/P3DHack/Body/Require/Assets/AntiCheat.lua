function anticheat()			
	if isHost() then
		Toggle.disanticheat = not Toggle.disanticheat
		
		if not Toggle.disanticheat then
			backuper:restore('PlayerManager.verify_carry')
			backuper:restore('PlayerManager.verify_equipment')
			backuper:restore('PlayerManager.verify_grenade')
			backuper:restore('PlayerManager.register_grenade')
			backuper:restore('PlayerManager.register_carry')
			backuper:restore('UnitNetworkHandler.place_deployable')
			backuper:restore('LootManager.get_secured_bonus_bags_value')
			tweak_data.money_manager.max_small_loot_value = 2800000
			ChatMessage('Включен', 'Анти-Чит')
			return
		end
		
		backuper:backup('PlayerManager.verify_carry')
		function PlayerManager:verify_carry(peer, carry_id) return true end
		
		backuper:backup('PlayerManager.verify_equipment')
		function PlayerManager:verify_equipment(peer, equipment_id) return true end
		
		backuper:backup('PlayerManager.verify_grenade')
		function PlayerManager:verify_grenade(peer) return true end	
		
		backuper:backup('PlayerManager.register_grenade')
		function PlayerManager:register_grenade(peer) return true end
		
		backuper:backup('PlayerManager.register_carry')
		function PlayerManager:register_carry(peer, carry_id) return true end
		
		backuper:backup('UnitNetworkHandler.place_deployable')
		function UnitNetworkHandler:place_deployable(class_name, pos, rot, upgrade_lvl, rpc) return true end
		
		-- REVOME SMALL LOOT CAP
		tweak_data.money_manager.max_small_loot_value = 9999999999999999
		
		-- ANTI PAYOUT CAP by LazyOzzy and hejoro (EDITED TO ALLOW TRULY ALLOW UNLIMITED BAGS)
		backuper:backup('LootManager.get_secured_bonus_bags_value')
		local LootManager_get_secured_bonus_bags_value = LootManager.get_secured_bonus_bags_value
		function LootManager:get_secured_bonus_bags_value(level_id, is_vehicle)
			local mandatory_bags_amount = self._global.mandatory_bags.amount or 0
			local value = 0
			for _,data in ipairs( self._global.secured ) do
				if not tweak_data.carry.small_loot[data.carry_id] and not tweak_data.carry[data.carry_id].is_vehicle == not is_vehicle then
					if mandatory_bags_amount > 0 and (self._global.mandatory_bags.carry_id == "none" or self._global.mandatory_bags.carry_id == data.carry_id) then
						mandatory_bags_amount = mandatory_bags_amount - 1
					end
					value = value + managers.money:get_bag_value(data.carry_id, data.multiplier)
				end	
			end
			return value
		end
		
		ChatMessage('Выключен', 'Анти-Чит')
	end 
end