if callType == LuaCallType.Init then
    intensity = 0.1
    for _, zoom in pairs(wollo_lowZoomLight) do
        local elm = zoom.gameObject.GetComponent('Element')
        elm.lightStrengthMultiplier = intensity
    end
end