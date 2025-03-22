--[[
    Author: GG3L (@GGӡL)
    Script: Rotate 2.0
    Description: This script adds the ability to rotate any object on one or more axes, with the possibility to control the amount and duration.
    
    Permission is granted to use this script in custom rooms for Escape Simulator, provided that:
    - Credit is given to the author.
    - Neither this header nor the code is modified.

    Unauthorized distribution or modification is prohibited.
    All rights reserved by the author.
]]
if callType == LuaCallType.Init then
    objects = {}
    function clamp(number, min, max)
        return math.max(min, math.min(number, max))
    end
    function clampAngle(angle)
        return (angle + 360) % 360
    end
    function parseInput(input)
        local incrementStr = input:match("increment:(.-);")
        local timeStr = input:match("time:(.-);")
        local loopStr = input:match("loop:(.-);")
        local increment = {0, 0, 0}
        if incrementStr then
            for i, v in ipairs({incrementStr:match("(%-?%d+%.?%d*),%s*(%-?%d+%.?%d*),%s*(%-?%d+%.?%d*)")}) do
                increment[i] = clamp(tonumber(v) or 0, -360, 360)
            end
        end
        local time = clamp(tonumber(timeStr) or 0, 0, 3600)
        local loop = clamp(tonumber(loopStr) or 0, 0, 1) == 1
        return {x = increment[1], y = increment[2], z = increment[3]}, time, loop
    end
    function startRotation(objectIndex)
        local found = false
        for _, objData in ipairs(objects) do
            if objData.index == objectIndex then
                if not objData.isRotating then
                    objData.isRotating = true
                    objData.elapsedTime = 0
                    objData.startRotation = rotate[objectIndex].transform.localEulerAngles
                end
                found = true
                break
            end
        end
        if not found then
            local inputStr = rotate[objectIndex].gameObject.GetComponent('Element').elementName
            local increment, time, loop = parseInput(inputStr)
            table.insert(objects, {
                index = objectIndex,
                initRotation = rotate[objectIndex].transform.localEulerAngles,
                startRotation = rotate[objectIndex].transform.localEulerAngles,
                increment = increment,
                time = time,
                elapsedTime = 0,
                loop = loop,
                isRotating = true
            })
        end
    end
    function stopRotation(objectIndex)
        for _, objData in ipairs(objects) do
            if objData.index == objectIndex then
                objData.isRotating = false
                return
            end
        end
    end
    function resetRotation(objectIndex)
        for _, objData in ipairs(objects) do
            if objData.index == objectIndex then
                objData.isRotating = false
                rotate[objectIndex].transform.localRotation = Quaternion.Euler(objData.initRotation)
                rotateSwitch[objectIndex].switchActive = false
                rotateSwitch[objectIndex].isOn = false
                rotateSwitch[objectIndex].goalIsOn = false
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
        if not objectData.isRotating then
            return
        end
        objectData.elapsedTime = objectData.elapsedTime + Time.deltaTime
        local t = clamp(objectData.elapsedTime / objectData.time, 0, 1)
        local transform = rotate[objectData.index].transform
        transform.localEulerAngles = api.vector3(
            clampAngle(objectData.startRotation.x + t * objectData.increment.x),
            clampAngle(objectData.startRotation.y + t * objectData.increment.y),
            clampAngle(objectData.startRotation.z + t * objectData.increment.z)
        )
        if t >= 1 then
            if objectData.loop then
                objectData.elapsedTime = 0
                objectData.startRotation = transform.localEulerAngles
            else
                objectData.isRotating = false
            end
        end
    end
end
if callType == LuaCallType.Update then
    for _, objData in ipairs(objects) do
        smoothRotate(objData)
    end
end
if callType == LuaCallType.SwitchDone then
    if api.contains(rotateSwitch, context) then
        local objectIndex = getIndex(context)
        if context.isOn then
            startRotation(objectIndex)
        elseif not context.bounce then
            stopRotation(objectIndex)
        end
    end
    if api.contains(rotateResetSwitch, context) and context.isOn then
        local objectIndex = getIndex(context)
        resetRotation(objectIndex)
    end
end
