dofile(ModPath .."P3DHack/Head/Config_(P3DGroup).lua")

if P3DGroup_P3DHack.Text then
function MenuNodeMainGui:_setup_item_rows(node)
	MenuNodeMainGui.super._setup_item_rows(self, node)
	if alive(self._version_string) then
		self._version_string:parent():remove(self._version_string)
		self._version_string = nil
	end
	self._version_string = self.ws:panel():text({
		name = "version_string",
		text = "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\P3D Hack BLT v1.3 [Premium]\nvk.com/p3dhack_premium\nNOT Free,It's PRVT",
		font = "fonts/font_medium_noshadow_mf",
		font_size = 25,
		color = Color.White,
		align = SystemInfo:platform() == Idstring("WIN32") and "right",
		vertical = "top",
		alpha = 0.87
	})	
	self._version_string = self.ws:panel():text({
		name = "version_string",
		text = "By: P3D Hack Group",
		font = "fonts/font_medium_noshadow_mf",
		font_size = 25,
		color = Color.White,
		align = SystemInfo:platform() == Idstring("WIN32") and "right",
		vertical = "bottom",
		alpha = 0.90
	})
end
end