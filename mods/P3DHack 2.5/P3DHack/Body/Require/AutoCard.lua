dofile(ModPath .."P3DHack/Head/Config_(P3DGroup).lua")

if P3DGroup_P3DHack.Auto_Pick_Card then
	local init_original = LootDropScreenGui.init
	function LootDropScreenGui:init(...)
		init_original(self, ...)
		self._fade_time_left = 0
		self._time_left = 0
	end

	local update_original = LootDropScreenGui.update
	function LootDropScreenGui:update(...)
		update_original(self, ...)
		if not self._card_chosen then
			self:_set_selected_and_sync(math.random(1,3))
			self:confirm_pressed()
		end
	end
end