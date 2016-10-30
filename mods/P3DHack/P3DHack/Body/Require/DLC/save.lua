_G.SelectiveDlcUnlocker = {}
SelectiveDlcUnlocker.path = ModPath
SelectiveDlcUnlocker.settings_path = SavePath .. "SelectiveDlcUnlocker.json"
SelectiveDlcUnlocker.settings = {} 

function SelectiveDlcUnlocker.get_settings_key(dlc_name)
	return "unlock_" .. tostring(dlc_name)
end

function SelectiveDlcUnlocker.get_loc_key(dlc_name)
	return "selective_dlc_unlocker_" .. tostring(dlc_name)
end

function SelectiveDlcUnlocker:Save()
	local file = io.open(self.settings_path, "w+")
	if file then
		file:write(json.encode(self.settings))
		file:close()
	end
end

function SelectiveDlcUnlocker:Load()
	local file = io.open(self.settings_path, "r")
	if file then
		self.settings = json.decode(file:read("*all"))
		file:close()
	end
end

function SelectiveDlcUnlocker:AddAllDlcs()
	for name, data in pairs(Global.dlc_manager.all_dlc_data) do
		local key = self.get_settings_key(name)
		self.settings[key] = self.settings[key] or data.verified or false
	end
end

SelectiveDlcUnlocker:Load()
SelectiveDlcUnlocker:AddAllDlcs()
SelectiveDlcUnlocker:Save()

Hooks:Add("LocalizationManagerPostInit", "LocalizationManagerPostInit_SelectiveDlcUnlocker", function(loc)
	loc:load_localization_file(SelectiveDlcUnlocker.path .. "P3DHack/Body/Require/DLC/en.json")
	
	local string_table = {}
	for name, _ in pairs(Global.dlc_manager.all_dlc_data) do
		string_table[SelectiveDlcUnlocker.get_loc_key(name)] = name
	end
	loc:add_localized_strings(string_table, false)
end)
