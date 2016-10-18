dofile(ModPath .."P3DHack/Head/Config_(P3DGroup).lua")
if P3DGroup_P3DHack.Favors then
function PrePlanningManager:get_current_budget()
    -- num_spent, num_available
    return 0, 69
end

function PrePlanningManager:can_reserve_mission_element(type, peer_id)
    return true, 4
end
end