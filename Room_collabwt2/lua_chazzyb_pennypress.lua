if callType == LuaCallType.Init then
	dial = crankDial.gameObject.GetComponent('Dial')
	dial.soundTurn = 'event:/SFX/VICTORIAN/VICTORIAN2/CLOCK/clockTickMove'
	dial.soundTurnHotspot = 'event:/ROOM EDITOR/Locks/Comb Lock 01'
	dial.soundOnEveryValue = true
	dial.soundOnPoints = true
	dial.controllerRotationSpeed = 4
	end
if callType == LuaCallType.DialMoved then
	if context == crankDial then
		selectorGear.transform.localEulerAngles = api.vector3(0, 180, crankDial.currentAngle*0.0625)
		secondaryGear.transform.localEulerAngles = api.vector3(0, 180, crankDial.currentAngle*-0.33)
		makerGear1.transform.localEulerAngles = api.vector3(crankDial.currentAngle*-0.0625, 270, 0)
		makerGear2.transform.localEulerAngles = api.vector3(crankDial.currentAngle*0.0625, 270, 0)
	end
end