--[[
    Author: GG3L (@GGӡL)
    Script: Free Cam
    Description: This script adds the ability to move the camera without restrictions.

    Permission is granted to use this script in custom rooms for Escape Simulator, provided that:
    - Credit is given to the author.
    - Neither this header nor the code is modified.

    Unauthorized distribution or modification is prohibited.
    All rights reserved by the author.
]]
if callType == LuaCallType.Init then
	initScript = false
	characterModels = {}
	freeCams = {}
	player = api.getLocalPlayer()
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
    mainCamera = player.gameObject.FindGameObjectWithTag('MainCamera')
	function initCharacterModels()
		local cm = player.gameObject.Find('CharacterModels')
		if cm then
			table.insert(characterModels, cm.gameObject)
			cm.transform.name = 'done'
			initCharacterModels()
		end
	end

	function initFreeCams()
		for i, fc in ipairs(followFC) do
			table.insert(freeCams, i, {
				followTarget = followFC[i],
				endTarget = endFC[i],
				active = false
			})
		end
	end

	function getIndex(context)
        local element = context.gameObject.GetComponent('Element')
        local index = string.match(element.playerVariableName, "{(%d+)}")
        return tonumber(index)
    end

	function toggleCharacterModels(state)
		for _, cm in ipairs(characterModels) do
			cm.SetActive(state)
		end
	end

	function adjustAngle(current, target)
		local difference = target - current
		if difference > 180 or target > 180 then
			target = target - 360
		elseif difference < -180 or target < -180 then
			target = target + 360
		end
		return target
	end

	initCharacterModels()
	initFreeCams()
end

if callType == LuaCallType.SwitchDone then
	if api.contains(startFC, context) then
		local index = getIndex(context)
		toggleCharacterModels(false)
		freeCams[index].followTarget = followFC[index]
        freeCams[index].endTarget = endFC[index] or {
            transform = {
                position = player.transform.position,
                eulerAngles = mainCamera.transform.eulerAngles
            }
        }
		navMesh.gameObject.SetActive(false)
		freeCams[index].active = true
	end

	if api.contains(stopFC, context) then
		local index = getIndex(context)
		toggleCharacterModels(true)
		freeCams[index].active = false
		api.teleportPlayer(player, freeCams[index].endTarget.transform.position, freeCams[index].endTarget.transform.eulerAngles)
		navMesh.gameObject.SetActive(true)
	end
end

if callType == LuaCallType.Update then
	for _, fc in pairs(freeCams) do
		if fc.active then
			local rotationEuler = api.vector3(
				adjustAngle(mainCamera.transform.eulerAngles.x, fc.followTarget.transform.eulerAngles.x),
				adjustAngle(mainCamera.transform.eulerAngles.y, fc.followTarget.transform.eulerAngles.y),
				adjustAngle(mainCamera.transform.eulerAngles.z, fc.followTarget.transform.eulerAngles.z)
			)
			api.teleportPlayer(player, api.vector3(
				fc.followTarget.transform.position.x,
				fc.followTarget.transform.position.y - 1.6,
				fc.followTarget.transform.position.z
			), rotationEuler)
		end
	end
end
