if P3DGroup_P3DHack.Ammo_Replenish then	
	if isPlaying() and not inChat() then
		-- REPLENISH AMMO
		for id,weapon in pairs(managers.player:player_unit():inventory():available_selections()) do
			if alive(weapon.unit) then
				weapon.unit:base():replenish()
				managers.hud:set_ammo_amount( id, weapon.unit:base():ammo_info() )
			end 
		end
		showHint("Патроны пополнены",2)
	end
end
