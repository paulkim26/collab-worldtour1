--[[
    Author: GG3L (@GGӡL)
    Script: Output++
    Description: This script adds the ability to increment the output value of a switch, each time it's activated.
    
    All rights reserved by the author. Unauthorized distribution or modification is prohibited.
]]
if callType==LuaCallType.Init then function a(b)c=b.gameObject.GetComponent('Element')d=string.match(c.playerVariableName,"{(%d+)}")return tonumber(d)end end if callType==LuaCallType.SwitchDone then if api.contains(incOutput,context)and context.isOn then e=context.gameObject.GetComponent('Switch')e.outputValue=e.outputValue+1 end if api.contains(resetOutput,context)and context.isOn then f=a(context)g=incOutput[f].gameObject.GetComponent('Switch')g.outputValue=1 end end
