if callType == LuaCallType.Init then
    next = 0
    animatePath[5].remoteOnly = false
end

if callType == LuaCallType.SwitchStarted then
    if context == animatePath[5] and not context.isOn then
        animatePath[5].remoteOnly = true
        next = 2
    end
    if context == animatePath[2] and not context.isOn then
        animatePath[2].remoteOnly = true
        next = 4
    end
    if context == animatePath[4] and not context.isOn then
        animatePath[4].remoteOnly = true
        next = 0
    end
end

if callType == LuaCallType.SwitchDone then
    if context == dollTargetToggle then
        if next ~= 0 then
            animatePath[next].remoteOnly = false
        end
    end
end
