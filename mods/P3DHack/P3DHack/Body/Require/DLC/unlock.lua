function SelectiveDlcUnlocker.unlock_dlc(dlc_name)
	if (Global.dlc_manager.all_dlc_data and Global.dlc_manager.all_dlc_data[dlc_name]) then
		Global.dlc_manager.all_dlc_data[dlc_name].verified = true
	end
end

function SelectiveDlcUnlocker:RedoUnlocks()
	for dlc_name, unlock in pairs(SelectiveDlcUnlocker.settings) do
		if unlock == true then
			SelectiveDlcUnlocker.unlock_dlc(string.sub(dlc_name, 8))
		end
	end
end

SelectiveDlcUnlocker:RedoUnlocks()
