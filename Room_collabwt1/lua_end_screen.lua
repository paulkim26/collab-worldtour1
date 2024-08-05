if callType == LuaCallType.Init then
	active = false
	camera = transform.gameObject.FindGameObjectWithTag('MainCamera')
end
if callType == LuaCallType.Unlock then
	if context == endLock and context.unlocked then
		active = true
	end
end
if callType == LuaCallType.Update then
	if active then
		endScreen.transform.rotation = camera.transform.rotation
	end
end