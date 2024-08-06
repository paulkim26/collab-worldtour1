if callType == LuaCallType.Init then
    animObjects = {}
    function getIndex(context)
        local element = context.gameObject.GetComponent('Element')
        local index = string.match(element.playerVariableName, "{(%d+)}")
        return tonumber(index)
    end

    function addAnimObject(context, state)
        local index = getIndex(context)
        local anim = animObjects[index]
        if not anim then
            animObjects[index] = {
                object = context,
                originalScale = context.transform.localScale,
                startScale = context.transform.localScale,
                targetScale = context.pivot.transform.localScale,
                startTime = Time.time,
                duration = context.duration,
				interpolation = context.interpolation,
                loop = context.loop,
                bounce = context.bounce,
                state = state,
				cycle = 0,
                progress = 0,
                restarted = 0
            }
        else
            if anim.state == state then
                anim.restarted = 1
                anim.startTime = Time.time - (anim.progress * anim.duration)
                if not anim.loop then
                    anim.targetScale = anim.originalScale
                end
            else
                anim.progress = 0
                anim.startTime = Time.time
            end
			if state == 'done' and anim.restarted == 0 then
				anim.cycle = anim.cycle + 1
			end
			if state == 'done' and anim.cycle % 2 ~= 0 and anim.restarted == 0 then
                anim.targetScale = anim.originalScale
			elseif state == 'done' and anim.cycle % 2 == 0 and anim.restarted == 0 then
				anim.targetScale = context.pivot.transform.localScale
			end
            if anim.restarted ~= 0 then
                anim.restarted = anim.restarted + 1
                if anim.restarted == 4 and anim.state == 'done' then
                    anim.restarted = 0
                    if not anim.loop then
                        anim.targetScale = context.pivot.transform.localScale
                    end
                end
            end
            anim.startScale = context.transform.localScale
            anim.state = state
            if not anim.bounce and anim.loop then
                anim.object.transform.localScale = anim.originalScale
            end
        end
    end
end

if callType == LuaCallType.SwitchStarted then
    if api.contains(wollo_animScale, context) then
        addAnimObject(context, 'started')
    end
end

if callType == LuaCallType.SwitchDone then
    if api.contains(wollo_animScale, context) then
        addAnimObject(context, 'done')
    end
end

if callType == LuaCallType.Update then
    for index, anim in pairs(animObjects) do
        local timeElapsed = Time.time - anim.startTime
        local fracComplete = timeElapsed / anim.duration
        anim.progress = fracComplete
        if anim.state == 'started' or anim.restarted ~= 0 then
            if fracComplete < 1 then
                local t = fracComplete
                if anim.interpolation == 0 then
                    t = (1 - math.cos(fracComplete * math.pi)) / 2
                end
                anim.object.transform.localScale = Vector3.Lerp(anim.startScale, anim.targetScale, t)
            end
        end
    end
end
