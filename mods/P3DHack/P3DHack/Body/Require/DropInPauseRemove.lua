-- DROPIN PAUSE REMOVED
if P3DGroup_P3DHack.Dropin_Pause_Remove then	
	if string.lower(RequiredScript) == "lib/network/networkgame" then
		function NetworkGame:load(game_data)
			if managers.network:session():is_client() and managers.network:session():server_peer() then
				Network:set_client(managers.network:session():server_peer():rpc())
			end
			if game_data then
				for k, v in pairs(game_data.members) do
					self._members[k] = NetworkMember:new()
					self._members[k]:load(v)
				end
			end
		end	

		function NetworkGame:on_drop_in_pause_request_received(peer_id, nickname, state)
			print( "[NetworkGame:on_drop_in_pause_request_received]", peer_id, nickname, state )
			local status_changed = false
			local is_playing = BaseNetworkHandler._gamestate_filter.any_ingame_playing[ game_state_machine:last_queued_state_name() ]
			if state then
				if not managers.network:session():closing() then
					status_changed = true
					self._dropin_pause_info[ peer_id ] = nickname
				end
			elseif self._dropin_pause_info[ peer_id ] then
				status_changed = true
				if peer_id == managers.network:session():local_peer():id() then
					self._dropin_pause_info[ peer_id ] = nil
					managers.menu:close_person_joining( peer_id )
				else
					self._dropin_pause_info[ peer_id ] = nil
					managers.menu:close_person_joining( peer_id )
				end	
			end
			
			if status_changed then
				if state then
					if not managers.network:session():closing() then
						if table.size( self._dropin_pause_info ) == 1 then
						end
						if Network:is_client() then
							managers.network:session():send_to_host( "drop_in_pause_confirmation", peer_id )
						end
					elseif not next( self._dropin_pause_info ) then
						print( "DROP-IN UNPAUSE" )
					else
						print( "MAINTAINING DROP-IN UNPAUSE. # dropping peers:", table.size( self._dropin_pause_info ) )
					end	
				end	
			end	
		end
	end
	
	if string.lower(RequiredScript) == "lib/network/base/basenetworksession" then
		function BaseNetworkSession:on_drop_in_pause_request_received(peer_id, nickname, state)
			print("[BaseNetworkSession:on_drop_in_pause_request_received]", peer_id, nickname, state)
			local status_changed = false
			local is_playing = BaseNetworkHandler._gamestate_filter.any_ingame_playing[game_state_machine:last_queued_state_name()]
			if state then
				if not self:closing() then
					status_changed = true
					self._dropin_pause_info[peer_id] = nickname
				end
			elseif self._dropin_pause_info[peer_id] then
				status_changed = true
				if peer_id == self._local_peer:id() then
					self._dropin_pause_info[peer_id] = nil
					managers.menu:close_person_joining(peer_id)
				else
					self._dropin_pause_info[peer_id] = nil
					managers.menu:close_person_joining(peer_id)
				end
			end
			if status_changed then
				if state then
					if not self:closing() then
						if table.size(self._dropin_pause_info) == 1 then
							print("DROP-IN PAUSE")
							SoundDevice:set_rtpc("ingame_sound", 0)
							local peer = self:peer(peer_id)
							if is_playing and peer and 0 < peer:rank() then
								managers.hud:post_event("infamous_player_join_stinger")
							end
						end
						if Network:is_client() then
							self:send_to_host("drop_in_pause_confirmation", peer_id)
						end
					end
				elseif not next(self._dropin_pause_info) then
					print("DROP-IN UNPAUSE")
					SoundDevice:set_rtpc("ingame_sound", 1)
				else
					print("MAINTAINING DROP-IN UNPAUSE. # dropping peers:", table.size(self._dropin_pause_info))
				end
			end
		end
	end
end