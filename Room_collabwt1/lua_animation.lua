--[[
    Author: GG3L (@GGӡL)
    Script: Animation 2.1
    Description: This script, using the default Animation behavior, adds the ability to do the following:
        - Animate an object’s scale, long side its position and rotation.
        - Choose from a variety of interpolation methods such as quadratic, cubic, and sine easing.
    
    Permission is granted to use this script in custom rooms for Escape Simulator, provided that:
    - Credit is given to the author.
    - Neither this header nor the code is modified.

    Unauthorized distribution or modification is prohibited.
    All rights reserved by the author.
]]
if callType == LuaCallType.Init then
    animations = {}

	function clamp(number, min, max)
        return math.max(min, math.min(number, max))
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

	for _, animation in pairs(animate) do
		local element = animation.gameObject.GetComponent('Element')
		local settings = getSettings(element.elementName:match("%b[]"))
		element.elementName = element.elementName:gsub("%b[]", "", 1)
		table.insert(animations, {
			transform = animation.transform,
			pivot = animation.pivot.transform,
			active = false,
			forward = false,
			duration = animation.duration,
			loop = animation.loop,
			bounce = animation.bounce,
			startTime = 0,
			deltaTime = 0,
			interpolation = settings.interpolation or animation.interpolation,
			target = {
				localPosition = animation.pivot.transform.localPosition,
				localRotation = animation.pivot.transform.localRotation,
				localScale = animation.pivot.transform.localScale
			},
			origin = {
				localPosition = animation.transform.localPosition,
				localRotation = animation.transform.localRotation,
				localScale = animation.transform.localScale
			},
			startTransform = nil
		})
		animation.pivot.transform.localPosition = animation.transform.localPosition
		animation.pivot.transform.localRotation = animation.transform.localRotation
		animation.pivot.transform.localScale = animation.transform.localScale
	end
end

if callType == LuaCallType.SwitchStarted then
	if api.contains(animate, context) then
		local index = getIndex(context)
		animations[index].startTime = Time.time
		animations[index].deltaTime = 0
        if not animations[index].loop or (animations[index].loop and animations[index].bounce) then
            animations[index].forward = not animations[index].forward
        else
            animations[index].forward = true
        end
        if not animations[index].loop or (animations[index].loop and animations[index].bounce) then
            animations[index].startTransform = {
                localPosition = animations[index].pivot.localPosition,
                localRotation = animations[index].pivot.localRotation,
                localScale = animations[index].pivot.localScale
            }
        else
            animations[index].startTransform = {
                localPosition = animations[index].origin.localPosition,
                localRotation = animations[index].origin.localRotation,
                localScale = animations[index].origin.localScale
            }
        end
		animations[index].active = true
	end
end

if callType == LuaCallType.Update then
	for _, animation in pairs(animations) do
		if animation.active then
			animation.deltaTime = animation.deltaTime + Time.deltaTime
			local t = 1
			if animation.duration > 0 then
				t = animation.deltaTime / animation.duration
			end
			local interpolation = interpolation(animation.interpolation, 0, 1, t)

			if interpolation >= 1 and not animation.loop and (animation.bounce and not animation.forward) then
				animation.active = false
			end
			
			local fromPosition = animation.startTransform.localPosition
			local toPosition = animation.target.localPosition

            if (not animation.forward and not animation.loop) or (animation.loop and animation.bounce and not animation.forward) then
				toPosition = animation.origin.localPosition
			end

			animation.pivot.localPosition = Vector3.Lerp(
				fromPosition,
				toPosition,
				interpolation
			)
			animation.transform.localPosition = animation.pivot.localPosition

			local fromRotation = animation.startTransform.localRotation
			local toRotation = animation.target.localRotation
			if not animation.forward then
				toRotation = animation.origin.localRotation
			end
			animation.pivot.localRotation = Quaternion.Slerp(
				fromRotation,
				toRotation,
				interpolation
			)
			animation.transform.localRotation = animation.pivot.localRotation
			
			local fromScale = animation.startTransform.localScale
			local toScale = animation.target.localScale

			if not animation.forward then
				toScale = animation.origin.localScale
			end
			animation.pivot.localScale = Vector3.Lerp(
				fromScale,
				toScale,
				interpolation
			)
			animation.transform.localScale = animation.pivot.localScale
		end
	end
end