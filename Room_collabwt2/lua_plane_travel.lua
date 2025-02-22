if callType == LuaCallType.Init then
    function getLevelContainer(transform)
        local currentTransform = toggleUI[1].transform.parent
        if transform then
            currentTransform = transform.parent
        end
        if currentTransform.name == 'LevelContainer' or currentTransform.name == 'LevelContainerEditor' then
            return toggleUI[1].gameObject.Find(currentTransform.name)
        else
            return getLevelContainer(currentTransform)
        end
    end

    LevelContainer = getLevelContainer()
    navMesh = LevelContainer.transform.GetChild(0)
end

if callType == LuaCallType.SwitchStarted then
    if context == toggleUI[1] then
        navMesh.gameObject.SetActive(false)
    end
end

if callType == LuaCallType.SwitchDone then
    if context == toggleUI[1] then
        navMesh.gameObject.SetActive(true)
    end
end
