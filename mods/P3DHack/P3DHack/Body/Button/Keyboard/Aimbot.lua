if inGame() and isPlaying() then
    SDSA_IsActivated = not SDSA_IsActivated
    local SDSA_FoundTarget = false
    local SDSA_TargetDir = Vector3()
	if SDSA_IsActivated then
            managers.hud:show_hint( { text = "AIMBOT ON" } )
		else
            managers.hud:show_hint( { text = "AIMBOT OFF" } )
        end
 
    if mvector3 then
        local SDST_Orig_mvector3_spread = mvector3.spread
        function mvector3.spread(Direction, Spread)
            if SDSA_IsActivated and SDSA_FoundTarget then
                mvector3.set(Direction, SDSA_TargetDir)
                SDSA_FoundTarget = false
                return SDST_Orig_mvector3_spread(Direction, 0)
            else
                return SDST_Orig_mvector3_spread(Direction, Spread)
            end
        end
    end
 
    function SDSA_SilverAim(ThisPtr, t, input)
        if SDSA_IsActivated and managers and managers.enemy and ThisPtr._ext_camera and ThisPtr._equipped_unit and ThisPtr._equipped_unit:base() and not ThisPtr:_is_reloading() and not ThisPtr:_changing_weapon() and not ThisPtr:_is_meleeing() and not ThisPtr._use_item_expire_t and not ThisPtr:_interacting() and not ThisPtr:_is_throwing_grenade() then
            for k, MyUnitBase in pairs(managers.enemy:all_enemies()) do 
                if MyUnitBase.unit and alive(MyUnitBase.unit) and not MyUnitBase.is_converted and not isHostage(MyUnitBase.unit) and MyUnitBase.unit:movement() and MyUnitBase.unit:movement():m_head_pos() then
                    local MyEye = Vector3()
                    local MyTarget = Vector3()
                    mvector3.set(MyEye, ThisPtr._ext_camera:position())
                    mvector3.set(MyTarget, MyUnitBase.unit:movement():m_head_pos())
                    if not World:raycast("ray", MyEye, MyTarget, "slot_mask", managers.slot:get_mask("AI_visibility"), "ray_type", "ai_vision") then
                        local MyRay = World:raycast("ray", MyEye, MyTarget, "slot_mask", ThisPtr._equipped_unit:base()._bullet_slotmask, "ignore_unit", ThisPtr._equipped_unit:base()._setup.ignore_units)
                        if MyRay and MyRay.unit and MyRay.body then
                            if MyRay.unit:character_damage() and MyRay.unit:character_damage().is_head and MyRay.unit:character_damage():is_head(MyRay.body) or (MyRay.unit:base() and MyRay.unit:base()._tweak_table == "tank") then
                                mvector3.set(SDSA_TargetDir, MyTarget)
                                mvector3.subtract(SDSA_TargetDir, MyEye)                              
                                SDSA_FoundTarget = true
                                break
                            end
                        end
                    end
                end
            end
        end
    end
 
    if PlayerStandard then
        local SDSP_Orig_PlayerStandard_check_action_primary_attack = PlayerStandard._check_action_primary_attack
        
        function PlayerStandard:_check_action_primary_attack(t, input)
            if SDSA_IsActivated then
                SDSA_SilverAim(self, t, input)
                return SDSP_Orig_PlayerStandard_check_action_primary_attack(self, t, input)
            else
                return SDSP_Orig_PlayerStandard_check_action_primary_attack(self, t, input)
            end
        end
    end
end