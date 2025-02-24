--[[
Author: apa-games (@apa_games)

Summary: Creates an invisible movementSpline between the children of the ballPath{x} variable and moves the ball{x} object along it.
It also slows the ball with time
ballPath{x} name options:
    speed: number

children name options:
    order: number
--]]

if callType == LuaCallType.Init then
    init = false
    
    paths = {}

    function beginPath(path)
        path.currentIndex = 1
        path.currentSpeedFactor = path.pathLength / path.sectorLengths[1]
        path.t = 0
        path.hasStarted = true
        path.lastPos = Vector3.zero
        path.currentDirection = path.nodes[path.currentIndex + 1].position - path.nodes[path.currentIndex].position
    end

    function initialize()
        init = true
        for i, currentPath in ipairs(ballPath) do
            local newPath = {}
            local pathSectorLengths = {}
            local childCount = currentPath.transform.childCount
            local totalLength = 0.0
            
            for j = 0, childCount - 1, 1 do
                local child = currentPath.transform.GetChild(j)
                local element = child.gameObject.GetComponent('Element')
                local orderString = api.getElement(element).elementName:match("order:(.-);")
                local order = tonumber(orderString)
                newPath[order] = child
            end

            for j = 1, childCount - 1, 1 do
                local length = Vector3.Distance(newPath[j].position, newPath[j+1].position)
                table.insert(pathSectorLengths, length)
                totalLength = totalLength + length
            end

            local name = api.getElement(currentPath).elementName
            local speedString = name:match("speed:(.-);")
            table.insert(paths, {
                nodes = newPath,
                nodeCount = childCount,
                sectorLengths = pathSectorLengths,
                pathLength = totalLength,
                index = i, 
                hasStarted = false, 
                currentIndex = -1, 
                t = 0.0,
                speed = tonumber(speedString),
                currentSpeedFactor = 0.0,
                pathingObject = ball[i].transform,
                targetRotation = ball[i].transform.rotation,
                currentDirection = Vector3.forward,
                lastPos = Vector3.zero
            })
        end
    end

    time = 0
end

if callType == LuaCallType.Update then
    if not init then
        return
    end

    --path logic
    for i, path in ipairs(paths) do
        if path.hasStarted then
            if path.t < 1 then
                local inverseEnd = (path.nodeCount - path.t - (path.currentIndex - 1))
                path.t = math.min(path.t + Time.deltaTime * path.speed * path.currentSpeedFactor * inverseEnd / path.nodeCount, 1)
                path.pathingObject.position = Vector3.Lerp(path.nodes[path.currentIndex].position, path.nodes[path.currentIndex + 1].position, path.t)
                path.pathingObject.rotation = Quaternion.AngleAxis(3 * inverseEnd, -Vector3.Cross(path.currentDirection, Vector3.up)) * path.pathingObject.rotation
            end

            if path.t >= 1 then
                path.currentIndex = path.currentIndex + 1
                if path.currentIndex >= path.nodeCount then
                    path.hasStarted = false
                    path.pathingObject.rotation = path.targetRotation
                    path.currentIndex = -1
                else
                    path.t = 0
                    path.currentSpeedFactor = path.pathLength / path.sectorLengths[path.currentIndex]
                    path.currentDirection = path.nodes[path.currentIndex + 1].position - path.nodes[path.currentIndex].position
                end
            end
        end
    end
end

if callType == LuaCallType.SwitchDone then
    --start button
    if context == rollBall then
        for i, path in ipairs(paths) do
            beginPath(path)
        end
    elseif context == beachBall then
        initialize()
    end
end