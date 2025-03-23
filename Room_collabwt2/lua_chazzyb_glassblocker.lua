--[[
    Original Author: GG3L (@GGӡL) (this script was modified by ChazzyB from GG3L's Pressed Token script)
    Script: Glass Blocker (originally Pressed Token by GG3L)
    Description: This script adds the ability to dynamically alter children meshes of a model, in this case making a glass enclosure gradually more opaque.

    Permission is granted to use this script in custom rooms for Escape Simulator, provided that:
    - Credit is given to the author.
    - Neither this header nor the code is modified.

    Unauthorized distribution or modification is prohibited.
    All rights reserved by the author.
]]
if callType == LuaCallType.Init then
    function switchToFaceIndex(glass, faceIndex)
		local faces = glass.transform.GetChild(0).GetChild(0).GetChild(0)
        for index = 0, faces.childCount - 1 do
            local child = faces.GetChild(index)
            if child.transform.name == 'GlassFace' .. faceIndex then
            	child.transform.localScale = Vector3.one
			else
				child.transform.localScale = Vector3.zero
			end
        end
    end
end
if callType == LuaCallType.SwitchDone then
    if context == glassBlockerOn then
        if not context.isOn then
            --api.log(glassBlockerOn.outputValue)	
            context.outputValue = context.outputValue + 1
            switchToFaceIndex(glassBlocker, glassBlockerOn.outputValue)
            if context.outputValue > 19 then
		glassBlockerOff.outputValue = 20
		elseif context.outputValue < 19 then
			api.activateSwitch(volume1swap)
			api.activateSwitch(volume2swap)
	end  
            if context.outputValue < 19 then
                api.activateSwitch(glassBlockerOn)
    	end
	end
    end
    if context == glassBlockerOff then
        if not context.isOn then
            --api.log(glassBlockerOff.outputValue)
            context.outputValue = context.outputValue - 1
            switchToFaceIndex(glassBlocker, glassBlockerOff.outputValue)
            if context.outputValue < 0 then
            	context.outputValue = 20
		glassBlockerOn.outputValue = -1
		api.activateSwitch(glassBlockerDisable)
	end  
            if context.outputValue < 20 then
                api.activateSwitch(glassBlockerOff)
    	end
	end
    end
end
