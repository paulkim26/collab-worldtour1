--[[
    Author: GG3L (@GGӡL)
    Script: Path Animation 2.1
    Description: This script, using the default Animation behavior, adds the ability to animate an object along a custom user defined path.
    
    Permission is granted to use this script in custom rooms for Escape Simulator, provided that:
    - Credit is given to the author.
    - Neither this header nor the code is modified.

    Unauthorized distribution or modification is prohibited.
    All rights reserved by the author.
]]
if callType == LuaCallType.Init then
    pathEndThreshold = 0.005
    animations = {}

	function clamp(number, min, max)
        return math.max(min, math.min(number, max))
    end

    function catmullRomSpline(p0, p1, p2, p3, t)
        local t2 = t * t
        local t3 = t2 * t
    
        local a = -0.5 * t3 + t2 - 0.5 * t
        local b = 1.5 * t3 - 2.5 * t2 + 1.0
        local c = -1.5 * t3 + 2.0 * t2 + 0.5 * t
        local d = 0.5 * t3 - 0.5 * t2
    
        return p0 * a + p1 * b + p2 * c + p3 * d
    end

	function quaternionCatmullRomSpline(q0, q1, q2, q3, t)
        local t2 = t * t
        local t3 = t2 * t

        local a = Quaternion.Slerp(Quaternion.identity, q0, -0.5 * t3 + t2 - 0.5 * t)
        local b = Quaternion.Slerp(Quaternion.identity, q1,  1.5 * t3 - 2.5 * t2 + 1.0)
        local c = Quaternion.Slerp(Quaternion.identity, q2, -1.5 * t3 + 2.0 * t2 + 0.5 * t)
        local d = Quaternion.Slerp(Quaternion.identity, q3,  0.5 * t3 - 0.5 * t2)

        return a * b * c * d
    end

	function interpolation(type, from, to, t)
		t = clamp(t, 0, 1)
		local interpolation = {
			[0] = function(t) return t * t * (3 - 2 * t) end,                  -- Default Smooth
			[1] = function(t) return t end,                                    -- Default Linear
			[2] = function(t) return t * t * t * (t * (t * 6 - 15) + 10) end,  -- Default Smoother

			[3] = function(t) return t * t end,                                -- Quadratic Ease In
			[4] = function(t) return 1 - (1 - t) * (1 - t) end,                -- Quadratic Ease Out
			[5] = function(t) return t * t * (3 - 2 * t) end,                  -- Quadratic Ease In Out

			[6] = function(t) return t * t * t end,                            -- Cubic Ease In
			[7] = function(t) return 1 - (1 - t) * (1 - t) * (1 - t) end,      -- Cubic Ease Out
			[8] = function(t) return t * t * t * (t * (t * 6 - 15) + 10) end,  -- Cubic Ease In Out

			[9] = function(t) return 1 - math.cos(t * math.pi / 2) end,        -- Sine Ease In
		   [10] = function(t) return math.sin(t * math.pi / 2) end,            -- Sine Ease Out
		   [11] = function(t) return -math.cos(t * math.pi) / 2 + 0.5 end      -- Sine Ease In Out
		}
		return from + (to - from) * interpolation[type](t)
	end

    function getSettings(input)
		local result = {}
		if not input then
			return result
		end
		input = input:match("%[(.*)%]"):gsub("^%s*(.-)%s*$", "%1")
		input = input:gsub(";?%s*$", "")
		for key, value in input:gmatch("([^:;]+)%s*:%s*([^;]+)") do
			key = key:match("^%s*(.-)%s*$")
			value = value:match("^%s*(.-)%s*$")
			if value == "true" then
				value = true
			elseif value == "false" then
				value = false
			elseif tonumber(value) then
				value = tonumber(value)
			elseif value:match("^'.*'$") or value:match('^".*"$') then
				value = value:sub(2, -2)
			end
			result[key] = value
		end
		return result
	end

	function getIndex(context)
        local element = context.gameObject.GetComponent('Element')
        local index = string.match(element.playerVariableName, "{(%d+)}")
        return tonumber(index)
    end

	for _, animation in pairs(animatePath) do
		local element = animation.gameObject.GetComponent('Element')
		local settings = getSettings(element.elementName:match("%b[]"))
		element.elementName = element.elementName:gsub("%b[]", "", 1)

        local currentAnim = {
			transform = animation.transform,
			pivot = animation.pivot.transform,
			active = false,
            extendFrames = 0,
            lastFrame = false,
			forward = false,
			duration = animation.duration,
			loop = animation.loop,
			startTime = 0,
			deltaTime = 0,
			interpolation = settings.interpolation or animation.interpolation,
            hasPath = false,
            nodes = nil,
            lookAtNext = (settings.lookAtNext == nil) and true or settings.lookAtNext,
			lookTarget = false
		}

        local index = getIndex(animation)

        if path and path[index] then
            currentAnim.hasPath = true
            local nodes = {
                [1] = nil
            }

            for n = 0, path[index].transform.childCount - 1 do
                local node = path[index].transform:GetChild(n)
                local nodeElement = node.gameObject.GetComponent('Element')
                local nodeIndex = tonumber(nodeElement.elementName)
                nodes[nodeIndex + 1] = node
            end

            currentAnim.nodes = nodes
            currentAnim.totalPathLength = 0
        end

		if lookTarget and lookTarget[index] then
			currentAnim.lookTarget = lookTarget[index].transform
		end

        table.insert(animations, currentAnim)

        animation.pivot.transform.position = animation.transform.position
		animation.pivot.transform.rotation = animation.transform.rotation
	end
end

