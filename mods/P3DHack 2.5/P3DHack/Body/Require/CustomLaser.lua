dofile(ModPath .."P3DHack/Head/Config_(P3DGroup).lua")

-- WEAPON LASER COLOR CHANGER
if P3DGroup_P3DHack.Weapon_Laser then	
	local laser_color = P3DGroup_P3DHack.Weapon_Laser_Color

	local orig_init = WeaponLaser.init
	function WeaponLaser:init(unit)
		orig_init(self, unit)	
		self._themes.custom_laser = {light = laser_color*10, glow = laser_color, brush = laser_color:with_alpha(0.8)}
		self:set_color_by_theme("custom_laser")
	end
end