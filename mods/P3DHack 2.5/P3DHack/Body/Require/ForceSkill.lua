dofile(ModPath .."P3DHack/Head/Config_(P3DGroup).lua")
dofile(ModPath .."P3DHack/Head/SkillConfig.lua")

if P3DGroup_P3DHack.Force_Skills then	
	local old_init = SkillTreeTweakData.init

	function SkillTreeTweakData:init()
		old_init(self)
		
		self.default_upgrades = P3DGroup_P3DHack_Skill_Config
	end
end