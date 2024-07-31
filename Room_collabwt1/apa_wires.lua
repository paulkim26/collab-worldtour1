if callType == LuaCallType.Init then
    dist = {}
    startingScale = {}
    for i, wire in ipairs(apa_wires) do
        dist[i] = Vector3.Distance(wire.transform.position, apa_wireTargets[i].transform.position)
        startingScale[i] = wire.transform.GetChild(0).localScale.y
    end
elseif callType == LuaCallType.Update then
    for i, wire in ipairs(apa_wires) do
        local dir = apa_wireTargets[i].transform.position - wire.transform.position
        local distance = Vector3.Distance(wire.transform.position, apa_wireTargets[i].transform.position)
        wire.transform.rotation = Quaternion.LookRotation(dir)
        wire.transform.GetChild(0).localScale = api.vector3(1,startingScale[i] * distance / dist[i],1)
    end
end