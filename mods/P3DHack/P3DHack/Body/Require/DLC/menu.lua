local menu_id = "selective_dlc_unlocker_menu"

Hooks:Add("MenuManagerSetupCustomMenus", "MenuManagerSetupCustomMenus_SelectiveDlcUnlocker", function(menu_manager, nodes)
	MenuHelper:NewMenu(menu_id)
end)

MenuCallbackHandler.callback_selective_dlc_unlocker_toggle = function(self, item)
	SelectiveDlcUnlocker.settings[item:name()] = (item:value() == "on")
	SelectiveDlcUnlocker:Save()
	SelectiveDlcUnlocker:RedoUnlocks()
end

Hooks:Add("MenuManagerPopulateCustomMenus", "MenuManagerPopulateCustomMenus_SelectiveDlcUnlocker", function(menu_manager, nodes)
	for name, _ in pairs(Global.dlc_manager.all_dlc_data) do
		MenuHelper:AddToggle({
			id = SelectiveDlcUnlocker.get_settings_key(name),
			title = SelectiveDlcUnlocker.get_loc_key(name),
			desc = "",
			callback = "callback_selective_dlc_unlocker_toggle",
			value = SelectiveDlcUnlocker.settings[SelectiveDlcUnlocker.get_settings_key(name)],
			menu_id = menu_id
		})
	end
end)

Hooks:Add("MenuManagerBuildCustomMenus", "MenuManagerBuildCustomMenus_SelectiveDlcUnlocker", function(menu_manager, nodes)
	nodes[menu_id] = MenuHelper:BuildMenu(menu_id)
	MenuHelper:AddMenuItem(MenuHelper:GetMenu("lua_mod_options_menu"), menu_id, "selective_dlc_unlocker_menu_name", "selective_dlc_unlocker_menu_desc")
end)
