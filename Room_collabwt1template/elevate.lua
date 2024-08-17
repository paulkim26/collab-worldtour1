if callType == LuaCallType.Init then
    player = api.getLocalPlayer()
    playerOffsetY = 0.8
    LevelContainer = player.gameObject.Find('LevelContainerEditor')
    if debug then
        LevelContainer = player.gameObject.Find('LevelContainer')
    end
	navMesh = LevelContainer.transform.GetChild(0)
	elevation.transform.parent = navMesh.transform
	initColliders = false
    for i = 0, floors.transform.childCount - 1 do
        local child = floors.transform.GetChild(i)
        child.gameObject.SetActive(false)
    end
    function disableRoomColliders(transform)
        local childCount = transform.childCount
        for i = 0, childCount - 1 do
            local child = transform.GetChild(i)
            if child.name == "_EmptyCeiling(Clone)" or 
               child.name == "_EmptyFloor(Clone)" then
                if child.childCount > 0 then
                    local firstSubChild = child.GetChild(0)
                    firstSubChild.gameObject.SetActive(false)
                end
            end
            if child.childCount > 0 then
                disableRoomColliders(child)
            end
        end
    end
end
if callType == LuaCallType.Update then
    if not initColliders then
		for _, start in pairs(spawn) do
			local distance = Vector3.Distance(player.transform.position, start.transform.position)
			if distance > 0.85 and distance < 1.1 then
                disableRoomColliders(LevelContainer.transform)
				initColliders = true
				break
			end
		end
	end
    local playerY = player.transform.position.y - playerOffsetY
    for i = 0, floors.transform.childCount - 1 do
        local child = floors.transform.GetChild(i)
        local yDiff = math.abs(child.transform.position.y - playerY)
        if yDiff < 1.6 then
            child.gameObject.SetActive(false)
        else
            child.gameObject.SetActive(true)
        end
    end
end
