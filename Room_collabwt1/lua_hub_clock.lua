if callType == LuaCallType.Init then
	clocks = {}

	function getIndex(context)
        local element = context.gameObject.GetComponent('Element')
        local index = string.match(element.playerVariableName, "{(%d+)}")
        return tonumber(index)
    end

	function setHandRotation(hand, rotation)
		if hand then
			hand.transform.rotation = rotation
		end
	end

	for _, clk in ipairs(clock) do
		local element = clk.gameObject.GetComponent('Element')
		local seconds = 0
		if element.elementName ~= '' then
			local hours, minutes = string.match(element.elementName, "(%d+):(%d+)")
			seconds = (hours * 3600) + (minutes * 60)
		end
		table.insert(clocks, {
			active = false,
			seconds = seconds,
			last = 0
		})
	end
end

if callType == LuaCallType.SwitchDone then
	if api.contains(clockToggle, context) and context.isOn then
		local index = getIndex(context)
		clocks[index].last = 0
		clocks[index].active = not clocks[index].active
	end
end

if callType == LuaCallType.Update then
	for index, clk in ipairs(clocks) do
		if clk.active and Time.time - clk.last >= 1 then
			local hours = math.floor(clk.seconds / 3600)
			local minutes = math.floor((clk.seconds % 3600) / 60)
			local seconds = clk.seconds % 60
			local secondAngle = seconds * (360 / 60)
			local minuteAngle = (minutes * 6) + (seconds * 0.1)
			local hourAngle = ((hours % 12) * 30) + (minutes * 0.5) + (seconds * (0.5 / 60))
			setHandRotation(clockHourHand[index], Quaternion.Euler(0, 0, -hourAngle))
			setHandRotation(clockMinuteHand[index], Quaternion.Euler(0, 0, -minuteAngle))
			setHandRotation(clockSecondHand[index], Quaternion.Euler(0, 0, -secondAngle))
			if clockSound[index] then
				api.activateSwitch(clockSound[index])
			end
			clk.seconds = clk.seconds + 1
			clk.last = Time.time
		end
	end
end
