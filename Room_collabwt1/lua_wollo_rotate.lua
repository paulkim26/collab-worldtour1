if callType == LuaCallType.Init then
	objects = {}

    function clamp(number, min, max)
        return math.max(min, math.min(number, max))
    end
    
    function parseComponent(componentString, valueType)
        local values = {}
        for value in componentString:gmatch("%-?%d+%.?%d*") do
            table.insert(values, tonumber(value))
        end
        if valueType == 'rotation' then
            for i, v in ipairs(values) do
                values[i] = clamp(v, -1, 1)
            end
        elseif valueType == 'speed' then
            for i, v in ipairs(values) do
                values[i] = clamp(v, 1, 5000)
            end
        elseif valueType == 'stopRotation' then
            for i, v in ipairs(values) do
                values[i] = clamp(v, 0, 360)
            end
        elseif valueType == 'increment' then
            for i, v in ipairs(values) do
                values[i] = clamp(v, 0, 360)
            end
        end
    
        return values
    end
    
    function parseInput(input)
        local rotationStr = input:match("rotation:(.-);")
        local speedStr = input:match("speed:(.-);")
        local stopRotationStr = input:match("stopRotation:(.-);")
        local incrementStr = input:match("increment:(.-);")
        local timeStr = input:match("time:(.-);")
        local rotation, speed, stopRotation, increment, time = {}, {}, nil, nil, 0
        if rotationStr then
            rotation = parseComponent(rotationStr, "rotation")
        end
        if speedStr then
            speed = parseComponent(speedStr, "speed")
        end
        if stopRotationStr and #stopRotationStr > 0 then
            stopRotation = parseComponent(stopRotationStr, "stopRotation")
        end
        if incrementStr then
            increment = parseComponent(incrementStr, "increment")
        end
        if timeStr then
            time = clamp(timeStr, 0, 3600)
        end
        return {
            x = rotation[1] or 0, 
            y = rotation[2] or 0, 
            z = rotation[3] or 0
        }, {
            x = speed[1] or 1, 
            y = speed[2] or 1, 
            z = speed[3] or 1
        }, stopRotation and {
            x = stopRotation[1] or 0, 
            y = stopRotation[2] or 0, 
            z = stopRotation[3] or 0
        } or nil, increment and {
            x = increment[1] or 0, 
            y = increment[2] or 0, 
            z = increment[3] or 0
        } or nil, time or 0
    end
    
    function startRotation(objectIndex, targetRot, targetSpeed, stopRotation)
        local found = false
    
        for _, objData in ipairs(objects) do
            if objData.index == objectIndex then
                objData.isRotating = true
                found = true
                break
            end
        end
    
        if not found then
            local rotation, speed, stopRotation, increment, time = parseInput(wollo_rotate[objectIndex].gameObject.GetComponent('Element').elementName)
            table.insert(objects, {
                index = objectIndex,
                originalRotation = wollo_rotate[objectIndex].transform.localRotation,
                targetRotation = rotation,
                targetSpeed = speed,
                stopRotation = stopRotation,
                increment = increment,
                time = time,
                isRotating = true
            })
        end
    end
    
    function stopRotation(objectIndex)
        for _, objData in ipairs(objects) do
            if objData.index == objectIndex then
                if objData.stopRotation then
                    wollo_rotate[objectIndex].transform.localRotation = Quaternion.Euler(objData.stopRotation.x, objData.stopRotation.y, objData.stopRotation.z)
                end
                objData.isRotating = false
                return
            end
        end
    end

    function getIndex(context)
        local element = context.gameObject.GetComponent('Element')
        local index = string.match(element.playerVariableName, "{(%d+)}")
        return tonumber(index)
    end

    function smoothRotate(objectData)
        if not objectData.isRotating and not objectData.slerpStarted then
            return
        end
        if not objectData.increment then
            local rotationX = objectData.targetRotation.x ~= 0 and objectData.targetSpeed.x * Time.deltaTime * objectData.targetRotation.x or 0
            local rotationY = objectData.targetRotation.y ~= 0 and objectData.targetSpeed.y * Time.deltaTime * objectData.targetRotation.y or 0
            local rotationZ = objectData.targetRotation.z ~= 0 and objectData.targetSpeed.z * Time.deltaTime * objectData.targetRotation.z or 0
            wollo_rotate[objectData.index].transform.localRotation = wollo_rotate[objectData.index].transform.localRotation * Quaternion.Euler(rotationX, rotationY, rotationZ)
        else
            if not objectData.slerpStarted then
                incrementRotationX = Quaternion.AngleAxis(objectData.increment.x * objectData.targetRotation.x, Vector3.right)
                incrementRotationY = Quaternion.AngleAxis(objectData.increment.y * objectData.targetRotation.y, Vector3.up)
                incrementRotationZ = Quaternion.AngleAxis(objectData.increment.z * objectData.targetRotation.z, Vector3.forward)
                objectData.toRotation = objectData.originalRotation
                objectData.toRotation = incrementRotationX * objectData.toRotation
                objectData.toRotation = incrementRotationY * objectData.toRotation
                objectData.toRotation = incrementRotationZ * objectData.toRotation
                objectData.slerpStarted = true
                objectData.timeCount = 0
            end
            objectData.timeCount = objectData.timeCount + Time.deltaTime
            local elapsedTime = objectData.timeCount / objectData.time
            wollo_rotate[objectData.index].transform.localRotation = Quaternion.Slerp(objectData.originalRotation, objectData.toRotation, clamp(elapsedTime, 0, 1))
            if elapsedTime >= 1 then
                objectData.isRotating = false
                objectData.slerpStarted = false
                wollo_rotate[objectData.index].transform.localRotation = objectData.toRotation
                objectData.originalRotation = objectData.toRotation
            end
        end
    end
end

if callType == LuaCallType.Update then
    for _, objData in ipairs(objects) do
        if objData then smoothRotate(objData) end
    end
end

if callType == LuaCallType.SwitchDone then
    if api.contains(switch, context) then
        local objectIndex = getIndex(context)
		if context.isOn then
			startRotation(objectIndex)
		elseif not context.bounce then
			stopRotation(objectIndex)
		end
	end
end
