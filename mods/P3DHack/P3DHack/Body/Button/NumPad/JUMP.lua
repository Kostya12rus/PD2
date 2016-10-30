	-- GOD MODE TOGGLE
	--function Jump()
		Toggle.Jump = not Toggle.Jump
			
		-- Jump OFF
		if not Toggle.Jump then
		-- Jump OFF
		function PlayerStandard:_perform_jump(jump_vec)
		local v = math.UP * 470
		if self._running then
		v = math.UP * 470 * 1
		end
		self._unit:mover():set_velocity( v )
		end
		ChatMessage('Выключено', 'Высокий прыжок')
		return
		end
		-- Jump ON
		function PlayerStandard:_perform_jump(jump_vec)
		local v = math.UP * 470
		if self._running then
		v = math.UP * 470 * 2
		end
		self._unit:mover():set_velocity( v )
		end
		ChatMessage('Включено', 'Высокий прыжок')
	--end