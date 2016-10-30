dofile(ModPath .."P3DHack/Head/Config_(P3DGroup).lua")

-- BULLET PENETRATION ALL WEAPONS
if P3DGroup_P3DHack.Bullet_Penetration then	
	local old_init = WeaponTweakData.init

	function WeaponTweakData:init(tweak_data)
		old_init(self, tweak_data)
		
		for k,v in pairs(self) do
			if type(v) == "table" and v.category then
				self[k].can_shoot_through_shield = P3DGroup_P3DHack.Bullet_Penetration_Shield
				self[k].can_shoot_through_enemy = P3DGroup_P3DHack.Bullet_Penetration_Enemy
				self[k].can_shoot_through_wall = P3DGroup_P3DHack.Bullet_Penetration_Wall
			end	
		end 
	end 
end