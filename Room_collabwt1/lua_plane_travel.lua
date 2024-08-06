if callType == LuaCallType.Init then
    function getLevelContainer(transform)
		local currentTransform = toggleUI.transform.parent
		if transform then
			currentTransform = transform.parent
		end
		if currentTransform.name == 'LevelContainer' or currentTransform.name == 'LevelContainerEditor' then
			return toggleUI.gameObject.Find(currentTransform.name)
		else
			return getLevelContainer(currentTransform)
		end
	end
	levelContainer = getLevelContainer()
	navMesh = levelContainer.transform.GetChild(0)
end
if callType == LuaCallType.SwitchStarted then
    if context == toggleUI then
		navMesh.gameObject.SetActive(false)
	end
end
if callType == LuaCallType.SwitchDone then
    if context == toggleUI then
		navMesh.gameObject.SetActive(true)
	end
end