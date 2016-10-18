-- GRENADE RESTRICTION
function restrictgrenade()	
	local PlayerManager_Can_Throw_Grenade_Original = PlayerManager.can_throw_grenade
	function PlayerManager:can_throw_grenade()
		if managers.groupai:state():whisper_mode() then
			return false
		else
			return PlayerManager_Can_Throw_Grenade_Original(self)
		end 
	end
	
	local UnitNetworkHandler_Server_Throw_Grenade_Original = UnitNetworkHandler.server_throw_grenade
	function UnitNetworkHandler:server_throw_grenade(grenade_type, position, dir, sender)    
		if managers.groupai:state():whisper_mode() then
			return
		end
		return UnitNetworkHandler_Server_Throw_Grenade_Original(self, grenade_type, position, dir, sender)
	end 
end	