if callType == LuaCallType.SwitchStarted then
	if api.contains(animatePath, context) then
		local index = getIndex(context)
		animations[index].startTime = Time.time
		animations[index].deltaTime = 0
		if animations[index].hasPath then
			if not animations[index].loop or (animations[index].loop and animations[index].bounce) then
				animations[index].forward = not animations[index].forward
			else
				animations[index].forward = true
			end
		else
			animations[index].forward = not animations[index].forward
		end
        if animations[index].hasPath and animations[index].nodes[1] == nil then    
            animations[index].nodes[1] = {
                position = animations[index].transform.position,
                rotation = animations[index].transform.rotation
            }
            for n = 1, #animations[index].nodes - 1 do
                animations[index].totalPathLength = animations[index].totalPathLength + Vector3.Distance(animations[index].nodes[n].position, animations[index].nodes[n + 1].position)
            end
        end
		animations[index].active = true
		animations[index].lastFrame = false
	end
end

if callType == LuaCallType.SwitchDone then
	if api.contains(animatePath, context) then
        local index = getIndex(context)
        animations[index].extendFrames = 500
		animations[index].lastFrame = true
	end
end

if callType == LuaCallType.Update then
	for _, animation in pairs(animations) do
		if animation.active then
            if animation.lastFrame then
                if animation.extendFrames > 0 then
                    animation.extendFrames = animation.extendFrames - 1
                end
                if animation.extendFrames <= 0 then
                    animation.lastFrame = false
                    animation.active = false
                end
            end
			animation.deltaTime = animation.deltaTime + Time.deltaTime
			local t = 1

			if animation.duration > 0 then
				t = animation.deltaTime / animation.duration
			end

			local interpolation = interpolation(animation.interpolation, 0, 1, t)

            if animation.hasPath then
                local totalDistance = interpolation * animation.totalPathLength
                local coveredDistance = 0
                local targetRotation = Quaternion.identity

                if animation.forward then
                    for i = 1, #animation.nodes - 1 do
                        local segmentLength = Vector3.Distance(animation.nodes[i].position, animation.nodes[i + 1].position)

                        if coveredDistance + segmentLength >= totalDistance then
                            local segmentT = (totalDistance - coveredDistance) / segmentLength
                            local p0 = (i > 1) and animation.nodes[i - 1].position or animation.nodes[i].position
                            local p1 = animation.nodes[i].position
                            local p2 = animation.nodes[i + 1].position
                            local p3 = (i < #animation.nodes - 1) and animation.nodes[i + 2].position or animation.nodes[i + 1].position
                            toPosition = catmullRomSpline(p0, p1, p2, p3, segmentT)
                            local posDiff = p2 - animation.pivot.position

                            if posDiff.sqrMagnitude >= pathEndThreshold * pathEndThreshold then
                                if animation.lookAtNext then
									local direction = (toPosition - animation.pivot.position).normalized
									if animation.lookTarget then
										direction = (animation.lookTarget.position - toPosition).normalized
									end
									local lookRotation = Quaternion.LookRotation(direction)
									targetRotation = Quaternion.Slerp(animation.pivot.rotation, lookRotation, segmentT)
                                else
                                    local q0 = (i > 1) and animation.nodes[i - 1].rotation or animation.nodes[i].rotation
                                    local q1 = animation.nodes[i].rotation
                                    local q2 = animation.nodes[i + 1].rotation
                                    local q3 = (i < #animation.nodes - 1) and animation.nodes[i + 2].rotation or animation.nodes[i + 1].rotation
                                    targetRotation = Quaternion.Slerp(q1, q2, segmentT)
                                end
                                animation.pivot.rotation = targetRotation
                            end

                            break
                        end

                        coveredDistance = coveredDistance + segmentLength
                    end
                else
                    for i = #animation.nodes, 2, -1 do
                        local segmentLength = Vector3.Distance(animation.nodes[i].position, animation.nodes[i - 1].position)

                        if coveredDistance + segmentLength >= totalDistance then
                            local segmentT = (totalDistance - coveredDistance) / segmentLength
                            local p0 = (i < #animation.nodes) and animation.nodes[i + 1].position or animation.nodes[i].position
                            local p1 = animation.nodes[i].position
                            local p2 = animation.nodes[i - 1].position
                            local p3 = (i > 2) and animation.nodes[i - 2].position or animation.nodes[i - 1].position
                            toPosition = catmullRomSpline(p0, p1, p2, p3, segmentT)
                            local posDiff = p2 - animation.pivot.position

                        	if posDiff.sqrMagnitude >= pathEndThreshold * pathEndThreshold then
                                if animation.lookAtNext then
									local direction = (toPosition - animation.pivot.position).normalized
									if animation.lookTarget then
										direction = (animation.lookTarget.position - toPosition).normalized
									end
									local lookRotation = Quaternion.LookRotation(direction)
									targetRotation = Quaternion.Slerp(animation.pivot.rotation, lookRotation, segmentT)
                                else
                                    local q0 = (i < #animation.nodes) and animation.nodes[i + 1].rotation or animation.nodes[i].rotation
                                    local q1 = animation.nodes[i].rotation
                                    local q2 = animation.nodes[i - 1].rotation
                                    local q3 = (i > 2) and animation.nodes[i - 2].rotation or animation.nodes[i - 1].rotation
                                    targetRotation = Quaternion.Slerp(q1, q2, segmentT)
                                end
                                animation.pivot.rotation = targetRotation
                            end

                            break
                        end

                        coveredDistance = coveredDistance + segmentLength
                    end
                end

                animation.pivot.position = toPosition
                animation.transform.position = animation.pivot.position
                animation.transform.rotation = animation.pivot.rotation
            end
		end
	end
end
