if callType == LuaCallType.Update then

	valveRot1 = var_poland_valve1.transform.localEulerAngles
	valveRot2 = var_poland_valve2.transform.localEulerAngles
	valveRot3 = var_poland_valve3.transform.localEulerAngles
	
	var_poland_xray1.transform.rotation = Quaternion.Euler(valveRot1.z, 113.4, 0.0)
	var_poland_xray2.transform.rotation = Quaternion.Euler(valveRot2.z, 113.4, 0.0)
	var_poland_xray3.transform.rotation = Quaternion.Euler(valveRot3.z, 113.4, 0.0)
end