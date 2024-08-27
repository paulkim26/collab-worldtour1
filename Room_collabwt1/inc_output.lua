--[[
    Author: GG3L (@GGӡL)
    Script: Output++
    Description: This script adds the ability to increment the output value of a switch, each time it's activated.
    
    All rights reserved by the author. Unauthorized distribution or modification is prohibited.
]]
if callType == LuaCallType.Init then
	function getIndex(context)
        local element = context.gameObject.GetComponent('Element')
        local index = string.match(element.playerVariableName, "{(%d+)}")
        return tonumber(index)
    end
end

if callType == LuaCallType.SwitchDone then
	if api.contains(incOutput, context) and context.isOn then
		local switch = context.gameObject.GetComponent('Switch')
		api.log(switch.outputValue)
		switch.outputValue = switch.outputValue + 1
	end
	if api.contains(resetOutput, context) and context.isOn then
		local index = getIndex(context)
		local switch = incOutput[index].gameObject.GetComponent('Switch')
		switch.outputValue = 1
	end
end
