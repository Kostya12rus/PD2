dofile(ModPath .."P3DHack/Head/Config_(P3DGroup).lua")

-- FREE ASSETS
if P3DGroup_P3DHack.Free_Assets then	
	function MoneyManager:get_mission_asset_cost()
		return 0
	end

	function MoneyManager:get_mission_asset_cost_by_stars(stars)
		return 0
	end

	function MoneyManager:get_mission_asset_cost_by_id(id)
		return 0
	end
end

-- FREE CONTRACTS
if P3DGroup_P3DHack.Free_Contracts then	
	function MoneyManager:get_cost_of_premium_contract(job_id, difficulty_id)
		return 0
	end
end

-- FREE SKILLS
if P3DGroup_P3DHack.Free_Skills then
	function MoneyManager:get_skillpoint_cost(tree, tier, points)
		return 0
	end
end

-- FREE WEAPONS
if P3DGroup_P3DHack.Free_Weapons then
	function MoneyManager:get_weapon_price(weapon_id)
		return 0
	end
	
	function MoneyManager:get_weapon_price_modified(weapon_id)
		return 0
	end
end

-- FREE WEAPON MODS
if P3DGroup_P3DHack.Free_Weapon_Mods then	
	function MoneyManager:get_weapon_modify_price(weapon_id, part_id, global_value)
		return 0
	end
end

-- FREE SLOTS
if P3DGroup_P3DHack.Free_Slots then
	function MoneyManager:get_buy_mask_slot_price()
		return 0
	end

	function MoneyManager:get_buy_weapon_slot_price()
		return 0
	end
end

-- FREE CASINO
if P3DGroup_P3DHack.Free_Casino then	
	function MoneyManager:get_cost_of_casino_entrance()
		return 0
	end

	function MoneyManager:get_cost_of_casino_fee(secured_cards, increase_infamous, preferred_card)
		return 0
	end
end

-- FREE PREPLANNING
if P3DGroup_P3DHack.Free_PrePlanning then	
	function MoneyManager:get_preplanning_type_cost(type)
		return 0
	end
end

-- FREE MASKS
if P3DGroup_P3DHack.Free_Masks then	
	function MoneyManager:get_mask_part_price_modified(category, id, global_value, mask_id)
		return 0 
	end

	function MoneyManager:get_mask_crafting_price_modified(mask_id, global_value, blueprint, default_blueprint)
		return 0
	end
end