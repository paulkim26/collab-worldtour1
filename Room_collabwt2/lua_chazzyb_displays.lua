if callType == LuaCallType.SwitchDone then
    if context == pennyPressDisplay_logoReset then
	if not context.isOn then
            pennyPressDisplay_logo.outputValue = 0
	end
	end

    if context == pennyPressDisplay_logo then
        if not context.isOn then
            context.outputValue = context.outputValue + 1
             
            if context.outputValue > 30 then
            	context.outputValue = 31
            end
            
            if context.outputValue < 30 then
                api.activateSwitch(pennyPressDisplay_logo)
        end
        
       	end
	end

    if context == pennyPressDisplay_countryReset then
	if not context.isOn then
            pennyPressDisplay_country.outputValue = 0
	end
	end

    if context == pennyPressDisplay_country then
        if not context.isOn then
            context.outputValue = context.outputValue + 1
             
            if context.outputValue > 30 then
            	context.outputValue = 31
            end
            
            if context.outputValue < 30 then
                api.activateSwitch(pennyPressDisplay_country)
        end
        
       	end
	end

    if context == pennyPressDisplay_collect then
        if not context.isOn then
            context.outputValue = context.outputValue + 1
             
            if context.outputValue > 14 then
            	pennyPressDisplay_collect.outputValue = 0
            end
            
            if context.outputValue < 30 then
                api.activateSwitch(pennyPressDisplay_collect)
        end
        
       	end
	end
end