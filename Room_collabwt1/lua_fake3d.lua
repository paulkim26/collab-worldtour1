if callType == LuaCallType.Init then
    camera = transform.gameObject.FindGameObjectWithTag('MainCamera')
end
if callType == LuaCallType.Update then
    for _, f3d in pairs(fake3d) do
        local direction = camera.transform.position - f3d.transform.position
        direction.y = 0
        f3d.transform.rotation = Quaternion.LookRotation(direction)
    end
end