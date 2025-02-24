--[[
    Author: GG3L (@GGӡL)
    Script: Elevate 2.0
    Description: This script adds vertical navigation functionality to custom levels in the game, allowing players to walk up and down on non-flat surfaces.
    
    Permission is granted to use this script in custom rooms for Escape Simulator, provided that:
    - Credit is given to the author.
    - Neither this header nor the code is modified.

    Unauthorized distribution or modification is prohibited.
    All rights reserved by the author.
]]
if callType == LuaCallType.Init then
    player = api.getLocalPlayer()
    playerOffsetY = 0.8
    function getLevelContainer(transform)
        local currentTransform = spawn[1].transform.parent
        if transform then
            currentTransform = transform.parent
        end
        if currentTransform.name == 'LevelContainer' or currentTransform.name == 'LevelContainerEditor' then
            return spawn[1].gameObject.Find(currentTransform.name)
        else
            return getLevelContainer(currentTransform)
        end
    end
    LevelContainer = getLevelContainer()
	navMesh = LevelContainer.transform.GetChild(0)
	elevation.transform.parent = navMesh.transform
	initColliders = false
    playerMoved = 0
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
        playerMoved = 0
		for _, start in pairs(spawn) do
			local distance = Vector3.Distance(player.transform.position, start.transform.position)
			if distance > 1 then
                playerMoved = playerMoved + 1
			end
		end
        if playerMoved == #spawn then
            disableRoomColliders(LevelContainer.transform)
			initColliders = true
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
