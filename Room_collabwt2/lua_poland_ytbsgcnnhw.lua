if callType == LuaCallType.Init then

elseif callType == LuaCallType.SwitchDone then

	if context == gacek_foodvanish_2 then
        if gacek_lock_now.values[1]== 1 then
            api.toggleActivator(pierogi_vanish_activator_2)
            api.toggleActivator(schabowy_vanish_activator_2)
            api.toggleActivator(bigos_vanish_activator_2)
        elseif gacek_lock_now.values[1]==2 then
            api.toggleActivator(sausage_vanish_activator_2)
            api.toggleActivator(schabowy_vanish_activator_2)
            api.toggleActivator(bigos_vanish_activator_2)
        elseif gacek_lock_now.values[1]==3 then
            api.toggleActivator(sausage_vanish_activator_2)
            api.toggleActivator(pierogi_vanish_activator_2)
            api.toggleActivator(bigos_vanish_activator_2)
            elseif gacek_lock_now.values[1]==4 then
            api.toggleActivator(sausage_vanish_activator_2)
            api.toggleActivator(pierogi_vanish_activator_2)
            api.toggleActivator(schabowy_vanish_activator_2)
		end
            
	end
    
    if context == gacek_eating then
        if gacek_lock_now.values[1]== 1 then 
            api.toggleActivator(pierogi_vanish_activator_2)
            api.toggleActivator(schabowy_vanish_activator_2)
            api.toggleActivator(bigos_vanish_activator_2)
        elseif gacek_lock_now.values[1]==2 then
            api.toggleActivator(sausage_vanish_activator_2)
            api.toggleActivator(schabowy_vanish_activator_2)
            api.toggleActivator(bigos_vanish_activator_2)
        elseif gacek_lock_now.values[1]==3 then
            api.toggleActivator(sausage_vanish_activator_2)
            api.toggleActivator(pierogi_vanish_activator_2)
            api.toggleActivator(bigos_vanish_activator_2)
        elseif gacek_lock_now.values[1]==4 then
            api.toggleActivator(sausage_vanish_activator_2)
            api.toggleActivator(pierogi_vanish_activator_2)
            api.toggleActivator(schabowy_vanish_activator_2)
		end
            api.setLockValue(gacek_lock_now,0,1) 
        if gacek_lock.values[1]== 1 and gacek_lock.values[2]== 2 and gacek_lock.values[3]== 3 and gacek_lock.values[4]== 4 then
            api.activateSwitch(gacek_nothungry)
            else
            api.activateSwitch(gacek_stillhungry)
	   end
    end
    
    
    if context == gacek_foodvanish then
        if gacek_lock_now.values[1]== 1 then
            api.toggleActivator(sausage_vanish_activator)
           
        elseif gacek_lock_now.values[1]==2 then
            api.toggleActivator(pierogi_vanish_activator)
           
        elseif gacek_lock_now.values[1]==3 then
            api.toggleActivator(schabowy_vanish_activator)
            
        elseif gacek_lock_now.values[1]==4 then
            api.toggleActivator(bigos_vanish_activator)
            
		end
	end
    
    
end